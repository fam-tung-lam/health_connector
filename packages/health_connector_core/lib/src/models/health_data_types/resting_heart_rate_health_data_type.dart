part of 'health_data_type.dart';

/// Health data type for resting heart rate information.
///
/// Resting heart rate represents the heart rate while at complete rest,
/// typically measured first thing in the morning before getting out of bed.
@sinceV1_3_0
@immutable
final class RestingHeartRateHealthDataType
    extends HealthDataType<RestingHeartRateRecord, Numeric>
    implements
        ReadableHealthDataType<RestingHeartRateRecord>,
        WriteableHealthDataType,
        AvgAggregatableHealthDataType<RestingHeartRateRecord, Numeric>,
        MinAggregatableHealthDataType<RestingHeartRateRecord, Numeric>,
        MaxAggregatableHealthDataType<RestingHeartRateRecord, Numeric> {
  @internal
  const RestingHeartRateHealthDataType();

  @override
  String get identifier => 'resting_heart_rate';

  @override
  String get name => identifier;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RestingHeartRateHealthDataType &&
          runtimeType == other.runtimeType &&
          identifier == other.identifier;

  @override
  int get hashCode => identifier.hashCode;

  @override
  String toString() => 'resting_heart_rate_data_type';

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
  ReadRecordRequest<RestingHeartRateRecord> readRecord(HealthRecordId id) {
    return ReadRecordRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsRequest<RestingHeartRateRecord> readRecords({
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
  AggregateRequest<RestingHeartRateRecord, Numeric> aggregateAvg({
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
  AggregateRequest<RestingHeartRateRecord, Numeric> aggregateMin({
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
  AggregateRequest<RestingHeartRateRecord, Numeric> aggregateMax({
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
