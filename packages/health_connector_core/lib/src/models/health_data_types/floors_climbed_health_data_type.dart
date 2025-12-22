part of 'health_data_type.dart';

/// Health data type for floors climbed information.
@sinceV1_0_0
@immutable
final class FloorsClimbedHealthDataType
    extends HealthDataType<FloorsClimbedRecord, Number>
    implements
        ReadableHealthDataType<FloorsClimbedRecord>,
        WriteableHealthDataType,
        SumAggregatableHealthDataType<FloorsClimbedRecord, Number> {
  @internal
  const FloorsClimbedHealthDataType();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FloorsClimbedHealthDataType && runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  HealthDataPermission get writePermission => HealthDataPermission.write(this);

  @override
  List<Permission> get permissions => [readPermission, writePermission];

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.sum,
  ];

  @override
  ReadRecordByIdRequest<FloorsClimbedRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<FloorsClimbedRecord> readInTimeRange({
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
  AggregateRequest<FloorsClimbedRecord, Number> aggregateSum({
    required DateTime startTime,
    required DateTime endTime,
  }) {
    return CommonAggregateRequest(
      dataType: this,
      aggregationMetric: AggregationMetric.sum,
      startTime: startTime,
      endTime: endTime,
    );
  }
}
