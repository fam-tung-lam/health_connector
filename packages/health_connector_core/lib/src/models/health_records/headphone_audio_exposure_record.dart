part of 'health_record.dart';

/// A health record representing headphone audio exposure.
///
/// A quantity sample type that measures audio exposure from headphones.
///
/// ## See also
///
/// - [HeadphoneAudioExposureDataType]
/// - [EnvironmentalAudioExposureEventDataType]
/// - [EnvironmentalAudioExposureEventRecord]
/// - [EnvironmentalAudioExposureDataType]
/// - [EnvironmentalAudioExposureRecord]
/// - [HeadphoneAudioExposureEventDataType]
/// - [HeadphoneAudioExposureEventRecord]
///
/// {@category Health Records}
@sinceV3_6_0
@immutable
final class HeadphoneAudioExposureRecord extends IntervalHealthRecord {
  /// Creates a [HeadphoneAudioExposureRecord] with the given parameters.
  HeadphoneAudioExposureRecord({
    required super.startTime,
    required super.endTime,
    required this.aWeightedDecibel,
    required super.metadata,
    super.id = HealthRecordId.none,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  }) {
    requireEndTimeAfterStartTime(startTime: startTime, endTime: endTime);
  }

  /// Internal factory for creating [HeadphoneAudioExposureRecord] instances
  /// without validation.
  ///
  /// **⚠️ Warning**: Not for public use.
  @internalUse
  factory HeadphoneAudioExposureRecord.internal({
    required HealthRecordId id,
    required DateTime startTime,
    required DateTime endTime,
    required Metadata metadata,
    required Number aWeightedDecibel,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
  }) {
    return HeadphoneAudioExposureRecord._(
      id: id,
      startTime: startTime,
      endTime: endTime,
      metadata: metadata,
      aWeightedDecibel: aWeightedDecibel,
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
    );
  }

  /// Creates a [HeadphoneAudioExposureRecord] with the given
  /// parameters
  HeadphoneAudioExposureRecord._({
    required super.id,
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required this.aWeightedDecibel,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  });

  /// The A-weighted decibel level associated with headphone audio exposure.
  ///
  /// Measures the equivalent continuous sound pressure level from
  /// headphones. Unit: dB(A).
  final Number aWeightedDecibel;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is HeadphoneAudioExposureRecord &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            metadata == other.metadata &&
            startTime == other.startTime &&
            endTime == other.endTime &&
            startZoneOffsetSeconds == other.startZoneOffsetSeconds &&
            endZoneOffsetSeconds == other.endZoneOffsetSeconds &&
            aWeightedDecibel == other.aWeightedDecibel;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      metadata.hashCode ^
      startTime.hashCode ^
      endTime.hashCode ^
      startZoneOffsetSeconds.hashCode ^
      endZoneOffsetSeconds.hashCode ^
      aWeightedDecibel.hashCode;

  /// Creates a copy of this record with the given fields replaced with new
  /// values.
  HeadphoneAudioExposureRecord copyWith({
    DateTime? startTime,
    DateTime? endTime,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
    Number? aWeightedDecibel,
    Metadata? metadata,
    HealthRecordId? id,
  }) {
    return HeadphoneAudioExposureRecord(
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      startZoneOffsetSeconds:
          startZoneOffsetSeconds ?? this.startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds ?? this.endZoneOffsetSeconds,
      aWeightedDecibel: aWeightedDecibel ?? this.aWeightedDecibel,
      metadata: metadata ?? this.metadata,
      id: id ?? this.id,
    );
  }
}
