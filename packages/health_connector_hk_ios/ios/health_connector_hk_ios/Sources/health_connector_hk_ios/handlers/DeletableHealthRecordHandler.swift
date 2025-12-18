import Foundation
import HealthKit

/// Capability for handlers that support deleting health records.
protocol DeletableHealthRecordHandler: HealthRecordHandler {
}

extension DeletableHealthRecordHandler {
    /// Deletes records by IDs using HealthKit's predicate-based batch deletion.
    ///
    /// Uses `HKQuery.predicateForObjects(withUUIDs:)` to delete all matching samples
    /// in a single HealthKit operation, which is more performant than querying and
    /// deleting individual samples.
    ///
    /// - Parameters:
    ///   - ids: Array of record UUIDs to delete
    /// - Throws: HealthConnectorError if deletion fails
    func deleteRecords(ids: [String]) async throws {
        // Fast-check: early return if no IDs provided
        guard !ids.isEmpty else {
            return
        }

        try await process(
            operation: "delete_records_by_ids",
            context: ["count": ids.count]
        ) {
            // Convert string IDs to UUIDs, filtering out invalid ones
            var validUUIDs: [UUID] = []
            for id in ids {
                guard let uuid = UUID(uuidString: id) else {
                    HealthConnectorLogger.error(
                        tag: String(describing: type(of: self)),
                        operation: "delete_records_by_ids",
                        message: "Invalid UUID",
                        context: ["id": id]
                    )

                    throw HealthConnectorError.invalidArgument(
                        message: "Invalid UUID provided for deletion",
                        context: [
                            "operation": "delete_records_by_ids",
                            "id": id,
                        ]
                    )
                }
                validUUIDs.append(uuid)
            }
            let uuidSet = Set(validUUIDs)

            let sampleType = try type(of: self).dataType.toHealthKit()

            // Create predicate for all UUIDs - HealthKit will handle finding and deleting them
            let predicate = HKQuery.predicateForObjects(with: uuidSet)

            // Delete all matching samples in a single operation
            try await self.healthStore.deleteObjects(of: sampleType, predicate: predicate)
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
            let sampleType = try type(of: self).dataType.toHealthKit()

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
