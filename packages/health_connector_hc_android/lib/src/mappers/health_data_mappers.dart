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
        HydrationHealthDataType,
        SleepSessionHealthDataType,
        LeanBodyMassHealthDataType,
        MeasurementUnit,
        StepsHealthDataType,
        WeightHealthDataType,
        WheelchairPushesHealthDataType,
        SleepStageHealthDataType;
import 'package:health_connector_hc_android/src/pigeon/health_connector_platform_api.g.dart'
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
      case HealthDataTypeDto.heartRateSeriesRecord:
        return HealthDataType.heartRateSeriesRecord;
      case HealthDataTypeDto.sleepSession:
        return HealthDataType.sleepSession;
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
      case HeartRateSeriesRecordHealthDataType _:
        return HealthDataTypeDto.heartRateSeriesRecord;
      case SleepSessionHealthDataType _:
        return HealthDataTypeDto.sleepSession;
      case SleepStageHealthDataType _:
        throw UnsupportedError(
          '$SleepStageHealthDataType is not supported on Android. '
          'Use $SleepSessionHealthDataType instead.',
        );
      case HeartRateMeasurementRecordHealthDataType _:
        throw UnsupportedError(
          '$HeartRateMeasurementRecordHealthDataType is not supported on '
          'Android. Use $HeartRateSeriesRecordHealthDataType instead.',
        );
    }
  }
}
