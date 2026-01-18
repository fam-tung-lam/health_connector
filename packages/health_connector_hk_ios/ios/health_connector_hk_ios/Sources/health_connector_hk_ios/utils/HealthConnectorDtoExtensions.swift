import Foundation

/// Extension providing common property access for `HealthRecordDto` protocol
///
/// Pigeon does not allow defining properties in base classes and interfaces, this extension
/// provides a computed property to access fields that exist in all `HealthRecordDto` implementations.
extension HealthRecordDto {
    /// Platform-assigned unique identifier for this health record
    var id: String? {
        switch self {
        case let record as ActiveEnergyBurnedRecordDto:
            record.id
        case let record as AlcoholicBeveragesRecordDto:
            record.id
        case let record as AppleExerciseTimeRecordDto:
            record.id
        case let record as AppleMoveTimeRecordDto:
            record.id
        case let record as AppleStandTimeRecordDto:
            record.id
        case let record as BloodAlcoholContentRecordDto:
            record.id
        case let record as BasalEnergyBurnedRecordDto:
            record.id
        case let record as DistanceActivityRecordDto:
            record.id
        case let record as FloorsClimbedRecordDto:
            record.id
        case let record as StepsRecordDto:
            record.id
        case let record as WeightRecordDto:
            record.id
        case let record as HeightRecordDto:
            record.id
        case let record as HydrationRecordDto:
            record.id
        case let record as LeanBodyMassRecordDto:
            record.id
        case let record as BodyFatPercentageRecordDto:
            record.id
        case let record as BodyTemperatureRecordDto:
            record.id
        case let record as BasalBodyTemperatureRecordDto:
            record.id
        case let record as WheelchairPushesRecordDto:
            record.id
        case let record as HeartRateRecordDto:
            record.id
        case let record as RestingHeartRateRecordDto:
            record.id
        case let record as SleepStageRecordDto:
            record.id
        case let record as SpeedActivityRecordDto:
            record.id
        case let record as ExerciseSessionRecordDto:
            record.id
        case let record as CyclingPowerRecordDto:
            record.id
        case let record as RunningPowerRecordDto:
            record.id
        case let record as SexualActivityRecordDto:
            record.id
        case let record as CervicalMucusRecordDto:
            record.id
        case let record as MindfulnessSessionRecordDto:
            record.id
        case let record as CyclingPedalingCadenceRecordDto:
            record.id
        case let record as OvulationTestRecordDto:
            record.id
        case let record as PregnancyTestRecordDto:
            record.id
        case let record as PregnancyRecordDto:
            record.id
        case let record as ProgesteroneTestRecordDto:
            record.id
        case let record as IntermenstrualBleedingRecordDto:
            record.id
        case let record as MenstrualFlowRecordDto:
            record.id
        case let record as LactationRecordDto:
            record.id
        case let record as BodyMassIndexRecordDto:
            record.id
        case let record as WaistCircumferenceRecordDto:
            record.id
        case let record as HeartRateVariabilitySDNNRecordDto:
            record.id
        case let record as BloodGlucoseRecordDto:
            record.id
        case let record as BloodPressureRecordDto:
            record.id
        case let record as SystolicBloodPressureRecordDto:
            record.id
        case let record as DiastolicBloodPressureRecordDto:
            record.id
        case let record as OxygenSaturationRecordDto:
            record.id
        case let record as RespiratoryRateRecordDto:
            record.id
        case let record as Vo2MaxRecordDto:
            record.id
        case let record as DietaryEnergyConsumedRecordDto:
            record.id
        case let record as DietaryCaffeineRecordDto:
            record.id
        case let record as DietaryProteinRecordDto:
            record.id
        case let record as DietaryTotalCarbohydrateRecordDto:
            record.id
        case let record as DietaryTotalFatRecordDto:
            record.id
        case let record as DietarySaturatedFatRecordDto:
            record.id
        case let record as DietaryMonounsaturatedFatRecordDto:
            record.id
        case let record as DietaryPolyunsaturatedFatRecordDto:
            record.id
        case let record as DietaryCholesterolRecordDto:
            record.id
        case let record as DietaryFiberRecordDto:
            record.id
        case let record as DietarySugarRecordDto:
            record.id
        case let record as DietaryVitaminARecordDto:
            record.id
        case let record as DietaryVitaminB6RecordDto:
            record.id
        case let record as DietaryVitaminB12RecordDto:
            record.id
        case let record as DietaryVitaminCRecordDto:
            record.id
        case let record as DietaryVitaminDRecordDto:
            record.id
        case let record as DietaryVitaminERecordDto:
            record.id
        case let record as DietaryVitaminKRecordDto:
            record.id
        case let record as DietaryThiaminRecordDto:
            record.id
        case let record as DietaryRiboflavinRecordDto:
            record.id
        case let record as DietaryNiacinRecordDto:
            record.id
        case let record as DietaryFolateRecordDto:
            record.id
        case let record as DietaryBiotinRecordDto:
            record.id
        case let record as DietaryPantothenicAcidRecordDto:
            record.id
        case let record as DietaryCalciumRecordDto:
            record.id
        case let record as DietaryIronRecordDto:
            record.id
        case let record as DietaryMagnesiumRecordDto:
            record.id
        case let record as DietaryManganeseRecordDto:
            record.id
        case let record as DietaryPhosphorusRecordDto:
            record.id
        case let record as DietaryPotassiumRecordDto:
            record.id
        case let record as DietarySeleniumRecordDto:
            record.id
        case let record as DietarySodiumRecordDto:
            record.id
        case let record as DietaryZincRecordDto:
            record.id
        case let record as NutritionRecordDto:
            record.id
        case let record as SwimmingStrokesRecordDto:
            record.id
        case let record as ForcedVitalCapacityRecordDto:
            record.id
        default:
            nil
        }
    }

    /// Returns the data type of the record.
    var dataType: HealthDataTypeDto {
        get throws {
            switch self {
            case is StepsRecordDto:
                return .steps
            case is WeightRecordDto:
                return .weight
            case is HeightRecordDto:
                return .height
            case is BodyFatPercentageRecordDto:
                return .bodyFatPercentage
            case is BodyTemperatureRecordDto:
                return .bodyTemperature
            case is BasalBodyTemperatureRecordDto:
                return .basalBodyTemperature
            case is ActiveEnergyBurnedRecordDto:
                return .activeCaloriesBurned
            case is AppleExerciseTimeRecordDto:
                return .appleExerciseTime
            case is AppleMoveTimeRecordDto:
                return .appleMoveTime
            case is AppleStandTimeRecordDto:
                return .appleStandTime
            case is AlcoholicBeveragesRecordDto:
                return .alcoholicBeverages
            case is BloodAlcoholContentRecordDto:
                return .bloodAlcoholContent
            case is BasalEnergyBurnedRecordDto:
                return .basalEnergyBurned
            case let record as DistanceActivityRecordDto:
                return switch record.activityType {
                case .walkingRunning: .walkingRunningDistance
                case .cycling: .cyclingDistance
                case .swimming: .swimmingDistance
                case .wheelchair: .wheelchairDistance
                case .downhillSnowSports: .downhillSnowSportsDistance
                case .rowing: .rowingDistance
                case .paddleSports: .paddleSportsDistance
                case .crossCountrySkiing: .crossCountrySkiingDistance
                case .skatingSports: .skatingSportsDistance
                case .sixMinuteWalkTest: .sixMinuteWalkTestDistance
                }
            case let record as SpeedActivityRecordDto:
                return switch record.activityType {
                case .walking: .walkingSpeed
                case .running: .runningSpeed
                case .stairAscent: .stairAscentSpeed
                case .stairDescent: .stairDescentSpeed
                }
            case is FloorsClimbedRecordDto:
                return .floorsClimbed
            case is WheelchairPushesRecordDto:
                return .wheelchairPushes
            case is HydrationRecordDto:
                return .hydration
            case is LeanBodyMassRecordDto:
                return .leanBodyMass
            case is HeartRateRecordDto:
                return .heartRateMeasurementRecord
            case is RestingHeartRateRecordDto:
                return .restingHeartRate
            case is BloodPressureRecordDto:
                return .bloodPressure
            case is SystolicBloodPressureRecordDto:
                return .systolicBloodPressure
            case is DiastolicBloodPressureRecordDto:
                return .diastolicBloodPressure
            case is SleepStageRecordDto:
                return .sleepStageRecord
            case is DietaryEnergyConsumedRecordDto:
                return .dietaryEnergyConsumed
            case is DietaryCaffeineRecordDto:
                return .caffeine
            case is DietaryProteinRecordDto:
                return .protein
            case is DietaryTotalCarbohydrateRecordDto:
                return .totalCarbohydrate
            case is DietaryTotalFatRecordDto:
                return .totalFat
            case is DietarySaturatedFatRecordDto:
                return .saturatedFat
            case is DietaryMonounsaturatedFatRecordDto:
                return .monounsaturatedFat
            case is DietaryPolyunsaturatedFatRecordDto:
                return .polyunsaturatedFat
            case is DietaryCholesterolRecordDto:
                return .cholesterol
            case is DietaryFiberRecordDto:
                return .dietaryFiber
            case is DietarySugarRecordDto:
                return .sugar
            case is DietaryVitaminARecordDto:
                return .vitaminA
            case is DietaryVitaminB6RecordDto:
                return .vitaminB6
            case is DietaryVitaminB12RecordDto:
                return .vitaminB12
            case is DietaryVitaminCRecordDto:
                return .vitaminC
            case is DietaryVitaminDRecordDto:
                return .vitaminD
            case is DietaryVitaminERecordDto:
                return .vitaminE
            case is DietaryVitaminKRecordDto:
                return .vitaminK
            case is DietaryThiaminRecordDto:
                return .thiamin
            case is DietaryRiboflavinRecordDto:
                return .riboflavin
            case is DietaryNiacinRecordDto:
                return .niacin
            case is DietaryFolateRecordDto:
                return .folate
            case is DietaryBiotinRecordDto:
                return .biotin
            case is DietaryPantothenicAcidRecordDto:
                return .pantothenicAcid
            case is DietaryCalciumRecordDto:
                return .calcium
            case is DietaryIronRecordDto:
                return .iron
            case is DietaryMagnesiumRecordDto:
                return .magnesium
            case is DietaryManganeseRecordDto:
                return .manganese
            case is DietaryPhosphorusRecordDto:
                return .phosphorus
            case is DietaryPotassiumRecordDto:
                return .potassium
            case is DietarySeleniumRecordDto:
                return .selenium
            case is DietarySodiumRecordDto:
                return .sodium
            case is DietaryZincRecordDto:
                return .zinc
            case is NutritionRecordDto:
                return .nutrition
            case is BloodGlucoseRecordDto:
                return .bloodGlucose
            case is OxygenSaturationRecordDto:
                return .oxygenSaturation
            case is RespiratoryRateRecordDto:
                return .respiratoryRate
            case is Vo2MaxRecordDto:
                return .vo2Max
            case is ExerciseSessionRecordDto:
                return .exerciseSession
            case is CyclingPowerRecordDto:
                return .cyclingPower
            case is RunningPowerRecordDto:
                return .runningPower
            case is SexualActivityRecordDto:
                return .sexualActivity
            case is CervicalMucusRecordDto:
                return .cervicalMucus
            case is MindfulnessSessionRecordDto:
                return .mindfulnessSession
            case is CyclingPedalingCadenceRecordDto:
                return .cyclingPedalingCadence
            case is OvulationTestRecordDto:
                return .ovulationTest
            case is PregnancyTestRecordDto:
                return .pregnancyTest
            case is PregnancyRecordDto:
                return .pregnancy
            case is ProgesteroneTestRecordDto:
                return .progesteroneTest
            case is IntermenstrualBleedingRecordDto:
                return .intermenstrualBleeding
            case is MenstrualFlowRecordDto:
                return .menstrualFlow
            case is LactationRecordDto:
                return .lactation
            case is BodyMassIndexRecordDto:
                return .bodyMassIndex
            case is WaistCircumferenceRecordDto:
                return .waistCircumference
            case is HeartRateVariabilitySDNNRecordDto:
                return .heartRateVariabilitySDNN
            case is ContraceptiveRecordDto:
                return .contraceptive
            case is SwimmingStrokesRecordDto:
                return .swimmingStrokes
            case is ForcedVitalCapacityRecordDto:
                return .forcedVitalCapacity
            default:
                throw HealthConnectorError.invalidArgument(
                    message:
                    "Unimplemented `HealthRecordDto.dataType` for health record DTO: \(type(of: self))"
                )
            }
        }
    }

    /// The timestamp used for pagination, in milliseconds since epoch.
    ///
    /// Handles platform-specific timestamp fields:
    /// - Interval records: `endTime`
    /// - Nutrients: `time`
    /// - Correlations: `endTime`
    ///
    /// - Returns: Pagination timestamp
    /// - Throws: `HealthConnectorError.invalidArgument` for unknown DTO types
    func extractTimestamp() throws -> Int64 {
        switch self {
        // Interval-based DTOs with endTime
        case let dto as StepsRecordDto:
            return dto.endTime
        case let dto as AppleExerciseTimeRecordDto:
            return dto.endTime
        case let dto as AppleMoveTimeRecordDto:
            return dto.endTime
        case let dto as AppleStandTimeRecordDto:
            return dto.endTime
        case let dto as ActiveEnergyBurnedRecordDto:
            return dto.endTime
        case let dto as BasalEnergyBurnedRecordDto:
            return dto.endTime
        case let dto as MenstrualFlowRecordDto:
            return dto.endTime
        case let dto as LactationRecordDto:
            return dto.endTime
        case let dto as DistanceActivityRecordDto:
            return dto.endTime
        case let dto as FloorsClimbedRecordDto:
            return dto.endTime
        case let dto as WheelchairPushesRecordDto:
            return dto.endTime
        case let dto as HydrationRecordDto:
            return dto.endTime
        case let dto as SleepStageRecordDto:
            return dto.endTime
        case let dto as NutritionRecordDto:
            return dto.endTime
        // Instant measurement DTOs with time
        case let dto as WeightRecordDto:
            return dto.time
        case let dto as HeightRecordDto:
            return dto.time
        case let dto as BodyFatPercentageRecordDto:
            return dto.time
        case let dto as BloodAlcoholContentRecordDto:
            return dto.time
        case let dto as BodyTemperatureRecordDto:
            return dto.time
        case let dto as BasalBodyTemperatureRecordDto:
            return dto.time
        case let dto as LeanBodyMassRecordDto:
            return dto.time
        case let dto as HeartRateRecordDto:
            return dto.time
        case let dto as RestingHeartRateRecordDto:
            return dto.time
        case let dto as OxygenSaturationRecordDto:
            return dto.time
        case let dto as RespiratoryRateRecordDto:
            return dto.time
        case let dto as Vo2MaxRecordDto:
            return dto.time
        case let dto as BloodGlucoseRecordDto:
            return dto.time
        case let dto as BloodPressureRecordDto:
            return dto.time
        case let dto as SystolicBloodPressureRecordDto:
            return dto.time
        case let dto as DiastolicBloodPressureRecordDto:
            return dto.time
        case let dto as SpeedActivityRecordDto:
            return dto.time
        case let dto as DietaryEnergyConsumedRecordDto:
            return dto.time
        case let dto as DietaryCaffeineRecordDto:
            return dto.time
        case let dto as DietaryProteinRecordDto:
            return dto.time
        case let dto as DietaryTotalCarbohydrateRecordDto:
            return dto.time
        case let dto as DietaryTotalFatRecordDto:
            return dto.time
        case let dto as DietarySaturatedFatRecordDto:
            return dto.time
        case let dto as DietaryMonounsaturatedFatRecordDto:
            return dto.time
        case let dto as DietaryPolyunsaturatedFatRecordDto:
            return dto.time
        case let dto as DietaryCholesterolRecordDto:
            return dto.time
        case let dto as DietaryFiberRecordDto:
            return dto.time
        case let dto as DietarySugarRecordDto:
            return dto.time
        case let dto as DietaryVitaminARecordDto:
            return dto.time
        case let dto as DietaryVitaminB6RecordDto:
            return dto.time
        case let dto as DietaryVitaminB12RecordDto:
            return dto.time
        case let dto as DietaryVitaminCRecordDto:
            return dto.time
        case let dto as DietaryVitaminDRecordDto:
            return dto.time
        case let dto as DietaryVitaminERecordDto:
            return dto.time
        case let dto as DietaryVitaminKRecordDto:
            return dto.time
        case let dto as DietaryThiaminRecordDto:
            return dto.time
        case let dto as DietaryRiboflavinRecordDto:
            return dto.time
        case let dto as DietaryNiacinRecordDto:
            return dto.time
        case let dto as DietaryFolateRecordDto:
            return dto.time
        case let dto as DietaryBiotinRecordDto:
            return dto.time
        case let dto as DietaryPantothenicAcidRecordDto:
            return dto.time
        case let dto as DietaryCalciumRecordDto:
            return dto.time
        case let dto as DietaryIronRecordDto:
            return dto.time
        case let dto as DietaryMagnesiumRecordDto:
            return dto.time
        case let dto as DietaryManganeseRecordDto:
            return dto.time
        case let dto as DietaryPhosphorusRecordDto:
            return dto.time
        case let dto as DietaryPotassiumRecordDto:
            return dto.time
        case let dto as DietarySeleniumRecordDto:
            return dto.time
        case let dto as DietarySodiumRecordDto:
            return dto.time
        case let dto as DietaryZincRecordDto:
            return dto.time
        case let dto as ExerciseSessionRecordDto:
            return dto.endTime
        case let dto as MindfulnessSessionRecordDto:
            return dto.endTime
        case let dto as CyclingPedalingCadenceRecordDto:
            return dto.time
        case let dto as CyclingPowerRecordDto:
            return dto.time
        case let dto as RunningPowerRecordDto:
            return dto.time
        case let dto as SexualActivityRecordDto:
            return dto.time
        case let dto as CervicalMucusRecordDto:
            return dto.time
        case let dto as OvulationTestRecordDto:
            return dto.time
        case let dto as PregnancyTestRecordDto:
            return dto.time
        case let dto as PregnancyRecordDto:
            return dto.endTime
        case let dto as ProgesteroneTestRecordDto:
            return dto.time
        case let dto as IntermenstrualBleedingRecordDto:
            return dto.time
        case let dto as BodyMassIndexRecordDto:
            return dto.time
        case let dto as WaistCircumferenceRecordDto:
            return dto.time
        case let dto as HeartRateVariabilitySDNNRecordDto:
            return dto.time
        case let dto as SwimmingStrokesRecordDto:
            return dto.endTime
        case let dto as ForcedVitalCapacityRecordDto:
            return dto.time
        default:
            throw HealthConnectorError.invalidArgument(
                message:
                "Unimplemented `HealthRecordDto.extractTimestamp` for health record DTO: \(type(of: self))"
            )
        }
    }
}
