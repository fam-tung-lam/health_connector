import Foundation
import HealthKit

/// Capability for handlers that support reading health records.
protocol ReadableHealthRecordHandler: HealthRecordHandler {
}

/// Type-safe wrapper for pagination tokens
///
/// Encapsulates timestamp-based pagination logic used by ReadableHealthRecordHandler.
/// Provides validation and conversion between external string representation and
/// internal timestamp representation.
///
/// ## Usage
/// ```swift
/// // Creating from timestamp
/// let token = PaginationToken(timestamp: 1234567890000)
///
/// // Parsing from string
/// let token = try PaginationToken(fromString: "1234567890000")
///
/// // Converting to string for DTOs
/// let stringToken = token.toString()
///
/// // Converting to Date for HealthKit queries
/// let date = token.toDate()
/// ```
struct PaginationToken: Equatable, Sendable {
    /// The timestamp in milliseconds since epoch
    let timestamp: Int64

    /// Creates a pagination token from a timestamp
    ///
    /// - Parameter timestamp: Milliseconds since epoch
    init(timestamp: Int64) {
        self.timestamp = timestamp
    }

    /// Creates a pagination token from a string representation
    ///
    /// - Parameter string: String containing timestamp value
    /// - Throws: HealthConnectorError.invalidArgument if string is not a valid Int64
    init(fromString string: String) throws {
        guard let timestamp = Int64(string) else {
            throw HealthConnectorError.invalidArgument(
                message: "Invalid pagination token format",
                context: ["token": string]
            )
        }
        self.timestamp = timestamp
    }

    /// Converts to external string representation
    ///
    /// - Returns: String representation of the timestamp
    func toString() -> String {
        String(timestamp)
    }

    /// Creates a Date from the token for HealthKit queries
    ///
    /// - Returns: Date representation of the timestamp
    func toDate() -> Date {
        Date(timeIntervalSince1970: Double(timestamp) / 1000.0)
    }
}

extension ReadableHealthRecordHandler {
    /// Default page size for record reading
    static var defaultPageSize: Int { 1000 }

    /// Maximum number of samples to query when discovering HKSource objects
    ///
    /// This limit balances completeness vs performance when filtering by data origin.
    /// HealthKit doesn't provide direct source lookup by bundle ID, so we query
    /// a sample of records to collect sources. In most cases, 1000 samples is
    /// sufficient to find all relevant sources.
    private static var sourceDiscoveryLimit: Int { 1000 }

    /// Fetches all samples within a time range (no pagination)
    ///
    /// This method is useful for custom aggregations that need to process all samples
    /// in a time range without pagination constraints.
    ///
    /// - Parameters:
    ///   - startTime: Start of time range
    ///   - endTime: End of time range
    /// - Returns: Array of samples matching the time range
    /// - Throws: HealthConnectorError if query fails
    func readAllRecords(
        startTime: Date,
        endTime: Date
    ) async throws -> [SampleType] {
        let sampleType = try healthKitType()
        guard let sampleType = sampleType as? HKSampleType else {
            throw HealthConnectorError.unsupportedOperation(
                message: "Health data type does not support querying as HKSampleType"
            )
        }
        let predicate = HKQuery.predicateForSamples(
            withStart: startTime,
            end: endTime,
            options: .strictStartDate
        )

        return try await withCheckedThrowingContinuation { continuation in
            let query = HKSampleQuery(
                sampleType: sampleType,
                predicate: predicate,
                limit: HKObjectQueryNoLimit,
                sortDescriptors: nil
            ) { _, samples, error in
                if let error {
                    continuation.resume(throwing: error)
                    return
                }

                guard let samples else {
                    continuation.resume(returning: [])
                    return
                }

                // Cast to expected sample type
                let typedSamples = samples.compactMap { $0 as? SampleType }
                continuation.resume(returning: typedSamples)
            }

            self.healthStore.execute(query)
        }
    }

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

            let sampleType = try healthKitType()
            guard let sampleType = sampleType as? HKSampleType else {
                throw HealthConnectorError.unsupportedOperation(
                    message: "Health data type does not support querying as HKSampleType"
                )
            }
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
    ///   - startTime: Start of time range
    ///   - endTime: End of time range
    ///   - pageToken: Pagination token for fetching next page, nil for first page
    ///   - pageSize: Maximum number of records to return
    ///   - dataOriginPackageNames: Optional list of bundle identifiers to filter by data source
    /// - Returns: Tuple of (records array, next page token)
    /// - Throws: HealthConnectorError if read fails
    func readRecords(
        startTime: Date,
        endTime: Date,
        pageToken: PaginationToken? = nil,
        pageSize: Int = Self.defaultPageSize,
        dataOriginPackageNames: [String] = []
    ) async throws -> (records: [HealthRecordDto], pageToken: PaginationToken?) {
        try await process(
            operation: "read_records",
            context: [
                "start_time": startTime,
                "end_time": endTime,
                "page_size": pageSize,
            ]
        ) {
            let sampleType = try healthKitType()
            guard let sampleType = sampleType as? HKSampleType else {
                throw HealthConnectorError.unsupportedOperation(
                    message: "Health data type does not support querying as HKSampleType"
                )
            }

            // Build time range predicate
            let timePredicate = HKQuery.predicateForSamples(
                withStart: startTime,
                end: endTime,
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
            if let pageToken {
                let pageTokenDate = pageToken.toDate()
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
                        let nextPageToken: PaginationToken?
                        if hasMorePages, let lastDto = dtos.last {
                            let timestamp = try lastDto.extractTimestamp()
                            nextPageToken = PaginationToken(timestamp: timestamp)
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
                limit: Self.sourceDiscoveryLimit,
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
