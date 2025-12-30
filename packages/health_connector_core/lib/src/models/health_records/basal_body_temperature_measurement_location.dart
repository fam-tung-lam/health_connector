part of 'health_record.dart';

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
