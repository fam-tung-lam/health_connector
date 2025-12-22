import 'package:health_connector_core/health_connector_core.dart'
    show
        ActiveCaloriesBurnedHealthDataType,
        BiotinNutrientDataType,
        BloodGlucoseHealthDataType,
        BodyFatPercentageHealthDataType,
        BodyTemperatureHealthDataType,
        CaffeineNutrientDataType,
        CalciumNutrientDataType,
        CholesterolNutrientDataType,
        CrossCountrySkiingDistanceDataType,
        CyclingDistanceDataType,
        DietaryFiberNutrientDataType,
        DistanceHealthDataType,
        DownhillSnowSportsDistanceDataType,
        EnergyNutrientDataType,
        FloorsClimbedHealthDataType,
        FolateNutrientDataType,
        HealthDataType,
        HealthRecord,
        HeartRateMeasurementRecordHealthDataType,
        HeartRateSeriesRecordHealthDataType,
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
        OxygenSaturationHealthDataType,
        PaddleSportsDistanceDataType,
        PantothenicAcidNutrientDataType,
        PhosphorusNutrientDataType,
        PolyunsaturatedFatNutrientDataType,
        PotassiumNutrientDataType,
        ProteinNutrientDataType,
        RiboflavinNutrientDataType,
        RestingHeartRateHealthDataType,
        RespiratoryRateHealthDataType,
        RowingDistanceDataType,
        SaturatedFatNutrientDataType,
        SeleniumNutrientDataType,
        SixMinuteWalkTestDistanceDataType,
        SkatingSportsDistanceDataType,
        SleepSessionHealthDataType,
        SleepStageHealthDataType,
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
        WheelchairDistanceDataType,
        WalkingRunningDistanceDataType,
        WheelchairPushesHealthDataType,
        ZincNutrientDataType,
        BloodPressureHealthDataType,
        SystolicBloodPressureHealthDataType,
        DiastolicBloodPressureHealthDataType,
        SpeedSeriesDataType,
        WalkingSpeedDataType,
        RunningSpeedDataType,
        StairAscentSpeedDataType,
        StairDescentSpeedDataType,
        sinceV1_0_0;
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
        return HealthDataType.activeCaloriesBurned;
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
      case HealthDataTypeDto.steps:
        return HealthDataType.steps;
      case HealthDataTypeDto.weight:
        return HealthDataType.weight;
      case HealthDataTypeDto.wheelchairPushes:
        return HealthDataType.wheelchairPushes;
      case HealthDataTypeDto.heartRateSeriesRecord:
        return HealthDataType.heartRateSeriesRecord;
      case HealthDataTypeDto.sleepSession:
        return HealthDataType.sleepSession;

      case HealthDataTypeDto.nutrition:
        return HealthDataType.nutrition;
      case HealthDataTypeDto.restingHeartRate:
        return HealthDataType.restingHeartRate;
      case HealthDataTypeDto.bloodPressure:
        return HealthDataType.bloodPressure;
      case HealthDataTypeDto.oxygenSaturation:
        return HealthDataType.oxygenSaturation;
      case HealthDataTypeDto.respiratoryRate:
        return HealthDataType.respiratoryRate;
      case HealthDataTypeDto.vo2Max:
        return HealthDataType.vo2Max;
      case HealthDataTypeDto.bloodGlucose:
        return HealthDataType.bloodGlucose;
      case HealthDataTypeDto.speedSeries:
        return HealthDataType.speedSeries;
    }
  }
}

/// Converts [HealthDataType] to [HealthDataTypeDto].
@sinceV1_0_0
@internal
extension HealthDataTypeToDto on HealthDataType<HealthRecord, MeasurementUnit> {
  HealthDataTypeDto toDto() {
    switch (this) {
      case ActiveCaloriesBurnedHealthDataType _:
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
      case StepsHealthDataType _:
        return HealthDataTypeDto.steps;
      case WeightHealthDataType _:
        return HealthDataTypeDto.weight;
      case WheelchairPushesHealthDataType _:
        return HealthDataTypeDto.wheelchairPushes;
      case HeartRateSeriesRecordHealthDataType _:
        return HealthDataTypeDto.heartRateSeriesRecord;
      case SleepSessionHealthDataType _:
        return HealthDataTypeDto.sleepSession;
      case EnergyNutrientDataType _:
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
          '$this is not supported on Android Health Connect.',
        );
      case BloodPressureHealthDataType _:
        return HealthDataTypeDto.bloodPressure;
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
      // Distance activity data types (iOS only)
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
          '$this is an iOS-only distance activity data type '
          'and is not supported on Android Health Connect.',
        );
      case SpeedSeriesDataType _:
        return HealthDataTypeDto.speedSeries;
      // Speed activity types (iOS only)
      case WalkingSpeedDataType _:
      case RunningSpeedDataType _:
      case StairAscentSpeedDataType _:
      case StairDescentSpeedDataType _:
        throw UnsupportedError(
          '$this is an iOS-only speed activity data type '
          'and is not supported on Android Health Connect.',
        );
    }
  }
}
