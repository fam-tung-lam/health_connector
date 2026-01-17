part of 'aggregate_request.dart';

/// Request to perform aggregation on activity intensity health records.
///
/// This specialized request extends [AggregateRequest] and includes an
/// additional field [intensityType] to specify which activity intensity
/// metric to aggregate.
///
/// {@category Core API}
@sinceV3_1_0
@supportedOnHealthConnect
@internalUse
@immutable
final class ActivityIntensityAggregateRequest
    extends AggregateRequest<ActivityIntensityRecord, TimeDuration> {
  /// Creates an activity intensity aggregation request.
  ///
  /// The [intensityType] parameter determines which aggregation metric to use:
  /// - `null`: `DURATION_TOTAL` (total minutes in any activity)
  /// - `ActivityIntensityType.moderate`: `MODERATE_DURATION_TOTAL`
  /// - `ActivityIntensityType.vigorous`: `VIGOROUS_DURATION_TOTAL`
  ///
  /// ## Parameters
  ///
  /// - [dataType]: The activity intensity data type
  /// - [startTime]: Inclusive start of the time range
  /// - [endTime]: Exclusive end of the time range
  /// - [intensityType]: The intensity type to aggregate (nullable)
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [dataType] is not [HealthDataType.activityIntensity]
  /// - [ArgumentError] if [endTime] is before [startTime]
  ActivityIntensityAggregateRequest({
    required super.dataType,
    required super.startTime,
    required super.endTime,
    this.intensityType,
  }) : super(aggregationMetric: AggregationMetric.sum) {
    requireEndTimeAfterStartTime(startTime: startTime, endTime: endTime);

    require(
      condition: dataType == HealthDataType.activityIntensity,
      value: dataType,
      name: 'dataType',
      message:
          'dataType must be HealthDataType.activityIntensity for '
          'ActivityIntensityAggregateRequest',
    );
  }

  /// The intensity type to aggregate.
  ///
  /// - `null`: Aggregates total duration across all intensity types
  /// - `ActivityIntensityType.moderate`: Aggregates only moderate intensity
  ///   duration
  /// - `ActivityIntensityType.vigorous`: Aggregates only vigorous intensity
  ///   duration
  final ActivityIntensityType? intensityType;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is ActivityIntensityAggregateRequest &&
          intensityType == other.intensityType;

  @override
  int get hashCode => super.hashCode ^ intensityType.hashCode;

  @override
  String toString() {
    return 'ActivityIntensityAggregateRequest('
        'dataType=$dataType, '
        'intensityType=$intensityType, '
        'spanDays=${endTime.difference(startTime).inDays}'
        ')';
  }
}
