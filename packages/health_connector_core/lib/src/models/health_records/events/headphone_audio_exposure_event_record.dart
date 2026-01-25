part of '../health_record.dart';

/// A health record representing a headphone audio exposure event.
///
/// ## See also
///
/// - [HeadphoneAudioExposureEventDataType]
/// - [EnvironmentalAudioExposureEventDataType]
/// - [EnvironmentalAudioExposureEventRecord]
/// - [EnvironmentalAudioExposureDataType]
/// - [EnvironmentalAudioExposureRecord]
/// - [HeadphoneAudioExposureDataType]
/// - [HeadphoneAudioExposureRecord]
///
/// {@category Health Records}
@sinceV3_6_0
@supportedOnAppleHealth
@readOnly
@immutable
final class HeadphoneAudioExposureEventRecord extends IntervalHealthRecord {
  /// Internal factory for creating [HeadphoneAudioExposureEventRecord]
  /// instances without validation.
  ///
  /// **⚠️ Warning**: Not for public use.
  @internalUse
  factory HeadphoneAudioExposureEventRecord.internal({
    required HealthRecordId id,
    required DateTime startTime,
    required DateTime endTime,
    required Metadata metadata,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
  }) {
    return HeadphoneAudioExposureEventRecord._(
      id: id,
      startTime: startTime,
      endTime: endTime,
      metadata: metadata,
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
    );
  }

  /// Creates a [HeadphoneAudioExposureEventRecord] with the given
  /// parameters
  HeadphoneAudioExposureEventRecord._({
    required super.id,
    required super.startTime,
    required super.endTime,
    required super.metadata,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  });

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is HeadphoneAudioExposureEventRecord &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            metadata == other.metadata &&
            startTime == other.startTime &&
            endTime == other.endTime &&
            startZoneOffsetSeconds == other.startZoneOffsetSeconds &&
            endZoneOffsetSeconds == other.endZoneOffsetSeconds;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      metadata.hashCode ^
      startTime.hashCode ^
      endTime.hashCode ^
      startZoneOffsetSeconds.hashCode ^
      endZoneOffsetSeconds.hashCode;
}
