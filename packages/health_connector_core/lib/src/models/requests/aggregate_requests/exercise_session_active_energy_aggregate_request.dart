part of 'aggregate_request.dart';

/// Request to aggregate active energy burned for a saved exercise session.
///
/// {@category Core API}
@sinceV3_12_0
@internalUse
@immutable
final class ExerciseSessionActiveEnergyAggregateRequest
    extends AggregateRequest<Energy> {
  /// Creates a request for the saved exercise session identified by
  /// [exerciseSessionId] with its recorded [startTime] and [endTime].
  ///
  /// Equal timestamps are allowed for saved workouts without a duration.
  /// Both platforms read the saved workout by ID; iOS ignores these timestamps
  /// and Android aggregates over the native workout's saved time range.
  ///
  /// ## Throws
  ///
  /// - [ArgumentError]: If [exerciseSessionId] is [HealthRecordId.none].
  /// - [ArgumentError]: If [endTime] is before [startTime].
  ExerciseSessionActiveEnergyAggregateRequest({
    required this.exerciseSessionId,
    required super.startTime,
    required super.endTime,
  }) : super(
         dataType: HealthDataType.activeEnergyBurned,
         aggregationMetric: AggregationMetric.sum,
       ) {
    requireEndTimeNotBeforeStartTime(startTime: startTime, endTime: endTime);
    require(
      condition: exerciseSessionId != HealthRecordId.none,
      value: exerciseSessionId,
      name: 'exerciseSessionId',
      message: 'Exercise session must have a saved record ID.',
    );
  }

  /// The platform-assigned ID of the saved exercise session.
  final HealthRecordId exerciseSessionId;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is ExerciseSessionActiveEnergyAggregateRequest &&
          exerciseSessionId == other.exerciseSessionId;

  @override
  int get hashCode => Object.hash(super.hashCode, exerciseSessionId);

  @override
  String toString() =>
      'ExerciseSessionActiveEnergyAggregateRequest('
      'dataType=$dataType, '
      'aggregationMetric=$aggregationMetric, '
      'spanDays=${endTime.difference(startTime).inDays}'
      ')';
}
