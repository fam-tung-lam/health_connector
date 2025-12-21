part of 'health_record.dart';

/// Represents a resting heart rate measurement at a specific point in time.
///
/// [RestingHeartRateRecord] captures the user's heart rate while at complete
/// rest, typically measured first thing in the morning before getting out of
/// bed.
/// This is a point-in-time record with a single timestamp.
///
/// ## Platform Mapping
///
/// - **Android**: Maps to Health Connect's `RestingHeartRateRecord`
/// - **iOS**: Maps to HealthKit's `HKQuantityType(.restingHeartRate)`
@sinceV1_3_0
@immutable
final class RestingHeartRateRecord extends InstantHealthRecord {
  /// Creates a resting heart rate record.
  ///
  /// ## Parameters
  ///
  /// - [id]: The unique identifier for this record.
  /// - [time]: The timestamp when the resting heart rate was measured.
  /// - [zoneOffsetSeconds]: Optional timezone offset for the measurement time.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [beatsPerMinute]: The resting heart rate measurement in beats per
  ///   minute.
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [beatsPerMinute] is negative.
  const RestingHeartRateRecord({
    required super.time,
    required super.metadata,
    required this.beatsPerMinute,
    super.id = HealthRecordId.none,
    super.zoneOffsetSeconds,
  });

  /// The resting heart rate measurement in beats per minute.
  final Number beatsPerMinute;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RestingHeartRateRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          time == other.time &&
          zoneOffsetSeconds == other.zoneOffsetSeconds &&
          beatsPerMinute == other.beatsPerMinute &&
          metadata == other.metadata;

  @override
  int get hashCode =>
      id.hashCode ^
      time.hashCode ^
      (zoneOffsetSeconds?.hashCode ?? 0) ^
      beatsPerMinute.hashCode ^
      metadata.hashCode;

  @override
  List<HealthPlatform> get supportedHealthPlatforms => HealthPlatform.values;
}
