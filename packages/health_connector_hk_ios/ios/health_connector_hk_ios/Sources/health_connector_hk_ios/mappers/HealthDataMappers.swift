import Foundation
import HealthKit

/**
 * Extension to convert `HealthDataTypeDto` to HealthKit types.
 */
extension HealthDataTypeDto {
    /**
     * Converts this DTO to a HealthKit `HKQuantityType`.
     *
     * - Returns: The corresponding `HKQuantityType` for this health data type.
     */
    func toHealthKitQuantityType() -> HKQuantityType {
        switch self {
        case .activeCaloriesBurned:
            return HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned)!
        case .distance:
            return HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning)!
        case .floorsClimbed:
            return HKQuantityType.quantityType(forIdentifier: .flightsClimbed)!
        case .height:
            return HKQuantityType.quantityType(forIdentifier: .height)!
        case .hydration:
            return HKQuantityType.quantityType(forIdentifier: .dietaryWater)!
        case .leanBodyMass:
            return HKQuantityType.quantityType(forIdentifier: .leanBodyMass)!
        case .bodyFatPercentage:
            return HKQuantityType.quantityType(forIdentifier: .bodyFatPercentage)!
        case .bodyTemperature:
            return HKQuantityType.quantityType(forIdentifier: .bodyTemperature)!
        case .steps:
            return HKQuantityType.quantityType(forIdentifier: .stepCount)!
        case .weight:
            return HKQuantityType.quantityType(forIdentifier: .bodyMass)!
        case .wheelchairPushes:
            return HKQuantityType.quantityType(forIdentifier: .pushCount)!
        case .heartRateMeasurementRecord:
            return HKQuantityType.quantityType(forIdentifier: .heartRate)!
        case .sleepStageRecord:
            // Sleep stages use HKCategoryType, not HKQuantityType
            // This function should not be called for sleep stages
            fatalError("sleepStageRecord cannot be converted to HKQuantityType. Use toHealthKitSampleType() instead.")

        // MARK: Nutrients - Energy & Other (2)
        case .energyNutrient:
            return HKQuantityType.quantityType(forIdentifier: .dietaryEnergyConsumed)!
        case .caffeine:
            return HKQuantityType.quantityType(forIdentifier: .dietaryCaffeine)!

        // MARK: Nutrients - Macronutrients (9)
        case .protein:
            return HKQuantityType.quantityType(forIdentifier: .dietaryProtein)!
        case .totalCarbohydrate:
            return HKQuantityType.quantityType(forIdentifier: .dietaryCarbohydrates)!
        case .totalFat:
            return HKQuantityType.quantityType(forIdentifier: .dietaryFatTotal)!
        case .saturatedFat:
            return HKQuantityType.quantityType(forIdentifier: .dietaryFatSaturated)!
        case .monounsaturatedFat:
            return HKQuantityType.quantityType(forIdentifier: .dietaryFatMonounsaturated)!
        case .polyunsaturatedFat:
            return HKQuantityType.quantityType(forIdentifier: .dietaryFatPolyunsaturated)!
        case .cholesterol:
            return HKQuantityType.quantityType(forIdentifier: .dietaryCholesterol)!
        case .dietaryFiber:
            return HKQuantityType.quantityType(forIdentifier: .dietaryFiber)!
        case .sugar:
            return HKQuantityType.quantityType(forIdentifier: .dietarySugar)!

        // MARK: Nutrients - Vitamins (13)
        case .vitaminA:
            return HKQuantityType.quantityType(forIdentifier: .dietaryVitaminA)!
        case .vitaminB6:
            return HKQuantityType.quantityType(forIdentifier: .dietaryVitaminB6)!
        case .vitaminB12:
            return HKQuantityType.quantityType(forIdentifier: .dietaryVitaminB12)!
        case .vitaminC:
            return HKQuantityType.quantityType(forIdentifier: .dietaryVitaminC)!
        case .vitaminD:
            return HKQuantityType.quantityType(forIdentifier: .dietaryVitaminD)!
        case .vitaminE:
            return HKQuantityType.quantityType(forIdentifier: .dietaryVitaminE)!
        case .vitaminK:
            return HKQuantityType.quantityType(forIdentifier: .dietaryVitaminK)!
        case .thiamin:
            return HKQuantityType.quantityType(forIdentifier: .dietaryThiamin)!
        case .riboflavin:
            return HKQuantityType.quantityType(forIdentifier: .dietaryRiboflavin)!
        case .niacin:
            return HKQuantityType.quantityType(forIdentifier: .dietaryNiacin)!
        case .folate:
            return HKQuantityType.quantityType(forIdentifier: .dietaryFolate)!
        case .biotin:
            return HKQuantityType.quantityType(forIdentifier: .dietaryBiotin)!
        case .pantothenicAcid:
            return HKQuantityType.quantityType(forIdentifier: .dietaryPantothenicAcid)!

        // MARK: Nutrients - Minerals (9)
        case .calcium:
            return HKQuantityType.quantityType(forIdentifier: .dietaryCalcium)!
        case .iron:
            return HKQuantityType.quantityType(forIdentifier: .dietaryIron)!
        case .magnesium:
            return HKQuantityType.quantityType(forIdentifier: .dietaryMagnesium)!
        case .manganese:
            return HKQuantityType.quantityType(forIdentifier: .dietaryManganese)!
        case .phosphorus:
            return HKQuantityType.quantityType(forIdentifier: .dietaryPhosphorus)!
        case .potassium:
            return HKQuantityType.quantityType(forIdentifier: .dietaryPotassium)!
        case .selenium:
            return HKQuantityType.quantityType(forIdentifier: .dietarySelenium)!
        case .sodium:
            return HKQuantityType.quantityType(forIdentifier: .dietarySodium)!
        case .zinc:
            return HKQuantityType.quantityType(forIdentifier: .dietaryZinc)!

        // MARK: Correlation Types
        case .nutrition:
            // Nutrition is a correlation type (HKCorrelation.food), not a quantity type
            fatalError("nutrition cannot be converted to HKQuantityType. Use HealthKitTypeRegistry.getSampleHandler() instead.")
        }
    }

    /**
     * Converts this DTO to a HealthKit `HKSampleType`.
     *
     * This method returns the sample type (which is a base class for quantity types, category types, etc.)
     * that can be used for queries and deletions.
     *
     * - Returns: The corresponding `HKSampleType` for this health data type.
     * - Throws: An error if the conversion fails (should not happen for supported types).
     */
    func toHealthKitSampleType() throws -> HKSampleType {
        switch self {
        case .sleepStageRecord:
            // Sleep stages use HKCategoryType, not HKQuantityType
            return HKCategoryType.categoryType(forIdentifier: .sleepAnalysis)!
        default:
            // All other types are quantity types
            return toHealthKitQuantityType()
        }
    }
}
