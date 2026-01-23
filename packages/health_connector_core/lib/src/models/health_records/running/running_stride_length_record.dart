part of '../health_record.dart';

/// Represents a Running Stride Length measurement over a time interval.
///
/// Tracks the distance covered by a single step while running.
///
/// ## See also
///
/// - [RunningStrideLengthDataType]
///
/// {@category Health Records}
@sinceV3_5_0
@supportedOnAppleHealthIOS16Plus
@immutable
final class RunningStrideLengthRecord extends IntervalHealthRecord {
  /// Minimum valid running stride length (0.20 meters / 20 cm).
  ///
  /// Accommodates children, individuals with mobility issues, and slow
  /// running/jogging.
  static const Length minStrideLength = Length.centimeters(20.0);

  /// Maximum valid running stride length (5.0 meters).
  ///
  /// Accommodates world-class sprinters and elite athletes. Normal maximum
  /// is around 2.5 meters; 5.0 meters provides margin for extreme edge cases.
  static const Length maxStrideLength = Length.meters(5.0);

  /// Creates a running stride length record.
  ///
  /// ## Parameters
  ///
  /// - [id]: The unique identifier for this record.
  /// - [startTime]: The start of the time interval (inclusive).
  /// - [endTime]: The end of the time interval (exclusive).
  /// - [startZoneOffsetSeconds]: Optional timezone offset for start time.
  /// - [endZoneOffsetSeconds]: Optional timezone offset for end time.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [strideLength]: The running stride length measurement.
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [endTime] is not after [startTime].
  /// - [ArgumentError] if [strideLength] is outside the valid range of
  ///   [minStrideLength]-[maxStrideLength].
  RunningStrideLengthRecord({
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required this.strideLength,
    super.id = HealthRecordId.none,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  }) {
    requireEndTimeAfterStartTime(startTime: startTime, endTime: endTime);
    require(
      condition:
          strideLength >= minStrideLength && strideLength <= maxStrideLength,
      value: strideLength,
      name: 'strideLength',
      message:
          'Running stride length must be between '
          '${minStrideLength.inCentimeters.toStringAsFixed(0)} cm-'
          '${maxStrideLength.inMeters.toStringAsFixed(1)} m. '
          'Got ${strideLength.inCentimeters.toStringAsFixed(1)} cm.',
    );
  }

  /// Internal factory for creating [RunningStrideLengthRecord] instances
  /// without validation.
  ///
  /// **⚠️ Warning**: Not for public use.
  @internalUse
  factory RunningStrideLengthRecord.internal({
    required HealthRecordId id,
    required DateTime startTime,
    required DateTime endTime,
    required Metadata metadata,
    required Length strideLength,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
  }) {
    return RunningStrideLengthRecord._(
      id: id,
      startTime: startTime,
      endTime: endTime,
      metadata: metadata,
      strideLength: strideLength,
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
    );
  }

  RunningStrideLengthRecord._({
    required super.id,
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required this.strideLength,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  });

  /// The running stride length.
  final Length strideLength;

  /// Creates a copy with the given fields replaced with the new values.
  RunningStrideLengthRecord copyWith({
    DateTime? startTime,
    DateTime? endTime,
    Length? strideLength,
    Metadata? metadata,
    HealthRecordId? id,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
  }) {
    return RunningStrideLengthRecord(
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      strideLength: strideLength ?? this.strideLength,
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
      other is RunningStrideLengthRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          metadata == other.metadata &&
          startTime == other.startTime &&
          endTime == other.endTime &&
          startZoneOffsetSeconds == other.startZoneOffsetSeconds &&
          endZoneOffsetSeconds == other.endZoneOffsetSeconds &&
          strideLength == other.strideLength;

  @override
  int get hashCode => Object.hash(
    id,
    metadata,
    startTime,
    endTime,
    startZoneOffsetSeconds,
    endZoneOffsetSeconds,
    strideLength,
  );
}
