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

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<ActiveCaloriesBurnedRecord> readById(
    HealthRecordId id,
  ) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<ActiveCaloriesBurnedRecord> readInTimeRange({
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
  AggregateRequest<ActiveCaloriesBurnedRecord, Energy> aggregateSum({
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

  @override
  List<Permission> get permissions => [readPermission, writePermission];
}
