part of 'health_data_type.dart';

/// Health data type for distance information.
@sinceV1_0_0
@immutable
final class DistanceHealthDataType
    extends HealthDataType<DistanceRecord, Length>
    implements
        ReadableHealthDataType<DistanceRecord>,
        WriteableHealthDataType,
        SumAggregatableHealthDataType<DistanceRecord, Length> {
  @internal
  const DistanceHealthDataType();

  @override
  String get identifier => 'distance';

  @override
  String get name => identifier;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DistanceHealthDataType &&
          runtimeType == other.runtimeType &&
          identifier == other.identifier;

  @override
  int get hashCode => identifier.hashCode;

  @override
  String toString() => 'distance_data_type';

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
  ReadRecordRequest<DistanceRecord> readRecord(HealthRecordId id) {
    return ReadRecordRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsRequest<DistanceRecord> readRecords({
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
  AggregateRequest<DistanceRecord, Length> aggregateSum({
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
