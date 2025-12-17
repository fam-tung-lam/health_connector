import Foundation
import HealthKit

/// Handler for combined nutrition records using HKCorrelation.food
final class NutritionCorrelationHandler:
    HealthRecordHandler,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    DeletableHealthRecordHandler
{
    let healthStore: HKHealthStore

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
    }

    static var supportedType: HealthDataTypeDto {
        .nutrition
    }

    func getSampleType() throws -> HKSampleType {
        try HKCorrelationType.make(from: .food)
    }

    func deleteRecords(ids: [String]) async throws {
        try await process(operation: "delete_records_by_ids", context: ["ids": ids]) {
            for id in ids {
                // For correlations, we need to fetch the actual object to get its contained samples
                guard let uuid = UUID(uuidString: id) else {
                    HealthConnectorLogger.warning(
                        tag: String(describing: Self.self),
                        operation: "delete_records_by_ids",
                        message: "Invalid UUID, skipping deletion",
                        context: ["id": id]
                    )
                    continue
                }

                let predicate = HKQuery.predicateForObject(with: uuid)
                let sampleType = try getSampleType()
                let samples = try await withCheckedThrowingContinuation {
                    (
                        continuation: CheckedContinuation<
                            [HKSample],
                            Error
                        >
                    ) in
                    let query = HKSampleQuery(
                        sampleType: sampleType,
                        predicate: predicate,
                        limit: 1,
                        sortDescriptors: nil
                    ) { _, samples, error in
                        if let error {
                            continuation.resume(throwing: error)
                        } else {
                            continuation.resume(returning: samples ?? [])
                        }
                    }
                    self.healthStore.execute(query)
                }

                guard let correlation = samples.first as? HKCorrelation else {
                    HealthConnectorLogger.warning(
                        tag: String(describing: Self.self),
                        operation: "delete_records_by_ids",
                        message: "Correlation not found or not a valid correlation",
                        context: ["id": id]
                    )
                    continue
                }

                // Critical: Must delete both correlation AND all contained samples
                // to avoid orphaned nutrient samples that would cause double-counting.
                var objectsToDelete: [HKObject] = [correlation]
                objectsToDelete.append(contentsOf: correlation.objects)

                // Execute deletion
                try await withCheckedThrowingContinuation {
                    (continuation: CheckedContinuation<Void, Error>) in
                    self.healthStore.delete(objectsToDelete) { success, error in
                        if let error {
                            if let nsError = error as NSError? {
                                continuation.resume(
                                    throwing: HealthConnectorClient.mapHealthKitError(nsError))
                            } else {
                                continuation.resume(
                                    throwing: HealthConnectorError.unknown(
                                        message:
                                        "Failed to delete nutrition correlation and samples: \(error.localizedDescription)"
                                    ))
                            }
                        } else if success {
                            continuation.resume()
                        } else {
                            continuation.resume(
                                throwing: HealthConnectorError.unknown(
                                    message: "Failed to delete nutrition correlation and samples"
                                ))
                        }
                    }
                }
            }
        }
    }
}
