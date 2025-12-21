part of '../health_data_type.dart';

/// Health data type for composite blood pressure measurements.
///
/// This data type represents a complete blood pressure reading with both
/// systolic and diastolic values.
///
/// For individual systolic or diastolic measurements, see:
/// - [SystolicBloodPressureHealthDataType]
/// - and [DiastolicBloodPressureHealthDataType].
@sinceV1_2_0
@immutable
final class BloodPressureHealthDataType
    extends HealthDataType<BloodPressureRecord, Pressure>
    implements
        ReadableHealthDataType<BloodPressureRecord>,
        WriteableHealthDataType {
  @internal
  const BloodPressureHealthDataType();

  @override
  String get identifier => 'blood_pressure';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BloodPressureHealthDataType &&
          runtimeType == other.runtimeType &&
          identifier == other.identifier;

  @override
  int get hashCode => identifier.hashCode;

  @override
  String toString() => 'blood_pressure_data_type';

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<BloodPressureRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<BloodPressureRecord> readInTimeRange({
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
  List<Permission> get permissions => [readPermission, writePermission];

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.avg,
    AggregationMetric.min,
    AggregationMetric.max,
  ];

  BloodPressureAggregateRequest aggregateAverage({
    required HealthDataType<HealthRecord, Pressure> bloodPressureType,
    required DateTime startTime,
    required DateTime endTime,
  }) {
    return BloodPressureAggregateRequest(
      dataType: bloodPressureType,
      aggregationMetric: AggregationMetric.avg,
      startTime: startTime,
      endTime: endTime,
    );
  }

  BloodPressureAggregateRequest aggregateMin({
    required HealthDataType<HealthRecord, Pressure> bloodPressureType,
    required DateTime startTime,
    required DateTime endTime,
  }) {
    return BloodPressureAggregateRequest(
      dataType: bloodPressureType,
      aggregationMetric: AggregationMetric.min,
      startTime: startTime,
      endTime: endTime,
    );
  }

  BloodPressureAggregateRequest aggregateMax({
    required HealthDataType<HealthRecord, Pressure> bloodPressureType,
    required DateTime startTime,
    required DateTime endTime,
  }) {
    return BloodPressureAggregateRequest(
      dataType: bloodPressureType,
      aggregationMetric: AggregationMetric.max,
      startTime: startTime,
      endTime: endTime,
    );
  }
}
