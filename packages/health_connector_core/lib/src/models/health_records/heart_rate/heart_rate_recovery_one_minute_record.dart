part of '../health_record.dart';

/// Represents a heart rate recovery measurement over a one-minute interval.
///
/// Heart rate recovery is the reduction in heart rate from the peak exercise
/// rate to the rate one minute after exercising ended.
///
/// {@category Health Records}
@sinceV3_5_0
@supportedOnAppleHealthIOS16Plus
@immutable
final class HeartRateRecoveryOneMinuteRecord extends IntervalHealthRecord {
  /// Minimum valid heart rate recovery value (0).
  static const Number minHeartRateRecovery = Number.zero;

  /// Maximum valid heart rate recovery value (200).
  ///
  /// A value of 200 bpm recovery is extremely high and unlikely in normal
  /// physiology, providing a safe upper bound.
  static const Number maxHeartRateRecovery = Number(200.0);

  /// Creates a heart rate recovery one minute record.
  ///
  /// ## Parameters
  ///
  /// - [id]: The unique identifier for this record.
  /// - [startTime]: The start of the time interval (inclusive), typically
  ///   when exercise ended.
  /// - [endTime]: The end of the time interval (exclusive), one minute after
  ///   exercise ended.
  /// - [startZoneOffsetSeconds]: Optional timezone offset for start time.
  /// - [endZoneOffsetSeconds]: Optional timezone offset for end time.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [heartRateCount]: The reduction in heart rate (must be >= 0).
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [heartRateCount] is negative or exceeds
  ///   [maxHeartRateRecovery].
  /// - [ArgumentError] if [endTime] is not after [startTime].
  HeartRateRecoveryOneMinuteRecord({
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required this.heartRateCount,
    super.id = HealthRecordId.none,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  }) {
    require(
      condition:
          heartRateCount >= minHeartRateRecovery &&
          heartRateCount <= maxHeartRateRecovery,
      value: heartRateCount,
      name: 'heartRateCount',
      message:
          'Heart rate recovery must be between '
          '${minHeartRateRecovery.value.toInt()}-'
          '${maxHeartRateRecovery.value.toInt()}. '
          'Got ${heartRateCount.value.toInt()}.',
    );
  }

  /// Internal factory for creating [HeartRateRecoveryOneMinuteRecord] instances
  /// without validation.
  ///
  /// **⚠️ Warning**: Not for public use. SDK users should use the public
  /// [HeartRateRecoveryOneMinuteRecord] constructor, which enforces validation.
  @internalUse
  factory HeartRateRecoveryOneMinuteRecord.internal({
    required HealthRecordId id,
    required DateTime startTime,
    required DateTime endTime,
    required Number heartRateCount,
    required Metadata metadata,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
  }) {
    return HeartRateRecoveryOneMinuteRecord._(
      startTime: startTime,
      endTime: endTime,
      heartRateCount: heartRateCount,
      metadata: metadata,
      id: id,
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
    );
  }

  /// Private constructor without validation.
  HeartRateRecoveryOneMinuteRecord._({
    required this.heartRateCount,
    required super.startTime,
    required super.endTime,
    required super.metadata,
    super.id,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  });

  /// The reduction in heart rate from the peak exercise rate to the rate
  /// one minute after exercising ended.
  final Number heartRateCount;

  /// Creates a copy with the given fields replaced with the new values.
  HeartRateRecoveryOneMinuteRecord copyWith({
    DateTime? startTime,
    DateTime? endTime,
    Number? heartRateCount,
    Metadata? metadata,
    HealthRecordId? id,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
  }) {
    return HeartRateRecoveryOneMinuteRecord(
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      heartRateCount: heartRateCount ?? this.heartRateCount,
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
      other is HeartRateRecoveryOneMinuteRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          startTime == other.startTime &&
          endTime == other.endTime &&
          startZoneOffsetSeconds == other.startZoneOffsetSeconds &&
          endZoneOffsetSeconds == other.endZoneOffsetSeconds &&
          heartRateCount == other.heartRateCount &&
          metadata == other.metadata;

  @override
  int get hashCode =>
      id.hashCode ^
      startTime.hashCode ^
      endTime.hashCode ^
      (startZoneOffsetSeconds?.hashCode ?? 0) ^
      (endZoneOffsetSeconds?.hashCode ?? 0) ^
      heartRateCount.hashCode ^
      metadata.hashCode;
}
