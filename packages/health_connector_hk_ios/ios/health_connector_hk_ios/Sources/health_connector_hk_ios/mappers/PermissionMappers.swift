import Foundation
import HealthKit

/**
 * Extension to convert `HealthDataPermissionDto` to HealthKit types.
 */
extension HealthDataPermissionDto {
    /**
     * Converts this permission DTO to a list of HealthKit `HKObjectType`.
     *
     * HealthKit uses different object types for different health data:
     * - Quantity types: For data that can be measured (e.g., steps, heart rate)
     * - Category types: For data that falls into categories (e.g., sleep analysis)
     * - Characteristic types: For unchanging data (e.g., blood type, biological sex)
     *
     * - Returns: A list of corresponding `HKObjectType` for this health data permission.
     *            For simple types, returns a single-element array.
     *            For correlation types, returns the correlation type plus all component types.
     * - Throws: HealthConnectorError if type creation fails
     */
    func toHealthKitObjectTypes() throws -> [HKObjectType] {
        switch healthDataType {
        case .activeCaloriesBurned:
            try [HKQuantityType.safeQuantityType(forIdentifier: .activeEnergyBurned)]
        case .distance:
            try [HKQuantityType.safeQuantityType(forIdentifier: .distanceWalkingRunning)]
        case .floorsClimbed:
            try [HKQuantityType.safeQuantityType(forIdentifier: .flightsClimbed)]
        case .height:
            try [HKQuantityType.safeQuantityType(forIdentifier: .height)]
        case .hydration:
            try [HKQuantityType.safeQuantityType(forIdentifier: .dietaryWater)]
        case .leanBodyMass:
            try [HKQuantityType.safeQuantityType(forIdentifier: .leanBodyMass)]
        case .bodyFatPercentage:
            try [HKQuantityType.safeQuantityType(forIdentifier: .bodyFatPercentage)]
        case .bodyTemperature:
            try [HKQuantityType.safeQuantityType(forIdentifier: .bodyTemperature)]
        case .steps:
            try [HKQuantityType.safeQuantityType(forIdentifier: .stepCount)]
        case .weight:
            try [HKQuantityType.safeQuantityType(forIdentifier: .bodyMass)]
        case .wheelchairPushes:
            try [HKQuantityType.safeQuantityType(forIdentifier: .pushCount)]
        case .heartRateMeasurementRecord:
            try [HKQuantityType.safeQuantityType(forIdentifier: .heartRate)]
        case .restingHeartRate:
            try [HKQuantityType.safeQuantityType(forIdentifier: .restingHeartRate)]
        case .sleepStageRecord:
            try [HKCategoryType.safeCategoryType(forIdentifier: .sleepAnalysis)]

        // MARK: Nutrients
        case .energyNutrient:
            try [HKQuantityType.safeQuantityType(forIdentifier: .dietaryEnergyConsumed)]
        case .caffeine:
            try [HKQuantityType.safeQuantityType(forIdentifier: .dietaryCaffeine)]
        case .protein:
            try [HKQuantityType.safeQuantityType(forIdentifier: .dietaryProtein)]
        case .totalCarbohydrate:
            try [HKQuantityType.safeQuantityType(forIdentifier: .dietaryCarbohydrates)]
        case .totalFat:
            try [HKQuantityType.safeQuantityType(forIdentifier: .dietaryFatTotal)]
        case .saturatedFat:
            try [HKQuantityType.safeQuantityType(forIdentifier: .dietaryFatSaturated)]
        case .monounsaturatedFat:
            try [HKQuantityType.safeQuantityType(forIdentifier: .dietaryFatMonounsaturated)]
        case .polyunsaturatedFat:
            try [HKQuantityType.safeQuantityType(forIdentifier: .dietaryFatPolyunsaturated)]
        case .cholesterol:
            try [HKQuantityType.safeQuantityType(forIdentifier: .dietaryCholesterol)]
        case .dietaryFiber:
            try [HKQuantityType.safeQuantityType(forIdentifier: .dietaryFiber)]
        case .sugar:
            try [HKQuantityType.safeQuantityType(forIdentifier: .dietarySugar)]
        case .vitaminA:
            try [HKQuantityType.safeQuantityType(forIdentifier: .dietaryVitaminA)]
        case .vitaminB6:
            try [HKQuantityType.safeQuantityType(forIdentifier: .dietaryVitaminB6)]
        case .vitaminB12:
            try [HKQuantityType.safeQuantityType(forIdentifier: .dietaryVitaminB12)]
        case .vitaminC:
            try [HKQuantityType.safeQuantityType(forIdentifier: .dietaryVitaminC)]
        case .vitaminD:
            try [HKQuantityType.safeQuantityType(forIdentifier: .dietaryVitaminD)]
        case .vitaminE:
            try [HKQuantityType.safeQuantityType(forIdentifier: .dietaryVitaminE)]
        case .vitaminK:
            try [HKQuantityType.safeQuantityType(forIdentifier: .dietaryVitaminK)]
        case .thiamin:
            try [HKQuantityType.safeQuantityType(forIdentifier: .dietaryThiamin)]
        case .riboflavin:
            try [HKQuantityType.safeQuantityType(forIdentifier: .dietaryRiboflavin)]
        case .niacin:
            try [HKQuantityType.safeQuantityType(forIdentifier: .dietaryNiacin)]
        case .folate:
            try [HKQuantityType.safeQuantityType(forIdentifier: .dietaryFolate)]
        case .biotin:
            try [HKQuantityType.safeQuantityType(forIdentifier: .dietaryBiotin)]
        case .pantothenicAcid:
            try [HKQuantityType.safeQuantityType(forIdentifier: .dietaryPantothenicAcid)]
        case .calcium:
            try [HKQuantityType.safeQuantityType(forIdentifier: .dietaryCalcium)]
        case .iron:
            try [HKQuantityType.safeQuantityType(forIdentifier: .dietaryIron)]
        case .magnesium:
            try [HKQuantityType.safeQuantityType(forIdentifier: .dietaryMagnesium)]
        case .manganese:
            try [HKQuantityType.safeQuantityType(forIdentifier: .dietaryManganese)]
        case .phosphorus:
            try [HKQuantityType.safeQuantityType(forIdentifier: .dietaryPhosphorus)]
        case .potassium:
            try [HKQuantityType.safeQuantityType(forIdentifier: .dietaryPotassium)]
        case .selenium:
            try [HKQuantityType.safeQuantityType(forIdentifier: .dietarySelenium)]
        case .sodium:
            try [HKQuantityType.safeQuantityType(forIdentifier: .dietarySodium)]
        case .zinc:
            try [HKQuantityType.safeQuantityType(forIdentifier: .dietaryZinc)]

        // MARK: Correlation Types
        case .nutrition:
            // Nutrition is a correlation type (HKCorrelation.food) but HealthKit requires
            // requesting permissions for the individual quantity types, not the correlation type itself
            try [
                // Energy & Other
                HKQuantityType.safeQuantityType(forIdentifier: .dietaryEnergyConsumed),
                HKQuantityType.safeQuantityType(forIdentifier: .dietaryCaffeine),
                // Macronutrients
                HKQuantityType.safeQuantityType(forIdentifier: .dietaryProtein),
                HKQuantityType.safeQuantityType(forIdentifier: .dietaryCarbohydrates),
                HKQuantityType.safeQuantityType(forIdentifier: .dietaryFatTotal),
                HKQuantityType.safeQuantityType(forIdentifier: .dietaryFatSaturated),
                HKQuantityType.safeQuantityType(forIdentifier: .dietaryFatMonounsaturated),
                HKQuantityType.safeQuantityType(forIdentifier: .dietaryFatPolyunsaturated),
                HKQuantityType.safeQuantityType(forIdentifier: .dietaryCholesterol),
                HKQuantityType.safeQuantityType(forIdentifier: .dietaryFiber),
                HKQuantityType.safeQuantityType(forIdentifier: .dietarySugar),
                // Vitamins
                HKQuantityType.safeQuantityType(forIdentifier: .dietaryVitaminA),
                HKQuantityType.safeQuantityType(forIdentifier: .dietaryVitaminB6),
                HKQuantityType.safeQuantityType(forIdentifier: .dietaryVitaminB12),
                HKQuantityType.safeQuantityType(forIdentifier: .dietaryVitaminC),
                HKQuantityType.safeQuantityType(forIdentifier: .dietaryVitaminD),
                HKQuantityType.safeQuantityType(forIdentifier: .dietaryVitaminE),
                HKQuantityType.safeQuantityType(forIdentifier: .dietaryVitaminK),
                HKQuantityType.safeQuantityType(forIdentifier: .dietaryThiamin),
                HKQuantityType.safeQuantityType(forIdentifier: .dietaryRiboflavin),
                HKQuantityType.safeQuantityType(forIdentifier: .dietaryNiacin),
                HKQuantityType.safeQuantityType(forIdentifier: .dietaryFolate),
                HKQuantityType.safeQuantityType(forIdentifier: .dietaryBiotin),
                HKQuantityType.safeQuantityType(forIdentifier: .dietaryPantothenicAcid),
                // Minerals
                HKQuantityType.safeQuantityType(forIdentifier: .dietaryCalcium),
                HKQuantityType.safeQuantityType(forIdentifier: .dietaryIron),
                HKQuantityType.safeQuantityType(forIdentifier: .dietaryMagnesium),
                HKQuantityType.safeQuantityType(forIdentifier: .dietaryManganese),
                HKQuantityType.safeQuantityType(forIdentifier: .dietaryPhosphorus),
                HKQuantityType.safeQuantityType(forIdentifier: .dietaryPotassium),
                HKQuantityType.safeQuantityType(forIdentifier: .dietarySelenium),
                HKQuantityType.safeQuantityType(forIdentifier: .dietarySodium),
                HKQuantityType.safeQuantityType(forIdentifier: .dietaryZinc),
                // Water
                HKQuantityType.safeQuantityType(forIdentifier: .dietaryWater),
            ]
        case .bloodPressure:
            // Blood pressure is a correlation type (HKCorrelation.bloodPressure) but HealthKit requires
            // requesting permissions for the individual quantity types, not the correlation type itself
            try [
                HKQuantityType.safeQuantityType(forIdentifier: .bloodPressureSystolic),
                HKQuantityType.safeQuantityType(forIdentifier: .bloodPressureDiastolic),
            ]
        case .systolicBloodPressure:
            try [HKQuantityType.safeQuantityType(forIdentifier: .bloodPressureSystolic)]
        case .diastolicBloodPressure:
            try [HKQuantityType.safeQuantityType(forIdentifier: .bloodPressureDiastolic)]
        case .oxygenSaturation:
            try [HKQuantityType.safeQuantityType(forIdentifier: .oxygenSaturation)]
        case .respiratoryRate:
            try [HKQuantityType.safeQuantityType(forIdentifier: .respiratoryRate)]
        }
    }
}
