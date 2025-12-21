part of '../health_data_type.dart';

/// Health data type for diastolic blood pressure measurements.
///
/// This data type represents the diastolic (lower) blood pressure value only.
/// Supports AVG, MIN, MAX aggregation.
@sinceV1_2_0
@supportedOnAppleHealth
@immutable
final class DiastolicBloodPressureHealthDataType
    extends HealthDataType<DiastolicBloodPressureRecord, Pressure>
    implements
        ReadableHealthDataType<DiastolicBloodPressureRecord>,
        WriteableHealthDataType,
        AvgAggregatableHealthDataType<DiastolicBloodPressureRecord, Pressure>,
        MinAggregatableHealthDataType<DiastolicBloodPressureRecord, Pressure>,
        MaxAggregatableHealthDataType<DiastolicBloodPressureRecord, Pressure> {
  @internal
  const DiastolicBloodPressureHealthDataType();

  @override
  String get identifier => 'diastolic_blood_pressure';

  @override
  String get name => identifier;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DiastolicBloodPressureHealthDataType &&
          runtimeType == other.runtimeType &&
          identifier == other.identifier;

  @override
  int get hashCode => identifier.hashCode;

  @override
  String toString() => 'diastolic_blood_pressure_data_type';

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.appleHealth,
  ];

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.avg,
    AggregationMetric.min,
    AggregationMetric.max,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<DiastolicBloodPressureRecord> readById(
    HealthRecordId id,
  ) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<DiastolicBloodPressureRecord> readInTimeRange({
    required DateTime startTime,
    required DateTime endTime,
    int pageSize = HealthConnectorConfigConstants.defaultPageSize,
  }) {
    return ReadRecordsInTimeRangeRequest(
      dataType: this,
      startTime: startTime,
      endTime: endTime,
      pageSize: pageSize,
    );
  }

  @override
  HealthDataPermission get writePermission => HealthDataPermission.write(this);

  @override
  AggregateRequest<DiastolicBloodPressureRecord, Pressure> aggregateAvg({
    required DateTime startTime,
    required DateTime endTime,
  }) {
    return CommonAggregateRequest(
      dataType: this,
      aggregationMetric: AggregationMetric.avg,
      startTime: startTime,
      endTime: endTime,
    );
  }

  @override
  AggregateRequest<DiastolicBloodPressureRecord, Pressure> aggregateMin({
    required DateTime startTime,
    required DateTime endTime,
  }) {
    return CommonAggregateRequest(
      dataType: this,
      aggregationMetric: AggregationMetric.min,
      startTime: startTime,
      endTime: endTime,
    );
  }

  @override
  AggregateRequest<DiastolicBloodPressureRecord, Pressure> aggregateMax({
    required DateTime startTime,
    required DateTime endTime,
  }) {
    return CommonAggregateRequest(
      dataType: this,
      aggregationMetric: AggregationMetric.max,
      startTime: startTime,
      endTime: endTime,
    );
  }

  @override
  List<Permission> get permissions => [readPermission, writePermission];
}
