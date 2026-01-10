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
        case let dto as CyclingPedalingCadenceRecordDto:
            return try dto.toHealthKit()
        case let dto as ExerciseSessionRecordDto:
            return try dto.toHealthKit()
        case let dto as MindfulnessSessionRecordDto:
            return try dto.toHealthKit()
        case let dto as OvulationTestRecordDto:
            return try dto.toHealthKit()
        case let dto as IntermenstrualBleedingRecordDto:
            return try dto.toHealthKit()
        case let dto as MenstrualFlowRecordDto:
            return try dto.toHealthKit()
        case let dto as BodyMassIndexRecordDto:
            return try dto.toHealthKit()
        case let dto as HeartRateVariabilitySDNNRecordDto:
            return try dto.toHealthKit()
        case let dto as WaistCircumferenceRecordDto:
            return try dto.toHealthKit()
        case let dto as DietaryEnergyConsumedRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as CaffeineNutrientRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as ProteinNutrientRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as TotalCarbohydrateNutrientRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as TotalFatNutrientRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as SaturatedFatNutrientRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as MonounsaturatedFatNutrientRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as PolyunsaturatedFatNutrientRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as CholesterolNutrientRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as DietaryFiberNutrientRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as SugarNutrientRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as VitaminANutrientRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as VitaminB6NutrientRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as VitaminB12NutrientRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as VitaminCNutrientRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as VitaminDNutrientRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as VitaminENutrientRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as VitaminKNutrientRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as ThiaminNutrientRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as RiboflavinNutrientRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as NiacinNutrientRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as FolateNutrientRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as BiotinNutrientRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as PantothenicAcidNutrientRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as CalciumNutrientRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as IronNutrientRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as MagnesiumNutrientRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as ManganeseNutrientRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as PhosphorusNutrientRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as PotassiumNutrientRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as SeleniumNutrientRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as SodiumNutrientRecordDto:
            return try dto.toHealthKitQuantitySample()
        case let dto as ZincNutrientRecordDto:
            return try dto.toHealthKitQuantitySample()
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
            message: "Unsupported HKSample type",
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
        case .intermenstrualBleeding:
            try toIntermenstrualBleedingRecordDto()
        case .menstrualFlow:
            try toMenstrualFlowRecordDto()
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
            try toCaffeineNutrientDto()
        case .protein:
            try toProteinNutrientDto()
        case .totalCarbohydrate:
            try toTotalCarbohydrateNutrientDto()
        case .totalFat:
            try toTotalFatNutrientDto()
        case .saturatedFat:
            try toSaturatedFatNutrientDto()
        case .monounsaturatedFat:
            try toMonounsaturatedFatNutrientDto()
        case .polyunsaturatedFat:
            try toPolyunsaturatedFatNutrientDto()
        case .cholesterol:
            try toCholesterolNutrientDto()
        case .dietaryFiber:
            try toDietaryFiberNutrientDto()
        case .sugar:
            try toSugarNutrientDto()
        case .vitaminA:
            try toVitaminANutrientDto()
        case .vitaminB6:
            try toVitaminB6NutrientDto()
        case .vitaminB12:
            try toVitaminB12NutrientDto()
        case .vitaminC:
            try toVitaminCNutrientDto()
        case .vitaminD:
            try toVitaminDNutrientDto()
        case .vitaminE:
            try toVitaminENutrientDto()
        case .vitaminK:
            try toVitaminKNutrientDto()
        case .thiamin:
            try toThiaminNutrientDto()
        case .riboflavin:
            try toRiboflavinNutrientDto()
        case .niacin:
            try toNiacinNutrientDto()
        case .folate:
            try toFolateNutrientDto()
        case .biotin:
            try toBiotinNutrientDto()
        case .pantothenicAcid:
            try toPantothenicAcidNutrientDto()
        case .calcium:
            try toCalciumNutrientDto()
        case .iron:
            try toIronNutrientDto()
        case .magnesium:
            try toMagnesiumNutrientDto()
        case .manganese:
            try toManganeseNutrientDto()
        case .phosphorus:
            try toPhosphorusNutrientDto()
        case .potassium:
            try toPotassiumNutrientDto()
        case .selenium:
            try toSeleniumNutrientDto()
        case .sodium:
            try toSodiumNutrientDto()
        case .zinc:
            try toZincNutrientDto()
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
