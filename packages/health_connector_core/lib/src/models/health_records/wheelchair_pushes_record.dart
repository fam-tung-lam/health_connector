part of 'health_record.dart';

/// Represents wheelchair pushes over a time interval.
///
/// This record captures the number of wheelchair pushes performed during
/// a specific time period. A push represents a single propulsion action
/// used to move a wheelchair forward.
///
/// ## Platform Mapping
/// - **Android (Health Connect)**:
///   `androidx.health.connect.client.records.WheelchairPushesRecord`
/// - **iOS (HealthKit)**:
///   `HKQuantityTypeIdentifier.pushCount`
///
/// ## Example
/// ```dart
/// final record = WheelchairPushesRecord(
///   startTime: DateTime.now().subtract(Duration(hours: 1)),
///   endTime: DateTime.now(),
///   pushes: Numeric(150), // 150 pushes
///   metadata: Metadata.automaticallyRecorded(
///     dataOrigin: DataOrigin(packageName: 'com.example.app'),
///   ),
/// );
/// ```
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

  @override
  String get name => 'wheelchair_pushes_record';

  @override
  List<HealthPlatform> get supportedHealthPlatforms => HealthPlatform.values;
}
