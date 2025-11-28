part of 'health_data_type.dart';

/// Health data type for step count information.
@sinceV1_0_0
@immutable
final class StepsHealthDataType extends HealthDataType<StepRecord, Numeric>
    implements
        ReadableHealthDataType<StepRecord>,
        WriteableHealthDataType,
        SumAggregatableHealthDataType<StepRecord, Numeric> {
  @internal
  const StepsHealthDataType();

  @override
  String get identifier => 'steps';

  @override
  String get name => identifier;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StepsHealthDataType &&
          runtimeType == other.runtimeType &&
          identifier == other.identifier;

  @override
  int get hashCode => identifier.hashCode;

  @override
  String toString() => 'steps_data_type';

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.sum,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission(
    dataType: this,
    accessType: HealthDataPermissionAccessType.read,
  );

  @override
  ReadRecordRequest<StepRecord> readRecord(HealthRecordId id) {
    return ReadRecordRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsRequest<StepRecord> readRecords({
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
  AggregateRequest<StepRecord, Numeric> aggregateSum({
    required DateTime startTime,
    required DateTime endTime,
  }) {
    return AggregateRequest(
      dataType: this,
      aggregationMetric: AggregationMetric.sum,
      startTime: startTime,
      endTime: endTime,
    );
  }

  @override
  List<Permission> get permissions => [readPermission, writePermission];
}
