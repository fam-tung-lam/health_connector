part of 'health_record.dart';

/// Represents a step count record over a time interval.
///
/// [StepRecord] tracks the number of steps taken during a specific time
/// period. This is an interval-based record, meaning it has both a start and
/// end time.
///
/// ## Platform Mapping
///
/// - **Android**: Maps to Health Connect's `StepsRecord`
/// - **iOS**: Maps to HealthKit's `HKQuantityType(.stepCount)`
@sinceV1_0_0
@immutable
final class StepRecord extends IntervalHealthRecord {
  /// Creates a step count record.
  ///
  /// ## Parameters
  ///
  ///
  /// - [id]: The unique identifier for this record.
  /// - [startTime]: The start of the time interval (inclusive).
  /// - [endTime]: The end of the time interval (exclusive).
  /// - [startZoneOffsetSeconds]: Optional timezone offset for start time.
  /// - [endZoneOffsetSeconds]: Optional timezone offset for end time.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [count]: The number of steps (must be >= 0).
  ///
  /// ## Throws
  ///
  ///
  /// - [AssertionError] if [count] is negative (in debug/checked mode).
  /// - [ArgumentError] if [endTime] is not after [startTime].
  StepRecord({
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required this.count,
    super.id = HealthRecordId.none,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  }) : assert(count.value >= 0, 'count.value must be non-negative');

  /// The number of steps taken during the interval.
  ///
  /// Must be non-negative (>= 0).
  final Numeric count;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StepRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          startTime == other.startTime &&
          endTime == other.endTime &&
          startZoneOffsetSeconds == other.startZoneOffsetSeconds &&
          endZoneOffsetSeconds == other.endZoneOffsetSeconds &&
          count == other.count &&
          metadata == other.metadata;

  @override
  int get hashCode =>
      id.hashCode ^
      startTime.hashCode ^
      endTime.hashCode ^
      (startZoneOffsetSeconds?.hashCode ?? 0) ^
      (endZoneOffsetSeconds?.hashCode ?? 0) ^
      count.hashCode ^
      metadata.hashCode;

  @override
  String toString() =>
      'StepRecord('
      'id: $id, '
      'count: ${count.value}, '
      'time_range: ${formatTimeRange(startTime: startTime, endTime: endTime)}, '
      'duration: $duration'
      ')';

  @override
  String get name => 'step_record';

  @override
  List<HealthPlatform> get supportedHealthPlatforms => HealthPlatform.values;
}
