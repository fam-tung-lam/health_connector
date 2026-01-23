part of 'health_record.dart';

/// Represents a step count record over a time interval.
///
/// [StepsRecord] tracks the number of steps taken during a specific time
/// period. This is an interval-based record, meaning it has both a start and
/// end time.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: [`StepsRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/StepsRecord)
/// - **iOS HealthKit**: [`HKQuantityTypeIdentifier.stepCount`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/stepcount)
///
/// ## Example
///
/// ```dart
/// final record = StepsRecord(
///   startTime: DateTime.now().subtract(Duration(hours: 1)),
///   endTime: DateTime.now(),
///   count: Number(1500),
///   metadata: Metadata.automaticallyRecorded(
///     device: Device.fromType(DeviceType.phone),
///   ),
/// );
/// ```
///
/// ## See also
///
/// - [StepsDataType]
///
/// {@category Health Records}
@sinceV1_0_0
@immutable
final class StepsRecord extends IntervalHealthRecord {
  /// Minimum valid step count (0).
  /// Minimum valid step count (0).
  static const Number minSteps = Number.zero;

  /// Maximum valid step count (1,000,000).
  ///
  /// Represents extreme endurance events (e.g., 200+ mile ultra-marathons)
  /// with safety margin.
  static const Number maxSteps = Number(1000000);

  /// Creates a step count record.
  ///
  /// ## Parameters
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
  /// - [ArgumentError] if [count] is negative.
  /// - [ArgumentError] if [endTime] is not after [startTime].
  /// - [ArgumentError] if [count] is outside the valid range of
  ///   [minSteps]-[maxSteps].
  StepsRecord({
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required this.count,
    super.id,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  }) {
    requireEndTimeAfterStartTime(startTime: startTime, endTime: endTime);
    require(
      condition: count >= minSteps && count <= maxSteps,
      value: count,
      name: 'count',
      message:
          'Steps must be between ${minSteps.value.toInt()}-'
          '${maxSteps.value.toInt()}. '
          'Got ${count.value.toInt()} steps.',
    );
  }

  /// Internal factory for creating [StepsRecord] instances
  /// without validation.
  ///
  /// **⚠️ Warning**: Not for public use.
  @internalUse
  factory StepsRecord.internal({
    required HealthRecordId id,
    required DateTime startTime,
    required DateTime endTime,
    required Number count,
    required Metadata metadata,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
  }) {
    return StepsRecord._(
      startTime: startTime,
      endTime: endTime,
      count: count,
      metadata: metadata,
      id: id,
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
    );
  }

  /// Private constructor without validation.
  StepsRecord._({
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required this.count,
    super.id,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  });

  /// The number of steps taken during the interval.
  ///
  /// Must be non-negative (>= 0).
  final Number count;

  /// Creates a copy with the given fields replaced with the new values.
  StepsRecord copyWith({
    DateTime? startTime,
    DateTime? endTime,
    Number? count,
    Metadata? metadata,
    HealthRecordId? id,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
  }) {
    return StepsRecord(
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      count: count ?? this.count,
      metadata: metadata ?? this.metadata,
      id: id ?? this.id,
      startZoneOffsetSeconds:
          startZoneOffsetSeconds ?? this.startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds ?? this.endZoneOffsetSeconds,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StepsRecord &&
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
}
