part of 'health_record.dart';

/// Represents a Forced Expiratory Volume, 1st Second (FEV1) measurement.
///
/// ## See also
///
/// - [ForcedExpiratoryVolumeDataType]
///
/// {@category Health Records}
@sinceV3_4_0
@supportedOnAppleHealth
@immutable
final class ForcedExpiratoryVolumeRecord extends IntervalHealthRecord {
  /// Creates a forced expiratory volume record.
  ///
  /// ## Parameters
  ///
  /// - [startTime]: The start time of the measurement.
  /// - [endTime]: The end time of the measurement.
  /// - [volume]: The volume of air exhaled.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [id]: The unique identifier for this record.
  /// - [startZoneOffsetSeconds]: Optional timezone offset for the start time.
  /// - [endZoneOffsetSeconds]: Optional timezone offset for the end time.
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [endTime] is not after [startTime].
  ForcedExpiratoryVolumeRecord({
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required this.volume,
    super.id = HealthRecordId.none,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  }) {
    requireEndTimeAfterStartTime(startTime: startTime, endTime: endTime);
  }

  /// The volume of air exhaled.
  final Volume volume;

  /// Creates a copy with the given fields replaced with the new values.
  ForcedExpiratoryVolumeRecord copyWith({
    HealthRecordId? id,
    Metadata? metadata,
    DateTime? startTime,
    DateTime? endTime,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
    Volume? volume,
  }) {
    return ForcedExpiratoryVolumeRecord(
      id: id ?? this.id,
      metadata: metadata ?? this.metadata,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      startZoneOffsetSeconds:
          startZoneOffsetSeconds ?? this.startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds ?? this.endZoneOffsetSeconds,
      volume: volume ?? this.volume,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ForcedExpiratoryVolumeRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          metadata == other.metadata &&
          startTime == other.startTime &&
          endTime == other.endTime &&
          startZoneOffsetSeconds == other.startZoneOffsetSeconds &&
          endZoneOffsetSeconds == other.endZoneOffsetSeconds &&
          volume == other.volume;

  @override
  int get hashCode =>
      id.hashCode ^
      metadata.hashCode ^
      startTime.hashCode ^
      endTime.hashCode ^
      startZoneOffsetSeconds.hashCode ^
      endZoneOffsetSeconds.hashCode ^
      volume.hashCode;
}
