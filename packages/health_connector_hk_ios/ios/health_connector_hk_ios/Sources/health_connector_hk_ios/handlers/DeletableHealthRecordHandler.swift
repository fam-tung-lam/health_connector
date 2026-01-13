import Foundation
import HealthKit

/// Capability for handlers that support deleting health records.
protocol DeletableHealthRecordHandler: HealthRecordHandler {
}

extension DeletableHealthRecordHandler {
    /// Validates and converts string IDs to a set of UUIDs.
    ///
    /// - Parameters:
    ///   - ids: Array of string IDs to validate and convert
    ///   - operation: Operation name for logging context
    /// - Returns: Set of valid UUIDs
    /// - Throws: HealthConnectorError.invalidArgument if any ID is not a valid UUID
    func validateAndConvertToUUIDs(_ ids: [String]) throws -> Set<UUID> {
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
        return Set(validUUIDs)
    }

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
        guard !ids.isEmpty else {
            return
        }

        let tag = String(describing: type(of: self))
        let operation = "delete_records_by_ids"
        let context: [String: Any] = [
            "data_type": type(of: self).dataType.rawValue,
            "record_count": ids.count,
        ]

        try await process(
            operation: operation,
            context: context
        ) {
            HealthConnectorLogger.debug(
                tag: tag,
                operation: operation,
                message: "Preparing to delete records by IDs",
                context: context
            )

            // Validate and convert string IDs to UUID set
            let uuidSet = try validateAndConvertToUUIDs(ids)

            let sampleType = try type(of: self).dataType.toHealthKit()

            // Create predicate for all UUIDs - HealthKit will handle finding and deleting them
            let predicate = HKQuery.predicateForObjects(with: uuidSet)

            // Delete all matching samples in a single operation
            try await self.healthStore.deleteObjects(of: sampleType, predicate: predicate)

            HealthConnectorLogger.info(
                tag: tag,
                operation: operation,
                message: "Records deleted successfully",
                context: context
            )
        }
    }

    /// Deletes all records within a time range
    ///
    /// - Parameters:
    ///   - startTime: Start of time range
    ///   - endTime: End of time range
    /// - Throws: HealthConnectorError if deletion fails
    func deleteRecords(
        startTime: Date,
        endTime: Date
    ) async throws {
        let tag = String(describing: type(of: self))
        let operation = "delete_records_by_time_range"
        let querySpanDays =
            Calendar.current.dateComponents([.day], from: startTime, to: endTime).day ?? 0
        let context: [String: Any] = [
            "data_type": type(of: self).dataType.rawValue,
            "query_span_days": querySpanDays,
        ]

        try await process(
            operation: operation,
            context: context
        ) {
            HealthConnectorLogger.debug(
                tag: tag,
                operation: operation,
                message: "Preparing to delete records by time range",
                context: context
            )

            let sampleType = try type(of: self).dataType.toHealthKit()
            let predicate = HKQuery.predicateForSamples(
                withStart: startTime,
                end: endTime,
                options: [.strictStartDate, .strictEndDate]
            )

            try await self.healthStore.deleteObjects(of: sampleType, predicate: predicate)

            HealthConnectorLogger.info(
                tag: tag,
                operation: operation,
                message: "Records deleted successfully in time range",
                context: context
            )
        }
    }
}

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
///     DeletableCorrelationHealthRecordHandler,
///     ReadableHealthRecordHandler,
///     WritableHealthRecordHandler
/// {
/// }
/// ```
protocol DeletableCorrelationHealthRecordHandler: DeletableHealthRecordHandler {
}

extension DeletableCorrelationHealthRecordHandler {
    /// Deletes correlation records by ID, including all contained samples.
    ///
    /// - Parameter ids: Array of correlation record UUIDs to delete
    /// - Throws: HealthConnectorError.invalidArgument if invalid UUID provided, or other errors if batch operations
    /// fail
    func deleteRecords(ids: [String]) async throws {
        guard !ids.isEmpty else {
            return
        }

        let tag = String(describing: type(of: self))
        let operation = "delete_records_by_ids"
        let context: [String: Any] = [
            "data_type": type(of: self).dataType.rawValue,
            "record_count": ids.count,
        ]

        try await process(
            operation: operation,
            context: context
        ) {
            HealthConnectorLogger.debug(
                tag: tag,
                operation: operation,
                message: "Preparing to delete correlation records by IDs",
                context: context
            )

            // Validate and convert string IDs to UUID set
            let uuidSet = try validateAndConvertToUUIDs(ids)

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
            if correlations.count < uuidSet.count {
                let foundUUIDs = Set(correlations.map(\.uuid))
                let missingUUIDs = uuidSet.subtracting(foundUUIDs)
                HealthConnectorLogger.info(
                    tag: String(describing: Self.self),
                    operation: "delete_records_by_ids",
                    message: "Some correlations not found",
                    context: context.merging([
                        "requested": uuidSet.count,
                        "found": correlations.count,
                        "missing_count": missingUUIDs.count,
                    ]) { _, new in new }
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
                            throwing: HealthConnectorError.unknownError(
                                message: "Failed to delete correlations and contained samples"
                            )
                        )
                    } else {
                        continuation.resume()
                    }
                }
            }

            HealthConnectorLogger.info(
                tag: tag,
                operation: operation,
                message: "Correlation records deleted successfully",
                context: context
            )
        }
    }

    /// Deletes correlation records within a time range, including all contained samples.
    ///
    /// This implementation uses a batch-optimized approach:
    /// 1. Batch-fetches all correlations in the time range using a single HealthKit query
    /// 2. Builds comprehensive deletion set (correlations + contained samples)
    /// 3. Performs single atomic batch deletion
    ///
    /// - Parameters:
    ///   - startTime: Start of time range
    ///   - endTime: End of time range
    /// - Throws: HealthConnectorError if deletion fails
    func deleteRecords(startTime: Date, endTime: Date) async throws {
        let tag = String(describing: type(of: self))
        let operation = "delete_records_by_time_range"
        let querySpanDays =
            Calendar.current.dateComponents([.day], from: startTime, to: endTime).day ?? 0
        let context: [String: Any] = [
            "data_type": type(of: self).dataType.rawValue,
            "query_span_days": querySpanDays,
        ]

        try await process(
            operation: operation,
            context: context
        ) {
            HealthConnectorLogger.debug(
                tag: tag,
                operation: operation,
                message: "Preparing to delete correlation records by time range",
                context: context
            )

            let sampleType = try type(of: self).dataType.toHealthKit()

            // Batch-fetch all correlations in time range in a SINGLE query
            let predicate = HKQuery.predicateForSamples(
                withStart: startTime,
                end: endTime,
                options: [.strictStartDate, .strictEndDate]
            )
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

            // Single batch deletion of both correlations AND all contained samples
            // to avoid orphaned data that could cause double-counting
            try await withCheckedThrowingContinuation {
                (continuation: CheckedContinuation<Void, Error>) in
                self.healthStore.delete(objectsToDelete) { success, error in
                    if let error {
                        // Let process() wrapper handle `HKError` → `HealthConnectorError` mapping
                        continuation.resume(throwing: error)
                    } else if !success {
                        continuation.resume(
                            throwing: HealthConnectorError.unknownError(
                                message: "Failed to delete correlations and contained samples"
                            )
                        )
                    } else {
                        continuation.resume()
                    }
                }
            }

            HealthConnectorLogger.info(
                tag: tag,
                operation: operation,
                message: "Correlation records deleted successfully in time range",
                context: context
            )
        }
    }
}
