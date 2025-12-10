// General extensions for dispatching to specific record type mappers
import 'package:health_connector_core/health_connector_core.dart'
    show
        ActiveCaloriesBurnedRecord,
        BloodPressureRecord,
        BodyFatPercentageRecord,
        BodyTemperatureRecord,
        DiastolicBloodPressureRecord,
        DistanceRecord,
        FloorsClimbedRecord,
        HealthRecord,
        HeartRateMeasurementRecord,
        HeartRateSeriesRecord,
        HeightRecord,
        HydrationRecord,
        LeanBodyMassRecord,
        NutrientHealthRecord,
        NutritionRecord,
        SleepSessionRecord,
        SleepStageRecord,
        StepRecord,
        SystolicBloodPressureRecord,
        WeightRecord,
        WheelchairPushesRecord;
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/health_record_mappers.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_platform_api.g.dart'
    show
        ActiveCaloriesBurnedRecordDto,
        BloodPressureRecordDto,
        BodyFatPercentageRecordDto,
        BodyTemperatureRecordDto,
        DistanceRecordDto,
        FloorsClimbedRecordDto,
        HealthRecordDto,
        HeartRateSeriesRecordDto,
        HeightRecordDto,
        HydrationRecordDto,
        LeanBodyMassRecordDto,
        NutritionRecordDto,
        SleepSessionRecordDto,
        StepRecordDto,
        WeightRecordDto,
        WheelchairPushesRecordDto;
import 'package:meta/meta.dart' show internal;

/// Converts [HealthRecord] to [HealthRecordDto].
@internal
extension HealthRecordToDto on HealthRecord {
  HealthRecordDto toDto() {
    switch (this) {
      case final ActiveCaloriesBurnedRecord record:
        return record.toDto();
      case final DistanceRecord record:
        return record.toDto();
      case final FloorsClimbedRecord record:
        return record.toDto();
      case final HeightRecord record:
        return record.toDto();
      case final HydrationRecord record:
        return record.toDto();
      case final LeanBodyMassRecord record:
        return record.toDto();
      case final BodyFatPercentageRecord record:
        return record.toDto();
      case final BodyTemperatureRecord record:
        return record.toDto();
      case final StepRecord record:
        return record.toDto();
      case final WeightRecord record:
        return record.toDto();
      case final WheelchairPushesRecord record:
        return record.toDto();
      case final HeartRateSeriesRecord record:
        return record.toDto();
      case final SleepSessionRecord record:
        return record.toDto();
      case final NutrientHealthRecord record:
        return record.toDto();
      case final NutritionRecord record:
        return record.toDto();
      case final BloodPressureRecord record:
        return record.toDto();
      case final SleepStageRecord _:
        throw UnsupportedError(
          '$SleepStageRecord is not supported on Android. '
          'Use $SleepSessionRecord instead.',
        );
      case final HeartRateMeasurementRecord _:
        throw UnsupportedError(
          '$HeartRateMeasurementRecord is not supported on Android. '
          'Use $HeartRateSeriesRecord instead.',
        );
      case final SystolicBloodPressureRecord _:
        throw UnsupportedError(
          '$SystolicBloodPressureRecord is not supported on '
          'Android Health Connect. Use $BloodPressureRecord instead.',
        );
      case final DiastolicBloodPressureRecord _:
        throw UnsupportedError(
          '$DiastolicBloodPressureRecord is not supported on '
          'Android Health Connect. Use $BloodPressureRecord instead.',
        );
    }
  }
}

/// Converts [HealthRecordDto] to [HealthRecord].
@internal
extension HealthRecordDtoToDomain on HealthRecordDto {
  HealthRecord toDomain() {
    switch (this) {
      case final ActiveCaloriesBurnedRecordDto dto:
        return dto.toDomain();
      case final DistanceRecordDto dto:
        return dto.toDomain();
      case final FloorsClimbedRecordDto dto:
        return dto.toDomain();
      case final HeightRecordDto dto:
        return dto.toDomain();
      case final HydrationRecordDto dto:
        return dto.toDomain();
      case final LeanBodyMassRecordDto dto:
        return dto.toDomain();
      case final BodyFatPercentageRecordDto dto:
        return dto.toDomain();
      case final BodyTemperatureRecordDto dto:
        return dto.toDomain();
      case final StepRecordDto dto:
        return dto.toDomain();
      case final WeightRecordDto dto:
        return dto.toDomain();
      case final WheelchairPushesRecordDto dto:
        return dto.toDomain();
      case final HeartRateSeriesRecordDto dto:
        return dto.toDomain();
      case final SleepSessionRecordDto dto:
        return dto.toDomain();
      case final NutritionRecordDto dto:
        return dto.toDomain();
      case final BloodPressureRecordDto dto:
        return dto.toDomain();
    }
  }
}
