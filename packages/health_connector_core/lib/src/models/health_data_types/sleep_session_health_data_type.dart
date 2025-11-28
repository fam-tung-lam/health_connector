part of 'health_data_type.dart';

/// Health data type for Android sleep sessions.
///
/// **Platform:** Android only (Health Connect)
///
/// Sleep sessions on Android are container records with embedded sleep stages.
/// Each session has a single ID that encompasses all stages.
@sinceV1_0_0
@supportedOnHealthConnect
@immutable
final class SleepSessionHealthDataType
    extends HealthDataType<SleepSessionRecord, Numeric>
    implements
        ReadableHealthDataType<SleepSessionRecord>,
        WriteableHealthDataType,
        SumAggregatableHealthDataType<SleepSessionRecord, Numeric> {
  @internal
  const SleepSessionHealthDataType();

  @override
  String get identifier => 'sleep_session';

  @override
  String get name => identifier;

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.healthConnect,
  ];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SleepSessionHealthDataType &&
          runtimeType == other.runtimeType &&
          identifier == other.identifier;

  @override
  int get hashCode => identifier.hashCode;

  @override
  String toString() => 'sleep_session_data_type';

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
  ReadRecordRequest<SleepSessionRecord> readRecord(HealthRecordId id) {
    return ReadRecordRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsRequest<SleepSessionRecord> readRecords({
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

  // SumAggregatableHealthDataType implementation
  @override
  AggregateRequest<SleepSessionRecord, Numeric> aggregateSum({
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
