part of 'health_record.dart';

/// Represents wheelchair pushes over a time interval.
///
/// This record captures the number of wheelchair pushes performed during
/// a specific time period. A push represents a single propulsion action
/// used to move a wheelchair forward.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: [`WheelchairPushesRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/WheelchairPushesRecord)
/// - **iOS HealthKit**: [`HKQuantityTypeIdentifier.pushCount`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/pushcount)
///
/// ## Example
///
/// ```dart
/// final record = WheelchairPushesRecord(
///   startTime: DateTime.now().subtract(Duration(hours: 1)),
///   endTime: DateTime.now(),
///   count: Numeric(150), // 150 pushes
///   metadata: Metadata.automaticallyRecorded(
///     device: Device.fromType(DeviceType.phone),
///   ),
/// );
/// ```
///
/// ## See also
///
/// - [WheelchairPushesDataType]
///
/// {@category Health Records}
@sinceV1_0_0
@immutable
final class WheelchairPushesRecord extends IntervalHealthRecord {
  /// Minimum valid wheelchair pushes (0.0).
  ///
  /// No wheelchair activity during the interval.
  /// Minimum valid wheelchair pushes (0).
  ///
  /// No wheelchair activity during the interval.
  static const Number minPushes = Number.zero;

  /// Maximum valid wheelchair pushes (100,000).
  ///
  /// Typical daily activity ~500-5,000 pushes; 100,000 allows for multi-day
  /// intervals and high-activity users.
  static const Number maxPushes = Number(100000);

  /// Creates a wheelchair pushes record.
  ///
  /// ## Parameters
  ///
  /// - [startTime]: The start of the time interval (inclusive).
  /// - [endTime]: The end of the time interval (exclusive).
  /// - [count]: The number of wheelchair pushes performed during the interval.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [id]: The unique identifier for this record.
  /// - [startZoneOffsetSeconds]: Optional timezone offset for start time.
  /// - [endZoneOffsetSeconds]: Optional timezone offset for end time.
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [endTime] is not after [startTime].
  /// - [ArgumentError] if [count] is outside the valid range of
  ///   [minPushes]-[maxPushes].
  ///
  /// ## Validation Rationale
  ///
  /// - **Minimum ([minPushes])**: No wheelchair activity during the interval.
  /// - **Maximum ([maxPushes])**: Typical daily activity ~500-5,000 pushes;
  ///   100,000 allows for multi-day intervals and high-activity users.
  WheelchairPushesRecord({
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
      condition: count >= minPushes && count <= maxPushes,
      value: count,
      name: 'count',
      message:
          'Wheelchair pushes must be between '
          '${minPushes.value.toInt()}-${maxPushes.value.toInt()}. '
          'Got ${count.value.toInt()} pushes.',
    );
  }

  /// Internal factory for creating [WheelchairPushesRecord] instances
  /// without validation.
  ///
  /// **⚠️ Warning**: Not for public use. SDK users should use the public
  /// [WheelchairPushesRecord] constructor, which enforces validation.
  @internalUse
  factory WheelchairPushesRecord.internal({
    required HealthRecordId id,
    required DateTime startTime,
    required DateTime endTime,
    required Metadata metadata,
    required Number count,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
  }) {
    return WheelchairPushesRecord._(
      id: id,
      startTime: startTime,
      endTime: endTime,
      metadata: metadata,
      count: count,
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
    );
  }

  WheelchairPushesRecord._({
    required super.id,
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required this.count,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  });

  /// The number of wheelchair pushes performed during the interval.
  final Number count;

  /// Creates a copy with the given fields replaced with the new values.
  WheelchairPushesRecord copyWith({
    DateTime? startTime,
    DateTime? endTime,
    Number? count,
    Metadata? metadata,
    HealthRecordId? id,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
  }) {
    return WheelchairPushesRecord(
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
      other is WheelchairPushesRecord &&
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
