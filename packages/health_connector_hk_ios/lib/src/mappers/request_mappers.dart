import 'package:health_connector_core/health_connector_core.dart'
    show
        ActiveCaloriesBurnedRecord,
        AggregateRequest,
        BodyFatPercentageRecord,
        BodyTemperatureRecord,
        DistanceRecord,
        FloorsClimbedRecord,
        HealthRecord,
        HeartRateMeasurementRecord,
        HeartRateSeriesRecord,
        HeightRecord,
        HydrationRecord,
        LeanBodyMassRecord,
        MeasurementUnit,
        ReadRecordRequest,
        ReadRecordsRequest,
        StepRecord,
        WeightRecord,
        WheelchairPushesRecord;
import 'package:health_connector_hk_ios/src/mappers/'
    'aggregation_metric_mappers.dart';
import 'package:health_connector_hk_ios/src/mappers/health_data_mappers.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_platform_api.g.dart'
    show
        ReadRecordRequestDto,
        ReadRecordsRequestDto,
        AggregateRequestDto,
        WriteRecordRequestDto,
        UpdateRecordRequestDto,
        WriteRecordsRequestDto,
        HealthDataTypeDto;
import 'package:meta/meta.dart' show internal;

/// Converts [ReadRecordRequest] to [ReadRecordRequestDto].
@internal
extension ReadRecordRequestDtoMapper<R extends HealthRecord>
    on ReadRecordRequest<R> {
  ReadRecordRequestDto toDto() {
    return ReadRecordRequestDto(
      dataType: dataType.toDto(),
      recordId: id.toDto(),
    );
  }
}

/// Converts [ReadRecordsRequest] to [ReadRecordsRequestDto].
@internal
extension ReadRecordsRequestDtoMapper<R extends HealthRecord>
    on ReadRecordsRequest<R> {
  ReadRecordsRequestDto toDto() {
    return ReadRecordsRequestDto(
      dataType: dataType.toDto(),
      startTime: startTime.millisecondsSinceEpoch,
      endTime: endTime.millisecondsSinceEpoch,
      pageSize: pageSize,
      pageToken: pageToken,
      dataOriginPackageNames: dataOrigins
          .map((origin) => origin.packageName)
          .toList(),
    );
  }
}

/// Converts [AggregateRequest] to [AggregateRequestDto].
@internal
extension AggregateRequestDtoMapper<
  R extends HealthRecord,
  U extends MeasurementUnit
>
    on AggregateRequest<R, U> {
  AggregateRequestDto toDto() {
    return AggregateRequestDto(
      dataType: dataType.toDto(),
      aggregationMetric: aggregationMetric.toDto(),
      startTime: startTime.millisecondsSinceEpoch,
      endTime: endTime.millisecondsSinceEpoch,
    );
  }
}

/// Converts [HealthRecord] to [WriteRecordRequestDto].
@internal
extension HealthRecordToWriteRequestDto on HealthRecord {
  WriteRecordRequestDto toWriteRecordRequestDto() {
    switch (this) {
      case final ActiveCaloriesBurnedRecord record:
        return WriteRecordRequestDto(
          dataType: HealthDataTypeDto.activeCaloriesBurned,
          activeCaloriesBurnedRecord: record.toDto(),
        );
      case final DistanceRecord record:
        return WriteRecordRequestDto(
          dataType: HealthDataTypeDto.distance,
          distanceRecord: record.toDto(),
        );
      case final FloorsClimbedRecord record:
        return WriteRecordRequestDto(
          dataType: HealthDataTypeDto.floorsClimbed,
          floorsClimbedRecord: record.toDto(),
        );
      case final StepRecord record:
        return WriteRecordRequestDto(
          dataType: HealthDataTypeDto.steps,
          stepsRecord: record.toDto(),
        );
      case final HeightRecord record:
        return WriteRecordRequestDto(
          dataType: HealthDataTypeDto.height,
          heightRecord: record.toDto(),
        );
      case final HydrationRecord record:
        return WriteRecordRequestDto(
          dataType: HealthDataTypeDto.hydration,
          hydrationRecord: record.toDto(),
        );
      case final LeanBodyMassRecord record:
        return WriteRecordRequestDto(
          dataType: HealthDataTypeDto.leanBodyMass,
          leanBodyMassRecord: record.toDto(),
        );
      case final BodyFatPercentageRecord record:
        return WriteRecordRequestDto(
          dataType: HealthDataTypeDto.bodyFatPercentage,
          bodyFatPercentageRecord: record.toDto(),
        );
      case final BodyTemperatureRecord record:
        return WriteRecordRequestDto(
          dataType: HealthDataTypeDto.bodyTemperature,
          bodyTemperatureRecord: record.toDto(),
        );
      case final WeightRecord record:
        return WriteRecordRequestDto(
          dataType: HealthDataTypeDto.weight,
          weightRecord: record.toDto(),
        );
      case final WheelchairPushesRecord record:
        return WriteRecordRequestDto(
          dataType: HealthDataTypeDto.wheelchairPushes,
          wheelchairPushesRecord: record.toDto(),
        );
      case final HeartRateMeasurementRecord record:
        return WriteRecordRequestDto(
          dataType: HealthDataTypeDto.heartRateMeasurementRecord,
          heartRateMeasurementRecord: record.toDto(),
        );
      case final HeartRateSeriesRecord _:
        throw UnsupportedError(
          'HeartRateSeriesRecord is not supported on iOS. '
          'Use HeartRateMeasurementRecord instead.',
        );
    }
  }
}

/// Converts [HealthRecord] to [UpdateRecordRequestDto].
@internal
extension HealthRecordToUpdateRequestDto on HealthRecord {
  UpdateRecordRequestDto toUpdateRecordRequestDto() {
    switch (this) {
      case final ActiveCaloriesBurnedRecord record:
        return UpdateRecordRequestDto(
          dataType: HealthDataTypeDto.activeCaloriesBurned,
          activeCaloriesBurnedRecord: record.toDto(),
        );
      case final DistanceRecord record:
        return UpdateRecordRequestDto(
          dataType: HealthDataTypeDto.distance,
          distanceRecord: record.toDto(),
        );
      case final FloorsClimbedRecord record:
        return UpdateRecordRequestDto(
          dataType: HealthDataTypeDto.floorsClimbed,
          floorsClimbedRecord: record.toDto(),
        );
      case final StepRecord record:
        return UpdateRecordRequestDto(
          dataType: HealthDataTypeDto.steps,
          stepsRecord: record.toDto(),
        );
      case final HeightRecord record:
        return UpdateRecordRequestDto(
          dataType: HealthDataTypeDto.height,
          heightRecord: record.toDto(),
        );
      case final HydrationRecord record:
        return UpdateRecordRequestDto(
          dataType: HealthDataTypeDto.hydration,
          hydrationRecord: record.toDto(),
        );
      case final LeanBodyMassRecord record:
        return UpdateRecordRequestDto(
          dataType: HealthDataTypeDto.leanBodyMass,
          leanBodyMassRecord: record.toDto(),
        );
      case final BodyFatPercentageRecord record:
        return UpdateRecordRequestDto(
          dataType: HealthDataTypeDto.bodyFatPercentage,
          bodyFatPercentageRecord: record.toDto(),
        );
      case final BodyTemperatureRecord record:
        return UpdateRecordRequestDto(
          dataType: HealthDataTypeDto.bodyTemperature,
          bodyTemperatureRecord: record.toDto(),
        );
      case final WeightRecord record:
        return UpdateRecordRequestDto(
          dataType: HealthDataTypeDto.weight,
          weightRecord: record.toDto(),
        );
      case final WheelchairPushesRecord record:
        return UpdateRecordRequestDto(
          dataType: HealthDataTypeDto.wheelchairPushes,
          wheelchairPushesRecord: record.toDto(),
        );
      case final HeartRateMeasurementRecord record:
        return UpdateRecordRequestDto(
          dataType: HealthDataTypeDto.heartRateMeasurementRecord,
          heartRateMeasurementRecord: record.toDto(),
        );
      case final HeartRateSeriesRecord _:
        throw UnsupportedError(
          'HeartRateSeriesRecord is not supported on iOS. '
          'Use HeartRateMeasurementRecord instead.',
        );
    }
  }
}

/// Converts list of domain [HealthRecord] to [WriteRecordsRequestDto].
@internal
extension HealthRecordListToWriteRequestDto on List<HealthRecord> {
  WriteRecordsRequestDto toWriteRecordsRequestDto() {
    if (isEmpty) {
      throw ArgumentError('Cannot create write request from empty record list');
    }

    // Group records by type
    final activeCaloriesBurnedRecords = <ActiveCaloriesBurnedRecord>[];
    final bodyFatPercentageRecords = <BodyFatPercentageRecord>[];
    final bodyTemperatureRecords = <BodyTemperatureRecord>[];
    final distanceRecords = <DistanceRecord>[];
    final floorsClimbedRecords = <FloorsClimbedRecord>[];
    final heightRecords = <HeightRecord>[];
    final hydrationRecords = <HydrationRecord>[];
    final leanBodyMassRecords = <LeanBodyMassRecord>[];
    final stepRecords = <StepRecord>[];
    final weightRecords = <WeightRecord>[];
    final wheelchairPushesRecords = <WheelchairPushesRecord>[];
    final heartRateMeasurementRecords = <HeartRateMeasurementRecord>[];
    final dataTypes = <HealthDataTypeDto>[];

    for (final record in this) {
      switch (record) {
        case final ActiveCaloriesBurnedRecord activeCaloriesBurnedRecord:
          activeCaloriesBurnedRecords.add(activeCaloriesBurnedRecord);
          if (!dataTypes.contains(HealthDataTypeDto.activeCaloriesBurned)) {
            dataTypes.add(HealthDataTypeDto.activeCaloriesBurned);
          }
        case final DistanceRecord distanceRecord:
          distanceRecords.add(distanceRecord);
          if (!dataTypes.contains(HealthDataTypeDto.distance)) {
            dataTypes.add(HealthDataTypeDto.distance);
          }
        case final FloorsClimbedRecord floorsClimbedRecord:
          floorsClimbedRecords.add(floorsClimbedRecord);
          if (!dataTypes.contains(HealthDataTypeDto.floorsClimbed)) {
            dataTypes.add(HealthDataTypeDto.floorsClimbed);
          }
        case final HeightRecord heightRecord:
          heightRecords.add(heightRecord);
          if (!dataTypes.contains(HealthDataTypeDto.height)) {
            dataTypes.add(HealthDataTypeDto.height);
          }
        case final HydrationRecord hydrationRecord:
          hydrationRecords.add(hydrationRecord);
          if (!dataTypes.contains(HealthDataTypeDto.hydration)) {
            dataTypes.add(HealthDataTypeDto.hydration);
          }
        case final LeanBodyMassRecord leanBodyMassRecord:
          leanBodyMassRecords.add(leanBodyMassRecord);
          if (!dataTypes.contains(HealthDataTypeDto.leanBodyMass)) {
            dataTypes.add(HealthDataTypeDto.leanBodyMass);
          }
        case final BodyFatPercentageRecord bodyFatPercentageRecord:
          bodyFatPercentageRecords.add(bodyFatPercentageRecord);
          if (!dataTypes.contains(HealthDataTypeDto.bodyFatPercentage)) {
            dataTypes.add(HealthDataTypeDto.bodyFatPercentage);
          }
        case final BodyTemperatureRecord bodyTemperatureRecord:
          bodyTemperatureRecords.add(bodyTemperatureRecord);
          if (!dataTypes.contains(HealthDataTypeDto.bodyTemperature)) {
            dataTypes.add(HealthDataTypeDto.bodyTemperature);
          }
        case final StepRecord stepRecord:
          stepRecords.add(stepRecord);
          if (!dataTypes.contains(HealthDataTypeDto.steps)) {
            dataTypes.add(HealthDataTypeDto.steps);
          }
        case final WeightRecord weightRecord:
          weightRecords.add(weightRecord);
          if (!dataTypes.contains(HealthDataTypeDto.weight)) {
            dataTypes.add(HealthDataTypeDto.weight);
          }
        case final WheelchairPushesRecord wheelchairPushesRecord:
          wheelchairPushesRecords.add(wheelchairPushesRecord);
          if (!dataTypes.contains(HealthDataTypeDto.wheelchairPushes)) {
            dataTypes.add(HealthDataTypeDto.wheelchairPushes);
          }
        case final HeartRateMeasurementRecord heartRateMeasurementRecord:
          heartRateMeasurementRecords.add(heartRateMeasurementRecord);
          if (!dataTypes.contains(HealthDataTypeDto.heartRateMeasurementRecord)) {
            dataTypes.add(HealthDataTypeDto.heartRateMeasurementRecord);
          }
        case final HeartRateSeriesRecord _:
          throw UnsupportedError(
            'HeartRateSeriesRecord is not supported on iOS. '
            'Use HeartRateMeasurementRecord instead.',
          );
      }
    }

    return WriteRecordsRequestDto(
      dataTypes: dataTypes,
      activeCaloriesBurnedRecords: activeCaloriesBurnedRecords.isEmpty
          ? null
          : activeCaloriesBurnedRecords.map((r) => r.toDto()).toList(),
      distanceRecords: distanceRecords.isEmpty
          ? null
          : distanceRecords.map((r) => r.toDto()).toList(),
      floorsClimbedRecords: floorsClimbedRecords.isEmpty
          ? null
          : floorsClimbedRecords.map((r) => r.toDto()).toList(),
      bodyFatPercentageRecords: bodyFatPercentageRecords.isEmpty
          ? null
          : bodyFatPercentageRecords.map((r) => r.toDto()).toList(),
      bodyTemperatureRecords: bodyTemperatureRecords.isEmpty
          ? null
          : bodyTemperatureRecords.map((r) => r.toDto()).toList(),
      heightRecords: heightRecords.isEmpty
          ? null
          : heightRecords.map((r) => r.toDto()).toList(),
      hydrationRecords: hydrationRecords.isEmpty
          ? null
          : hydrationRecords.map((r) => r.toDto()).toList(),
      leanBodyMassRecords: leanBodyMassRecords.isEmpty
          ? null
          : leanBodyMassRecords.map((r) => r.toDto()).toList(),
      stepsRecords: stepRecords.isEmpty
          ? null
          : stepRecords.map((r) => r.toDto()).toList(),
      weightRecords: weightRecords.isEmpty
          ? null
          : weightRecords.map((r) => r.toDto()).toList(),
      wheelchairPushesRecords: wheelchairPushesRecords.isEmpty
          ? null
          : wheelchairPushesRecords.map((r) => r.toDto()).toList(),
      heartRateMeasurementRecords: heartRateMeasurementRecords.isEmpty
          ? null
          : heartRateMeasurementRecords.map((r) => r.toDto()).toList(),
    );
  }
}
