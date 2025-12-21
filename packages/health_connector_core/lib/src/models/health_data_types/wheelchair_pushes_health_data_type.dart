part of 'health_data_type.dart';

/// Health data type for wheelchair pushes information.
@sinceV1_0_0
@immutable
final class WheelchairPushesHealthDataType
    extends HealthDataType<WheelchairPushesRecord, Number>
    implements
        ReadableHealthDataType<WheelchairPushesRecord>,
        WriteableHealthDataType,
        SumAggregatableHealthDataType<WheelchairPushesRecord, Number> {
  @internal
  const WheelchairPushesHealthDataType();

  @override
  String get identifier => 'wheelchair_pushes';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WheelchairPushesHealthDataType &&
          runtimeType == other.runtimeType &&
          identifier == other.identifier;

  @override
  int get hashCode => identifier.hashCode;

  @override
  String toString() => 'wheelchair_pushes_data_type';

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.sum,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<WheelchairPushesRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<WheelchairPushesRecord> readInTimeRange({
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
  AggregateRequest<WheelchairPushesRecord, Number> aggregateSum({
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
