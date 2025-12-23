part of 'health_data_type.dart';

/// Sleep session data type.
///
/// Represents sleep sessions on Android Health Connect. Sleep sessions are
/// container records that encompass all sleep stages within a single session,
/// with one ID for the entire session.
///
/// ## Measurement Unit
///
/// Duration is measured in [TimeDuration] (seconds, minutes, hours).
///
/// ## Platform Mapping
///
/// - **Android (Health Connect)**: `SleepSessionRecord`
/// - **iOS (HealthKit)**: Not supported (use [SleepStageHealthDataType])
///
/// ## Capabilities
///
/// - ✅ Readable: Query sleep session records
/// - ✅ Writeable: Write sleep session records
/// - ✅ Aggregatable: Sum total sleep duration
/// - ✅ Deletable: Delete records by IDs or time range
///
/// > [!NOTE]
/// > This data type is only supported on Android Health Connect. For iOS,
/// > use [SleepStageHealthDataType] instead.
@sinceV1_0_0
@supportedOnHealthConnect
@immutable
final class SleepSessionHealthDataType
    extends HealthDataType<SleepSessionRecord, TimeDuration>
    implements
        ReadableHealthDataType<SleepSessionRecord>,
        WriteableHealthDataType,
        SumAggregatableHealthDataType<SleepSessionRecord, TimeDuration>,
        DeletableHealthDataType<SleepSessionRecord> {
  /// Creates a sleep session data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const SleepSessionHealthDataType();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SleepSessionHealthDataType && runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

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

  @override
  DeleteRecordsByIdsRequest<SleepSessionRecord> deleteByIds(
    List<HealthRecordId> recordIds,
  ) {
    return DeleteRecordsByIdsRequest(
      dataType: this,
      recordIds: recordIds,
    );
  }

  @override
  DeleteRecordsInTimeRangeRequest<SleepSessionRecord> deleteInTimeRange({
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
