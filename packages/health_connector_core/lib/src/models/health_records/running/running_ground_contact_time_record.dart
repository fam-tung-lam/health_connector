part of '../health_record.dart';

/// Represents a Running Ground Contact Time measurement over a time interval.
///
/// Tracks the amount of time the foot is in contact with the ground during
/// running, measured in duration per step. Lower ground contact times typically
/// indicate more efficient running form.
///
/// ## See also
///
/// - [RunningGroundContactTimeDataType]
///
/// {@category Health Records}
@sinceV3_5_0
@supportedOnAppleHealthIOS16Plus
@immutable
final class RunningGroundContactTimeRecord extends IntervalHealthRecord {
  /// Minimum valid ground contact time (50 milliseconds).
  ///
  /// Accommodates very fast sprinting with minimal ground contact.
  static const TimeDuration minGroundContactTime = TimeDuration.milliseconds(
    50.0,
  );

  /// Maximum valid ground contact time (500 milliseconds).
  ///
  /// Accommodates slow jogging or running with extended ground contact.
  static const TimeDuration maxGroundContactTime = TimeDuration.milliseconds(
    500.0,
  );

  /// Creates a running ground contact time record.
  ///
  /// ## Parameters
  ///
  /// - [id]: The unique identifier for this record.
  /// - [startTime]: The start of the time interval (inclusive).
  /// - [endTime]: The end of the time interval (exclusive).
  /// - [startZoneOffsetSeconds]: Optional timezone offset for start time.
  /// - [endZoneOffsetSeconds]: Optional timezone offset for end time.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [groundContactTime]: The running ground contact time measurement.
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [endTime] is not after [startTime].
  /// - [ArgumentError] if [groundContactTime] is outside the valid range of
  ///   [minGroundContactTime]-[maxGroundContactTime].
  RunningGroundContactTimeRecord({
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required this.groundContactTime,
    super.id = HealthRecordId.none,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  }) {
    requireEndTimeAfterStartTime(startTime: startTime, endTime: endTime);
    require(
      condition:
          groundContactTime >= minGroundContactTime &&
          groundContactTime <= maxGroundContactTime,
      value: groundContactTime,
      name: 'groundContactTime',
      message:
          'Running ground contact time must be between '
          '${minGroundContactTime.inMilliseconds.toStringAsFixed(0)} ms-'
          '${maxGroundContactTime.inMilliseconds.toStringAsFixed(0)} ms. '
          'Got ${groundContactTime.inMilliseconds.toStringAsFixed(1)} ms.',
    );
  }

  /// Internal factory for creating [RunningGroundContactTimeRecord] instances
  /// without validation.
  ///
  /// **⚠️ Warning**: Not for public use.
  @internalUse
  factory RunningGroundContactTimeRecord.internal({
    required HealthRecordId id,
    required DateTime startTime,
    required DateTime endTime,
    required Metadata metadata,
    required TimeDuration groundContactTime,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
  }) {
    return RunningGroundContactTimeRecord._(
      id: id,
      startTime: startTime,
      endTime: endTime,
      metadata: metadata,
      groundContactTime: groundContactTime,
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
    );
  }

  RunningGroundContactTimeRecord._({
    required super.id,
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required this.groundContactTime,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  });

  /// The running ground contact time.
  final TimeDuration groundContactTime;

  /// Creates a copy with the given fields replaced with the new values.
  RunningGroundContactTimeRecord copyWith({
    DateTime? startTime,
    DateTime? endTime,
    TimeDuration? groundContactTime,
    Metadata? metadata,
    HealthRecordId? id,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
  }) {
    return RunningGroundContactTimeRecord(
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      groundContactTime: groundContactTime ?? this.groundContactTime,
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
      other is RunningGroundContactTimeRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          metadata == other.metadata &&
          startTime == other.startTime &&
          endTime == other.endTime &&
          startZoneOffsetSeconds == other.startZoneOffsetSeconds &&
          endZoneOffsetSeconds == other.endZoneOffsetSeconds &&
          groundContactTime == other.groundContactTime;

  @override
  int get hashCode => Object.hash(
    id,
    metadata,
    startTime,
    endTime,
    startZoneOffsetSeconds,
    endZoneOffsetSeconds,
    groundContactTime,
  );
}
