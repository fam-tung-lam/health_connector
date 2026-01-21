import Foundation
import HealthKit

/// Extension for mapping `HealthRecordDto` → `HKSample`.
extension HealthRecordDto {
    /// Converts this `HealthRecordDto` to its corresponding `HKSample`.
    ///
    /// - Returns: The corresponding `HKSample`
    /// - Throws: `HealthConnectorError.invalidArgument` if the `HealthRecordDto` cannot be converted
    func toHKSample() throws -> HKSample {
        switch self {
        case let dto as ActiveEnergyBurnedRecordDto:
            return try dto.toHKQuantitySample()
        case let dto as AlcoholicBeveragesRecordDto:
            return try dto.toHKQuantitySample()
        case let dto as BloodAlcoholContentRecordDto:
            return try dto.toHKQuantitySample()
        case let dto as BasalEnergyBurnedRecordDto:
            return try dto.toHKQuantitySample()
        case let dto as BloodGlucoseRecordDto:
            return try dto.toHKQuantitySample()
        case let dto as BodyFatPercentageRecordDto:
            return try dto.toHKQuantitySample()
        case let dto as BodyTemperatureRecordDto:
            return try dto.toHKQuantitySample()
        case let dto as BasalBodyTemperatureRecordDto:
            return try dto.toHKQuantitySample()
        case let dto as SleepingWristTemperatureRecordDto:
            return try dto.toHKQuantitySample()
        case let dto as CervicalMucusRecordDto:
            return try dto.toHKCategorySample()
        case let dto as DiastolicBloodPressureRecordDto:
            return try dto.toHKQuantitySample()
        case let dto as DistanceActivityRecordDto:
            return try dto.toHKQuantitySample()
        case let dto as FloorsClimbedRecordDto:
            return try dto.toHKQuantitySample()
        case let dto as HeartRateRecordDto:
            return try dto.toHKQuantitySample()
        case let dto as HeightRecordDto:
            return try dto.toHKQuantitySample()
        case let dto as HydrationRecordDto:
            return try dto.toHKQuantitySample()
        case let dto as LeanBodyMassRecordDto:
            return try dto.toHKQuantitySample()
        case let dto as OxygenSaturationRecordDto:
            return try dto.toHKQuantitySample()
        case let dto as RespiratoryRateRecordDto:
            return try dto.toHKQuantitySample()
        case let dto as RestingHeartRateRecordDto:
            return try dto.toHKQuantitySample()
        case let dto as StepsRecordDto:
            return try dto.toHKQuantitySample()
        case let dto as SystolicBloodPressureRecordDto:
            return try dto.toHKQuantitySample()
        case let dto as Vo2MaxRecordDto:
            return try dto.toHKQuantitySample()
        case let dto as WeightRecordDto:
            return try dto.toHKQuantitySample()
        case let dto as WheelchairPushesRecordDto:
            return try dto.toHKQuantitySample()
        case let dto as BloodPressureRecordDto:
            return try dto.toHKCorrelation()
        case let dto as NutritionRecordDto:
            return try dto.toHKCorrelation()
        case let dto as SexualActivityRecordDto:
            return try dto.toHKCategorySample()
        case let dto as SleepStageRecordDto:
            return try dto.toHKCategorySample()
        case let dto as SpeedActivityRecordDto:
            return try dto.toHKQuantitySample()
        case let dto as CyclingPowerRecordDto:
            return try dto.toHKQuantitySample()
        case let dto as RunningPowerRecordDto:
            return try dto.toHKQuantitySample()
        case let dto as CyclingPedalingCadenceRecordDto:
            return try dto.toHKQuantitySample()
        case let dto as ExerciseSessionRecordDto:
            return try dto.toHKWorkout()
        case let dto as MindfulnessSessionRecordDto:
            return try dto.toHKCategorySample()
        case let dto as OvulationTestRecordDto:
            return try dto.toHKCategorySample()
        case let dto as PregnancyTestRecordDto:
            return try dto.toHKCategorySample()
        case let dto as ProgesteroneTestRecordDto:
            return try dto.toHKCategorySample()
        case let dto as IntermenstrualBleedingRecordDto:
            return try dto.toHKCategorySample()
        case let dto as MenstrualFlowRecordDto:
            return try dto.toHKCategorySample()
        case let dto as PregnancyRecordDto:
            return try dto.toHKCategorySample()
        case let dto as ContraceptiveRecordDto:
            return try dto.toHKCategorySample()
        case let dto as WaistCircumferenceRecordDto:
            return try dto.toHKQuantitySample()
        case let dto as WalkingDoubleSupportPercentageRecordDto:
            return try dto.toHKQuantitySample()
        case let dto as WalkingStepLengthRecordDto:
            return try dto.toHKQuantitySample()
        case let dto as LactationRecordDto:
            return try dto.toHKCategorySample()
        case let dto as BodyMassIndexRecordDto:
            return try dto.toHKQuantitySample()
        case let dto as HeartRateVariabilitySDNNRecordDto:
            return try dto.toHKQuantitySample()
        case let dto as DietaryEnergyConsumedRecordDto:
            return try dto.toHKQuantitySample()
        case let dto as DietaryCaffeineRecordDto:
            return try dto.toHKQuantitySample()
        case let dto as DietaryProteinRecordDto:
            return try dto.toHKQuantitySample()
        case let dto as DietaryTotalCarbohydrateRecordDto:
            return try dto.toHKQuantitySample()
        case let dto as DietaryTotalFatRecordDto:
            return try dto.toHKQuantitySample()
        case let dto as DietarySaturatedFatRecordDto:
            return try dto.toHKQuantitySample()
        case let dto as DietaryMonounsaturatedFatRecordDto:
            return try dto.toHKQuantitySample()
        case let dto as DietaryPolyunsaturatedFatRecordDto:
            return try dto.toHKQuantitySample()
        case let dto as DietaryCholesterolRecordDto:
            return try dto.toHKQuantitySample()
        case let dto as DietaryFiberRecordDto:
            return try dto.toHKQuantitySample()
        case let dto as DietarySugarRecordDto:
            return try dto.toHKQuantitySample()
        case let dto as DietaryVitaminARecordDto:
            return try dto.toHKQuantitySample()
        case let dto as DietaryVitaminB6RecordDto:
            return try dto.toHKQuantitySample()
        case let dto as DietaryVitaminB12RecordDto:
            return try dto.toHKQuantitySample()
        case let dto as DietaryVitaminCRecordDto:
            return try dto.toHKQuantitySample()
        case let dto as DietaryVitaminDRecordDto:
            return try dto.toHKQuantitySample()
        case let dto as DietaryVitaminERecordDto:
            return try dto.toHKQuantitySample()
        case let dto as DietaryVitaminKRecordDto:
            return try dto.toHKQuantitySample()
        case let dto as DietaryThiaminRecordDto:
            return try dto.toHKQuantitySample()
        case let dto as DietaryRiboflavinRecordDto:
            return try dto.toHKQuantitySample()
        case let dto as DietaryNiacinRecordDto:
            return try dto.toHKQuantitySample()
        case let dto as DietaryFolateRecordDto:
            return try dto.toHKQuantitySample()
        case let dto as DietaryBiotinRecordDto:
            return try dto.toHKQuantitySample()
        case let dto as DietaryPantothenicAcidRecordDto:
            return try dto.toHKQuantitySample()
        case let dto as DietaryCalciumRecordDto:
            return try dto.toHKQuantitySample()
        case let dto as DietaryIronRecordDto:
            return try dto.toHKQuantitySample()
        case let dto as DietaryMagnesiumRecordDto:
            return try dto.toHKQuantitySample()
        case let dto as DietaryManganeseRecordDto:
            return try dto.toHKQuantitySample()
        case let dto as DietaryPhosphorusRecordDto:
            return try dto.toHKQuantitySample()
        case let dto as DietaryPotassiumRecordDto:
            return try dto.toHKQuantitySample()
        case let dto as DietarySeleniumRecordDto:
            return try dto.toHKQuantitySample()
        case let dto as DietarySodiumRecordDto:
            return try dto.toHKQuantitySample()
        case let dto as DietaryZincRecordDto:
            return try dto.toHKQuantitySample()
        case let dto as SwimmingStrokesRecordDto:
            return try dto.toHKQuantitySample()
        case let dto as PeripheralPerfusionIndexRecordDto:
            return try dto.toHKQuantitySample()
        case let dto as ForcedVitalCapacityRecordDto:
            return try dto.toHKQuantitySample()
        // Read-only records
        case is ExerciseTimeRecordDto,
             is MoveTimeRecordDto,
             is StandTimeRecordDto,
             is WalkingSteadinessRecordDto,
             is WalkingAsymmetryPercentageRecordDto,
             is HighHeartRateEventRecordDto,
             is IrregularHeartRhythmEventRecordDto,
             is WalkingSteadinessEventRecordDto,
             is PersistentIntermenstrualBleedingEventRecordDto,
             is LowHeartRateEventRecordDto:
            throw HealthConnectorError.invalidArgument(
                message:
                "\(String(describing: type(of: self))) is read-only and cannot be written to HealthKit."
            )
        // Unsupported/unimplemented records
        default:
            throw HealthConnectorError.invalidArgument(
                message:
                "`HealthRecordDto.toHKSample()` is not supported or implemented for health record DTO type: '\(type(of: self))."
            )
        }
    }
}

/// Extension for mapping `HKSample` → `HealthRecordDto`.
extension HKSample {
    /// Converts this `HKSample` to its corresponding `HealthRecordDto`.
    ///
    /// - Returns: The corresponding `HealthRecordDto`
    /// - Throws: `HealthConnectorError.invalidArgument` if the `HKSample` cannot be converted
    func toDto() throws -> HealthRecordDto {
        let dataType = try healthDataType

        if let categorySample = self as? HKCategorySample {
            return try categorySample.toHKCategorySampleDto(for: dataType)
        } else if let correlation = self as? HKCorrelation {
            return try correlation.toHKCorrelationDto(for: dataType)
        } else if let quantitySample = self as? HKQuantitySample {
            return try quantitySample.toHKQuantitySampleDto(for: dataType)
        } else if let workout = self as? HKWorkout {
            return try workout.toHKWorkoutDto()
        }

        throw HealthConnectorError.invalidArgument(
            message:
            "`HKSample.toDto()` is not supported or implemented for HKSample type: \(String(describing: type(of: self)))."
        )
    }
}

/// Extension for mapping `HKCategorySample` → `HealthRecordDto`.
extension HKCategorySample {
    /// Converts this `HKCategorySample` to its corresponding `HealthRecordDto`.
    ///
    /// - Returns: The corresponding `HealthRecordDto`
    /// - Throws: `HealthConnectorError.invalidArgument` if the `HKCategorySample` cannot be converted
    func toHKCategorySampleDto(for type: HealthDataTypeDto) throws -> HealthRecordDto {
        switch type {
        case .cervicalMucus:
            try toCervicalMucusRecordDto()
        case .sexualActivity:
            try toSexualActivityRecordDto()
        case .sleepStageRecord:
            try toSleepStageRecordDto()
        case .mindfulnessSession:
            try toMindfulnessSessionDto()
        case .ovulationTest:
            try toOvulationTestRecordDto()
        case .pregnancyTest:
            try toPregnancyTestRecordDto()
        case .progesteroneTest:
            try toProgesteroneTestRecordDto()
        case .intermenstrualBleeding:
            try toIntermenstrualBleedingRecordDto()
        case .menstrualFlow:
            try toMenstrualFlowRecordDto()
        case .pregnancy:
            try toPregnancyRecordDto()
        case .contraceptive:
            try toContraceptiveRecordDto()
        case .lactation:
            try toLactationRecordDto()
        case .lowHeartRateEvent:
            try toLowHeartRateEventRecordDto()
        case .irregularHeartRhythmEvent:
            try toIrregularHeartRhythmEventRecordDto()
        case .infrequentMenstrualCycleEvent:
            if #available(iOS 16.0, *) {
                try toInfrequentMenstrualCycleEventRecordDto()
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
        case .irregularMenstrualCycleEvent:
            if #available(iOS 16.0, *) {
                try toIrregularMenstrualCycleEventRecordDto()
            } else {
                throw HealthConnectorError.unsupportedOperation(
                    message:
                    "Irregular menstrual cycle event is only supported on iOS 16.0 and later",
                    context: [
                        "dataType": "irregularMenstrualCycleEvent",
                        "minimumIOSVersion": "16.0",
                    ]
                )
            }
        case .persistentIntermenstrualBleedingEvent:
            if #available(iOS 16.0, *) {
                try toPersistentIntermenstrualBleedingEventRecordDto()
            } else {
                throw HealthConnectorError.unsupportedOperation(
                    message:
                    "Persistent intermenstrual bleeding event is only supported on iOS 16.0 and later",
                    context: [
                        "dataType": "persistentIntermenstrualBleedingEvent",
                        "minimumIOSVersion": "16.0",
                    ]
                )
            }
        case .highHeartRateEvent:
            try toHighHeartRateEventRecordDto()
        case .walkingSteadinessEvent:
            if #available(iOS 15.0, *) {
                try toWalkingSteadinessEventRecordDto()
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
        default:
            throw HealthConnectorError.invalidArgument(
                message:
                "`HKCategorySample.toHKCategorySampleDto(for: \(String(describing: type)))` is not supported or implemented for HKCategorySample type: \(String(describing: self))."
            )
        }
    }
}

/// Extension for mapping `HKCorrelation` → `HealthRecordDto`.
extension HKCorrelation {
    /// Converts this `HKCorrelation` to its corresponding `HealthRecordDto`.
    ///
    /// - Parameter type: The health data type to convert to
    /// - Returns: The corresponding `HealthRecordDto`
    /// - Throws: `HealthConnectorError.invalidArgument` if the `HKCorrelation` cannot be converted
    func toHKCorrelationDto(for type: HealthDataTypeDto) throws -> HealthRecordDto {
        switch type {
        case .bloodPressure:
            try toBloodPressureRecordDto()
        case .nutrition:
            try toNutritionRecordDto()
        default:
            throw HealthConnectorError.invalidArgument(
                message:
                "`HKCorrelation.toHKCorrelationDto(for: \(String(describing: type)))` is not supported or implemented for HKCorrelation type: \(String(describing: self))"
            )
        }
    }
}

/// Extension for mapping `HKQuantitySample` → `HealthRecordDto`.
extension HKQuantitySample {
    /// Converts this `HKQuantitySample` to its corresponding `HealthRecordDto`.
    ///
    /// - Parameter type: The health data type to convert to
    /// - Returns: The corresponding `HealthRecordDto`
    /// - Throws: `HealthConnectorError.invalidArgument` if the `HKQuantitySample` cannot be converted
    if let dietaryDto = try toDietaryRecordDto(for: type) {
        return dietaryDto
    }

    if let activityDto = try toActivityRecordDto(for: type) {
        return activityDto
    }

    if let vitalsDto = try toVitalsRecordDto(for: type) {
        return vitalsDto
    }

    switch type {
    case .weight:
        return try toWeightRecordDto()
    case .height:
        return try toHeightRecordDto()
    case .bodyFatPercentage:
        return try toBodyFatPercentageRecordDto()
    case .bodyTemperature:
        return try toBodyTemperatureRecordDto()
    case .basalBodyTemperature:
        return try toBasalBodyTemperatureRecordDto()
    case .sleepingWristTemperature:
        return try toSleepingWristTemperatureRecordDto()
    case .leanBodyMass:
        return try toLeanBodyMassRecordDto()
    case .bodyMassIndex:
        return try toBodyMassIndexRecordDto()
    case .waistCircumference:
        return try toWaistCircumferenceRecordDto()
    case .forcedVitalCapacity:
        return try toForcedVitalCapacityRecordDto()
    case .peripheralPerfusionIndex:
        return try toPeripheralPerfusionIndexRecordDto()
    case .swimmingStrokes:
        return try toSwimmingStrokesRecordDto()
    case .bloodAlcoholContent:
        return try toBloodAlcoholContentRecordDto()
    case .alcoholicBeverages:
        return try toAlcoholicBeveragesRecordDto()
    case .uvExposure:
        // Assuming this exists or falls into default if not handled
        throw HealthConnectorError.invalidArgument(
            message:
            "`HKQuantitySample.toHKQuantitySampleDto(for: \(String(describing: type)))` is not supported or implemented for HKQuantitySample type: \(String(describing: self))"
        )
    default:
        throw HealthConnectorError.invalidArgument(
            message:
            "`HKQuantitySample.toHKQuantitySampleDto(for: \(String(describing: type)))` is not supported or implemented for HKQuantitySample type: \(String(describing: self))"
        )
    }
}

private func toDietaryRecordDto(for type: HealthDataTypeDto) throws -> HealthRecordDto? {
    switch type {
    case .dietaryEnergyConsumed:
        try toDietaryEnergyConsumedDto()
    case .caffeine:
        try toDietaryCaffeineDto()
    case .protein:
        try toDietaryProteinDto()
    case .totalCarbohydrate:
        try toDietaryTotalCarbohydrateDto()
    case .totalFat:
        try toDietaryTotalFatDto()
    case .saturatedFat:
        try toDietarySaturatedFatDto()
    case .monounsaturatedFat:
        try toDietaryMonounsaturatedFatDto()
    case .polyunsaturatedFat:
        try toDietaryPolyunsaturatedFatDto()
    case .cholesterol:
        try toDietaryCholesterolDto()
    case .dietaryFiber:
        try toDietaryFiberDto()
    case .sugar:
        try toDietarySugarDto()
    case .vitaminA:
        try toDietaryVitaminADto()
    case .vitaminB6:
        try toDietaryVitaminB6Dto()
    case .vitaminB12:
        try toDietaryVitaminB12Dto()
    case .vitaminC:
        try toDietaryVitaminCDto()
    case .vitaminD:
        try toDietaryVitaminDDto()
    case .vitaminE:
        try toDietaryVitaminEDto()
    case .vitaminK:
        try toDietaryVitaminKDto()
    case .thiamin:
        try toDietaryThiaminDto()
    case .riboflavin:
        try toDietaryRiboflavinDto()
    case .niacin:
        try toDietaryNiacinDto()
    case .folate:
        try toDietaryFolateDto()
    case .biotin:
        try toDietaryBiotinDto()
    case .pantothenicAcid:
        try toDietaryPantothenicAcidDto()
    case .calcium:
        try toDietaryCalciumDto()
    case .iron:
        try toDietaryIronDto()
    case .magnesium:
        try toDietaryMagnesiumDto()
    case .manganese:
        try toDietaryManganeseDto()
    case .phosphorus:
        try toDietaryPhosphorusDto()
    case .potassium:
        try toDietaryPotassiumDto()
    case .selenium:
        try toDietarySeleniumDto()
    case .sodium:
        try toDietarySodiumDto()
    case .zinc:
        try toDietaryZincDto()
    default:
        nil
    }
}

private func toActivityRecordDto(for type: HealthDataTypeDto) throws -> HealthRecordDto? {
    switch type {
    case .steps:
        try toStepsRecordDto()
    case .activeCaloriesBurned:
        try toActiveEnergyBurnedRecordDto()
    case .basalEnergyBurned:
        try toBasalEnergyBurnedRecordDto()
    case .exerciseTime:
        try toExerciseTimeRecordDto()
    case .moveTime:
        try toMoveTimeRecordDto()
    case .standTime:
        try toStandTimeRecordDto()
    case .floorsClimbed:
        try toFloorsClimbedRecordDto()
    case .wheelchairPushes:
        try toWheelchairPushesRecordDto()
    case .cyclingDistance:
        try toDistanceActivityRecordDto(distanceActivityType: .cycling)
    case .swimmingDistance:
        try toDistanceActivityRecordDto(distanceActivityType: .swimming)
    case .wheelchairDistance:
        try toDistanceActivityRecordDto(distanceActivityType: .wheelchair)
    case .walkingRunningDistance:
        try toDistanceActivityRecordDto(
            distanceActivityType: .walkingRunning
        )
    case .downhillSnowSportsDistance:
        try toDistanceActivityRecordDto(
            distanceActivityType: .downhillSnowSports
        )
    case .rowingDistance:
        try toDistanceActivityRecordDto(distanceActivityType: .rowing)
    case .paddleSportsDistance:
        try toDistanceActivityRecordDto(
            distanceActivityType: .paddleSports
        )
    case .crossCountrySkiingDistance:
        try toDistanceActivityRecordDto(
            distanceActivityType: .crossCountrySkiing
        )
    case .skatingSportsDistance:
        try toDistanceActivityRecordDto(
            distanceActivityType: .skatingSports
        )
    case .sixMinuteWalkTestDistance:
        try toDistanceActivityRecordDto(
            distanceActivityType: .sixMinuteWalkTest
        )
    case .walkingSpeed:
        try toSpeedActivityRecordDto(speedActivityType: .walking)
    case .runningSpeed:
        try toSpeedActivityRecordDto(speedActivityType: .running)
    case .stairAscentSpeed:
        try toSpeedActivityRecordDto(speedActivityType: .stairAscent)
    case .stairDescentSpeed:
        try toSpeedActivityRecordDto(speedActivityType: .stairDescent)
    case .cyclingPower:
        try toCyclingPowerRecordDto()
    case .runningPower:
        try toRunningPowerRecordDto()
    case .cyclingPedalingCadence:
        try toCyclingPedalingCadenceRecordDto()
    case .walkingSteadiness:
        try toWalkingSteadinessRecordDto()
    case .walkingAsymmetryPercentage:
        try toWalkingAsymmetryPercentageRecordDto()
    case .walkingDoubleSupportPercentage:
        try toWalkingDoubleSupportPercentageRecordDto()
    case .walkingStepLength:
        try toWalkingStepLengthRecordDto()
    default:
        nil
    }
}

private func toVitalsRecordDto(for type: HealthDataTypeDto) throws -> HealthRecordDto? {
    switch type {
    case .heartRateMeasurementRecord:
        try toHeartRateRecordDto()
    case .restingHeartRate:
        try toRestingHeartRateRecordDto()
    case .heartRateVariabilitySDNN:
        try toHeartRateVariabilitySDNNRecordDto()
    case .bloodGlucose:
        try toBloodGlucoseRecordDto()
    case .systolicBloodPressure:
        try toSystolicBloodPressureRecordDto()
    case .diastolicBloodPressure:
        try toDiastolicBloodPressureRecordDto()
    case .respiratoryRate:
        try toRespiratoryRateRecordDto()
    case .oxygenSaturation:
        try toOxygenSaturationRecordDto()
    case .vo2Max:
        try toVo2MaxRecordDto()
    case .hydration:
        try toHydrationRecordDto()
    default:
        nil
    }
}
