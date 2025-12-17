import Foundation
import HealthKit

/// Extension to convert `HealthDataTypeDto` to HealthKit types.
extension HealthDataTypeDto {
    /// Converts this DTO to a HealthKit `HKSampleType`.
    ///
    /// - Throws: HealthConnectorError if type creation fails
    func toHealthKit() throws -> HKSampleType {
        switch self {
        case .sleepStageRecord:
            try HKCategoryType.make(from: .sleepAnalysis)
        case .bloodPressure:
            try HKCorrelationType.make(from: .bloodPressure)
        case .nutrition:
            try HKCorrelationType.make(from: .food)
        case .height:
            try HKQuantityType.make(from: .height)
        case .weight:
            try HKQuantityType.make(from: .bodyMass)
        case .leanBodyMass:
            try HKQuantityType.make(from: .leanBodyMass)
        case .bodyFatPercentage:
            try HKQuantityType.make(from: .bodyFatPercentage)
        case .bodyTemperature:
            try HKQuantityType.make(from: .bodyTemperature)
        case .steps:
            try HKQuantityType.make(from: .stepCount)
        case .activeCaloriesBurned:
            try HKQuantityType.make(from: .activeEnergyBurned)
        case .distance:
            try HKQuantityType.make(from: .distanceWalkingRunning)
        case .floorsClimbed:
            try HKQuantityType.make(from: .flightsClimbed)
        case .wheelchairPushes:
            try HKQuantityType.make(from: .pushCount)
        case .heartRateMeasurementRecord:
            try HKQuantityType.make(from: .heartRate)
        case .restingHeartRate:
            try HKQuantityType.make(from: .restingHeartRate)
        case .oxygenSaturation:
            try HKQuantityType.make(from: .oxygenSaturation)
        case .respiratoryRate:
            try HKQuantityType.make(from: .respiratoryRate)
        case .vo2Max:
            try HKQuantityType.make(from: .vo2Max)
        case .systolicBloodPressure:
            try HKQuantityType.make(from: .bloodPressureSystolic)
        case .diastolicBloodPressure:
            try HKQuantityType.make(from: .bloodPressureDiastolic)
        case .hydration:
            try HKQuantityType.make(from: .dietaryWater)
        case .energyNutrient:
            try HKQuantityType.make(from: .dietaryEnergyConsumed)
        case .caffeine:
            try HKQuantityType.make(from: .dietaryCaffeine)
        case .protein:
            try HKQuantityType.make(from: .dietaryProtein)
        case .totalCarbohydrate:
            try HKQuantityType.make(from: .dietaryCarbohydrates)
        case .totalFat:
            try HKQuantityType.make(from: .dietaryFatTotal)
        case .saturatedFat:
            try HKQuantityType.make(from: .dietaryFatSaturated)
        case .monounsaturatedFat:
            try HKQuantityType.make(from: .dietaryFatMonounsaturated)
        case .polyunsaturatedFat:
            try HKQuantityType.make(from: .dietaryFatPolyunsaturated)
        case .cholesterol:
            try HKQuantityType.make(from: .dietaryCholesterol)
        case .dietaryFiber:
            try HKQuantityType.make(from: .dietaryFiber)
        case .sugar:
            try HKQuantityType.make(from: .dietarySugar)
        case .vitaminA:
            try HKQuantityType.make(from: .dietaryVitaminA)
        case .vitaminB6:
            try HKQuantityType.make(from: .dietaryVitaminB6)
        case .vitaminB12:
            try HKQuantityType.make(from: .dietaryVitaminB12)
        case .vitaminC:
            try HKQuantityType.make(from: .dietaryVitaminC)
        case .vitaminD:
            try HKQuantityType.make(from: .dietaryVitaminD)
        case .vitaminE:
            try HKQuantityType.make(from: .dietaryVitaminE)
        case .vitaminK:
            try HKQuantityType.make(from: .dietaryVitaminK)
        case .thiamin:
            try HKQuantityType.make(from: .dietaryThiamin)
        case .riboflavin:
            try HKQuantityType.make(from: .dietaryRiboflavin)
        case .niacin:
            try HKQuantityType.make(from: .dietaryNiacin)
        case .folate:
            try HKQuantityType.make(from: .dietaryFolate)
        case .biotin:
            try HKQuantityType.make(from: .dietaryBiotin)
        case .pantothenicAcid:
            try HKQuantityType.make(from: .dietaryPantothenicAcid)
        case .calcium:
            try HKQuantityType.make(from: .dietaryCalcium)
        case .iron:
            try HKQuantityType.make(from: .dietaryIron)
        case .magnesium:
            try HKQuantityType.make(from: .dietaryMagnesium)
        case .manganese:
            try HKQuantityType.make(from: .dietaryManganese)
        case .phosphorus:
            try HKQuantityType.make(from: .dietaryPhosphorus)
        case .potassium:
            try HKQuantityType.make(from: .dietaryPotassium)
        case .selenium:
            try HKQuantityType.make(from: .dietarySelenium)
        case .sodium:
            try HKQuantityType.make(from: .dietarySodium)
        case .zinc:
            try HKQuantityType.make(from: .dietaryZinc)
        case .bloodGlucose:
            try HKQuantityType.make(from: .bloodGlucose)
        }
    }
}
