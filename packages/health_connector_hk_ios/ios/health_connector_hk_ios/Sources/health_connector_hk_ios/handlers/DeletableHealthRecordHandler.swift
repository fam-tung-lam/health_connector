import Foundation
import HealthKit

/// Capability for handlers that support deleting health records.
///
/// **Requirements:**
/// - `getSampleType()` - needed to query HealthKit for samples to delete
protocol DeletableHealthRecordHandler: HealthRecordHandler {
    /// Get the HKSampleType for queries
    ///
    /// - Returns: The HKSampleType used for this health data type
    /// - Throws: HealthConnectorError if the type cannot be created
    func getSampleType() throws -> HKSampleType
}

extension DeletableHealthRecordHandler {
    /// Deletes records by IDs
    ///
    /// - Parameters:
    ///   - ids: Array of record UUIDs to delete
    /// - Throws: HealthConnectorError if deletion fails
    func deleteRecords(ids: [String]) async throws {
        try await process(
            operation: "delete_records_by_ids",
            context: ["count": ids.count]
        ) {
            // Read all records first to get HKSample objects
            var samplesToDelete: [HKSample] = []

            for id in ids {
                do {
                    guard let uuid = UUID(uuidString: id) else {
                        HealthConnectorLogger.warning(
                            tag: String(describing: type(of: self)),
                            operation: "delete_records_by_ids",
                            message: "Invalid UUID, skipping deletion",
                            context: ["id": id]
                        )
                        continue
                    }

                    let sampleType = try getSampleType()
                    let predicate = HKQuery.predicateForObject(with: uuid)

                    let sample = try await withCheckedThrowingContinuation {
                        (continuation: CheckedContinuation<HKSample, Error>) in
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

                            if let sample = samples?.first {
                                continuation.resume(returning: sample)
                            } else {
                                continuation.resume(
                                    throwing: HealthConnectorError.invalidArgument(
                                        message: "Record not found: \(id)"
                                    )
                                )
                            }
                        }
                        self.healthStore.execute(query)
                    }

                    samplesToDelete.append(sample)

                } catch {
                    // Log but continue with other deletions
                    HealthConnectorLogger.warning(
                        tag: String(describing: type(of: self)),
                        operation: "delete_records_by_ids",
                        message: "Failed to read record for deletion",
                        context: ["id": id]
                    )
                }
            }

            // Delete all samples
            if !samplesToDelete.isEmpty {
                try await self.healthStore.delete(samplesToDelete)
            }
        }
    }

    /// Deletes all records within a time range
    ///
    /// - Parameters:
    ///   - startTime: Start of time range (milliseconds since epoch)
    ///   - endTime: End of time range (milliseconds since epoch)
    /// - Throws: HealthConnectorError if deletion fails
    func deleteRecords(
        startTime: Int64,
        endTime: Int64
    ) async throws {
        try await process(
            operation: "delete_records_by_time_range",
            context: [
                "start_time": startTime,
                "end_time": endTime,
            ]
        ) {
            let sampleType = try getSampleType()

            let startDate = Date(timeIntervalSince1970: Double(startTime) / 1000.0)
            let endDate = Date(timeIntervalSince1970: Double(endTime) / 1000.0)

            let predicate = HKQuery.predicateForSamples(
                withStart: startDate,
                end: endDate,
                options: [.strictStartDate, .strictEndDate]
            )

            try await self.healthStore.deleteObjects(of: sampleType, predicate: predicate)
        }
    }
}
