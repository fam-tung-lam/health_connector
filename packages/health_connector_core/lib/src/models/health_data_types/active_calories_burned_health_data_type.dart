part of 'health_data_type.dart';

/// Health data type for active calories burned information.
@sinceV1_0_0
@immutable
final class ActiveCaloriesBurnedHealthDataType
    extends HealthDataType<ActiveCaloriesBurnedRecord, Energy>
    implements
        ReadableHealthDataType<ActiveCaloriesBurnedRecord>,
        WriteableHealthDataType,
        SumAggregatableHealthDataType<ActiveCaloriesBurnedRecord, Energy> {
  @internal
  const ActiveCaloriesBurnedHealthDataType();

  @override
  String get identifier => 'active_calories_burned';

  @override
  String get name => identifier;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ActiveCaloriesBurnedHealthDataType &&
          runtimeType == other.runtimeType &&
          identifier == other.identifier;

  @override
  int get hashCode => identifier.hashCode;

  @override
  String toString() => 'active_calories_burned_data_type';

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.sum,
  ];

  // ReadableHealthDataType implementation
  @override
  HealthDataPermission get readPermission => HealthDataPermission(
    dataType: this,
    accessType: HealthDataPermissionAccessType.read,
  );

  @override
  ReadRecordRequest<ActiveCaloriesBurnedRecord> readRecord(HealthRecordId id) {
    return ReadRecordRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsRequest<ActiveCaloriesBurnedRecord> readRecords({
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

  // WriteableHealthDataType implementation
  @override
  HealthDataPermission get writePermission => HealthDataPermission(
    dataType: this,
    accessType: HealthDataPermissionAccessType.write,
  );

  @override
  AggregateRequest<ActiveCaloriesBurnedRecord, Energy> aggregateSum({
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
