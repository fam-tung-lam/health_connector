import Foundation
import HealthKit

/**
 * Handler for combined nutrition records using HKCorrelation.food
 */
struct NutritionCorrelationHandler: HealthKitCorrelationHandler {
    static var supportedType: HealthDataTypeDto {
        .nutrition
    }

    static var category: HealthKitDataCategory {
        .correlation
    }

    static func toDTO(_ sample: HKSample) throws -> HealthRecordDto {
        guard let correlation = sample as? HKCorrelation,
              correlation.correlationType.identifier == HKCorrelationTypeIdentifier.food.rawValue
        else {
            throw HealthConnectorErrors.invalidArgument(
                message: "Expected HKCorrelation with food type, got \(type(of: sample))"
            )
        }
        return correlation.toNutritionRecordDto()
    }

    static func toHealthKit(_ dto: HealthRecordDto) throws -> HKSample {
        guard let nutritionDto = dto as? NutritionRecordDto else {
            throw HealthConnectorErrors.invalidArgument(
                message: "Expected NutritionRecordDto but got \(type(of: dto))"
            )
        }
        return try nutritionDto.toHealthKitCorrelation()
    }

    static func getSampleType() throws -> HKSampleType {
        try HKCorrelationType.safeCorrelationType(forIdentifier: .food)
    }

    static func extractTimestamp(_ dto: HealthRecordDto) throws -> Int64 {
        guard let nutritionDto = dto as? NutritionRecordDto else {
            throw HealthConnectorErrors.invalidArgument(
                message: "Expected NutritionRecordDto, got \(type(of: dto))"
            )
        }
        return nutritionDto.endTime
    }

    static func deleteCorrelation(_ correlation: HKCorrelation, from store: HKHealthStore) async throws {
        // Critical: Must delete both correlation AND all contained samples
        // to avoid orphaned nutrient samples that would cause double-counting.
        var objectsToDelete: [HKObject] = [correlation]
        objectsToDelete.append(contentsOf: correlation.objects)

        try await withCheckedThrowingContinuation {
            (continuation: CheckedContinuation<Void, Error>) in
            store.delete(objectsToDelete) {
                success, error in
                if let error {
                    if let nsError = error as NSError? {
                        continuation.resume(throwing: HealthConnectorClient.mapHealthKitError(nsError))
                    } else {
                        continuation.resume(throwing: HealthConnectorErrors.unknown(
                            message: "Failed to delete nutrition correlation and samples: \(error.localizedDescription)"
                        ))
                    }
                } else if success {
                    continuation.resume()
                } else {
                    continuation.resume(throwing: HealthConnectorErrors.unknown(
                        message: "Failed to delete nutrition correlation and samples"
                    ))
                }
            }
        }
    }
}
