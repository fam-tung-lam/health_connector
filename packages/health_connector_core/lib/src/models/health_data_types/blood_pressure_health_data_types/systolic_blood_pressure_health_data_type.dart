part of '../health_data_type.dart';

/// Health data type for systolic blood pressure measurements.
///
/// This data type represents the systolic (upper) blood pressure value only.
/// Supports AVG, MIN, MAX aggregation.
@sinceV1_2_0
@supportedOnAppleHealth
@immutable
final class SystolicBloodPressureHealthDataType
    extends HealthDataType<SystolicBloodPressureRecord, Pressure>
    implements
        ReadableHealthDataType<SystolicBloodPressureRecord>,
        WriteableHealthDataType,
        AvgAggregatableHealthDataType<SystolicBloodPressureRecord, Pressure>,
        MinAggregatableHealthDataType<SystolicBloodPressureRecord, Pressure>,
        MaxAggregatableHealthDataType<SystolicBloodPressureRecord, Pressure> {
  @internal
  const SystolicBloodPressureHealthDataType();

  @override
  String get identifier => 'systolic_blood_pressure';

  @override
  String get name => identifier;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SystolicBloodPressureHealthDataType &&
          runtimeType == other.runtimeType &&
          identifier == other.identifier;

  @override
  int get hashCode => identifier.hashCode;

  @override
  String toString() => 'systolic_blood_pressure_data_type';

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
  ReadRecordByIdRequest<SystolicBloodPressureRecord> readById(
    HealthRecordId id,
  ) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<SystolicBloodPressureRecord> readInTimeRange({
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
  AggregateRequest<SystolicBloodPressureRecord, Pressure> aggregateAvg({
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
  AggregateRequest<SystolicBloodPressureRecord, Pressure> aggregateMin({
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
  AggregateRequest<SystolicBloodPressureRecord, Pressure> aggregateMax({
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
