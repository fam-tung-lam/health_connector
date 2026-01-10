import 'package:health_connector_core/health_connector_core_internal.dart'
    show
        ActiveEnergyBurnedHealthDataType,
        BiotinNutrientDataType,
        BloodGlucoseHealthDataType,
        BodyFatPercentageHealthDataType,
        BodyMassIndexHealthDataType,
        BodyTemperatureHealthDataType,
        BasalBodyTemperatureHealthDataType,
        BoneMassDataType,
        BodyWaterMassDataType,
        CaffeineNutrientDataType,
        CalciumNutrientDataType,
        CervicalMucusDataType,
        CholesterolNutrientDataType,
        CrossCountrySkiingDistanceDataType,
        CyclingDistanceDataType,
        CyclingPedalingCadenceMeasurementRecordHealthDataType,
        CyclingPedalingCadenceSeriesRecordHealthDataType,
        CyclingPowerDataType,
        DietaryFiberNutrientDataType,
        DistanceHealthDataType,
        DownhillSnowSportsDistanceDataType,
        DietaryEnergyConsumedDataType,
        ExerciseSessionHealthDataType,
        FloorsClimbedHealthDataType,
        FolateNutrientDataType,
        HealthDataType,
        HealthRecord,
        HeartRateMeasurementRecordHealthDataType,
        HeartRateSeriesRecordHealthDataType,
        HeartRateVariabilityRMSSDDataType,
        HeartRateVariabilitySDNNDataType,
        HeightHealthDataType,
        HydrationHealthDataType,
        IronNutrientDataType,
        LeanBodyMassHealthDataType,
        MagnesiumNutrientDataType,
        ManganeseNutrientDataType,
        MeasurementUnit,
        MonounsaturatedFatNutrientDataType,
        NiacinNutrientDataType,
        NutritionHealthDataType,
        IntermenstrualBleedingDataType,
        MenstrualFlowDataType,
        MenstrualFlowInstantDataType,
        OvulationTestDataType,
        OxygenSaturationHealthDataType,
        PaddleSportsDistanceDataType,
        PantothenicAcidNutrientDataType,
        PhosphorusNutrientDataType,
        PolyunsaturatedFatNutrientDataType,
        PotassiumNutrientDataType,
        PowerSeriesDataType,
        ProteinNutrientDataType,
        RiboflavinNutrientDataType,
        RestingHeartRateHealthDataType,
        RespiratoryRateHealthDataType,
        RowingDistanceDataType,
        SaturatedFatNutrientDataType,
        SeleniumNutrientDataType,
        SexualActivityDataType,
        SixMinuteWalkTestDistanceDataType,
        SkatingSportsDistanceDataType,
        SleepSessionHealthDataType,
        SleepStageHealthDataType,
        MindfulnessSessionDataType,
        SodiumNutrientDataType,
        StepsHealthDataType,
        SugarNutrientDataType,
        SwimmingDistanceDataType,
        ThiaminNutrientDataType,
        TotalCarbohydrateNutrientDataType,
        TotalFatNutrientDataType,
        VitaminANutrientDataType,
        VitaminB6NutrientDataType,
        VitaminB12NutrientDataType,
        VitaminCNutrientDataType,
        VitaminDNutrientDataType,
        VitaminENutrientDataType,
        VitaminKNutrientDataType,
        Vo2MaxHealthDataType,
        WeightHealthDataType,
        WaistCircumferenceHealthDataType,
        WheelchairDistanceDataType,
        WalkingRunningDistanceDataType,
        WheelchairPushesHealthDataType,
        ZincNutrientDataType,
        BloodPressureHealthDataType,
        SystolicBloodPressureHealthDataType,
        DiastolicBloodPressureHealthDataType,
        SpeedSeriesDataType,
        TotalEnergyBurnedHealthDataType,
        WalkingSpeedDataType,
        RunningSpeedDataType,
        StairAscentSpeedDataType,
        StairDescentSpeedDataType,
        sinceV1_0_0,
        BasalEnergyBurnedHealthDataType;
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show HealthDataTypeDto;
import 'package:meta/meta.dart' show internal;

/// Converts [HealthDataTypeDto] to [HealthDataType].
@sinceV1_0_0
@internal
extension HealthDataTypeDtoToDomain on HealthDataTypeDto {
  HealthDataType<HealthRecord, MeasurementUnit> toDomain() {
    switch (this) {
      case HealthDataTypeDto.activeCaloriesBurned:
        return HealthDataType.activeEnergyBurned;
      case HealthDataTypeDto.distance:
        return HealthDataType.distance;
      case HealthDataTypeDto.floorsClimbed:
        return HealthDataType.floorsClimbed;
      case HealthDataTypeDto.height:
        return HealthDataType.height;
      case HealthDataTypeDto.hydration:
        return HealthDataType.hydration;
      case HealthDataTypeDto.leanBodyMass:
        return HealthDataType.leanBodyMass;
      case HealthDataTypeDto.bodyFatPercentage:
        return HealthDataType.bodyFatPercentage;
      case HealthDataTypeDto.bodyTemperature:
        return HealthDataType.bodyTemperature;
      case HealthDataTypeDto.basalBodyTemperature:
        return HealthDataType.basalBodyTemperature;
      case HealthDataTypeDto.cervicalMucus:
        return HealthDataType.cervicalMucus;
      case HealthDataTypeDto.steps:
        return HealthDataType.steps;
      case HealthDataTypeDto.weight:
        return HealthDataType.weight;
      case HealthDataTypeDto.wheelchairPushes:
        return HealthDataType.wheelchairPushes;
      case HealthDataTypeDto.heartRateSeriesRecord:
        return HealthDataType.heartRateSeriesRecord;
      case HealthDataTypeDto.cyclingPedalingCadenceSeriesRecord:
        return HealthDataType.cyclingPedalingCadenceSeriesRecord;
      case HealthDataTypeDto.sexualActivity:
        return HealthDataType.sexualActivity;
      case HealthDataTypeDto.sleepSession:
        return HealthDataType.sleepSession;
      case HealthDataTypeDto.exerciseSession:
        return HealthDataType.exerciseSession;

      case HealthDataTypeDto.nutrition:
        return HealthDataType.nutrition;
      case HealthDataTypeDto.restingHeartRate:
        return HealthDataType.restingHeartRate;
      case HealthDataTypeDto.bloodPressure:
        return HealthDataType.bloodPressure;
      case HealthDataTypeDto.ovulationTest:
        return HealthDataType.ovulationTest;
      case HealthDataTypeDto.intermenstrualBleeding:
        return HealthDataType.intermenstrualBleeding;
      case HealthDataTypeDto.menstrualFlowInstant:
        return HealthDataType.menstrualFlowInstant;
      case HealthDataTypeDto.oxygenSaturation:
        return HealthDataType.oxygenSaturation;
      case HealthDataTypeDto.respiratoryRate:
        return HealthDataType.respiratoryRate;
      case HealthDataTypeDto.vo2Max:
        return HealthDataType.vo2Max;
      case HealthDataTypeDto.bloodGlucose:
        return HealthDataType.bloodGlucose;
      case HealthDataTypeDto.powerSeries:
        return HealthDataType.powerSeries;
      case HealthDataTypeDto.speedSeries:
        return HealthDataType.speedSeries;
      case HealthDataTypeDto.totalCaloriesBurned:
        return HealthDataType.totalEnergyBurned;
      case HealthDataTypeDto.mindfulnessSession:
        return HealthDataType.mindfulnessSession;
      case HealthDataTypeDto.boneMass:
        return HealthDataType.boneMass;
      case HealthDataTypeDto.bodyWaterMass:
        return HealthDataType.bodyWaterMass;
      case HealthDataTypeDto.heartRateVariabilityRMSSD:
        return HealthDataType.heartRateVariabilityRMSSD;
    }
  }
}

/// Converts [HealthDataType] to [HealthDataTypeDto].
@sinceV1_0_0
@internal
extension HealthDataTypeToDto on HealthDataType<HealthRecord, MeasurementUnit> {
  HealthDataTypeDto toDto() {
    switch (this) {
      case ActiveEnergyBurnedHealthDataType _:
        return HealthDataTypeDto.activeCaloriesBurned;
      case DistanceHealthDataType _:
        return HealthDataTypeDto.distance;
      case FloorsClimbedHealthDataType _:
        return HealthDataTypeDto.floorsClimbed;
      case HeightHealthDataType _:
        return HealthDataTypeDto.height;
      case HydrationHealthDataType _:
        return HealthDataTypeDto.hydration;
      case LeanBodyMassHealthDataType _:
        return HealthDataTypeDto.leanBodyMass;
      case BodyFatPercentageHealthDataType _:
        return HealthDataTypeDto.bodyFatPercentage;
      case BodyTemperatureHealthDataType _:
        return HealthDataTypeDto.bodyTemperature;
      case BasalBodyTemperatureHealthDataType _:
        return HealthDataTypeDto.basalBodyTemperature;
      case CervicalMucusDataType _:
        return HealthDataTypeDto.cervicalMucus;
      case StepsHealthDataType _:
        return HealthDataTypeDto.steps;
      case WeightHealthDataType _:
        return HealthDataTypeDto.weight;
      case WheelchairPushesHealthDataType _:
        return HealthDataTypeDto.wheelchairPushes;
      case HeartRateSeriesRecordHealthDataType _:
        return HealthDataTypeDto.heartRateSeriesRecord;
      case CyclingPedalingCadenceSeriesRecordHealthDataType _:
        return HealthDataTypeDto.cyclingPedalingCadenceSeriesRecord;
      case SexualActivityDataType _:
        return HealthDataTypeDto.sexualActivity;
      case SleepSessionHealthDataType _:
        return HealthDataTypeDto.sleepSession;
      case ExerciseSessionHealthDataType _:
        return HealthDataTypeDto.exerciseSession;
      case MindfulnessSessionDataType _:
        return HealthDataTypeDto.mindfulnessSession;
      case BoneMassDataType _:
        return HealthDataTypeDto.boneMass;
      case BodyWaterMassDataType _:
        return HealthDataTypeDto.bodyWaterMass;
      case HeartRateVariabilityRMSSDDataType _:
        return HealthDataTypeDto.heartRateVariabilityRMSSD;
      case BloodPressureHealthDataType _:
        return HealthDataTypeDto.bloodPressure;
      case OvulationTestDataType _:
        return HealthDataTypeDto.ovulationTest;
      case IntermenstrualBleedingDataType _:
        return HealthDataTypeDto.intermenstrualBleeding;
      case MenstrualFlowInstantDataType _:
        return HealthDataTypeDto.menstrualFlowInstant;
      case OxygenSaturationHealthDataType _:
        return HealthDataTypeDto.oxygenSaturation;
      case RespiratoryRateHealthDataType _:
        return HealthDataTypeDto.respiratoryRate;
      case NutritionHealthDataType _:
        return HealthDataTypeDto.nutrition;
      case RestingHeartRateHealthDataType _:
        return HealthDataTypeDto.restingHeartRate;
      case Vo2MaxHealthDataType _:
        return HealthDataTypeDto.vo2Max;
      case BloodGlucoseHealthDataType _:
        return HealthDataTypeDto.bloodGlucose;
      case TotalEnergyBurnedHealthDataType _:
        return HealthDataTypeDto.totalCaloriesBurned;
      case SpeedSeriesDataType _:
        return HealthDataTypeDto.speedSeries;
      case PowerSeriesDataType _:
        return HealthDataTypeDto.powerSeries;
      case DietaryEnergyConsumedDataType _:
      case CaffeineNutrientDataType _:
      case ProteinNutrientDataType _:
      case TotalCarbohydrateNutrientDataType _:
      case TotalFatNutrientDataType _:
      case SaturatedFatNutrientDataType _:
      case MonounsaturatedFatNutrientDataType _:
      case PolyunsaturatedFatNutrientDataType _:
      case CholesterolNutrientDataType _:
      case DietaryFiberNutrientDataType _:
      case SugarNutrientDataType _:
      case VitaminANutrientDataType _:
      case VitaminB6NutrientDataType _:
      case VitaminB12NutrientDataType _:
      case VitaminCNutrientDataType _:
      case VitaminDNutrientDataType _:
      case VitaminENutrientDataType _:
      case VitaminKNutrientDataType _:
      case ThiaminNutrientDataType _:
      case RiboflavinNutrientDataType _:
      case NiacinNutrientDataType _:
      case FolateNutrientDataType _:
      case BiotinNutrientDataType _:
      case PantothenicAcidNutrientDataType _:
      case CalciumNutrientDataType _:
      case IronNutrientDataType _:
      case MagnesiumNutrientDataType _:
      case ManganeseNutrientDataType _:
      case PhosphorusNutrientDataType _:
      case PotassiumNutrientDataType _:
      case SeleniumNutrientDataType _:
      case SodiumNutrientDataType _:
      case ZincNutrientDataType _:
        throw UnsupportedError(
          '$this is not supported on Android Health Connect. '
          'Use $NutritionHealthDataType instead.',
        );
      case BasalEnergyBurnedHealthDataType _:
        throw UnsupportedError(
          '$BasalEnergyBurnedHealthDataType is not supported on '
          'Android Health Connect. Use $TotalEnergyBurnedHealthDataType '
          'and $ActiveEnergyBurnedHealthDataType instead.',
        );
      case SleepStageHealthDataType _:
        throw UnsupportedError(
          '$SleepStageHealthDataType is not supported on '
          'Android Health Connect. Use $SleepSessionHealthDataType instead.',
        );
      case HeartRateMeasurementRecordHealthDataType _:
        throw UnsupportedError(
          '$HeartRateMeasurementRecordHealthDataType is not '
          'supported on Android Health Connect. '
          'Use $HeartRateSeriesRecordHealthDataType instead.',
        );
      case CyclingPedalingCadenceMeasurementRecordHealthDataType _:
        throw UnsupportedError(
          '$CyclingPedalingCadenceMeasurementRecordHealthDataType is not '
          'supported on Android Health Connect. '
          'Use $CyclingPedalingCadenceSeriesRecordHealthDataType instead.',
        );
      case SystolicBloodPressureHealthDataType _:
        throw UnsupportedError(
          '$SystolicBloodPressureHealthDataType is not supported on '
          'Android Health Connect. Use $BloodPressureHealthDataType instead.',
        );
      case DiastolicBloodPressureHealthDataType _:
        throw UnsupportedError(
          '$DiastolicBloodPressureHealthDataType is not supported on '
          'Health Connect. Use $BloodPressureHealthDataType instead.',
        );
      case CyclingDistanceDataType _:
      case SwimmingDistanceDataType _:
      case WheelchairDistanceDataType _:
      case DownhillSnowSportsDistanceDataType _:
      case RowingDistanceDataType _:
      case PaddleSportsDistanceDataType _:
      case CrossCountrySkiingDistanceDataType _:
      case SkatingSportsDistanceDataType _:
      case SixMinuteWalkTestDistanceDataType _:
      case WalkingRunningDistanceDataType _:
        throw UnsupportedError(
          '$this is is not supported on Android Health Connect. '
          'Use general $DistanceHealthDataType instead',
        );
      case CyclingPowerDataType _:
        throw UnsupportedError(
          '$CyclingPowerDataType is not supported on Android Health '
          'Connect. Use general $PowerSeriesDataType instead',
        );
      case WalkingSpeedDataType _:
      case RunningSpeedDataType _:
      case StairAscentSpeedDataType _:
      case StairDescentSpeedDataType _:
        throw UnsupportedError(
          '$this is not supported on Android Health Connect. '
          'Use general $SpeedSeriesDataType instead.',
        );
      case BodyMassIndexHealthDataType _:
        throw UnsupportedError(
          '$BodyMassIndexHealthDataType is not supported on Android '
          'Health Connect. Use $WeightHealthDataType and '
          '$HeightHealthDataType for calculation instead',
        );
      case WaistCircumferenceHealthDataType _:
        throw UnsupportedError(
          '$WaistCircumferenceHealthDataType is not supported on '
          'Android Health Connect.',
        );
      case HeartRateVariabilitySDNNDataType _:
        throw UnsupportedError(
          '$HeartRateVariabilitySDNNDataType is not supported on '
          'Android Health Connect. Use $HeartRateVariabilityRMSSDDataType '
          'instead.',
        );

      case MenstrualFlowDataType _:
        throw UnsupportedError(
          '$MenstrualFlowDataType is not supported on Android Health Connect. '
          'Use $MenstrualFlowInstantDataType instead.',
        );
    }
  }
}
