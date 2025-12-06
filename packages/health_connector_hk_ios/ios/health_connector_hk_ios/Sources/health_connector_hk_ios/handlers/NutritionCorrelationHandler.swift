import Foundation
import HealthKit

/// Handler for combined nutrition records using HKCorrelation.food
///
/// This handler manages food entries that group multiple nutrient samples
/// into a single correlation. It implements HealthKitCorrelationHandler
/// to provide proper delete logic that removes both the correlation
/// and all contained nutrient samples.
///
/// ## Overview
/// In HealthKit, a "food" entry is represented using `HKCorrelation` with
/// the `.food` type identifier. This correlation acts as a container,
/// grouping multiple nutritional `HKQuantitySample` objects (e.g., calories,
/// protein, carbs) together into a single logical meal entry.
///
/// ## Writing
/// When writing a `NutritionRecordDto`, this handler:
/// 1. Creates individual `HKQuantitySample` for each non-nil nutrient
/// 2. Groups them into an `HKCorrelation` with `.food` type
/// 3. Stores food name in `HKMetadataKeyFoodType` metadata
///
/// ## Reading
/// When reading, the handler extracts nutrient values from the contained
/// samples within the correlation.
///
/// ## Deletion
/// **Critical**: Deleting an `HKCorrelation` does NOT automatically delete
/// the contained samples. This handler's `deleteCorrelation` method ensures
/// both the correlation and all contained samples are deleted.

struct NutritionCorrelationHandler: HealthKitCorrelationHandler {

    static var supportedType: HealthDataTypeDto {
        .nutrition
    }

    static var category: HealthKitDataCategory {
        .correlation
    }

    // MARK: - HealthKitSampleHandler

    static func toDTO(_ sample: HKSample) throws -> HealthRecordDto? {
        guard let correlation = sample as? HKCorrelation,
        correlation.correlationType.identifier == HKCorrelationTypeIdentifier.food.rawValue else {
            return nil
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

    static func getSampleType() -> HKSampleType {
        return HKCorrelationType.correlationType(forIdentifier: .food)!
    }

    static func extractTimestamp(_ dto: HealthRecordDto) -> Int64 {
        guard let nutritionDto = dto as? NutritionRecordDto else {
            return 0
        }
        return nutritionDto.endTime
    }

    // MARK: - HealthKitCorrelationHandler

    static func deleteCorrelation(_ correlation: HKCorrelation, from store: HKHealthStore) async throws {
        // Critical: Must delete both correlation AND all contained samples
        // to avoid orphaned nutrient samples that would cause double-counting.
        var objectsToDelete: [HKObject] = [correlation]
        objectsToDelete.append(contentsOf: correlation.objects)

        try await withCheckedThrowingContinuation {
            (continuation: CheckedContinuation<Void, Error>) in
            store.delete(objectsToDelete) {
                success, error in
                if let error = error {
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
