part of 'health_record.dart';

/// Represents a swimming stroke count record over a time interval.
///
/// [SwimmingStrokesRecord] tracks the number of strokes taken during a specific
/// time period while swimming. This is an interval-based record.
///
/// ## Platform Mapping
///
/// - **iOS HealthKit**: [`HKQuantityTypeIdentifier.swimmingStrokeCount`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/swimmingStrokeCount)
///
/// ## Example
///
/// ```dart
/// final record = SwimmingStrokesRecord(
///   startTime: DateTime.now().subtract(Duration(minutes: 30)),
///   endTime: DateTime.now(),
///   count: Number(500),
///   metadata: Metadata.automaticallyRecorded(
///     device: Device.fromType(DeviceType.watch),
///   ),
/// );
/// ```
///
/// ## See also
///
/// - [SwimmingStrokesDataType]
///
/// {@category Health Records}
@sinceV3_1_0
@immutable
final class SwimmingStrokesRecord extends IntervalHealthRecord {
  /// Minimum valid stroke count (0).
  static const Number minStrokes = Number.zero;

  /// Maximum valid stroke count (100,000).
  ///
  /// Represents a safe upper bound for a single swimming session record.
  static const Number maxStrokes = Number(100000);

  /// Creates a swimming strokes record.
  ///
  /// ## Parameters
  ///
  /// - [id]: The unique identifier for this record.
  /// - [startTime]: The start of the time interval (inclusive).
  /// - [endTime]: The end of the time interval (exclusive).
  /// - [startZoneOffsetSeconds]: Optional timezone offset for start time.
  /// - [endZoneOffsetSeconds]: Optional timezone offset for end time.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [count]: The number of strokes (must be >= 0).
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [count] is negative.
  /// - [ArgumentError] if [endTime] is not after [startTime].
  /// - [ArgumentError] if [count] is outside the valid range of
  ///   [minStrokes]-[maxStrokes].
  SwimmingStrokesRecord({
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
      condition: count >= minStrokes && count <= maxStrokes,
      value: count,
      name: 'count',
      message:
          'Strokes must be between ${minStrokes.value.toInt()}-'
          '${maxStrokes.value.toInt()}. '
          'Got ${count.value.toInt()} strokes.',
    );
  }

  /// Internal factory for creating [SwimmingStrokesRecord] instances
  /// without validation.
  ///
  /// **⚠️ Warning**: Not for public use.
  @internalUse
  factory SwimmingStrokesRecord.internal({
    required HealthRecordId id,
    required DateTime startTime,
    required DateTime endTime,
    required Number count,
    required Metadata metadata,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
  }) {
    return SwimmingStrokesRecord._(
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
  SwimmingStrokesRecord._({
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required this.count,
    super.id,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  });

  /// The number of swimming strokes taken during the interval.
  ///
  /// Must be non-negative (>= 0).
  final Number count;

  /// Creates a copy with the given fields replaced with the new values.
  SwimmingStrokesRecord copyWith({
    DateTime? startTime,
    DateTime? endTime,
    Number? count,
    Metadata? metadata,
    HealthRecordId? id,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
  }) {
    return SwimmingStrokesRecord(
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
      other is SwimmingStrokesRecord &&
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
