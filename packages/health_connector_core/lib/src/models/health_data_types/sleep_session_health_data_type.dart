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
    extends HealthDataType<SleepSessionRecord, TimeDuration>
    implements
        ReadableHealthDataType<SleepSessionRecord>,
        WriteableHealthDataType,
        SumAggregatableHealthDataType<SleepSessionRecord, TimeDuration> {
  @internal
  const SleepSessionHealthDataType();

  @override
  String get identifier => 'sleep_session';

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

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<SleepSessionRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<SleepSessionRecord> readInTimeRange({
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
  AggregateRequest<SleepSessionRecord, TimeDuration> aggregateSum({
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
