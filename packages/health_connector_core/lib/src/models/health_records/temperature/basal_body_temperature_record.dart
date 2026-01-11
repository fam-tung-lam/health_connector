part of '../health_record.dart';

/// Represents a basal body temperature measurement at a specific point in time.
///
/// [BasalBodyTemperatureRecord] captures the user's basal body temperature,
/// which is the lowest body temperature attained during rest. It is typically
/// measured immediately after waking and before any physical activity.
///
/// This is commonly used for fertility tracking and menstrual cycle monitoring.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: [`BasalBodyTemperatureRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/BasalBodyTemperatureRecord)
/// - **iOS HealthKit**: [`HKQuantityTypeIdentifier.basalBodyTemperature`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/basalbodytemperature)
///
/// ## Example
///
/// ```dart
/// final record = BasalBodyTemperatureRecord(
///   time: DateTime.now(),
///   temperature: Temperature.celsius(36.5),
///   measurementLocation: BasalBodyTemperatureMeasurementLocation.mouth,
///   metadata: Metadata.manualEntry(),
/// );
/// ```
///
/// ## See also
///
/// - [BasalBodyTemperatureDataType]
/// - [BodyTemperatureRecord]
///
/// {@category Health Records}
@sinceV2_2_0
@immutable
final class BasalBodyTemperatureRecord extends InstantHealthRecord {
  /// Creates a basal body temperature record.
  ///
  /// ## Parameters
  ///
  /// - [id]: The unique identifier for this record.
  /// - [time]: The timestamp when the temperature was measured.
  /// - [zoneOffsetSeconds]: Optional timezone offset for the measurement time.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [temperature]: The basal body temperature measurement.
  /// - [measurementLocation]: The location on the body where the measurement
  ///   was taken.
  const BasalBodyTemperatureRecord({
    required super.time,
    required super.metadata,
    required this.temperature,
    super.id,
    super.zoneOffsetSeconds,
    this.measurementLocation = BasalBodyTemperatureMeasurementLocation.unknown,
  });

  /// Internal factory for creating [BasalBodyTemperatureRecord] instances
  /// without validation.
  ///
  /// Creates a [BasalBodyTemperatureRecord] by directly mapping platform data
  /// to fields,
  /// bypassing the normal validation and business rules applied by the
  /// public constructor.
  ///
  /// **⚠️ Warning**: Not for public use. SDK users should use the public
  /// [BasalBodyTemperatureRecord] constructor, which enforces validation and
  /// business rules.
  /// This factory is restricted to the SDK developers and contributors.
  @internalUse
  factory BasalBodyTemperatureRecord.internal({
    required HealthRecordId id,
    required DateTime time,
    required Metadata metadata,
    required Temperature temperature,
    int? zoneOffsetSeconds,
    BasalBodyTemperatureMeasurementLocation measurementLocation =
        BasalBodyTemperatureMeasurementLocation.unknown,
  }) {
    return BasalBodyTemperatureRecord._(
      id: id,
      time: time,
      metadata: metadata,
      temperature: temperature,
      zoneOffsetSeconds: zoneOffsetSeconds,
      measurementLocation: measurementLocation,
    );
  }

  const BasalBodyTemperatureRecord._({
    required super.id,
    required super.time,
    required super.metadata,
    required this.temperature,
    super.zoneOffsetSeconds,
    this.measurementLocation = BasalBodyTemperatureMeasurementLocation.unknown,
  });

  /// The basal body temperature measurement.
  ///
  /// This uses the [Temperature] unit class which supports multiple units
  /// (Celsius, Fahrenheit, Kelvin).
  final Temperature temperature;

  /// The location on the body where the measurement was taken.
  ///
  /// ## Platform Support
  /// - **Android Health Connect**: Natively supported
  /// - **iOS HealthKit**: Stored as custom metadata
  final BasalBodyTemperatureMeasurementLocation measurementLocation;

  /// Creates a copy with the given fields replaced with the new values.
  BasalBodyTemperatureRecord copyWith({
    DateTime? time,
    Temperature? temperature,
    Metadata? metadata,
    HealthRecordId? id,
    int? zoneOffsetSeconds,
    BasalBodyTemperatureMeasurementLocation? measurementLocation,
  }) {
    return BasalBodyTemperatureRecord(
      time: time ?? this.time,
      temperature: temperature ?? this.temperature,
      metadata: metadata ?? this.metadata,
      id: id ?? this.id,
      zoneOffsetSeconds: zoneOffsetSeconds ?? this.zoneOffsetSeconds,
      measurementLocation: measurementLocation ?? this.measurementLocation,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BasalBodyTemperatureRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          time == other.time &&
          zoneOffsetSeconds == other.zoneOffsetSeconds &&
          temperature == other.temperature &&
          measurementLocation == other.measurementLocation &&
          metadata == other.metadata;

  @override
  int get hashCode =>
      id.hashCode ^
      time.hashCode ^
      (zoneOffsetSeconds?.hashCode ?? 0) ^
      temperature.hashCode ^
      measurementLocation.hashCode ^
      metadata.hashCode;
}

/// Represents the measurement location for a basal body temperature reading.
///
/// This enum is used to specify where on the body the basal body temperature
/// was measured. Different measurement locations can yield slightly different
/// readings.
///
/// {@category Health Records}
@sinceV2_2_0
enum BasalBodyTemperatureMeasurementLocation {
  /// Unknown measurement location (default).
  unknown,

  /// Armpit measurement.
  armpit,

  /// Ear measurement.
  ear,

  /// Finger measurement.
  finger,

  /// Forehead measurement.
  forehead,

  /// Mouth measurement.
  mouth,

  /// Rectum measurement.
  rectum,

  /// Temporal artery measurement.
  temporalArtery,

  /// Toe measurement.
  toe,

  /// Vagina measurement.
  vagina,

  /// Wrist measurement.
  wrist,
}
