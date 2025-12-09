part of '../health_record.dart';

/// Represents a diastolic blood pressure measurement at a specific point in
/// time.
///
/// [DiastolicBloodPressureRecord] captures only the diastolic (lower) blood
/// pressure value. This is useful for querying and aggregating diastolic
/// values independently.
///
/// For combined blood pressure readings, see [BloodPressureRecord].
///
/// ## Platform Mapping
///
/// - **Android**: Maps to Health Connect's `BloodPressureRecord`
///   (systolic set to 0)
/// - **iOS**: Maps to HealthKit's `HKQuantityType(.bloodPressureDiastolic)`
@sinceV1_2_0
@immutable
final class DiastolicBloodPressureRecord extends InstantHealthRecord {
  /// Creates a diastolic blood pressure record.
  ///
  /// ## Parameters
  ///
  /// - [id]: The unique identifier for this record.
  /// - [time]: The timestamp when the blood pressure was measured.
  /// - [zoneOffsetSeconds]: Optional timezone offset for the measurement time.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [pressure]: The diastolic blood pressure measurement.
  const DiastolicBloodPressureRecord({
    required super.time,
    required super.metadata,
    required this.pressure,
    super.id = HealthRecordId.none,
    super.zoneOffsetSeconds,
  });

  /// The diastolic blood pressure measurement (pressure between heartbeats).
  ///
  /// Diastolic is the "lower" number in a blood pressure reading.
  /// Normal values are typically around 80 mmHg.
  final Pressure pressure;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DiastolicBloodPressureRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          time == other.time &&
          zoneOffsetSeconds == other.zoneOffsetSeconds &&
          pressure == other.pressure &&
          metadata == other.metadata;

  @override
  int get hashCode =>
      id.hashCode ^
      time.hashCode ^
      (zoneOffsetSeconds?.hashCode ?? 0) ^
      pressure.hashCode ^
      metadata.hashCode;

  @override
  String toString() =>
      'DiastolicBloodPressureRecord('
      'id: $id, '
      'pressure: $pressure, '
      'time: $time'
      ')';

  @override
  String get name => 'diastolic_blood_pressure_record';

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.appleHealth,
    HealthPlatform.healthConnect,
  ];
}
