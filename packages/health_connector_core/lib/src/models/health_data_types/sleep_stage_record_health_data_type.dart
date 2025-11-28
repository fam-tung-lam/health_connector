part of 'health_data_type.dart';

/// Health data type for iOS sleep stage records.
///
/// **Platform:** iOS only (HealthKit)
///
/// Sleep stage records on iOS are individual measurements, one per sleep stage.
/// A complete night's sleep consists of multiple records. Each record has
/// its own UUID.
@sinceV1_0_0
@availableOnAppleHealth
@immutable
final class SleepStageHealthDataType
    extends HealthDataType<SleepStageRecord, Numeric>
    implements
        ReadableHealthDataType<SleepStageRecord>,
        WriteableHealthDataType,
        SumAggregatableHealthDataType<SleepStageRecord, Numeric> {
  @internal
  const SleepStageHealthDataType();

  @override
  String get identifier => 'sleep_stage';

  @override
  String get name => identifier;

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.appleHealth,
  ];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SleepStageHealthDataType &&
          runtimeType == other.runtimeType &&
          identifier == other.identifier;

  @override
  int get hashCode => identifier.hashCode;

  @override
  String toString() => 'sleep_stage_data_type';

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
  ReadRecordRequest<SleepStageRecord> readRecord(HealthRecordId id) {
    return ReadRecordRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsRequest<SleepStageRecord> readRecords({
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
  AggregateRequest<SleepStageRecord, Numeric> aggregateSum({
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
