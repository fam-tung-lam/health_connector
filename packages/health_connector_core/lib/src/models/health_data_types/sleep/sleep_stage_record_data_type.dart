part of '../health_data_type.dart';

/// Sleep stage data type.
///
/// Represents individual sleep stage records. Each sleep stage is recorded as
/// a separate record with its own UUID. A complete night's sleep consists of
/// multiple records.
///
/// ## Measurement Unit
///
/// Duration is measured in [TimeDuration] (seconds, minutes, hours).
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: Not supported (use
/// [SleepSessionDataType])
/// - **iOS HealthKit**: `HKCategoryType(.sleepAnalysis)`
///
/// ## Capabilities
///
/// - Readable: Query sleep stage records
/// - Writeable: Write sleep stage records
/// - Aggregatable: Sum total sleep duration (excluding awake stages)
/// - Deletable: Delete records by IDs or time range
///
/// ## See also
///
/// - [SleepStageRecord]
///
/// {@category Health Records}
@sinceV1_0_0
@supportedOnAppleHealth
@immutable
final class SleepStageDataType
    extends HealthDataType<SleepStageRecord, TimeDuration>
    implements
        ReadableByIdHealthDataType<SleepStageRecord>,
        ReadableInTimeRangeHealthDataType<SleepStageRecord>,
        WriteableHealthDataType<SleepStageRecord>,
        SumAggregatableHealthDataType<SleepStageRecord, TimeDuration>,
        DeletableByIdsHealthDataType<SleepStageRecord>,
        DeletableInTimeRangeHealthDataType<SleepStageRecord> {
  /// Creates a sleep stage data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const SleepStageDataType();

  @override
  String get id => 'sleep_stage';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SleepStageDataType && runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.appleHealth,
  ];

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.sum,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<SleepStageRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<SleepStageRecord> readInTimeRange({
    required DateTime startTime,
    required DateTime endTime,
    List<DataOrigin> dataOrigins = const [],
    int pageSize = HealthConnectorConfigConstants.defaultPageSize,
    String? pageToken,
  }) {
    return ReadRecordsInTimeRangeRequest(
      dataType: this,
      dataOrigins: dataOrigins,
      startTime: startTime,
      endTime: endTime,
      pageSize: pageSize,
      pageToken: pageToken,
    );
  }

  @override
  HealthDataPermission get writePermission => HealthDataPermission.write(this);

  /// ## Implementation Note
  ///
  /// HealthKit category samples don't support aggregation natively, so the
  /// custom aggregation approach is implemented by the SDK:
  /// - Query all sleep stages
  /// - And calculate the total sleep duration
  ///
  /// ### Example Calculation
  ///
  /// - Given sleep stages:
  ///   - 11:00 PM - 11:30 PM: Light sleep (30 min)
  ///   - 11:30 PM - 2:00 AM: Deep sleep (2.5 hours)
  ///   - 2:00 AM - 2:15 AM: Awake (15 min) ← excluded
  ///   - 2:15 AM - 5:00 AM: Light sleep (2.75 hours)
  ///   - 5:00 AM - 6:30 AM: REM sleep (1.5 hours)
  ///   - 6:30 AM - 7:00 AM: Awake (30 min) ← excluded
  /// - Total Sleep Time:
  ///   - 30 min + 2.5 hrs + 2.75 hrs + 1.5 hrs = 7.25 hours (26,100 seconds)
  @override
  AggregateRequest<SleepStageRecord, TimeDuration> aggregateSum({
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

  @override
  HealthDataTypeCategory get category => HealthDataTypeCategory.sleep;

  @override
  DeleteRecordsByIdsRequest<SleepStageRecord> deleteByIds(
    List<HealthRecordId> recordIds,
  ) {
    return DeleteRecordsByIdsRequest(
      dataType: this,
      recordIds: recordIds,
    );
  }

  @override
  DeleteRecordsInTimeRangeRequest<SleepStageRecord> deleteInTimeRange({
    required DateTime startTime,
    required DateTime endTime,
  }) {
    return DeleteRecordsInTimeRangeRequest(
      dataType: this,
      startTime: startTime,
      endTime: endTime,
    );
  }
}
