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
    /// - Returns: Tuple of (records array, next page token)
    /// - Throws: HealthConnectorError if read fails
    func readRecords(
        startTime: Int64,
        endTime: Int64,
        pageToken: String? = nil,
        pageSize: Int = Self.defaultPageSize
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

            // Build predicate with pagination
            var predicates = [NSPredicate]()

            // Time range predicate
            predicates.append(
                HKQuery.predicateForSamples(
                    withStart: startDate,
                    end: endDate,
                    options: [.strictStartDate, .strictEndDate]
                )
            )

            // Pagination predicate (if pageToken provided)
            if let pageTokenString = pageToken,
               let pageTokenTimestamp = Int64(pageTokenString)
            {
                let pageTokenDate = Date(timeIntervalSince1970: Double(pageTokenTimestamp) / 1000.0)
                predicates.append(
                    NSPredicate(format: "endDate > %@", pageTokenDate as NSDate)
                )
            }

            let predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)

            // Sort by endDate ascending for consistent pagination
            let sortDescriptor = NSSortDescriptor(
                key: HKSampleSortIdentifierEndDate,
                ascending: true
            )

            // Request one extra record to determine if there are more pages
            let limit = pageSize + 1

            return try await withCheckedThrowingContinuation { continuation in
                let query = HKSampleQuery(
                    sampleType: sampleType,
                    predicate: predicate,
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
}
