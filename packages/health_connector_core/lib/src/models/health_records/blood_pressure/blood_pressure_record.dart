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
/// - **Android Health Connect**: [`BloodPressureRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/BloodPressureRecord)
/// - **iOS HealthKit**: [`HKCorrelationTypeIdentifier.bloodPressure`](https://developer.apple.com/documentation/healthkit/hkcorrelationtypeidentifier/bloodpressure)
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
///   metadata: Metadata.manualEntry(),
/// );
/// ```
///
/// ## See also
///
/// - [BloodPressureRecord]
/// - [DiastolicBloodPressureRecord]
/// - [SystolicBloodPressureRecord]
/// - [BloodPressureDataType]
/// - [DiastolicBloodPressureDataType]
/// - [SystolicBloodPressureDataType]
///
/// {@category Health Records}
@sinceV1_2_0
@immutable
final class BloodPressureRecord extends InstantHealthRecord {
  /// Minimum valid systolic blood pressure.
  static const Pressure minSystolic = SystolicBloodPressureRecord.minPressure;

  /// Maximum valid systolic blood pressure.
  static const Pressure maxSystolic = SystolicBloodPressureRecord.maxPressure;

  /// Minimum valid diastolic blood pressure.
  static const Pressure minDiastolic = DiastolicBloodPressureRecord.minPressure;

  /// Maximum valid diastolic blood pressure.
  static const Pressure maxDiastolic = DiastolicBloodPressureRecord.maxPressure;

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
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [systolic] is outside
  ///   [minSystolic]-[maxSystolic] mmHg.
  /// - [ArgumentError] if [diastolic] is outside
  ///   [minDiastolic]-[maxDiastolic] mmHg.
  /// - [ArgumentError] if [systolic] is not greater than [diastolic].
  ///
  /// ## Validation Rationale
  ///
  /// - **Systolic ([minSystolic]-[maxSystolic] mmHg)**:
  ///   50 mmHg indicates severe shock; 250 mmHg is hypertensive emergency
  ///   threshold.
  /// - **Diastolic ([minDiastolic]-[maxDiastolic] mmHg)**:
  ///   30 mmHg indicates severe shock; 150 mmHg is hypertensive emergency
  ///   threshold.
  /// - **Cross-field**: Systolic pressure must exceed diastolic in all
  ///   physiological states.
  BloodPressureRecord({
    required super.time,
    required super.metadata,
    required this.systolic,
    required this.diastolic,
    super.id = HealthRecordId.none,
    super.zoneOffsetSeconds,
    this.bodyPosition = BloodPressureBodyPosition.unknown,
    this.measurementLocation = BloodPressureMeasurementLocation.unknown,
  }) {
    require(
      condition: systolic >= minSystolic && systolic <= maxSystolic,
      value: systolic,
      name: 'systolic',
      message:
          'Systolic BP must be between '
          '${minSystolic.inMillimetersOfMercury.toStringAsFixed(0)}-'
          '${maxSystolic.inMillimetersOfMercury.toStringAsFixed(0)} mmHg. '
          'Got ${systolic.inMillimetersOfMercury.toStringAsFixed(1)} mmHg.',
    );
    require(
      condition: diastolic >= minDiastolic && diastolic <= maxDiastolic,
      value: diastolic,
      name: 'diastolic',
      message:
          'Diastolic BP must be between '
          '${minDiastolic.inMillimetersOfMercury.toStringAsFixed(0)}-'
          '${maxDiastolic.inMillimetersOfMercury.toStringAsFixed(0)} mmHg. '
          'Got ${diastolic.inMillimetersOfMercury.toStringAsFixed(1)} mmHg.',
    );
    require(
      condition: systolic > diastolic,
      value: '$systolic/$diastolic',
      name: 'blood pressure',
      message:
          'Systolic must be greater than diastolic. Got '
          '${systolic.inMillimetersOfMercury.toStringAsFixed(0)}/'
          '${diastolic.inMillimetersOfMercury.toStringAsFixed(0)} mmHg.',
    );
  }

  /// Internal factory for creating [BloodPressureRecord] instances without
  /// validation.
  ///
  /// **⚠️ Warning**: Not for public use. SDK users should use the public
  /// [BloodPressureRecord] constructor, which enforces validation and business
  /// rules.
  @internalUse
  factory BloodPressureRecord.internal({
    required HealthRecordId id,
    required DateTime time,
    required Metadata metadata,
    required Pressure systolic,
    required Pressure diastolic,
    int? zoneOffsetSeconds,
    BloodPressureBodyPosition bodyPosition = BloodPressureBodyPosition.unknown,
    BloodPressureMeasurementLocation measurementLocation =
        BloodPressureMeasurementLocation.unknown,
  }) {
    return BloodPressureRecord._(
      id: id,
      time: time,
      metadata: metadata,
      systolic: systolic,
      diastolic: diastolic,
      zoneOffsetSeconds: zoneOffsetSeconds,
      bodyPosition: bodyPosition,
      measurementLocation: measurementLocation,
    );
  }

  const BloodPressureRecord._({
    required super.id,
    required super.time,
    required super.metadata,
    required this.systolic,
    required this.diastolic,
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
}
