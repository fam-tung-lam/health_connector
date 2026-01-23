part of '../health_record.dart';

/// Represents a heart rate recovery measurement over a one-minute interval.
///
/// Heart rate recovery is the reduction in heart rate from the peak exercise
/// rate to the rate one minute after exercising ended.
///
/// ## See also
///
/// - [HeartRateRecoveryOneMinuteDataType]
///
/// {@category Health Records}
@sinceV3_5_0
@supportedOnAppleHealthIOS16Plus
@immutable
final class HeartRateRecoveryOneMinuteRecord extends IntervalHealthRecord {
  /// Minimum valid heart rate recovery value (0).
  static const Frequency minHeartRateRecovery = Frequency.zero;

  /// Maximum valid heart rate recovery value (200).
  ///
  /// A value of 200 bpm recovery is extremely high and unlikely in normal
  /// physiology, providing a safe upper bound.
  static final Frequency maxHeartRateRecovery = Frequency.perMinute(200.0);

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
  /// - [rate]: The reduction in heart rate (must be >= 0).
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [rate] is negative or exceeds
  ///   [maxHeartRateRecovery].
  /// - [ArgumentError] if [endTime] is not after [startTime].
  HeartRateRecoveryOneMinuteRecord({
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required this.rate,
    super.id = HealthRecordId.none,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  }) {
    requireEndTimeAfterStartTime(startTime: startTime, endTime: endTime);
    require(
      condition: rate >= minHeartRateRecovery && rate <= maxHeartRateRecovery,
      value: rate,
      name: 'beatsPerMinute',
      message:
          'Heart rate recovery must be between '
          '${minHeartRateRecovery.inPerMinute.toInt()}-'
          '${maxHeartRateRecovery.inPerMinute.toInt()}. '
          'Got ${rate.inPerMinute.toInt()}.',
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
    required Frequency rate,
    required Metadata metadata,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
  }) {
    return HeartRateRecoveryOneMinuteRecord._(
      startTime: startTime,
      endTime: endTime,
      rate: rate,
      metadata: metadata,
      id: id,
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
    );
  }

  /// Private constructor without validation.
  HeartRateRecoveryOneMinuteRecord._({
    required this.rate,
    required super.startTime,
    required super.endTime,
    required super.metadata,
    super.id,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  });

  /// The reduction in heart rate from the peak exercise rate to the rate
  /// one minute after exercising ended, measured in beats per minute.
  final Frequency rate;

  /// Creates a copy with the given fields replaced with the new values.
  HeartRateRecoveryOneMinuteRecord copyWith({
    DateTime? startTime,
    DateTime? endTime,
    Frequency? rate,
    Metadata? metadata,
    HealthRecordId? id,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
  }) {
    return HeartRateRecoveryOneMinuteRecord(
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      rate: rate ?? this.rate,
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
          rate == other.rate &&
          metadata == other.metadata;

  @override
  int get hashCode =>
      id.hashCode ^
      startTime.hashCode ^
      endTime.hashCode ^
      (startZoneOffsetSeconds?.hashCode ?? 0) ^
      (endZoneOffsetSeconds?.hashCode ?? 0) ^
      rate.hashCode ^
      metadata.hashCode;
}
