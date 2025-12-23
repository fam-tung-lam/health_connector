part of '../health_record.dart';

/// Represents a composite blood pressure measurement at a specific point in
/// time.
///
/// [BloodPressureRecord] captures both systolic and diastolic blood pressure
/// values together as a single measurement.
///
/// For platform-specific atomic measurements (systolic only or diastolic only),
/// see [SystolicBloodPressureRecord] and [DiastolicBloodPressureRecord].
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: `BloodPressureRecord`
/// - **iOS HealthKit**: `HKCorrelationType(.bloodPressure)`
///   correlation
///
/// ## Example
///
/// ```dart
/// final record = BloodPressureRecord(
///   time: DateTime.now(),
///   systolic: Pressure.millimetersOfMercury(120),
///   diastolic: Pressure.millimetersOfMercury(80),
///   bodyPosition: BloodPressureBodyPosition.sitting,
///   measurementLocation: BloodPressureMeasurementLocation.leftUpperArm,
///   metadata: Metadata.manualEntry(
///     dataOrigin: DataOrigin(packageName: 'com.example.app'),
///   ),
/// );
/// ```
///
/// {@category Health Records}
@sinceV1_2_0
@immutable
final class BloodPressureRecord extends InstantHealthRecord {
  /// Creates a composite blood pressure record.
  ///
  /// ## Parameters
  ///
  /// - [id]: The unique identifier for this record.
  /// - [time]: The timestamp when the blood pressure was measured.
  /// - [zoneOffsetSeconds]: Optional timezone offset for the measurement time.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [systolic]: The systolic blood pressure measurement.
  /// - [diastolic]: The diastolic blood pressure measurement.
  /// - [bodyPosition]: Optional body position during measurement.
  /// - [measurementLocation]: Optional location where measurement was taken.
  const BloodPressureRecord({
    required super.time,
    required super.metadata,
    required this.systolic,
    required this.diastolic,
    super.id = HealthRecordId.none,
    super.zoneOffsetSeconds,
    this.bodyPosition = BloodPressureBodyPosition.unknown,
    this.measurementLocation = BloodPressureMeasurementLocation.unknown,
  });

  /// The systolic blood pressure measurement (pressure during heartbeat).
  ///
  /// Systolic is the "upper" number in a blood pressure reading.
  /// Normal values are typically around 120 mmHg.
  final Pressure systolic;

  /// The diastolic blood pressure measurement (pressure between heartbeats).
  ///
  /// Diastolic is the "lower" number in a blood pressure reading.
  /// Normal values are typically around 80 mmHg.
  final Pressure diastolic;

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
  BloodPressureRecord copyWith({
    DateTime? time,
    Pressure? systolic,
    Pressure? diastolic,
    BloodPressureBodyPosition? bodyPosition,
    BloodPressureMeasurementLocation? measurementLocation,
    Metadata? metadata,
    HealthRecordId? id,
    int? zoneOffsetSeconds,
  }) {
    return BloodPressureRecord(
      time: time ?? this.time,
      systolic: systolic ?? this.systolic,
      diastolic: diastolic ?? this.diastolic,
      bodyPosition: bodyPosition ?? this.bodyPosition,
      measurementLocation: measurementLocation ?? this.measurementLocation,
      metadata: metadata ?? this.metadata,
      id: id ?? this.id,
      zoneOffsetSeconds: zoneOffsetSeconds ?? this.zoneOffsetSeconds,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BloodPressureRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          time == other.time &&
          zoneOffsetSeconds == other.zoneOffsetSeconds &&
          systolic == other.systolic &&
          diastolic == other.diastolic &&
          bodyPosition == other.bodyPosition &&
          measurementLocation == other.measurementLocation &&
          metadata == other.metadata;

  @override
  int get hashCode =>
      id.hashCode ^
      time.hashCode ^
      (zoneOffsetSeconds?.hashCode ?? 0) ^
      systolic.hashCode ^
      diastolic.hashCode ^
      bodyPosition.hashCode ^
      measurementLocation.hashCode ^
      metadata.hashCode;

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.appleHealth,
    HealthPlatform.healthConnect,
  ];
}
