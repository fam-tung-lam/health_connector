part of 'health_record.dart';

/// Represents floors climbed over a time interval.
///
/// This record captures the number of floors (flights of stairs) climbed during
/// a specific time period. A floor is typically defined as a vertical distance
/// of approximately 3 meters (10 feet).
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: `FloorsClimbedRecord`
/// - **iOS HealthKit**: `HKQuantityTypeIdentifier.flightsClimbed`
///
/// ## Example
///
/// ```dart
/// final record = FloorsClimbedRecord(
///   startTime: DateTime.now().subtract(Duration(hours: 1)),
///   endTime: DateTime.now(),
///   floors: Numeric(5), // 5 floors climbed
///   metadata: Metadata.automaticallyRecorded(
///     dataOrigin: DataOrigin(packageName: 'com.example.app'),
///   ),
/// );
/// ```
///
/// {@category Health Records}
@sinceV1_0_0
@immutable
final class FloorsClimbedRecord extends IntervalHealthRecord {
  /// Creates a floors climbed record.
  ///
  /// ## Parameters
  ///
  /// - [startTime]: The start of the time interval (inclusive).
  /// - [endTime]: The end of the time interval (exclusive).
  /// - [floors]: The number of floors (flights of stairs) climbed.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [id]: The unique identifier for this record.
  /// - [startZoneOffsetSeconds]: Optional timezone offset for start time.
  /// - [endZoneOffsetSeconds]: Optional timezone offset for end time.
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [endTime] is not after [startTime].
  const FloorsClimbedRecord({
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required this.floors,
    super.id = HealthRecordId.none,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  });

  /// The number of floors (flights of stairs) climbed during the interval.
  final Number floors;

  /// Creates a copy with the given fields replaced with the new values.
  FloorsClimbedRecord copyWith({
    DateTime? startTime,
    DateTime? endTime,
    Number? floors,
    Metadata? metadata,
    HealthRecordId? id,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
  }) {
    return FloorsClimbedRecord(
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      floors: floors ?? this.floors,
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
      other is FloorsClimbedRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          startTime == other.startTime &&
          endTime == other.endTime &&
          startZoneOffsetSeconds == other.startZoneOffsetSeconds &&
          endZoneOffsetSeconds == other.endZoneOffsetSeconds &&
          floors == other.floors &&
          metadata == other.metadata;

  @override
  int get hashCode =>
      id.hashCode ^
      startTime.hashCode ^
      endTime.hashCode ^
      (startZoneOffsetSeconds?.hashCode ?? 0) ^
      (endZoneOffsetSeconds?.hashCode ?? 0) ^
      floors.hashCode ^
      metadata.hashCode;
}
