import Foundation
import HealthKit

/// Extension to convert `HealthDataPermissionDto` to HealthKit types.
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
            try [HKQuantityType.make(from: .activeEnergyBurned)]
        case .distance:
            try [HKQuantityType.make(from: .distanceWalkingRunning)]
        case .floorsClimbed:
            try [HKQuantityType.make(from: .flightsClimbed)]
        case .height:
            try [HKQuantityType.make(from: .height)]
        case .hydration:
            try [HKQuantityType.make(from: .dietaryWater)]
        case .leanBodyMass:
            try [HKQuantityType.make(from: .leanBodyMass)]
        case .bodyFatPercentage:
            try [HKQuantityType.make(from: .bodyFatPercentage)]
        case .bodyTemperature:
            try [HKQuantityType.make(from: .bodyTemperature)]
        case .steps:
            try [HKQuantityType.make(from: .stepCount)]
        case .weight:
            try [HKQuantityType.make(from: .bodyMass)]
        case .wheelchairPushes:
            try [HKQuantityType.make(from: .pushCount)]
        case .heartRateMeasurementRecord:
            try [HKQuantityType.make(from: .heartRate)]
        case .restingHeartRate:
            try [HKQuantityType.make(from: .restingHeartRate)]
        case .sleepStageRecord:
            try [HKCategoryType.make(from: .sleepAnalysis)]

        // MARK: Nutrients
        case .energyNutrient:
            try [HKQuantityType.make(from: .dietaryEnergyConsumed)]
        case .caffeine:
            try [HKQuantityType.make(from: .dietaryCaffeine)]
        case .protein:
            try [HKQuantityType.make(from: .dietaryProtein)]
        case .totalCarbohydrate:
            try [HKQuantityType.make(from: .dietaryCarbohydrates)]
        case .totalFat:
            try [HKQuantityType.make(from: .dietaryFatTotal)]
        case .saturatedFat:
            try [HKQuantityType.make(from: .dietaryFatSaturated)]
        case .monounsaturatedFat:
            try [HKQuantityType.make(from: .dietaryFatMonounsaturated)]
        case .polyunsaturatedFat:
            try [HKQuantityType.make(from: .dietaryFatPolyunsaturated)]
        case .cholesterol:
            try [HKQuantityType.make(from: .dietaryCholesterol)]
        case .dietaryFiber:
            try [HKQuantityType.make(from: .dietaryFiber)]
        case .sugar:
            try [HKQuantityType.make(from: .dietarySugar)]
        case .vitaminA:
            try [HKQuantityType.make(from: .dietaryVitaminA)]
        case .vitaminB6:
            try [HKQuantityType.make(from: .dietaryVitaminB6)]
        case .vitaminB12:
            try [HKQuantityType.make(from: .dietaryVitaminB12)]
        case .vitaminC:
            try [HKQuantityType.make(from: .dietaryVitaminC)]
        case .vitaminD:
            try [HKQuantityType.make(from: .dietaryVitaminD)]
        case .vitaminE:
            try [HKQuantityType.make(from: .dietaryVitaminE)]
        case .vitaminK:
            try [HKQuantityType.make(from: .dietaryVitaminK)]
        case .thiamin:
            try [HKQuantityType.make(from: .dietaryThiamin)]
        case .riboflavin:
            try [HKQuantityType.make(from: .dietaryRiboflavin)]
        case .niacin:
            try [HKQuantityType.make(from: .dietaryNiacin)]
        case .folate:
            try [HKQuantityType.make(from: .dietaryFolate)]
        case .biotin:
            try [HKQuantityType.make(from: .dietaryBiotin)]
        case .pantothenicAcid:
            try [HKQuantityType.make(from: .dietaryPantothenicAcid)]
        case .calcium:
            try [HKQuantityType.make(from: .dietaryCalcium)]
        case .iron:
            try [HKQuantityType.make(from: .dietaryIron)]
        case .magnesium:
            try [HKQuantityType.make(from: .dietaryMagnesium)]
        case .manganese:
            try [HKQuantityType.make(from: .dietaryManganese)]
        case .phosphorus:
            try [HKQuantityType.make(from: .dietaryPhosphorus)]
        case .potassium:
            try [HKQuantityType.make(from: .dietaryPotassium)]
        case .selenium:
            try [HKQuantityType.make(from: .dietarySelenium)]
        case .sodium:
            try [HKQuantityType.make(from: .dietarySodium)]
        case .zinc:
            try [HKQuantityType.make(from: .dietaryZinc)]

        // MARK: Correlation Types
        case .nutrition:
            // Nutrition is a correlation type (HKCorrelation.food) but HealthKit requires
            // requesting permissions for the individual quantity types, not the correlation type itself
            try getNutritionTypes()
        case .bloodPressure:
            // Blood pressure is a correlation type (HKCorrelation.bloodPressure) but HealthKit requires
            // requesting permissions for the individual quantity types, not the correlation type itself
            try [
                HKQuantityType.make(from: .bloodPressureSystolic),
                HKQuantityType.make(from: .bloodPressureDiastolic),
            ]
        case .systolicBloodPressure:
            try [HKQuantityType.make(from: .bloodPressureSystolic)]
        case .diastolicBloodPressure:
            try [HKQuantityType.make(from: .bloodPressureDiastolic)]
        case .oxygenSaturation:
            try [HKQuantityType.make(from: .oxygenSaturation)]
        case .respiratoryRate:
            try [HKQuantityType.make(from: .respiratoryRate)]
        case .vo2Max:
            try [HKQuantityType.make(from: .vo2Max)]
        case .bloodGlucose:
            try [HKQuantityType.make(from: .bloodGlucose)]
        }
    }

    private func getNutritionTypes() throws -> [HKObjectType] {
        try [
            // Energy & Other
            HKQuantityType.make(from: .dietaryEnergyConsumed),
            HKQuantityType.make(from: .dietaryCaffeine),
            // Macronutrients
            HKQuantityType.make(from: .dietaryProtein),
            HKQuantityType.make(from: .dietaryCarbohydrates),
            HKQuantityType.make(from: .dietaryFatTotal),
            HKQuantityType.make(from: .dietaryFatSaturated),
            HKQuantityType.make(from: .dietaryFatMonounsaturated),
            HKQuantityType.make(from: .dietaryFatPolyunsaturated),
            HKQuantityType.make(from: .dietaryCholesterol),
            HKQuantityType.make(from: .dietaryFiber),
            HKQuantityType.make(from: .dietarySugar),
            // Vitamins
            HKQuantityType.make(from: .dietaryVitaminA),
            HKQuantityType.make(from: .dietaryVitaminB6),
            HKQuantityType.make(from: .dietaryVitaminB12),
            HKQuantityType.make(from: .dietaryVitaminC),
            HKQuantityType.make(from: .dietaryVitaminD),
            HKQuantityType.make(from: .dietaryVitaminE),
            HKQuantityType.make(from: .dietaryVitaminK),
            HKQuantityType.make(from: .dietaryThiamin),
            HKQuantityType.make(from: .dietaryRiboflavin),
            HKQuantityType.make(from: .dietaryNiacin),
            HKQuantityType.make(from: .dietaryFolate),
            HKQuantityType.make(from: .dietaryBiotin),
            HKQuantityType.make(from: .dietaryPantothenicAcid),
            // Minerals
            HKQuantityType.make(from: .dietaryCalcium),
            HKQuantityType.make(from: .dietaryIron),
            HKQuantityType.make(from: .dietaryMagnesium),
            HKQuantityType.make(from: .dietaryManganese),
            HKQuantityType.make(from: .dietaryPhosphorus),
            HKQuantityType.make(from: .dietaryPotassium),
            HKQuantityType.make(from: .dietarySelenium),
            HKQuantityType.make(from: .dietarySodium),
            HKQuantityType.make(from: .dietaryZinc),
            // Water
            HKQuantityType.make(from: .dietaryWater),
        ]
    }
}
