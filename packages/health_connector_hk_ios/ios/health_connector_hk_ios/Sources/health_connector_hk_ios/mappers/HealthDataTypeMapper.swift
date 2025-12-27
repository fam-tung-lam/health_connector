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
        case .cyclingDistance:
            try HKQuantityType.make(from: .distanceCycling)
        case .cyclingPower:
            if #available(iOS 17.0, *) {
                try HKQuantityType.make(from: .cyclingPower)
            } else {
                throw HealthConnectorError.unsupportedOperation(
                    message: "Cycling power is only supported on iOS 17.0 and later",
                    context: ["dataType": "cyclingPower", "minimumIOSVersion": "17.0"]
                )
            }
        case .swimmingDistance:
            try HKQuantityType.make(from: .distanceSwimming)
        case .wheelchairDistance:
            try HKQuantityType.make(from: .distanceWheelchair)
        case .walkingRunningDistance:
            try HKQuantityType.make(from: .distanceWalkingRunning)
        case .downhillSnowSportsDistance:
            try HKQuantityType.make(from: .distanceDownhillSnowSports)
        case .rowingDistance:
            if #available(iOS 18.0, *) {
                try HKQuantityType.make(from: .distanceRowing)
            } else {
                throw HealthConnectorError.unsupportedOperation(
                    message: "Rowing distance is only supported on iOS 18.0 and later",
                    context: ["dataType": "rowingDistance", "minimumIOSVersion": "18.0"]
                )
            }
        case .paddleSportsDistance:
            if #available(iOS 18.0, *) {
                try HKQuantityType.make(from: .distancePaddleSports)
            } else {
                throw HealthConnectorError.unsupportedOperation(
                    message: "Paddle sports distance is only supported on iOS 18.0 and later",
                    context: ["dataType": "paddleSportsDistance", "minimumIOSVersion": "18.0"]
                )
            }
        case .crossCountrySkiingDistance:
            if #available(iOS 18.0, *) {
                try HKQuantityType.make(from: .distanceCrossCountrySkiing)
            } else {
                throw HealthConnectorError.unsupportedOperation(
                    message:
                    "Cross-country skiing distance is only supported on iOS 18.0 and later",
                    context: [
                        "dataType": "crossCountrySkiingDistance", "minimumIOSVersion": "18.0",
                    ]
                )
            }
        case .skatingSportsDistance:
            if #available(iOS 18.0, *) {
                try HKQuantityType.make(from: .distanceSkatingSports)
            } else {
                throw HealthConnectorError.unsupportedOperation(
                    message: "Skating sports distance is only supported on iOS 18.0 and later",
                    context: ["dataType": "skatingSportsDistance", "minimumIOSVersion": "18.0"]
                )
            }
        case .sixMinuteWalkTestDistance:
            try HKQuantityType.make(from: .sixMinuteWalkTestDistance)
        case .distance:
            try HKQuantityType.make(from: .distanceWalkingRunning)
        case .walkingSpeed:
            if #available(iOS 16.0, *) {
                try HKQuantityType.make(from: .walkingSpeed)
            } else {
                throw HealthConnectorError.unsupportedOperation(
                    message: "Walking speed is only supported on iOS 16.0 and later",
                    context: ["dataType": "walkingSpeed", "minimumIOSVersion": "16.0"]
                )
            }
        case .runningSpeed:
            if #available(iOS 16.0, *) {
                try HKQuantityType.make(from: .runningSpeed)
            } else {
                throw HealthConnectorError.unsupportedOperation(
                    message: "Running speed is only supported on iOS 16.0 and later",
                    context: ["dataType": "runningSpeed", "minimumIOSVersion": "16.0"]
                )
            }
        case .stairAscentSpeed:
            if #available(iOS 16.0, *) {
                try HKQuantityType.make(from: .stairAscentSpeed)
            } else {
                throw HealthConnectorError.unsupportedOperation(
                    message: "Stair ascent speed is only supported on iOS 16.0 and later",
                    context: ["dataType": "stairAscentSpeed", "minimumIOSVersion": "16.0"]
                )
            }
        case .stairDescentSpeed:
            if #available(iOS 16.0, *) {
                try HKQuantityType.make(from: .stairDescentSpeed)
            } else {
                throw HealthConnectorError.unsupportedOperation(
                    message: "Stair descent speed is only supported on iOS 16.0 and later",
                    context: ["dataType": "stairDescentSpeed", "minimumIOSVersion": "16.0"]
                )
            }
        case .exerciseSession:
            throw HealthConnectorError.unsupportedOperation(
                message: "Exercise session is an interval type, not convertible to HKSampleType",
                context: [:]
            )
        }
    }
}
