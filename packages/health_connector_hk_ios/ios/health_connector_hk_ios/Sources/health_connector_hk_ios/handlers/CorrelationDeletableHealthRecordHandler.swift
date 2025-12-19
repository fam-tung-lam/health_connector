import Foundation
import HealthKit

/// Capability for handlers that support deleting correlation-type health records.
///
/// Correlations require special deletion logic because:
/// 1. Both the correlation AND its contained samples must be deleted to avoid orphaned data
/// 2. The correlation objects must be fetched first to access their contained samples
/// 3. Deletion must be atomic to prevent partial deletions
///
/// ## Usage
/// ```swift
/// final class BloodPressureHandler:
///     CorrelationDeletableHealthRecordHandler,
///     ReadableHealthRecordHandler,
///     WritableHealthRecordHandler
/// {
/// }
/// ```
protocol CorrelationDeletableHealthRecordHandler: DeletableHealthRecordHandler {
}

extension CorrelationDeletableHealthRecordHandler {
    /// Deletes correlation records by ID, including all contained samples.
    ///
    /// This implementation uses a batch-optimized approach:
    /// 1. Validates all UUIDs (throws on invalid UUIDs)
    /// 2. Batch-fetches all correlations in a single HealthKit query
    /// 3. Builds comprehensive deletion set (correlations + contained samples)
    /// 4. Performs single atomic batch deletion
    ///
    /// - Parameter ids: Array of correlation record UUIDs to delete
    /// - Throws: HealthConnectorError.invalidArgument if invalid UUID provided, or other errors if batch operations
    /// fail
    func deleteRecords(ids: [String]) async throws {
        guard !ids.isEmpty else {
            return
        }

        try await process(
            operation: "delete_records_by_ids",
            context: ["count": ids.count]
        ) {
            // Validate UUIDs (fail-fast on invalid input)
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

            // Batch-fetch all correlations in a SINGLE query
            let predicate = HKQuery.predicateForObjects(with: uuidSet)
            let correlations = try await withCheckedThrowingContinuation {
                (continuation: CheckedContinuation<[HKCorrelation], Error>) in
                let query = HKSampleQuery(
                    sampleType: sampleType,
                    predicate: predicate,
                    limit: HKObjectQueryNoLimit, // Fetch ALL matching correlations
                    sortDescriptors: nil
                ) { _, samples, error in
                    if let error {
                        continuation.resume(throwing: error)
                    } else {
                        let correlations = (samples ?? []).compactMap { $0 as? HKCorrelation }
                        continuation.resume(returning: correlations)
                    }
                }
                self.healthStore.execute(query)
            }

            // Log info if some correlations weren't found (don't fail, as they might be deleted)
            if correlations.count < validUUIDs.count {
                let foundUUIDs = Set(correlations.map(\.uuid))
                let missingUUIDs = uuidSet.subtracting(foundUUIDs)
                HealthConnectorLogger.info(
                    tag: String(describing: Self.self),
                    operation: "delete_records_by_ids",
                    message: "Some correlations not found",
                    context: [
                        "requested": validUUIDs.count,
                        "found": correlations.count,
                        "missing_count": missingUUIDs.count,
                    ]
                )
            }

            guard !correlations.isEmpty else {
                return
            }

            // Include BOTH correlations AND all contained samples in deletion set
            var objectsToDelete: [HKObject] = []
            // Reserve capacity for performance (rough estimate: correlation + ~3 samples each)
            objectsToDelete.reserveCapacity(correlations.count * 4)

            for correlation in correlations {
                objectsToDelete.append(correlation)
                objectsToDelete.append(contentsOf: correlation.objects)
            }

            // Single batch deletion both correlation AND all contained samples
            // to avoid orphaned data that could cause double-counting
            try await withCheckedThrowingContinuation {
                (continuation: CheckedContinuation<Void, Error>) in
                self.healthStore.delete(objectsToDelete) { success, error in
                    if let error {
                        // Let process() wrapper handle `HKError` → `HealthConnectorError` mapping
                        continuation.resume(throwing: error)
                    } else if !success {
                        continuation.resume(
                            throwing: HealthConnectorError.unknown(
                                message: "Failed to delete correlations and contained samples"
                            )
                        )
                    } else {
                        continuation.resume()
                    }
                }
            }
        }
    }
}
