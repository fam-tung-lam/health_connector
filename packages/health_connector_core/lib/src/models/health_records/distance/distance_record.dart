part of '../health_record.dart';

/// Represents a distance measurement over a time interval.
///
/// This record captures the distance traveled during a specific time period,
/// typically from activities like walking, running, cycling, or other movement.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: [`DistanceRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/DistanceRecord)
/// - **iOS HealthKit**: [`HKQuantityTypeIdentifier.distanceWalkingRunning`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/distancewalkingrunning)
///
/// ## Example
///
/// ```dart
/// final record = DistanceRecord(
///   startTime: DateTime.now().subtract(Duration(hours: 1)),
///   endTime: DateTime.now(),
///   distance: Length.meters(5000), // 5 km
///   metadata: Metadata.automaticallyRecorded(
///     device: Device.fromType(DeviceType.watch),
///   ),
/// );
/// ```
///
/// {@category Health Records}
@sinceV1_0_0
@supportedOnHealthConnect
@immutable
final class DistanceRecord extends IntervalHealthRecord {
  /// Minimum valid distance (0.0 km).
  static const Length minDistance = Length.zero;

  /// Maximum valid distance (1,000.0 km).
  ///
  /// Ultra-endurance events (e.g., multi-day races, cycling tours) can exceed
  /// 500 km; 1,000 km allows for aggregated data.
  static const Length maxDistance = Length.kilometers(1000.0);

  /// Creates a distance record.
  ///
  /// ## Parameters
  ///
  /// - [id]: The unique identifier for this record.
  /// - [startTime]: The start of the time interval (inclusive).
  /// - [endTime]: The end of the time interval (exclusive).
  /// - [startZoneOffsetSeconds]: Optional timezone offset for start time.
  /// - [endZoneOffsetSeconds]: Optional timezone offset for end time.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [distance]: The total distance traveled.
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [endTime] is not after [startTime].
  /// - [ArgumentError] if [distance] is outside the valid range of
  ///   [minDistance]-[maxDistance] km.
  ///
  /// ## Validation Rationale
  ///
  /// - **Minimum ([minDistance] km)**: No distance during the interval.
  /// - **Maximum ([maxDistance] km)**: Ultra-endurance events (e.g.,
  ///   multi-day races, cycling tours) can exceed 500 km; 1,000 km allows for
  ///   aggregated data.
  DistanceRecord({
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required this.distance,
    super.id = HealthRecordId.none,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  }) {
    require(
      condition: distance >= minDistance && distance <= maxDistance,
      value: distance,
      name: 'distance',
      message:
          'Distance must be between '
          '${minDistance.inKilometers.toStringAsFixed(0)}-'
          '${maxDistance.inKilometers.toStringAsFixed(0)} km. '
          'Got ${distance.inKilometers.toStringAsFixed(1)} km.',
    );
  }

  /// Internal factory for creating [DistanceRecord] instances
  /// without validation.
  ///
  /// **⚠️ Warning**: Not for public use. SDK users should use the public
  /// [DistanceRecord] constructor, which enforces validation.
  @internalUse
  factory DistanceRecord.internal({
    required HealthRecordId id,
    required DateTime startTime,
    required DateTime endTime,
    required Metadata metadata,
    required Length distance,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
  }) {
    return DistanceRecord._(
      id: id,
      startTime: startTime,
      endTime: endTime,
      metadata: metadata,
      distance: distance,
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
    );
  }

  DistanceRecord._({
    required super.id,
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required this.distance,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  });

  /// The distance measurement value.
  final Length distance;

  /// Creates a copy with the given fields replaced with the new values.
  DistanceRecord copyWith({
    DateTime? startTime,
    DateTime? endTime,
    Length? distance,
    Metadata? metadata,
    HealthRecordId? id,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
  }) {
    return DistanceRecord(
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      distance: distance ?? this.distance,
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
}
