part of 'health_data_type.dart';

/// Sleep stage data type.
///
/// Represents individual sleep stage records on iOS HealthKit. Each sleep stage
/// (light, deep, REM, awake) is recorded as a separate record with its own
/// UUID.
/// A complete night's sleep consists of multiple records.
///
/// ## Measurement Unit
///
/// Duration is measured in [TimeDuration] (seconds, minutes, hours).
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: Not supported (use
/// [SleepSessionHealthDataType])
/// - **iOS HealthKit**: `HKCategoryType(.sleepAnalysis)`
///
/// ## Capabilities
///
/// - ✅ Readable: Query sleep stage records
/// - ✅ Writeable: Write sleep stage records
/// - ✅ Aggregatable: Sum total sleep duration (excluding awake stages)
/// - ✅ Deletable: Delete records by IDs or time range
///
/// > [!NOTE]
/// > This data type is only supported on iOS HealthKit. For Android,
/// > use [SleepSessionHealthDataType] instead.
///
/// {@category Health Data Types}
@sinceV1_0_0
@immutable
final class SleepStageHealthDataType
    extends HealthDataType<SleepStageRecord, TimeDuration>
    implements
        ReadableHealthDataType<SleepStageRecord>,
        WriteableHealthDataType,
        SumAggregatableHealthDataType<SleepStageRecord, TimeDuration>,
        DeletableHealthDataType<SleepStageRecord> {
  /// Creates a sleep stage data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const SleepStageHealthDataType();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SleepStageHealthDataType && runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

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

  /// ## Note
  ///
  /// HealthKit category samples don't support `HKStatisticsQuery`,
  /// so the custom aggregation approach is implemented:
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
