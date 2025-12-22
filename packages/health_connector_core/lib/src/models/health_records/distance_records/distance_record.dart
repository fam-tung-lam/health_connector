part of '../health_record.dart';

/// Represents a distance measurement over a time interval.
///
/// This record captures the distance traveled during a specific time period,
/// typically from activities like walking, running, cycling, or other movement.
///
/// ## Platform Mapping
/// - **Android (Health Connect)**:
///   `androidx.health.connect.client.records.DistanceRecord`
/// - **iOS (HealthKit)**:
///   `HKQuantityTypeIdentifier.distanceWalkingRunning`
///
/// ## Example
/// ```dart
/// final record = DistanceRecord(
///   startTime: DateTime.now().subtract(Duration(hours: 1)),
///   endTime: DateTime.now(),
///   distance: Length.meters(5000), // 5 km
///   metadata: Metadata.automaticallyRecorded(
///     dataOrigin: DataOrigin(packageName: 'com.example.app'),
///   ),
/// );
/// ```
@sinceV1_0_0
@supportedOnHealthConnect
@immutable
final class DistanceRecord extends IntervalHealthRecord {
  /// Creates a distance record.
  ///
  /// ## Parameters
  ///
  /// - [startTime]: The start of the time interval (inclusive).
  /// - [endTime]: The end of the time interval (exclusive).
  /// - [distance]: The distance traveled during the interval.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [id]: The unique identifier for this record.
  /// - [startZoneOffsetSeconds]: Optional timezone offset for start time.
  /// - [endZoneOffsetSeconds]: Optional timezone offset for end time.
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [endTime] is not after [startTime].
  const DistanceRecord({
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required this.distance,
    super.id = HealthRecordId.none,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  });

  /// The distance measurement value.
  final Length distance;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DistanceRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          startTime == other.startTime &&
          endTime == other.endTime &&
          startZoneOffsetSeconds == other.startZoneOffsetSeconds &&
          endZoneOffsetSeconds == other.endZoneOffsetSeconds &&
          distance == other.distance &&
          metadata == other.metadata;

  @override
  int get hashCode =>
      id.hashCode ^
      startTime.hashCode ^
      endTime.hashCode ^
      (startZoneOffsetSeconds?.hashCode ?? 0) ^
      (endZoneOffsetSeconds?.hashCode ?? 0) ^
      distance.hashCode ^
      metadata.hashCode;

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.healthConnect,
  ];
}
