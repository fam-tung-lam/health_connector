part of '../health_record.dart';

/// A health record representing an environmental audio exposure event.
///
/// {@category Health Records}
@sinceV3_6_0
@immutable
final class EnvironmentalAudioExposureEventRecord extends IntervalHealthRecord {
  /// Internal factory for creating [EnvironmentalAudioExposureEventRecord]
  /// instances without validation.
  ///
  /// **⚠️ Warning**: Not for public use.
  @internalUse
  factory EnvironmentalAudioExposureEventRecord.internal({
    required HealthRecordId id,
    required DateTime startTime,
    required DateTime endTime,
    required Metadata metadata,
    Number? aWeightedDecibel,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
  }) {
    return EnvironmentalAudioExposureEventRecord._(
      id: id,
      startTime: startTime,
      endTime: endTime,
      metadata: metadata,
      aWeightedDecibel: aWeightedDecibel,
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
    );
  }

  /// Creates an [EnvironmentalAudioExposureEventRecord] with the given
  /// parameters
  EnvironmentalAudioExposureEventRecord._({
    required super.id,
    required super.startTime,
    required super.endTime,
    required super.metadata,
    this.aWeightedDecibel,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  });

  /// The audio level associated with an audio event.
  ///
  /// Measures the difference between the local pressure and the ambient
  /// atmospheric pressure caused by sound. Unit: dB(A).
  final Number? aWeightedDecibel;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is EnvironmentalAudioExposureEventRecord &&
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
}
