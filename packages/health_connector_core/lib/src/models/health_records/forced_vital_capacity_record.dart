part of 'health_record.dart';

/// Represents a Forced Vital Capacity (FVC) measurement.
///
/// Forced Vital Capacity is the amount of air that can be forcibly exhaled from
/// the lungs after taking the deepest breath possible.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: Not supported
/// - **iOS HealthKit**: [`HKQuantityTypeIdentifier.forcedVitalCapacity`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/forcedvitalcapacity)
///
/// ## Example
///
/// ```dart
/// final record = ForcedVitalCapacityRecord(
///   time: DateTime.now(),
///   volume: Volume.liters(3.5),
///   metadata: Metadata.manuallyRecorded(),
/// );
/// ```
///
/// ## See also
///
/// - [ForcedVitalCapacityDataType]
///
/// {@category Health Records}
@sinceV3_1_0
@supportedOnAppleHealth
@immutable
final class ForcedVitalCapacityRecord extends InstantHealthRecord {
  /// Creates a forced vital capacity record.
  ///
  /// ## Parameters
  ///
  /// - [time]: The timestamp when the measurement was taken.
  /// - [volume]: The volume of air exhaled.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [id]: The unique identifier for this record.
  /// - [zoneOffsetSeconds]: Optional timezone offset for the measurement time.
  ForcedVitalCapacityRecord({
    required super.time,
    required super.metadata,
    required this.volume,
    super.id = HealthRecordId.none,
    super.zoneOffsetSeconds,
  });

  /// The volume of air exhaled.
  final Volume volume;

  /// Creates a copy with the given fields replaced with the new values.
  ForcedVitalCapacityRecord copyWith({
    HealthRecordId? id,
    Metadata? metadata,
    DateTime? time,
    int? zoneOffsetSeconds,
    Volume? volume,
  }) {
    return ForcedVitalCapacityRecord(
      id: id ?? this.id,
      metadata: metadata ?? this.metadata,
      time: time ?? this.time,
      zoneOffsetSeconds: zoneOffsetSeconds ?? this.zoneOffsetSeconds,
      volume: volume ?? this.volume,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ForcedVitalCapacityRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          metadata == other.metadata &&
          time == other.time &&
          zoneOffsetSeconds == other.zoneOffsetSeconds &&
          volume == other.volume;

  @override
  int get hashCode =>
      id.hashCode ^
      metadata.hashCode ^
      time.hashCode ^
      zoneOffsetSeconds.hashCode ^
      volume.hashCode;
}
