import Foundation
import HealthKit

/// Extension to get HealthDataTypeDto from HKSample identifier.
extension HKSample {
    /// Determines the HealthDataTypeDto from this sample's identifier.
    ///
    /// - Returns: The corresponding HealthDataTypeDto
    /// - Throws: `HealthConnectorError.unsupportedOperation` if the sample type is not supported
    /// - Throws: `HealthConnectorError.invalidArgument` if the identifier is not recognized
    var healthDataType: HealthDataTypeDto {
        get throws {
            let identifier: String

            if let quantitySample = self as? HKQuantitySample {
                identifier = quantitySample.quantityType.identifier
            } else if let categorySample = self as? HKCategorySample {
                identifier = categorySample.categoryType.identifier
            } else if let correlation = self as? HKCorrelation {
                identifier = correlation.correlationType.identifier
            } else if self is HKWorkout {
                // HKWorkout doesn't have a type identifier like other samples
                // Return exerciseSession directly
                return .exerciseSession
            } else {
                throw HealthConnectorError.unsupportedOperation(
                    message: "Unsupported HKSample type: \(type(of: self))",
                    context: ["sampleType": String(describing: type(of: self))]
                )
            }

            switch identifier {
            // Quantity types
            case HKQuantityTypeIdentifier.stepCount.rawValue:
                return .steps
            case HKQuantityTypeIdentifier.bodyMass.rawValue:
                return .weight
            case HKQuantityTypeIdentifier.height.rawValue:
                return .height
            case HKQuantityTypeIdentifier.bodyFatPercentage.rawValue:
                return .bodyFatPercentage
            case HKQuantityTypeIdentifier.bodyTemperature.rawValue:
                return .bodyTemperature
            case HKQuantityTypeIdentifier.basalBodyTemperature.rawValue:
                return .basalBodyTemperature
            case HKQuantityTypeIdentifier.numberOfAlcoholicBeverages.rawValue:
                return .alcoholicBeverages
            case HKQuantityTypeIdentifier.bloodAlcoholContent.rawValue:
                return .bloodAlcoholContent
            case HKQuantityTypeIdentifier.activeEnergyBurned.rawValue:
                return .activeCaloriesBurned
            case HKQuantityTypeIdentifier.basalEnergyBurned.rawValue:
                return .basalEnergyBurned
            case HKQuantityTypeIdentifier.distanceWalkingRunning.rawValue:
                return .distance
            case HKQuantityTypeIdentifier.flightsClimbed.rawValue:
                return .floorsClimbed
            case HKQuantityTypeIdentifier.pushCount.rawValue:
                return .wheelchairPushes
            case HKQuantityTypeIdentifier.electrodermalActivity.rawValue:
                return .electrodermalActivity
            case HKQuantityTypeIdentifier.inhalerUsage.rawValue:
                return .inhalerUsage
            case HKQuantityTypeIdentifier.dietaryWater.rawValue:
                return .hydration
            case HKQuantityTypeIdentifier.insulinDelivery.rawValue:
                return .insulinDelivery
            case HKQuantityTypeIdentifier.leanBodyMass.rawValue:
                return .leanBodyMass
            case HKQuantityTypeIdentifier.heartRate.rawValue:
                return .heartRateMeasurementRecord
            case HKQuantityTypeIdentifier.restingHeartRate.rawValue:
                return .restingHeartRate
            case HKQuantityTypeIdentifier.walkingHeartRateAverage.rawValue:
                return .walkingHeartRateAverage
            case HKQuantityTypeIdentifier.oxygenSaturation.rawValue:
                return .oxygenSaturation
            case HKQuantityTypeIdentifier.respiratoryRate.rawValue:
                return .respiratoryRate
            case HKQuantityTypeIdentifier.vo2Max.rawValue:
                return .vo2Max
            case HKQuantityTypeIdentifier.bloodGlucose.rawValue:
                return .bloodGlucose
            case HKQuantityTypeIdentifier.bloodPressureSystolic.rawValue:
                return .systolicBloodPressure
            case HKQuantityTypeIdentifier.bloodPressureDiastolic.rawValue:
                return .diastolicBloodPressure
            case HKQuantityTypeIdentifier.dietaryEnergyConsumed.rawValue:
                return .dietaryEnergyConsumed
            case HKQuantityTypeIdentifier.dietaryCaffeine.rawValue:
                return .caffeine
            case HKQuantityTypeIdentifier.dietaryProtein.rawValue:
                return .protein
            case HKQuantityTypeIdentifier.dietaryCarbohydrates.rawValue:
                return .totalCarbohydrate
            case HKQuantityTypeIdentifier.dietaryFatTotal.rawValue:
                return .totalFat
            case HKQuantityTypeIdentifier.dietaryFatSaturated.rawValue:
                return .saturatedFat
            case HKQuantityTypeIdentifier.dietaryFatMonounsaturated.rawValue:
                return .monounsaturatedFat
            case HKQuantityTypeIdentifier.dietaryFatPolyunsaturated.rawValue:
                return .polyunsaturatedFat
            case HKQuantityTypeIdentifier.dietaryCholesterol.rawValue:
                return .cholesterol
            case HKQuantityTypeIdentifier.dietaryFiber.rawValue:
                return .dietaryFiber
            case HKQuantityTypeIdentifier.dietarySugar.rawValue:
                return .sugar
            case HKQuantityTypeIdentifier.dietaryVitaminA.rawValue:
                return .vitaminA
            case HKQuantityTypeIdentifier.dietaryVitaminB6.rawValue:
                return .vitaminB6
            case HKQuantityTypeIdentifier.dietaryVitaminB12.rawValue:
                return .vitaminB12
            case HKQuantityTypeIdentifier.dietaryVitaminC.rawValue:
                return .vitaminC
            case HKQuantityTypeIdentifier.dietaryVitaminD.rawValue:
                return .vitaminD
            case HKQuantityTypeIdentifier.dietaryVitaminE.rawValue:
                return .vitaminE
            case HKQuantityTypeIdentifier.dietaryVitaminK.rawValue:
                return .vitaminK
            case HKQuantityTypeIdentifier.dietaryThiamin.rawValue:
                return .thiamin
            case HKQuantityTypeIdentifier.dietaryRiboflavin.rawValue:
                return .riboflavin
            case HKQuantityTypeIdentifier.dietaryNiacin.rawValue:
                return .niacin
            case HKQuantityTypeIdentifier.dietaryFolate.rawValue:
                return .folate
            case HKQuantityTypeIdentifier.dietaryBiotin.rawValue:
                return .biotin
            case HKQuantityTypeIdentifier.dietaryPantothenicAcid.rawValue:
                return .pantothenicAcid
            case HKQuantityTypeIdentifier.dietaryCalcium.rawValue:
                return .calcium
            case HKQuantityTypeIdentifier.dietaryIron.rawValue:
                return .iron
            case HKQuantityTypeIdentifier.dietaryMagnesium.rawValue:
                return .magnesium
            case HKQuantityTypeIdentifier.dietaryManganese.rawValue:
                return .manganese
            case HKQuantityTypeIdentifier.dietaryPhosphorus.rawValue:
                return .phosphorus
            case HKQuantityTypeIdentifier.dietaryPotassium.rawValue:
                return .potassium
            case HKQuantityTypeIdentifier.dietarySelenium.rawValue:
                return .selenium
            case HKQuantityTypeIdentifier.dietarySodium.rawValue:
                return .sodium
            case HKQuantityTypeIdentifier.dietaryZinc.rawValue:
                return .zinc
            case HKQuantityTypeIdentifier.distanceCycling.rawValue:
                return .cyclingDistance
            case HKQuantityTypeIdentifier.distanceSwimming.rawValue:
                return .swimmingDistance
            case HKQuantityTypeIdentifier.swimmingStrokeCount.rawValue:
                return .swimmingStrokes
            case HKQuantityTypeIdentifier.distanceWheelchair.rawValue:
                return .wheelchairDistance
            case HKQuantityTypeIdentifier.distanceWalkingRunning.rawValue:
                return .walkingRunningDistance
            case HKQuantityTypeIdentifier.distanceDownhillSnowSports.rawValue:
                return .downhillSnowSportsDistance
            case HKQuantityTypeIdentifier.sixMinuteWalkTestDistance.rawValue:
                return .sixMinuteWalkTestDistance
            case HKQuantityTypeIdentifier.bodyMassIndex.rawValue:
                return .bodyMassIndex
            case HKQuantityTypeIdentifier.waistCircumference.rawValue:
                return .waistCircumference
            case HKQuantityTypeIdentifier.heartRateVariabilitySDNN.rawValue:
                return .heartRateVariabilitySDNN
            case HKQuantityTypeIdentifier.peripheralPerfusionIndex.rawValue:
                return .peripheralPerfusionIndex
            case HKQuantityTypeIdentifier.forcedVitalCapacity.rawValue:
                return .forcedVitalCapacity
            case HKQuantityTypeIdentifier.forcedExpiratoryVolume1.rawValue:
                return .forcedExpiratoryVolume
            case HKQuantityTypeIdentifier.appleExerciseTime.rawValue:
                return .exerciseTime
            case HKQuantityTypeIdentifier.appleMoveTime.rawValue:
                return .moveTime
            case HKQuantityTypeIdentifier.appleStandTime.rawValue:
                return .standTime
            case HKQuantityTypeIdentifier.appleWalkingSteadiness.rawValue:
                return .walkingSteadiness
            case HKQuantityTypeIdentifier.walkingAsymmetryPercentage.rawValue:
                return .walkingAsymmetryPercentage
            case HKQuantityTypeIdentifier.walkingDoubleSupportPercentage.rawValue:
                return .walkingDoubleSupportPercentage
            case HKQuantityTypeIdentifier.walkingStepLength.rawValue:
                return .walkingStepLength
            // Category types
            case HKCategoryTypeIdentifier.sleepAnalysis.rawValue:
                return .sleepStageRecord
            case HKCategoryTypeIdentifier.sexualActivity.rawValue:
                return .sexualActivity
            case HKCategoryTypeIdentifier.cervicalMucusQuality.rawValue:
                return .cervicalMucus
            case HKCategoryTypeIdentifier.ovulationTestResult.rawValue:
                return .ovulationTest
            case HKCategoryTypeIdentifier.pregnancyTestResult.rawValue:
                return .pregnancyTest
            case HKCategoryTypeIdentifier.progesteroneTestResult.rawValue:
                return .progesteroneTest
            case HKCategoryTypeIdentifier.mindfulSession.rawValue:
                return .mindfulnessSession
            case HKCategoryTypeIdentifier.intermenstrualBleeding.rawValue:
                return .intermenstrualBleeding
            case HKCategoryTypeIdentifier.menstrualFlow.rawValue:
                return .menstrualFlow
            case HKCategoryTypeIdentifier.lactation.rawValue:
                return .lactation
            case HKCategoryTypeIdentifier.pregnancy.rawValue:
                return .pregnancy
            case HKCategoryTypeIdentifier.contraceptive.rawValue:
                return .contraceptive
            case HKCategoryTypeIdentifier.lowHeartRateEvent.rawValue:
                return .lowHeartRateEvent
            case HKCategoryTypeIdentifier.irregularHeartRhythmEvent.rawValue:
                return .irregularHeartRhythmEvent
            case HKCategoryTypeIdentifier.highHeartRateEvent.rawValue:
                return .highHeartRateEvent
            case HKCategoryTypeIdentifier.appleWalkingSteadinessEvent.rawValue:
                return .walkingSteadinessEvent
            // Correlation types
            case HKCorrelationTypeIdentifier.bloodPressure.rawValue:
                return .bloodPressure
            case HKCorrelationTypeIdentifier.food.rawValue:
                return .nutrition
            case HKQuantityTypeIdentifier.environmentalAudioExposure.rawValue:
                return .environmentalAudioExposure
            case HKQuantityTypeIdentifier.headphoneAudioExposure.rawValue:
                return .headphoneAudioExposure
            default:
                if #available(iOS 14.0, *) {
                    if identifier
                        == HKCategoryTypeIdentifier.environmentalAudioExposureEvent.rawValue
                    {
                        return .environmentalAudioExposureEvent
                    }
                }

                if #available(iOS 16.0, *) {
                    switch identifier {
                    case HKQuantityTypeIdentifier.walkingSpeed.rawValue:
                        return .walkingSpeed
                    case HKQuantityTypeIdentifier.runningSpeed.rawValue:
                        return .runningSpeed
                    case HKQuantityTypeIdentifier.stairAscentSpeed.rawValue:
                        return .stairAscentSpeed
                    case HKQuantityTypeIdentifier.stairDescentSpeed.rawValue:
                        return .stairDescentSpeed
                    case HKQuantityTypeIdentifier.runningPower.rawValue:
                        return .runningPower
                    case HKQuantityTypeIdentifier.atrialFibrillationBurden.rawValue:
                        return .atrialFibrillationBurden
                    case HKQuantityTypeIdentifier.numberOfTimesFallen.rawValue:
                        return .numberOfTimesFallen
                    case HKQuantityTypeIdentifier.heartRateRecoveryOneMinute.rawValue:
                        return .heartRateRecoveryOneMinute
                    case HKCategoryTypeIdentifier.infrequentMenstrualCycles.rawValue:
                        return .infrequentMenstrualCycleEvent
                    case HKCategoryTypeIdentifier.irregularMenstrualCycles.rawValue:
                        return .irregularMenstrualCycleEvent
                    case HKCategoryTypeIdentifier.persistentIntermenstrualBleeding.rawValue:
                        return .persistentIntermenstrualBleedingEvent
                    case HKCategoryTypeIdentifier.prolongedMenstrualPeriods.rawValue:
                        return .prolongedMenstrualPeriodEvent
                    case HKQuantityTypeIdentifier.runningGroundContactTime.rawValue:
                        return .runningGroundContactTime
                    case HKQuantityTypeIdentifier.runningStrideLength.rawValue:
                        return .runningStrideLength
                    case HKCategoryTypeIdentifier.lowCardioFitnessEvent.rawValue:
                        return .lowCardioFitnessEvent
                    default:
                        break
                    }
                }

                if #available(iOS 18.0, *) {
                    switch identifier {
                    case HKQuantityTypeIdentifier.distanceRowing.rawValue:
                        return .rowingDistance
                    case HKQuantityTypeIdentifier.distancePaddleSports.rawValue:
                        return .paddleSportsDistance
                    case HKQuantityTypeIdentifier.distanceCrossCountrySkiing.rawValue:
                        return .crossCountrySkiingDistance
                    case HKQuantityTypeIdentifier.distanceSkatingSports.rawValue:
                        return .skatingSportsDistance
                    default:
                        break
                    }
                }

                if #available(iOS 17.0, *) {
                    switch identifier {
                    case HKQuantityTypeIdentifier.cyclingPower.rawValue:
                        return .cyclingPower
                    case HKQuantityTypeIdentifier.cyclingCadence.rawValue:
                        return .cyclingPedalingCadence
                    default:
                        break
                    }
                }

                throw HealthConnectorError.invalidArgument(
                    message: "Unsupported/unimplemented HealthKit identifier: \(identifier)",
                    context: ["identifier": identifier]
                )
            }
        }
    }
}

// Using convenience initializers or static factory methods allows for idiomatic "try HKQuantityType(...)" usage.
extension HKQuantityType {
    /// Creates an instance for the given identifier, throwing an error if unavailable.
    ///
    /// - Parameter identifier: The quantity type identifier (e.g., .stepCount).
    /// - Throws: `HealthConnectorError.invalidArgument` if the type is unavailable on this device/OS.
    static func make(from identifier: HKQuantityTypeIdentifier) throws -> HKQuantityType {
        guard let type = HKObjectType.quantityType(forIdentifier: identifier) else {
            throw HealthConnectorError.invalidArgument(
                message: "HealthKit quantity type unavailable: \(identifier.rawValue)",
                context: ["identifier": identifier.rawValue]
            )
        }
        return type
    }
}

extension HKCategoryType {
    /// Creates an instance for the given identifier, throwing an error if unavailable.
    static func make(from identifier: HKCategoryTypeIdentifier) throws -> HKCategoryType {
        guard let type = HKObjectType.categoryType(forIdentifier: identifier) else {
            throw HealthConnectorError.invalidArgument(
                message: "HealthKit category type unavailable: \(identifier.rawValue)",
                context: ["identifier": identifier.rawValue]
            )
        }

        return type
    }
}

extension HKCorrelationType {
    /// Creates an instance for the given identifier, throwing an error if unavailable.
    static func make(from identifier: HKCorrelationTypeIdentifier) throws -> HKCorrelationType {
        guard let type = HKObjectType.correlationType(forIdentifier: identifier) else {
            throw HealthConnectorError.invalidArgument(
                message: "HealthKit correlation type unavailable: \(identifier.rawValue)",
                context: ["identifier": identifier.rawValue]
            )
        }
        return type
    }
}

extension HKCategoryValueSleepAnalysis {
    /// Creates an HKCategoryValueSleepAnalysis from a raw value.
    static func make(from rawValue: Int) throws -> HKCategoryValueSleepAnalysis {
        guard let value = HKCategoryValueSleepAnalysis(rawValue: rawValue) else {
            throw HealthConnectorError.invalidArgument(
                message: "Invalid sleep analysis raw value: \(rawValue)",
                context: [
                    "details":
                        "This sleep stage value may not be supported on the current iOS version",
                ]
            )
        }
        return value
    }
}

/// iOS 16+ sleep stage raw values.
///
/// HealthKit introduced detailed sleep stages in iOS 16 with specific raw values.
/// These constants provide type-safe access to those values.
enum iOS16SleepStage: Int {
    case deep = 3
    case rem = 4
    case light = 5 // HealthKit calls this "core" sleep
}
