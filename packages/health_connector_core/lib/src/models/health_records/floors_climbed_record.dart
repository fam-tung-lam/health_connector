part of 'health_record.dart';

/// Represents floors climbed over a time interval.
///
/// This record captures the number of floors (flights of stairs) climbed during
/// a specific time period. A floor is typically defined as a vertical distance
/// of approximately 3 meters (10 feet).
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: [`FloorsClimbedRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/FloorsClimbedRecord)
/// - **iOS HealthKit**: [`HKQuantityTypeIdentifier.flightsClimbed`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/flightsclimbed)
///
/// ## Example
///
/// ```dart
/// final record = FloorsClimbedRecord(
///   startTime: DateTime.now().subtract(Duration(hours: 1)),
///   endTime: DateTime.now(),
///   floors: Numeric(5), // 5 floors climbed
///   metadata: Metadata.automaticallyRecorded(
///     device: Device.fromType(DeviceType.watch),
///   ),
/// );
/// ```
///
/// ## See also
///
/// - [FloorsClimbedDataType]
///
/// {@category Health Records}
@sinceV1_0_0
@immutable
final class FloorsClimbedRecord extends IntervalHealthRecord {
  /// Minimum valid floors climbed (0.0).
  ///
  /// No floors climbed during the interval.
  /// Minimum valid floors climbed (0).
  ///
  /// No floors climbed during the interval.
  static const Number minFloors = Number.zero;

  /// Maximum valid floors climbed (1,000).
  ///
  /// Typical max ~50 floors/day; 1,000 allows for multi-day intervals and
  /// extreme cases.
  static const Number maxFloors = Number(1000);

  /// Creates a floors climbed record.
  ///
  /// ## Parameters
  ///
  /// - [startTime]: The start of the time interval (inclusive).
  /// - [endTime]: The end of the time interval (exclusive).
  /// - [count]: The number of floors (flights of stairs) climbed.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [id]: The unique identifier for this record.
  /// - [startZoneOffsetSeconds]: Optional timezone offset for start time.
  /// - [endZoneOffsetSeconds]: Optional timezone offset for end time.
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [endTime] is not after [startTime].
  /// - [ArgumentError] if [count] is outside the valid range of
  ///   [minFloors]-[maxFloors].
  ///
  /// ## Validation Rationale
  ///
  /// - **Minimum ([minFloors])**: No floors climbed during the interval.
  /// - **Maximum ([maxFloors])**: Typical max ~50 floors/day; 1,000 allows for
  ///   multi-day intervals and extreme cases.
  FloorsClimbedRecord({
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required this.count,
    super.id = HealthRecordId.none,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  }) {
    requireEndTimeAfterStartTime(startTime: startTime, endTime: endTime);
    require(
      condition: count >= minFloors && count <= maxFloors,
      value: count,
      name: 'count',
      message:
          'Floors climbed must be between '
          '${minFloors.value.toInt()}-${maxFloors.value.toInt()}. '
          'Got ${count.value.toInt()} floors.',
    );
  }

  /// Internal factory for creating [BloodPressureRecord] instances without
  /// validation.
  ///
  /// **⚠️ Warning**: Not for public use. SDK users should use the public
  /// [BloodPressureRecord] constructor, which enforces validation and business
  /// rules.
  @internalUse
  factory FloorsClimbedRecord.internal({
    required HealthRecordId id,
    required DateTime startTime,
    required DateTime endTime,
    required Metadata metadata,
    required Number count,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
  }) {
    return FloorsClimbedRecord._(
      id: id,
      startTime: startTime,
      endTime: endTime,
      metadata: metadata,
      count: count,
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
    );
  }

  FloorsClimbedRecord._({
    required super.id,
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required this.count,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  });

  /// The number of floors (flights of stairs) climbed during the interval.
  final Number count;

  /// Creates a copy with the given fields replaced with the new values.
  FloorsClimbedRecord copyWith({
    DateTime? startTime,
    DateTime? endTime,
    Number? count,
    Metadata? metadata,
    HealthRecordId? id,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
  }) {
    return FloorsClimbedRecord(
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      count: count ?? this.count,
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
          count == other.count &&
          metadata == other.metadata;

  @override
  int get hashCode =>
      id.hashCode ^
      startTime.hashCode ^
      endTime.hashCode ^
      (startZoneOffsetSeconds?.hashCode ?? 0) ^
      (endZoneOffsetSeconds?.hashCode ?? 0) ^
      count.hashCode ^
      metadata.hashCode;
}
