import Foundation
import HealthKit

/// Central delegation for mapping `HealthRecordDto` → `HKSample`.
extension HealthRecordDto {
    /// Converts this DTO to its corresponding HealthKit sample.
    ///
    /// - Returns: A HealthKit sample
    /// - Throws: `HealthConnectorError.unsupportedOperation` if the DTO type has no mapping
    func toHealthKit() throws -> HKSample {
        switch self {
        case let dto as ActiveEnergyBurnedRecordDto:
            return try dto.toHealthKit()
        case let dto as AlcoholicBeveragesRecordDto:
            return try dto.toHealthKit()
        case let dto as BloodAlcoholContentRecordDto:
            return try dto.toHealthKit()
        case let dto as BasalEnergyBurnedRecordDto:
            return try dto.toHealthKit()
        case let dto as BloodGlucoseRecordDto:
            return try dto.toHealthKit()
        case let dto as BodyFatPercentageRecordDto:
            return try dto.toHealthKit()
        case let dto as BodyTemperatureRecordDto:
            return try dto.toHealthKit()
        case let dto as BasalBodyTemperatureRecordDto:
            return try dto.toHealthKit()
        case let dto as CervicalMucusRecordDto:
            return try dto.toHealthKit()
        case let dto as DiastolicBloodPressureRecordDto:
            return try dto.toHealthKit()
        case let dto as DistanceActivityRecordDto:
            return try dto.toHealthKit()
        case let dto as FloorsClimbedRecordDto:
            return try dto.toHealthKit()
        case let dto as HeartRateRecordDto:
            return try dto.toHealthKit()
        case let dto as HeightRecordDto:
            return try dto.toHealthKit()
        case let dto as HydrationRecordDto:
            return try dto.toHealthKit()
        case let dto as LeanBodyMassRecordDto:
            return try dto.toHealthKit()
        case let dto as OxygenSaturationRecordDto:
            return try dto.toHealthKit()
        case let dto as RespiratoryRateRecordDto:
            return try dto.toHealthKit()
        case let dto as RestingHeartRateRecordDto:
            return try dto.toHealthKit()
        case let dto as StepsRecordDto:
            return try dto.toHealthKit()
        case let dto as SystolicBloodPressureRecordDto:
            return try dto.toHealthKit()
        case let dto as Vo2MaxRecordDto:
            return try dto.toHealthKit()
        case let dto as WeightRecordDto:
            return try dto.toHealthKit()
        case let dto as WheelchairPushesRecordDto:
            return try dto.toHealthKit()
        case let dto as BloodPressureRecordDto:
            return try dto.toHealthKit()
        case let dto as NutritionRecordDto:
            return try dto.toHealthKit()
        case let dto as SexualActivityRecordDto:
            return try dto.toHealthKit()
        case let dto as SleepStageRecordDto:
            return try dto.toHealthKit()
        case let dto as SpeedActivityRecordDto:
            return try dto.toHealthKit()
        case let dto as CyclingPowerRecordDto:
            return try dto.toHealthKit()
        case let dto as RunningPowerRecordDto:
            return try dto.toHealthKit()
        case let dto as CyclingPedalingCadenceRecordDto:
            return try dto.toHealthKit()
        case let dto as ExerciseSessionRecordDto:
            return try dto.toHealthKit()
        case let dto as MindfulnessSessionRecordDto:
            return try dto.toHealthKit()
        case let dto as OvulationTestRecordDto:
            return try dto.toHealthKit()
        case let dto as PregnancyTestRecordDto:
            return try dto.toHealthKit()
        case let dto as ProgesteroneTestRecordDto:
            return try dto.toHealthKit()
        case let dto as IntermenstrualBleedingRecordDto:
            return try dto.toHealthKit()
        case let dto as MenstrualFlowRecordDto:
            return try dto.toHealthKit()
        case let dto as PregnancyRecordDto:
            return try dto.toHealthKit()
        case let dto as ContraceptiveRecordDto:
            return try dto.toHealthKit()
        case let dto as LactationRecordDto:
            return try dto.toHealthKit()
        case let dto as BodyMassIndexRecordDto:
            return try dto.toHealthKit()
        case let dto as HeartRateVariabilitySDNNRecordDto:
            return try dto.toHealthKit()
        case let dto as WaistCircumferenceRecordDto:
            return try dto.toHealthKit()
        case let dto as DietaryEnergyConsumedRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as DietaryCaffeineRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as DietaryProteinRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as DietaryTotalCarbohydrateRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as DietaryTotalFatRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as DietarySaturatedFatRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as DietaryMonounsaturatedFatRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as DietaryPolyunsaturatedFatRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as DietaryCholesterolRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as DietaryFiberRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as DietarySugarRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as DietaryVitaminARecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as DietaryVitaminB6RecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as DietaryVitaminB12RecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as DietaryVitaminCRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as DietaryVitaminDRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as DietaryVitaminERecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as DietaryVitaminKRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as DietaryThiaminRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as DietaryRiboflavinRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as DietaryNiacinRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as DietaryFolateRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as DietaryBiotinRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as DietaryPantothenicAcidRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as DietaryCalciumRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as DietaryIronRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as DietaryMagnesiumRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as DietaryManganeseRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as DietaryPhosphorusRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as DietaryPotassiumRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as DietarySeleniumRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as DietarySodiumRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as DietaryZincRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as SwimmingStrokesRecordDto:
            return try dto.toHealthKit()
        default:
            throw HealthConnectorError.unsupportedOperation(
                message:
                "HealthRecordDto type '\(type(of: self))' does not have a HealthKit mapping implementation",
                context: [
                    "dtoType": String(describing: type(of: self)),
                    "availableTypes": "See mapper files in health_record_mappers/",
                ]
            )
        }
    }
}

extension HKSample {
    func toDto() throws -> HealthRecordDto {
        let dataType = try healthDataType

        if let categorySample = self as? HKCategorySample {
            return try categorySample.mapCategorySampleToDto(for: dataType)
        } else if let correlation = self as? HKCorrelation {
            return try correlation.mapCorrelationSampleToDto(for: dataType)
        } else if let quantitySample = self as? HKQuantitySample {
            return try quantitySample.mapQuantitySampleToDto(for: dataType)
        } else if let workout = self as? HKWorkout {
            return try workout.toExerciseSessionRecordDto()
        }

        throw HealthConnectorError.invalidArgument(
            message: "Unsupported or unimplemented `HKSample.toDto` for data type",
            context: [
                "sampleType": String(describing: type(of: self)),
                "healthDataType": dataType.rawValue,
            ]
        )
    }
}

/// Central delegation for mapping `HKCategorySample` → `HealthRecordDto`.
extension HKCategorySample {
    /// Converts this HealthKit category sample to a DTO.
    ///
    /// - Returns: The corresponding HealthRecordDto
    /// - Throws: `HealthConnectorError.invalidArgument` if the sample cannot be converted
    func mapCategorySampleToDto(for type: HealthDataTypeDto) throws -> HealthRecordDto {
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
            if #available(iOS 14.3, *) {
                try toPregnancyRecordDto()
            } else {
                throw HealthConnectorError.unsupportedOperation(
                    message: "Pregnancy is only supported on iOS 14.3 and later",
                    context: ["dataType": "pregnancy", "minimumIOSVersion": "14.3"]
                )
            }
        case .contraceptive:
            if #available(iOS 14.3, *) {
                try toContraceptiveRecordDto()
            } else {
                throw HealthConnectorError.unsupportedOperation(
                    message: "Contraceptive is only supported on iOS 14.3 and later",
                    context: ["dataType": "contraceptive", "minimumIOSVersion": "14.3"]
                )
            }
        case .lactation:
            if #available(iOS 14.3, *) {
                try toLactationRecordDto()
            } else {
                throw HealthConnectorError.unsupportedOperation(
                    message: "Lactation is only supported on iOS 14.3 and later",
                    context: ["dataType": "lactation", "minimumIOSVersion": "14.3"]
                )
            }
        default:
            throw HealthConnectorError.invalidArgument(
                message: "Unsupported health data type for HKCategorySample",
                context: [
                    "type": type.rawValue,
                    "categoryType": categoryType.identifier,
                ]
            )
        }
    }
}

/// Central delegation for mapping `HKCorrelation` → `HealthRecordDto`.
extension HKCorrelation {
    /// Converts this HealthKit correlation to a DTO for the specified health data type.
    ///
    /// - Parameter type: The health data type to convert to
    /// - Returns: The corresponding HealthRecordDto
    /// - Throws: `HealthConnectorError.invalidArgument` if the correlation cannot be converted
    func mapCorrelationSampleToDto(for type: HealthDataTypeDto) throws -> HealthRecordDto {
        switch type {
        case .bloodPressure:
            try toBloodPressureRecordDto()
        case .nutrition:
            try toNutritionRecordDto()
        default:
            throw HealthConnectorError.invalidArgument(
                message: "Unsupported health data type for HKCorrelation",
                context: [
                    "type": type.rawValue,
                    "correlationType": correlationType.identifier,
                ]
            )
        }
    }
}

/// Central delegation for mapping `HKQuantitySample` → `HealthRecordDto`.
extension HKQuantitySample {
    /// Converts this HealthKit quantity sample to a DTO for the specified health data type.
    ///
    /// - Parameter type: The health data type to convert to
    /// - Returns: The corresponding HealthRecordDto
    /// - Throws: `HealthConnectorError.invalidArgument` if the sample cannot be converted
    func mapQuantitySampleToDto(for type: HealthDataTypeDto) throws -> HealthRecordDto {
        switch type {
        case .steps:
            try toStepsRecordDto()
        case .weight:
            try toWeightRecordDto()
        case .height:
            try toHeightRecordDto()
        case .activeCaloriesBurned:
            try toActiveEnergyBurnedRecordDto()
        case .alcoholicBeverages:
            try toAlcoholicBeveragesRecordDto()
        case .bloodAlcoholContent:
            try toBloodAlcoholContentRecordDto()
        case .basalEnergyBurned:
            try toBasalEnergyBurnedRecordDto()
        case .bodyFatPercentage:
            try toBodyFatPercentageRecordDto()
        case .bodyTemperature:
            try toBodyTemperatureRecordDto()
        case .basalBodyTemperature:
            try toBasalBodyTemperatureRecordDto()
        case .floorsClimbed:
            try toFloorsClimbedRecordDto()
        case .heartRateMeasurementRecord:
            try toHeartRateRecordDto()
        case .hydration:
            try toHydrationRecordDto()
        case .leanBodyMass:
            try toLeanBodyMassRecordDto()
        case .oxygenSaturation:
            try toOxygenSaturationRecordDto()
        case .respiratoryRate:
            try toRespiratoryRateRecordDto()
        case .restingHeartRate:
            try toRestingHeartRateRecordDto()
        case .vo2Max:
            try toVo2MaxRecordDto()
        case .wheelchairPushes:
            try toWheelchairPushesRecordDto()
        case .bloodGlucose:
            try toBloodGlucoseRecordDto()
        case .systolicBloodPressure:
            try toSystolicBloodPressureRecordDto()
        case .diastolicBloodPressure:
            try toDiastolicBloodPressureRecordDto()
        case .cyclingDistance:
            try toDistanceActivityRecordDto(distanceActivityType: .cycling)
        case .swimmingDistance:
            try toDistanceActivityRecordDto(distanceActivityType: .swimming)
        case .wheelchairDistance:
            try toDistanceActivityRecordDto(distanceActivityType: .wheelchair)
        case .walkingRunningDistance:
            try toDistanceActivityRecordDto(distanceActivityType: .walkingRunning)
        case .downhillSnowSportsDistance:
            try toDistanceActivityRecordDto(distanceActivityType: .downhillSnowSports)
        case .rowingDistance:
            try toDistanceActivityRecordDto(distanceActivityType: .rowing)
        case .paddleSportsDistance:
            try toDistanceActivityRecordDto(distanceActivityType: .paddleSports)
        case .crossCountrySkiingDistance:
            try toDistanceActivityRecordDto(distanceActivityType: .crossCountrySkiing)
        case .skatingSportsDistance:
            try toDistanceActivityRecordDto(distanceActivityType: .skatingSports)
        case .sixMinuteWalkTestDistance:
            try toDistanceActivityRecordDto(distanceActivityType: .sixMinuteWalkTest)
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
        case .bodyMassIndex:
            try toBodyMassIndexRecordDto()
        case .heartRateVariabilitySDNN:
            try toHeartRateVariabilitySDNNRecordDto()
        case .waistCircumference:
            try toWaistCircumferenceRecordDto()
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
        case .swimmingStrokes:
            try toSwimmingStrokesRecordDto()
        default:
            throw HealthConnectorError.invalidArgument(
                message: "Unsupported or unimplemented health data type for HKQuantitySample",
                context: [
                    "type": type.rawValue,
                    "quantityType": quantityType.identifier,
                ]
            )
        }
    }
}
