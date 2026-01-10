part of '../health_record.dart';

/// Represents a distance measurement over a time interval.
///
/// This record captures the distance traveled during a specific time period,
/// typically from activities like walking, running, cycling, or other movement.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: [`DistanceRecord`](https://developer.android.c
/// om/reference/kotlin/androidx/health/connect/client/records/DistanceRecord)
/// - **iOS HealthKit**: [`HKQuantityTypeIdentifier.distanceWalkingRunning`](htt
/// ps://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/di
/// stancewalkingrunning)
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
  DistanceRecord({
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required this.distance,
    super.id = HealthRecordId.none,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  });

  /// Internal factory for creating [DistanceRecord] instances
  /// without validation.
  ///
  /// Creates a [DistanceRecord] by directly mapping platform data
  /// to fields,
  /// bypassing the normal validation and business rules applied by the
  /// public constructor.
  ///
  /// **⚠️ Warning**: Not for public use. SDK users should use the public
  /// [DistanceRecord] constructor, which enforces validation and
  /// business rules.
  /// This factory is restricted to the SDK developers and contributors.
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
