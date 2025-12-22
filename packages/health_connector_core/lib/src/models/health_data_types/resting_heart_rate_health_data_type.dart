part of 'health_data_type.dart';

/// Health data type for resting heart rate information.
///
/// Resting heart rate represents the heart rate while at complete rest,
/// typically measured first thing in the morning before getting out of bed.
@sinceV1_3_0
@immutable
final class RestingHeartRateHealthDataType
    extends HealthDataType<RestingHeartRateRecord, Number>
    implements
        ReadableHealthDataType<RestingHeartRateRecord>,
        WriteableHealthDataType,
        AvgAggregatableHealthDataType<RestingHeartRateRecord, Number>,
        MinAggregatableHealthDataType<RestingHeartRateRecord, Number>,
        MaxAggregatableHealthDataType<RestingHeartRateRecord, Number> {
  @internal
  const RestingHeartRateHealthDataType();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RestingHeartRateHealthDataType &&
          runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.avg,
    AggregationMetric.min,
    AggregationMetric.max,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<RestingHeartRateRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<RestingHeartRateRecord> readInTimeRange({
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
  AggregateRequest<RestingHeartRateRecord, Number> aggregateAvg({
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
  AggregateRequest<RestingHeartRateRecord, Number> aggregateMin({
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
  AggregateRequest<RestingHeartRateRecord, Number> aggregateMax({
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
