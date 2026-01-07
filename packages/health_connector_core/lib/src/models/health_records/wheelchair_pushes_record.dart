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
///   pushes: Numeric(150), // 150 pushes
///   metadata: Metadata.automaticallyRecorded(
///     device: Device.fromType(DeviceType.phone),
///   ),
/// );
/// ```
///
/// ## See also
///
/// - [WheelchairPushesHealthDataType]
///
/// {@category Health Records}
@sinceV1_0_0
@immutable
final class WheelchairPushesRecord extends IntervalHealthRecord {
  /// Creates a wheelchair pushes record.
  ///
  /// ## Parameters
  ///
  /// - [startTime]: The start of the time interval (inclusive).
  /// - [endTime]: The end of the time interval (exclusive).
  /// - [pushes]: The number of wheelchair pushes performed during the interval.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [id]: The unique identifier for this record.
  /// - [startZoneOffsetSeconds]: Optional timezone offset for start time.
  /// - [endZoneOffsetSeconds]: Optional timezone offset for end time.
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [endTime] is not after [startTime].
  const WheelchairPushesRecord({
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required this.pushes,
    super.id = HealthRecordId.none,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  });

  /// The number of wheelchair pushes performed during the interval.
  final Number pushes;

  /// Creates a copy with the given fields replaced with the new values.
  WheelchairPushesRecord copyWith({
    DateTime? startTime,
    DateTime? endTime,
    Number? pushes,
    Metadata? metadata,
    HealthRecordId? id,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
  }) {
    return WheelchairPushesRecord(
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      pushes: pushes ?? this.pushes,
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
          pushes == other.pushes &&
          metadata == other.metadata;

  @override
  int get hashCode =>
      id.hashCode ^
      startTime.hashCode ^
      endTime.hashCode ^
      (startZoneOffsetSeconds?.hashCode ?? 0) ^
      (endZoneOffsetSeconds?.hashCode ?? 0) ^
      pushes.hashCode ^
      metadata.hashCode;
}
