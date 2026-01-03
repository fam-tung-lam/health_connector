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
/// - **iOS HealthKit**: `HKQuantityType(.bloodPressureDiastolic)`
/// - **Android Health Connect**: Not supported ( use [BloodPressureRecord])
///
/// ## Example
///
/// ```dart
/// final record = DiastolicBloodPressureRecord(
///   time: DateTime.now(),
///   pressure: Pressure.millimetersOfMercury(80),
///   metadata: Metadata.manualEntry(
///     dataOrigin: DataOrigin(packageName: 'com.example.app'),
///   ),
/// );
/// ```
///
/// ## See also
///
/// - [BloodPressureRecord]
/// - [SystolicBloodPressureRecord]
/// - [BloodPressureHealthDataType]
/// - [DiastolicBloodPressureHealthDataType]
/// - [SystolicBloodPressureHealthDataType]
///
/// {@category Health Records}
@sinceV1_2_0
@supportedOnAppleHealth
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
  /// - [bodyPosition]: Optional body position during measurement.
  /// - [measurementLocation]: Optional location where measurement was taken.
  const DiastolicBloodPressureRecord({
    required super.time,
    required super.metadata,
    required this.pressure,
    super.id = HealthRecordId.none,
    super.zoneOffsetSeconds,
    this.bodyPosition = BloodPressureBodyPosition.unknown,
    this.measurementLocation = BloodPressureMeasurementLocation.unknown,
  });

  /// The diastolic blood pressure measurement (pressure between heartbeats).
  ///
  /// Diastolic is the "lower" number in a blood pressure reading.
  /// Normal values are typically around 80 mmHg.
  final Pressure pressure;

  /// The body position during the blood pressure measurement.
  ///
  /// This field is only supported on Android Health Connect.
  /// On iOS, this will always be [BloodPressureBodyPosition.unknown].
  final BloodPressureBodyPosition bodyPosition;

  /// The location on the body where the measurement was taken.
  ///
  /// This field is only supported on Android Health Connect.
  /// On iOS, this will always be [BloodPressureMeasurementLocation.unknown].
  final BloodPressureMeasurementLocation measurementLocation;

  /// Creates a copy with the given fields replaced with the new values.
  DiastolicBloodPressureRecord copyWith({
    DateTime? time,
    Pressure? pressure,
    Metadata? metadata,
    HealthRecordId? id,
    BloodPressureBodyPosition? bodyPosition,
    BloodPressureMeasurementLocation? measurementLocation,
    int? zoneOffsetSeconds,
  }) {
    return DiastolicBloodPressureRecord(
      time: time ?? this.time,
      pressure: pressure ?? this.pressure,
      metadata: metadata ?? this.metadata,
      id: id ?? this.id,
      bodyPosition: bodyPosition ?? this.bodyPosition,
      measurementLocation: measurementLocation ?? this.measurementLocation,
      zoneOffsetSeconds: zoneOffsetSeconds ?? this.zoneOffsetSeconds,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DiastolicBloodPressureRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          time == other.time &&
          zoneOffsetSeconds == other.zoneOffsetSeconds &&
          pressure == other.pressure &&
          bodyPosition == other.bodyPosition &&
          measurementLocation == other.measurementLocation &&
          metadata == other.metadata;

  @override
  int get hashCode =>
      id.hashCode ^
      time.hashCode ^
      (zoneOffsetSeconds?.hashCode ?? 0) ^
      pressure.hashCode ^
      bodyPosition.hashCode ^
      measurementLocation.hashCode ^
      metadata.hashCode;
}
