import Foundation
import HealthKit

/// Handler for combined nutrition records using HKCorrelation.food
final class NutritionCorrelationHandler:
    HealthKitTypeHandler,
    HealthKitTypeMapper,
    ReadableHealthKitTypeHandler,
    WritableHealthKitTypeHandler,
    UpdatableHealthKitTypeHandler,
    DeletableHealthKitTypeHandler
{
    let healthStore: HKHealthStore

    init(healthStore: HKHealthStore) {
        self.healthStore = healthStore
    }

    static var supportedType: HealthDataTypeDto {
        .nutrition
    }

    typealias RecordDto = NutritionRecordDto
    typealias SampleType = HKCorrelation

    static func mapToDto(_ sample: HKSample) throws -> HealthRecordDto {
        guard let correlation = sample as? HKCorrelation,
              correlation.correlationType.identifier == HKCorrelationTypeIdentifier.food.rawValue
        else {
            throw HealthConnectorError.invalidArgument(
                message: "Expected HKCorrelation with food type, got \(type(of: sample))"
            )
        }
        return correlation.toNutritionRecordDto()
    }

    static func mapToHealthKit(_ dto: HealthRecordDto) throws -> HKSample {
        guard let nutritionDto = dto as? NutritionRecordDto else {
            throw HealthConnectorError.invalidArgument(
                message: "Expected NutritionRecordDto but got \(type(of: dto))"
            )
        }
        return try nutritionDto.toHealthKitCorrelation()
    }

    static func extractTimestamp(_ dto: HealthRecordDto) throws -> Int64 {
        guard let nutritionDto = dto as? NutritionRecordDto else {
            throw HealthConnectorError.invalidArgument(
                message: "Expected NutritionRecordDto, got \(type(of: dto))"
            )
        }
        return nutritionDto.endTime
    }

    func getSampleType() throws -> HKSampleType {
        try HKCorrelationType.safeCorrelationType(forIdentifier: .food)
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
