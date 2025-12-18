part of 'health_data_type.dart';

/// Health data type for iOS heart rate measurement records.
///
/// **Platform:** iOS only (HealthKit)
///
/// Heart rate measurement records on iOS are individual measurements. Each
/// record has its own UUID.
@sinceV1_0_0
@immutable
final class HeartRateMeasurementRecordHealthDataType
    extends HealthDataType<HeartRateMeasurementRecord, Numeric>
    implements
        ReadableHealthDataType<HeartRateMeasurementRecord>,
        WriteableHealthDataType,
        AvgAggregatableHealthDataType<HeartRateMeasurementRecord, Numeric>,
        MinAggregatableHealthDataType<HeartRateMeasurementRecord, Numeric>,
        MaxAggregatableHealthDataType<HeartRateMeasurementRecord, Numeric> {
  @internal
  const HeartRateMeasurementRecordHealthDataType();

  @override
  String get identifier => 'heart_rate_measurement_record';

  @override
  String get name => identifier;

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.appleHealth,
  ];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HeartRateMeasurementRecordHealthDataType &&
          runtimeType == other.runtimeType &&
          identifier == other.identifier;

  @override
  int get hashCode => identifier.hashCode;

  @override
  String toString() => 'heart_rate_measurement_record_data_type';

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.avg,
    AggregationMetric.min,
    AggregationMetric.max,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission(
    dataType: this,
    accessType: HealthDataPermissionAccessType.read,
  );

  @override
  ReadRecordRequest<HeartRateMeasurementRecord> readRecord(HealthRecordId id) {
    return ReadRecordRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsRequest<HeartRateMeasurementRecord> readRecords({
    required DateTime startTime,
    required DateTime endTime,
    int pageSize = HealthConnectorConfigConstants.defaultPageSize,
  }) {
    return ReadRecordsRequest(
      dataType: this,
      startTime: startTime,
      endTime: endTime,
      pageSize: pageSize,
    );
  }

  @override
  HealthDataPermission get writePermission => HealthDataPermission(
    dataType: this,
    accessType: HealthDataPermissionAccessType.write,
  );

  @override
  AggregateRequest<HeartRateMeasurementRecord, Numeric> aggregateAvg({
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
  AggregateRequest<HeartRateMeasurementRecord, Numeric> aggregateMin({
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
  AggregateRequest<HeartRateMeasurementRecord, Numeric> aggregateMax({
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
