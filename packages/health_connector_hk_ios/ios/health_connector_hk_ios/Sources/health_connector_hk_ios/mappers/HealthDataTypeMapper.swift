import Foundation
import HealthKit

/// Extension for mapping `HealthDataTypeDto` → `HKSampleType`.
extension HealthDataTypeDto {
    /// Converts this `HealthDataTypeDto` to its corresponding `HKSampleType`.
    ///
    /// - Returns: The corresponding `HKSampleType`
    /// - Throws: `HealthConnectorError` if type creation fails
    func toHKSampleType() throws -> HKSampleType {
        switch self {
        case .sleepStageRecord, .sleepStage:
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
        case .basalBodyTemperature:
            try HKQuantityType.make(from: .basalBodyTemperature)
        case .sleepingWristTemperature:
            if #available(iOS 16.0, *) {
                try HKQuantityType.make(from: .appleSleepingWristTemperature)
            } else {
                throw HealthConnectorError.unsupportedOperation(
                    message: "Sleeping wrist temperature is only supported on iOS 16.0 and later",
                    context: ["dataType": "sleepingWristTemperature", "minimumIOSVersion": "16.0"]
                )
            }
        case .steps:
            try HKQuantityType.make(from: .stepCount)
        case .activeCaloriesBurned:
            try HKQuantityType.make(from: .activeEnergyBurned)
        case .alcoholicBeverages:
            try HKQuantityType.make(from: .numberOfAlcoholicBeverages)
        case .exerciseTime:
            try HKQuantityType.make(from: .appleExerciseTime)
        case .moveTime:
            try HKQuantityType.make(from: .appleMoveTime)
        case .standTime:
            try HKQuantityType.make(from: .appleStandTime)
        case .walkingSteadiness:
            try HKQuantityType.make(from: .appleWalkingSteadiness)
        case .bloodAlcoholContent:
            try HKQuantityType.make(from: .bloodAlcoholContent)
        case .basalEnergyBurned:
            try HKQuantityType.make(from: .basalEnergyBurned)
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
        case .dietaryEnergyConsumed:
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
        case .runningPower:
            if #available(iOS 16.0, *) {
                try HKQuantityType.make(from: .runningPower)
            } else {
                throw HealthConnectorError.unsupportedOperation(
                    message: "Running power is only supported on iOS 16.0 and later",
                    context: ["dataType": "runningPower", "minimumIOSVersion": "16.0"]
                )
            }
        case .cyclingPedalingCadence:
            if #available(iOS 17.0, *) {
                try HKQuantityType.make(from: .cyclingCadence)
            } else {
                throw HealthConnectorError.unsupportedOperation(
                    message: "Cycling pedaling cadence is only supported on iOS 17.0 and later",
                    context: [
                        "dataType": "cyclingPedalingCadence",
                        "minimumIOSVersion": "17.0",
                    ]
                )
            }
        case .swimmingDistance:
            try HKQuantityType.make(from: .distanceSwimming)
        case .swimmingStrokes:
            try HKQuantityType.make(from: .swimmingStrokeCount)
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
        case .sexualActivity:
            try HKCategoryType.make(from: .sexualActivity)
        case .cervicalMucus:
            try HKCategoryType.make(from: .cervicalMucusQuality)
        case .intermenstrualBleeding:
            try HKCategoryType.make(from: .intermenstrualBleeding)
        case .ovulationTest, .ovulationTestResult:
            try HKCategoryType.make(from: .ovulationTestResult)
        case .pregnancyTest:
            try HKCategoryType.make(from: .pregnancyTestResult)
        case .lactation:
            try HKCategoryType.make(from: .lactation)
        case .pregnancy:
            try HKCategoryType.make(from: .pregnancy)
        case .contraceptive:
            try HKCategoryType.make(from: .contraceptive)
        case .progesteroneTest, .progesteroneTestResult:
            try HKCategoryType.make(from: .progesteroneTestResult)
        case .menstrualFlow:
            try HKCategoryType.make(from: .menstrualFlow)
        case .bodyMassIndex:
            try HKQuantityType.make(from: .bodyMassIndex)
        case .waistCircumference:
            try HKQuantityType.make(from: .waistCircumference)
        case .walkingAsymmetryPercentage:
            try HKQuantityType.make(from: .walkingAsymmetryPercentage)
        case .walkingDoubleSupportPercentage:
            try HKQuantityType.make(from: .walkingDoubleSupportPercentage)
        case .walkingStepLength:
            try HKQuantityType.make(from: .walkingStepLength)
        case .heartRateVariabilitySDNN:
            try HKQuantityType.make(from: .heartRateVariabilitySDNN)
        case .peripheralPerfusionIndex:
            try HKQuantityType.make(from: .peripheralPerfusionIndex)
        case .forcedVitalCapacity:
            try HKQuantityType.make(from: .forcedVitalCapacity)
        case .exerciseSession:
            HKObjectType.workoutType()
        case .mindfulnessSession:
            try HKCategoryType.make(from: .mindfulSession)
        case .lowHeartRateEvent:
            try HKCategoryType.make(from: .lowHeartRateEvent)
        case .irregularHeartRhythmEvent:
            try HKCategoryType.make(from: .irregularHeartRhythmEvent)
        case .infrequentMenstrualCycleEvent:
            if #available(iOS 16.0, *) {
                try HKCategoryType.make(from: .infrequentMenstrualCycles)
            } else {
                throw HealthConnectorError.unsupportedOperation(
                    message:
                    "Infrequent menstrual cycle event is only supported on iOS 16.0 and later",
                    context: [
                        "dataType": "infrequentMenstrualCycleEvent",
                        "minimumIOSVersion": "16.0",
                    ]
                )
            }
        case .highHeartRateEvent:
            try HKCategoryType.make(from: .highHeartRateEvent)
        case .walkingSteadinessEvent:
            if #available(iOS 15.0, *) {
                try HKCategoryType.make(from: .appleWalkingSteadinessEvent)
            } else {
                throw HealthConnectorError.unsupportedOperation(
                    message:
                    "Walking steadiness event is only supported on iOS 15.0 and later",
                    context: [
                        "dataType": "walkingSteadinessEvent",
                        "minimumIOSVersion": "15.0",
                    ]
                )
            }
        }
    }
}
