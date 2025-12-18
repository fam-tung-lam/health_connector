import Foundation
import HealthKit

/// Capability for handlers that support reading health records.
protocol ReadableHealthRecordHandler: HealthRecordHandler {
}

extension ReadableHealthRecordHandler {
    /// Default page size for record reading
    static var defaultPageSize: Int { 1000 }

    /// Reads a single record by ID
    ///
    /// - Parameters:
    ///   - id: The UUID of the record to read
    /// - Returns: The health record DTO
    /// - Throws: HealthConnectorError if record not found or read fails
    func readRecord(id: String) async throws -> HealthRecordDto {
        try await process(operation: "read_record", context: ["id": id]) {
            guard let uuid = UUID(uuidString: id) else {
                throw HealthConnectorError.invalidArgument(
                    message: "Invalid UUID format: \(id)"
                )
            }

            let sampleType = try Self.dataType.toHealthKit()
            let predicate = HKQuery.predicateForObject(with: uuid)

            return try await withCheckedThrowingContinuation { continuation in
                let query = HKSampleQuery(
                    sampleType: sampleType,
                    predicate: predicate,
                    limit: 1,
                    sortDescriptors: nil
                ) { _, samples, error in
                    if let error {
                        continuation.resume(throwing: error)
                        return
                    }

                    guard let sample = samples?.first else {
                        continuation.resume(
                            throwing: HealthConnectorError.invalidArgument(
                                message: "Record not found with ID: \(id)"
                            )
                        )
                        return
                    }

                    do {
                        let dto = try sample.toDto()
                        continuation.resume(returning: dto)
                    } catch {
                        continuation.resume(throwing: error)
                    }
                }

                self.healthStore.execute(query)
            }
        }
    }

    /// Reads multiple records within a time range with pagination
    ///
    /// - Parameters:
    ///   - startTime: Start of time range (milliseconds since epoch)
    ///   - endTime: End of time range (milliseconds since epoch)
    ///   - pageToken: Timestamp for pagination (milliseconds since epoch), nil for first page
    ///   - pageSize: Maximum number of records to return
    ///   - dataOriginPackageNames: Optional list of bundle identifiers to filter by data source
    /// - Returns: Tuple of (records array, next page token)
    /// - Throws: HealthConnectorError if read fails
    func readRecords(
        startTime: Int64,
        endTime: Int64,
        pageToken: String? = nil,
        pageSize: Int = Self.defaultPageSize,
        dataOriginPackageNames: [String] = []
    ) async throws -> (records: [HealthRecordDto], pageToken: String?) {
        try await process(
            operation: "read_records",
            context: [
                "start_time": startTime,
                "end_time": endTime,
                "page_size": pageSize,
            ]
        ) {
            let sampleType = try Self.dataType.toHealthKit()

            // Convert timestamps
            let startDate = Date(timeIntervalSince1970: Double(startTime) / 1000.0)
            let endDate = Date(timeIntervalSince1970: Double(endTime) / 1000.0)

            // Build time range predicate
            let timePredicate = HKQuery.predicateForSamples(
                withStart: startDate,
                end: endDate,
                options: .strictStartDate
            )

            // Handle data origin filtering
            let predicate: NSPredicate
            if !dataOriginPackageNames.isEmpty {
                let sources = try await self.querySources(
                    forSampleType: sampleType,
                    bundleIdentifiers: dataOriginPackageNames
                )
                if sources.isEmpty {
                    // No matching sources found - return empty result
                    return (records: [], pageToken: nil)
                }
                let sourcePredicates = sources.map { HKQuery.predicateForObjects(from: $0) }
                let sourcePredicate = NSCompoundPredicate(
                    orPredicateWithSubpredicates: sourcePredicates
                )
                predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
                    sourcePredicate, timePredicate,
                ])
            } else {
                predicate = timePredicate
            }

            // Build pagination predicate if needed
            let finalPredicate: NSPredicate
            if let pageTokenString = pageToken,
               let pageTokenTimestamp = Int64(pageTokenString)
            {
                let pageTokenDate = Date(timeIntervalSince1970: Double(pageTokenTimestamp) / 1000.0)
                let paginationPredicate = NSPredicate(
                    format: "startDate > %@", pageTokenDate as NSDate
                )
                finalPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [
                    predicate, paginationPredicate,
                ])
            } else {
                finalPredicate = predicate
            }

            // Sort by startDate ascending for consistent pagination
            let sortDescriptor = NSSortDescriptor(
                key: HKSampleSortIdentifierStartDate,
                ascending: true
            )

            // Request one extra record to determine if there are more pages
            let limit = pageSize + 1

            return try await withCheckedThrowingContinuation { continuation in
                let query = HKSampleQuery(
                    sampleType: sampleType,
                    predicate: finalPredicate,
                    limit: limit,
                    sortDescriptors: [sortDescriptor]
                ) { _, samples, error in
                    if let error {
                        continuation.resume(throwing: error)
                        return
                    }

                    guard let samples else {
                        continuation.resume(returning: (records: [], pageToken: nil))
                        return
                    }

                    do {
                        // Check if there are more pages
                        let hasMorePages = samples.count > pageSize
                        let recordsToReturn =
                            hasMorePages ? Array(samples.prefix(pageSize)) : samples

                        // Use toDto extension method
                        let dtos = try recordsToReturn.map { sample in
                            try sample.toDto()
                        }

                        // Determine next page token
                        let nextPageToken: String?
                        if hasMorePages, let lastDto = dtos.last {
                            let timestamp = try lastDto.extractTimestamp()
                            nextPageToken = String(timestamp)
                        } else {
                            nextPageToken = nil
                        }

                        continuation.resume(returning: (records: dtos, pageToken: nextPageToken))
                    } catch {
                        continuation.resume(throwing: error)
                    }
                }

                self.healthStore.execute(query)
            }
        }
    }

    /// Queries HealthKit for sources matching the given bundle identifiers.
    ///
    /// This helper method queries a sample of records for a given sample type to
    /// collect HKSource objects, then filters them by bundle identifier. This is
    /// necessary because HealthKit doesn't provide a direct API to get sources by
    /// bundle identifier - sources must be obtained from existing samples.
    ///
    /// To improve efficiency, we query a reasonable number of samples (up to 1000)
    /// to collect unique sources. If all requested bundle identifiers are found
    /// before reaching the limit, we can return early.
    ///
    /// - Parameters:
    ///   - sampleType: The HealthKit sample type to query sources for
    ///   - bundleIdentifiers: List of bundle identifiers to filter sources by
    /// - Returns: Set of HKSource objects matching the bundle identifiers
    /// - Throws: Errors from HealthKit queries
    private func querySources(
        forSampleType sampleType: HKSampleType,
        bundleIdentifiers: [String]
    ) async throws -> Set<HKSource> {
        try await withCheckedThrowingContinuation { continuation in
            // Query a sample of records to collect sources
            // Use a reasonable limit to balance between completeness and performance
            let query = HKSampleQuery(
                sampleType: sampleType,
                predicate: nil,
                limit: 1000,
                sortDescriptors: nil
            ) { _, samples, error in
                if let error {
                    continuation.resume(throwing: error)
                    return
                }

                // Extract unique sources that match the bundle identifiers
                let matchingSources = Set(
                    (samples ?? []).compactMap(\.sourceRevision.source).filter {
                        bundleIdentifiers.contains($0.bundleIdentifier)
                    }
                )

                continuation.resume(returning: matchingSources)
            }

            self.healthStore.execute(query)
        }
    }
}
