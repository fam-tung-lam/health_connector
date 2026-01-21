part of '../health_record.dart';

/// Represents a user's average heart rate while walking over a time interval.
///
/// A user’s average heart rate while walking is correlated to their fitness
/// level.
///
/// ## See also
///
/// - [WalkingHeartRateAverageDataType]
///
/// {@category Health Records}
@sinceV3_4_0
@supportedOnAppleHealth
@readOnly
@immutable
final class WalkingHeartRateAverageRecord extends IntervalHealthRecord {
  /// Internal factory for creating instances without validation.
  ///
  /// **⚠️ Warning**: Not for public use. SDK users should use the public
  /// constructor, which enforces validation.
  @internalUse
  factory WalkingHeartRateAverageRecord.internal({
    required HealthRecordId id,
    required DateTime startTime,
    required DateTime endTime,
    required Metadata metadata,
    required Frequency rate,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
  }) {
    return WalkingHeartRateAverageRecord._(
      id: id,
      startTime: startTime,
      endTime: endTime,
      metadata: metadata,
      rate: rate,
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
    );
  }

  WalkingHeartRateAverageRecord._({
    required super.id,
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required this.rate,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  });

  /// The average heart rate measurement in beats per minute.
  final Frequency rate;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WalkingHeartRateAverageRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          startTime == other.startTime &&
          endTime == other.endTime &&
          startZoneOffsetSeconds == other.startZoneOffsetSeconds &&
          endZoneOffsetSeconds == other.endZoneOffsetSeconds &&
          metadata == other.metadata &&
          rate == other.rate;

  @override
  int get hashCode =>
      id.hashCode ^
      startTime.hashCode ^
      endTime.hashCode ^
      (startZoneOffsetSeconds?.hashCode ?? 0) ^
      (endZoneOffsetSeconds?.hashCode ?? 0) ^
      metadata.hashCode ^
      rate.hashCode;
}
