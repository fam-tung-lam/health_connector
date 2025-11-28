part of 'health_record.dart';

/// Represents active calories burned over a time interval.
///
/// This record captures the amount of energy (calories) burned during physical
/// activity over a specific time period. Active calories are those burned
/// through exercise and movement, excluding basal metabolic rate.
///
/// ## Platform Mapping
/// - **Android (Health Connect)**:
///   `androidx.health.connect.client.records.ActiveCaloriesBurnedRecord`
/// - **iOS (HealthKit)**:
///   `HKQuantityTypeIdentifier.activeEnergyBurned`
///
/// ## Example
/// ```dart
/// final record = ActiveCaloriesBurnedRecord(
///   startTime: DateTime.now().subtract(Duration(hours: 1)),
///   endTime: DateTime.now(),
///   energy: Energy.kilocalories(300), // 300 kcal burned
///   metadata: Metadata.automaticallyRecorded(
///     dataOrigin: DataOrigin(packageName: 'com.example.app'),
///   ),
/// );
/// ```
@sinceV1_0_0
@immutable
final class ActiveCaloriesBurnedRecord extends IntervalHealthRecord {
  /// Creates an active calories burned record.
  ///
  /// ## Parameters
  ///
  /// - [startTime]: The start of the time interval (inclusive).
  /// - [endTime]: The end of the time interval (exclusive).
  /// - [energy]: The amount of energy (calories) burned during the interval.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [id]: The unique identifier for this record.
  /// - [startZoneOffsetSeconds]: Optional timezone offset for start time.
  /// - [endZoneOffsetSeconds]: Optional timezone offset for end time.
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [endTime] is not after [startTime].
  const ActiveCaloriesBurnedRecord({
    required super.startTime,
    required super.endTime,
    required super.metadata,
    required this.energy,
    super.id = HealthRecordId.none,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
  });

  /// The energy (calories) burned during the interval.
  final Energy energy;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ActiveCaloriesBurnedRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          startTime == other.startTime &&
          endTime == other.endTime &&
          startZoneOffsetSeconds == other.startZoneOffsetSeconds &&
          endZoneOffsetSeconds == other.endZoneOffsetSeconds &&
          energy == other.energy &&
          metadata == other.metadata;

  @override
  int get hashCode =>
      id.hashCode ^
      startTime.hashCode ^
      endTime.hashCode ^
      (startZoneOffsetSeconds?.hashCode ?? 0) ^
      (endZoneOffsetSeconds?.hashCode ?? 0) ^
      energy.hashCode ^
      metadata.hashCode;

  @override
  String toString() =>
      'ActiveCaloriesBurnedRecord('
      'id: $id, '
      'energy: ${energy.inKilocalories} kcal, '
      'time_range: ${formatTimeRange(startTime: startTime, endTime: endTime)}, '
      'duration: $duration'
      ')';

  @override
  String get name => 'active_calories_burned_record';

  @override
  List<HealthPlatform> get supportedHealthPlatforms => HealthPlatform.values;
}
