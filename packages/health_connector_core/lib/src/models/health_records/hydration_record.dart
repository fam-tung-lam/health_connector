part of 'health_record.dart';

/// Represents a hydration (water intake) measurement over a time interval.
///
/// Tracks the volume of water consumed during a specific time period.
///
/// ## Platform Mapping
/// - **Android (Health Connect)**:
///   `androidx.health.connect.client.records.HydrationRecord`
/// - **iOS (HealthKit)**: `HKQuantityTypeIdentifier.dietaryWater`
///
/// ## Example
/// ```dart
/// final record = HydrationRecord(
///   id: HealthRecordId.none,
///   startTime: DateTime.now().subtract(Duration(minutes: 30)),
///   endTime: DateTime.now(),
///   volume: Volume.milliliters(500),
///   metadata: Metadata.automaticallyRecorded(
///     dataOrigin: DataOrigin(packageName: 'com.example.hydration_tracker'),
///   ),
/// );
/// ```
@sinceV1_0_0
@immutable
final class HydrationRecord extends IntervalHealthRecord {
  /// Creates a hydration record.
  ///
  /// ## Parameters
  ///
  /// - [startTime]: The start of the time interval (inclusive).
  /// - [endTime]: The end of the time interval (exclusive).
  /// - [volume]: The volume of water consumed during the interval.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [id]: The unique identifier for this record.
  /// - [startZoneOffsetSeconds]: Optional timezone offset for start time.
  /// - [endZoneOffsetSeconds]: Optional timezone offset for end time.
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [endTime] is not after [startTime].
  const HydrationRecord({
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required this.volume,
    super.id = HealthRecordId.none,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  });

  /// The volume of water consumed.
  final Volume volume;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HydrationRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          startTime == other.startTime &&
          endTime == other.endTime &&
          startZoneOffsetSeconds == other.startZoneOffsetSeconds &&
          endZoneOffsetSeconds == other.endZoneOffsetSeconds &&
          volume == other.volume &&
          metadata == other.metadata;

  @override
  int get hashCode =>
      id.hashCode ^
      startTime.hashCode ^
      endTime.hashCode ^
      (startZoneOffsetSeconds?.hashCode ?? 0) ^
      (endZoneOffsetSeconds?.hashCode ?? 0) ^
      volume.hashCode ^
      metadata.hashCode;

  @override
  List<HealthPlatform> get supportedHealthPlatforms => HealthPlatform.values;
}
