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
  List<HealthPlatformRequirement> get healthPlatformRequirements =>
      HealthPlatformRequirement.allPlatformsWithoutRequirements;

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

  /// Permission to read exercise route data for sessions.
  @sinceV3_8_0
  ExerciseRoutePermission get readExerciseRoutePermission =>
      ExerciseRoutePermission.read;

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

  /// Permission to write exercise route data with sessions.
  @sinceV3_8_0
  ExerciseRoutePermission get writeExerciseRoutePermission =>
      ExerciseRoutePermission.write;

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

  /// Creates an active energy aggregation request for a saved exercise session.
  ///
  /// ## Platform Mapping
  ///
  /// - **Android Health Connect**: Reads the saved exercise session by ID.
  ///   Sums `ActiveCaloriesBurnedRecord.ACTIVE_CALORIES_TOTAL`
  ///   over its saved time range, filtered to its data origin. Calorie records
  ///   are not linked to the exercise session, so other active energy from the
  ///   same source during that interval can be included.
  /// - **iOS HealthKit**: Reads the saved `HKWorkout` by UUID and returns its
  ///   associated active energy. On iOS 16 and higher, prefers
  ///   `HKWorkout.statistics(for:)` for `activeEnergyBurned`, then falls back
  ///   to `totalEnergyBurned` when statistics are missing. On iOS 15, uses
  ///   `totalEnergyBurned`. A missing workout raises an invalid-argument error.
  ///
  /// Requires [readPermission] and
  /// [HealthDataType.activeEnergyBurned]'s read permission on Android.
  /// On iOS, requires workout read access.
  ///
  /// ## Parameters
  ///
  /// - [exerciseSession]: A saved exercise session with a platform-assigned ID.
  ///   Equal start and end timestamps are accepted for existing HealthKit
  ///   workouts. Android requires a valid native exercise-session time range.
  ///
  /// ## Returns
  ///
  /// A request that produces [Energy] when passed to
  /// `HealthConnector.aggregate()`. Missing active energy produces zero.
  ///
  /// ## Throws
  ///
  /// - [ArgumentError]: If [exerciseSession] has no saved record ID or its end
  ///   time is before its start time.
  ///
  /// ## Example
  ///
  /// ```dart
  /// final request =
  ///     HealthDataType.exerciseSession.aggregateActiveEnergyBurnedFor(
  ///   exerciseSession: exerciseSession,
  /// );
  /// final Energy energy = await connector.aggregate(request);
  /// ```
  ///
  /// {@category Core API}
  @sinceV3_12_0
  AggregateRequest<Energy> aggregateActiveEnergyBurnedFor({
    required ExerciseSessionRecord exerciseSession,
  }) {
    return ExerciseSessionActiveEnergyAggregateRequest(
      exerciseSessionId: exerciseSession.id,
      startTime: exerciseSession.startTime,
      endTime: exerciseSession.endTime,
    );
  }

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
