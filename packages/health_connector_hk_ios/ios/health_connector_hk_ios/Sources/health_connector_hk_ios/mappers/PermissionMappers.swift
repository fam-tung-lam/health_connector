import Foundation
import HealthKit

/**
 * Extension to convert `HealthDataPermissionDto` to HealthKit types.
 *
 * This extension provides utility methods to map Pigeon DTOs to their corresponding
 * HealthKit types for use with the HealthKit SDK.
 */
extension HealthDataPermissionDto {
    /**
     * Converts this permission DTO to a HealthKit `HKObjectType`.
     *
     * ## HealthKit Object Types
     * HealthKit uses different object types for different health data:
     * - Quantity types: For data that can be measured (e.g., steps, heart rate)
     * - Category types: For data that falls into categories (e.g., sleep analysis)
     * - Characteristic types: For unchanging data (e.g., blood type, biological sex)
     *
     * - Returns: The corresponding `HKObjectType` for this health data permission.
     *            Currently supports:
     *            - `.steps` → `HKQuantityType.quantityType(forIdentifier: .stepCount)`
     *            - `.weight` → `HKQuantityType.quantityType(forIdentifier: .bodyMass)`
     */
    func toHealthKitObjectType() -> HKObjectType {
        switch self.healthDataType {
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
            return HKCategoryType.categoryType(forIdentifier: .sleepAnalysis)!

        // MARK: Nutrients

        case .energyNutrient:
            return HKQuantityType.quantityType(forIdentifier: .dietaryEnergyConsumed)!
        case .caffeine:
            return HKQuantityType.quantityType(forIdentifier: .dietaryCaffeine)!

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
            // Nutrition is a correlation type (HKCorrelation.food)
            return HKCorrelationType.correlationType(forIdentifier: .food)!
        case .bloodPressure:
            // Blood pressure is a correlation type (HKCorrelation.bloodPressure)
            return HKCorrelationType.correlationType(forIdentifier: .bloodPressure)!
        case .systolicBloodPressure:
            return HKQuantityType.quantityType(forIdentifier: .bloodPressureSystolic)!
        case .diastolicBloodPressure:
            return HKQuantityType.quantityType(forIdentifier: .bloodPressureDiastolic)!
        }
    }
}
