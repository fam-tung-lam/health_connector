part of '../health_record.dart';

/// Represents a systolic blood pressure measurement at a specific point in
/// time.
///
/// [SystolicBloodPressureRecord] captures only the systolic (upper) blood
/// pressure value. This is useful for querying and aggregating systolic
/// values independently.
///
/// For combined blood pressure readings, see [BloodPressureRecord].
///
/// ## Platform Mapping
///
/// - **iOS HealthKit**: [`HKQuantityType.bloodPressureSystolic`](https://developer.apple.com/documentation/healthkit/hkcorrelationtypeidentifier/bloodPressureSystolic)
/// - **Android Health Connect**: Not supported ( use [BloodPressureRecord])
///
/// ## Example
///
/// ```dart
/// final record = SystolicBloodPressureRecord(
///   time: DateTime.now(),
///   pressure: Pressure.millimetersOfMercury(120),
///   metadata: Metadata.manualEntry(),
/// );
/// ```
///
/// ## See also
///
/// - [BloodPressureRecord]
/// - [DiastolicBloodPressureRecord]
/// - [BloodPressureDataType]
/// - [DiastolicBloodPressureDataType]
/// - [SystolicBloodPressureDataType]
///
/// {@category Health Records}
@sinceV1_2_0
@supportedOnAppleHealth
@immutable
final class SystolicBloodPressureRecord extends InstantHealthRecord {
  /// Creates a systolic blood pressure record.
  ///
  /// ## Parameters
  ///
  /// - [id]: The unique identifier for this record.
  /// - [time]: The timestamp when the blood pressure was measured.
  /// - [zoneOffsetSeconds]: Optional timezone offset for the measurement time.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [pressure]: The systolic blood pressure measurement.
  /// - [bodyPosition]: Optional body position during measurement.
  /// - [measurementLocation]: Optional location where measurement was taken.
  const SystolicBloodPressureRecord({
    required super.time,
    required super.metadata,
    required this.pressure,
    super.id = HealthRecordId.none,
    super.zoneOffsetSeconds,
    this.bodyPosition = BloodPressureBodyPosition.unknown,
    this.measurementLocation = BloodPressureMeasurementLocation.unknown,
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
  factory SystolicBloodPressureRecord.internal({
    required HealthRecordId id,
    required DateTime time,
    required Metadata metadata,
    required Pressure pressure,
    int? zoneOffsetSeconds,
    BloodPressureBodyPosition bodyPosition = BloodPressureBodyPosition.unknown,
    BloodPressureMeasurementLocation measurementLocation =
        BloodPressureMeasurementLocation.unknown,
  }) {
    return SystolicBloodPressureRecord._(
      id: id,
      time: time,
      metadata: metadata,
      pressure: pressure,
      zoneOffsetSeconds: zoneOffsetSeconds,
      bodyPosition: bodyPosition,
      measurementLocation: measurementLocation,
    );
  }

  const SystolicBloodPressureRecord._({
    required super.id,
    required super.time,
    required super.metadata,
    required this.pressure,
    super.zoneOffsetSeconds,
    this.bodyPosition = BloodPressureBodyPosition.unknown,
    this.measurementLocation = BloodPressureMeasurementLocation.unknown,
  });

  /// The systolic blood pressure measurement (pressure during heartbeat).
  ///
  /// Systolic is the "upper" number in a blood pressure reading.
  /// Normal values are typically around 120 mmHg.
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
  SystolicBloodPressureRecord copyWith({
    DateTime? time,
    Pressure? pressure,
    Metadata? metadata,
    HealthRecordId? id,
    BloodPressureBodyPosition? bodyPosition,
    BloodPressureMeasurementLocation? measurementLocation,
    int? zoneOffsetSeconds,
  }) {
    return SystolicBloodPressureRecord(
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
      other is SystolicBloodPressureRecord &&
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
