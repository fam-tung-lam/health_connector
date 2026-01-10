part of 'health_record.dart';

/// Represents floors climbed over a time interval.
///
/// This record captures the number of floors (flights of stairs) climbed during
/// a specific time period. A floor is typically defined as a vertical distance
/// of approximately 3 meters (10 feet).
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: [`FloorsClimbedRecord`](https://developer.andr
/// oid.com/reference/kotlin/androidx/health/connect/client/records/FloorsClimbe
/// dRecord)
/// - **iOS HealthKit**: [`HKQuantityTypeIdentifier.flightsClimbed`](https://dev
/// eloper.apple.com/documentation/healthkit/hkquantitytypeidentifier/flightscli
/// mbed)
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
  FloorsClimbedRecord({
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required this.count,
    super.id = HealthRecordId.none,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  });

  /// Internal factory for creating [BloodPressureRecord] instances without
  /// validation.
  ///
  /// Creates a [BloodPressureRecord] by directly mapping platform data to
  /// fields, bypassing the normal validation and business rules applied by the
  /// public constructor.
  ///
  /// **⚠️ Warning**: Not for public use. SDK users should use the public
  /// [BloodPressureRecord] constructor, which enforces validation and business
  /// rules. This factory is restricted to the SDK developers and contributors.
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
