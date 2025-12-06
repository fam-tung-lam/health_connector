import 'package:health_connector_core/health_connector_core.dart'
    show
        ActiveCaloriesBurnedHealthDataType,
        BodyFatPercentageHealthDataType,
        BodyTemperatureHealthDataType,
        DistanceHealthDataType,
        FloorsClimbedHealthDataType,
        HealthDataType,
        HealthRecord,
        HeartRateMeasurementRecordHealthDataType,
        HeartRateSeriesRecordHealthDataType,
        HeightHealthDataType,
        SleepSessionHealthDataType,
        SleepStageHealthDataType,
        HydrationHealthDataType,
        LeanBodyMassHealthDataType,
        MeasurementUnit,
        StepsHealthDataType,
        WeightHealthDataType,
        WheelchairPushesHealthDataType,
        PolyunsaturatedFatNutrientDataType,
        NutritionHealthDataType,
        EnergyNutrientDataType,
        CaffeineNutrientDataType,
        ProteinNutrientDataType,
        TotalCarbohydrateNutrientDataType,
        TotalFatNutrientDataType,
        SaturatedFatNutrientDataType,
        MonounsaturatedFatNutrientDataType,
        CholesterolNutrientDataType,
        DietaryFiberNutrientDataType,
        SugarNutrientDataType,
        CalciumNutrientDataType,
        IronNutrientDataType,
        MagnesiumNutrientDataType,
        ManganeseNutrientDataType,
        PhosphorusNutrientDataType,
        PotassiumNutrientDataType,
        SeleniumNutrientDataType,
        SodiumNutrientDataType,
        ZincNutrientDataType,
        VitaminANutrientDataType,
        VitaminB6NutrientDataType,
        VitaminB12NutrientDataType,
        VitaminCNutrientDataType,
        VitaminDNutrientDataType,
        VitaminENutrientDataType,
        VitaminKNutrientDataType,
        ThiaminNutrientDataType,
        RiboflavinNutrientDataType,
        NiacinNutrientDataType,
        FolateNutrientDataType,
        BiotinNutrientDataType,
        PantothenicAcidNutrientDataType;
import 'package:health_connector_hk_ios/src/pigeon/health_connector_platform_api.g.dart'
    show HealthDataTypeDto;
import 'package:meta/meta.dart' show internal;

/// Converts [HealthDataTypeDto] to [HealthDataType].
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
      case HealthDataTypeDto.heartRateMeasurementRecord:
        return HealthDataType.heartRateMeasurementRecord;
      case HealthDataTypeDto.sleepStageRecord:
        return HealthDataType.sleepStageRecord;
    }
  }
}

/// Converts [HealthDataType] to [HealthDataTypeDto].
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
      case HeartRateMeasurementRecordHealthDataType _:
        return HealthDataTypeDto.heartRateMeasurementRecord;
      case SleepStageHealthDataType _:
        return HealthDataTypeDto.sleepStageRecord;
      case NutritionHealthDataType _:
        throw UnimplementedError();
      case EnergyNutrientDataType _:
        throw UnimplementedError();
      case CaffeineNutrientDataType _:
        throw UnimplementedError();
      case ProteinNutrientDataType _:
        throw UnimplementedError();
      case TotalCarbohydrateNutrientDataType _:
        throw UnimplementedError();
      case TotalFatNutrientDataType _:
        throw UnimplementedError();
      case SaturatedFatNutrientDataType _:
        throw UnimplementedError();
      case MonounsaturatedFatNutrientDataType _:
        throw UnimplementedError();
      case PolyunsaturatedFatNutrientDataType _:
        throw UnimplementedError();
      case CholesterolNutrientDataType _:
        throw UnimplementedError();
      case DietaryFiberNutrientDataType _:
        throw UnimplementedError();
      case SugarNutrientDataType _:
        throw UnimplementedError();
      case CalciumNutrientDataType _:
        throw UnimplementedError();
      case IronNutrientDataType _:
        throw UnimplementedError();
      case MagnesiumNutrientDataType _:
        throw UnimplementedError();
      case ManganeseNutrientDataType _:
        throw UnimplementedError();
      case PhosphorusNutrientDataType _:
        throw UnimplementedError();
      case PotassiumNutrientDataType _:
        throw UnimplementedError();
      case SeleniumNutrientDataType _:
        throw UnimplementedError();
      case SodiumNutrientDataType _:
        throw UnimplementedError();
      case ZincNutrientDataType _:
        throw UnimplementedError();
      case VitaminANutrientDataType _:
        throw UnimplementedError();
      case VitaminB6NutrientDataType _:
        throw UnimplementedError();
      case VitaminB12NutrientDataType _:
        throw UnimplementedError();
      case VitaminCNutrientDataType _:
        throw UnimplementedError();
      case VitaminDNutrientDataType _:
        throw UnimplementedError();
      case VitaminENutrientDataType _:
        throw UnimplementedError();
      case VitaminKNutrientDataType _:
        throw UnimplementedError();
      case ThiaminNutrientDataType _:
        throw UnimplementedError();
      case RiboflavinNutrientDataType _:
        throw UnimplementedError();
      case NiacinNutrientDataType _:
        throw UnimplementedError();
      case FolateNutrientDataType _:
        throw UnimplementedError();
      case BiotinNutrientDataType _:
        throw UnimplementedError();
      case PantothenicAcidNutrientDataType _:
        throw UnimplementedError();
      case SleepSessionHealthDataType _:
        throw UnsupportedError(
          '$SleepSessionHealthDataType is not supported on iOS. '
          'Use $SleepStageHealthDataType instead.',
        );
      case HeartRateSeriesRecordHealthDataType _:
        throw UnsupportedError(
          '$HeartRateSeriesRecordHealthDataType is not supported on iOS. '
          'Use $HeartRateMeasurementRecordHealthDataType instead.',
        );
    }
  }
}
