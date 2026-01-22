part of 'health_data_type.dart';

/// Exercise session data type.
///
/// Exercise sessions track physical activity periods with exercise type,
/// duration, and optional notes.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: `ExerciseSessionRecord`
/// - **iOS HealthKit**: `HKWorkout`
///
/// ## Capabilities
///
/// - Readable: Query exercise session records
/// - Writeable: Write exercise session records
/// - Aggregatable: Sum total exercise duration
/// - Deletable: Delete records by IDs or time range
///
/// ## See also
///
/// - [ExerciseSessionRecord]
///
/// {@category Health Records}
@sinceV2_0_0
@immutable
final class ExerciseSessionDataType
    extends HealthDataType<ExerciseSessionRecord, TimeDuration>
    implements
        ReadableByIdHealthDataType<ExerciseSessionRecord>,
        ReadableInTimeRangeHealthDataType<ExerciseSessionRecord>,
        WriteableHealthDataType<ExerciseSessionRecord>,
        SumAggregatableHealthDataType<TimeDuration>,
        DeletableByIdsHealthDataType<ExerciseSessionRecord>,
        DeletableInTimeRangeHealthDataType<ExerciseSessionRecord> {
  /// Creates an exercise session data type.
  ///
  /// This is a constant constructor used internally. To reference this data
  /// type, use the singleton instance from [HealthDataType].
  @internal
  const ExerciseSessionDataType();

  @override
  List<HealthPlatform> get supportedHealthPlatforms => HealthPlatform.values;

  @override
  String get id => 'exercise_session';

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExerciseSessionDataType && runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  List<AggregationMetric> get supportedAggregationMetrics => [
    AggregationMetric.sum,
  ];

  @override
  HealthDataPermission get readPermission => HealthDataPermission.read(this);

  @override
  ReadRecordByIdRequest<ExerciseSessionRecord> readById(HealthRecordId id) {
    return ReadRecordByIdRequest(dataType: this, id: id);
  }

  @override
  ReadRecordsInTimeRangeRequest<ExerciseSessionRecord> readInTimeRange({
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

  @override
  AggregateRequest<TimeDuration> aggregateSum({
    required DateTime startTime,
    required DateTime endTime,
  }) {
    return StandardAggregateRequest(
      dataType: this,
      aggregationMetric: AggregationMetric.sum,
      startTime: startTime,
      endTime: endTime,
    );
  }

  @override
  List<Permission> get permissions => [readPermission, writePermission];

  @override
  HealthDataTypeCategory get category => HealthDataTypeCategory.activity;

  @override
  DeleteRecordsByIdsRequest deleteByIds(
    List<HealthRecordId> recordIds,
  ) {
    return DeleteRecordsByIdsRequest(
      dataType: this,
      recordIds: recordIds,
    );
  }

  @override
  DeleteRecordsInTimeRangeRequest deleteInTimeRange({
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
