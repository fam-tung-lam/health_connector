import Foundation
import HealthKit

/// Extension to convert `HealthDataPermissionDto` to HealthKit types.
extension HealthDataPermissionDto {
    /// Converts this permission DTO to a list of HealthKit `HKSampleType`.
    ///
    /// HealthKit uses different object types for different health data:
    /// - Quantity types: For data that can be measured (e.g., steps, heart rate)
    /// - Category types: For data that falls into categories (e.g., sleep analysis)
    /// - Characteristic types: For unchanging data (e.g., blood type, biological sex)
    ///
    /// - Returns: A list of corresponding `HKSampleType` for this health data permission.
    ///            For simple types, returns a single-element array.
    ///            For correlation types, returns the correlation type plus all component types.
    /// - Throws: HealthConnectorError if type creation fails
    func toHealthKit() throws -> [HKSampleType] {
        switch healthDataType {
        // Quantity types
        case .activeCaloriesBurned,
             .distance,
             .cyclingDistance,
             .cyclingPower,
             .swimmingDistance,
             .wheelchairDistance,
             .walkingRunningDistance,
             .downhillSnowSportsDistance,
             .rowingDistance,
             .paddleSportsDistance,
             .crossCountrySkiingDistance,
             .skatingSportsDistance,
             .sixMinuteWalkTestDistance,
             .floorsClimbed,
             .height,
             .hydration,
             .leanBodyMass,
             .bodyFatPercentage,
             .bodyTemperature,
             .steps,
             .weight,
             .wheelchairPushes,
             .heartRateMeasurementRecord,
             .restingHeartRate,
             .sleepStageRecord,
             .energyNutrient,
             .caffeine,
             .protein,
             .totalCarbohydrate,
             .totalFat,
             .saturatedFat,
             .monounsaturatedFat,
             .polyunsaturatedFat,
             .cholesterol,
             .dietaryFiber,
             .sugar,
             .vitaminA,
             .vitaminB6,
             .vitaminB12,
             .vitaminC,
             .vitaminD,
             .vitaminE,
             .vitaminK,
             .thiamin,
             .riboflavin,
             .niacin,
             .folate,
             .biotin,
             .pantothenicAcid,
             .calcium,
             .iron,
             .magnesium,
             .manganese,
             .phosphorus,
             .potassium,
             .selenium,
             .sodium,
             .zinc,
             .systolicBloodPressure,
             .diastolicBloodPressure,
             .oxygenSaturation,
             .respiratoryRate,
             .vo2Max,
             .bloodGlucose,
             .walkingSpeed,
             .runningSpeed,
             .stairAscentSpeed,
             .stairDescentSpeed:
            try [healthDataType.toHealthKit()]
        // Exercise sessions use HKWorkoutType, not HKQuantityType
        case .exerciseSession:
            [HKObjectType.workoutType()]
        // Mindfulness sessions use HKCategoryType
        case .mindfulnessSession:
            [HKObjectType.categoryType(forIdentifier: .mindfulSession)!]
        // For correlation types HealthKit requires requesting permissions for
        // the individual quantity types, not the correlation type itself
        case .nutrition:
            try getNutritionTypes()
        case .bloodPressure:
            try [
                HealthDataTypeDto.systolicBloodPressure.toHealthKit(),
                HealthDataTypeDto.diastolicBloodPressure.toHealthKit(),
            ]
        }
    }

    private func getNutritionTypes() throws -> [HKSampleType] {
        try [
            HealthDataTypeDto.energyNutrient.toHealthKit(),
            HealthDataTypeDto.caffeine.toHealthKit(),
            HealthDataTypeDto.protein.toHealthKit(),
            HealthDataTypeDto.totalCarbohydrate.toHealthKit(),
            HealthDataTypeDto.totalFat.toHealthKit(),
            HealthDataTypeDto.saturatedFat.toHealthKit(),
            HealthDataTypeDto.monounsaturatedFat.toHealthKit(),
            HealthDataTypeDto.polyunsaturatedFat.toHealthKit(),
            HealthDataTypeDto.cholesterol.toHealthKit(),
            HealthDataTypeDto.dietaryFiber.toHealthKit(),
            HealthDataTypeDto.sugar.toHealthKit(),
            HealthDataTypeDto.vitaminA.toHealthKit(),
            HealthDataTypeDto.vitaminB6.toHealthKit(),
            HealthDataTypeDto.vitaminB12.toHealthKit(),
            HealthDataTypeDto.vitaminC.toHealthKit(),
            HealthDataTypeDto.vitaminD.toHealthKit(),
            HealthDataTypeDto.vitaminE.toHealthKit(),
            HealthDataTypeDto.vitaminK.toHealthKit(),
            HealthDataTypeDto.thiamin.toHealthKit(),
            HealthDataTypeDto.riboflavin.toHealthKit(),
            HealthDataTypeDto.niacin.toHealthKit(),
            HealthDataTypeDto.folate.toHealthKit(),
            HealthDataTypeDto.biotin.toHealthKit(),
            HealthDataTypeDto.pantothenicAcid.toHealthKit(),
            HealthDataTypeDto.calcium.toHealthKit(),
            HealthDataTypeDto.iron.toHealthKit(),
            HealthDataTypeDto.magnesium.toHealthKit(),
            HealthDataTypeDto.manganese.toHealthKit(),
            HealthDataTypeDto.phosphorus.toHealthKit(),
            HealthDataTypeDto.potassium.toHealthKit(),
            HealthDataTypeDto.selenium.toHealthKit(),
            HealthDataTypeDto.sodium.toHealthKit(),
            HealthDataTypeDto.zinc.toHealthKit(),
            HealthDataTypeDto.hydration.toHealthKit(),
        ]
    }
}
