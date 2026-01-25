part of '../health_record.dart';

/// Represents the measurement location for a skin temperature reading.
///
/// {@category Health Records}
@sinceV3_6_0
enum SkinTemperatureMeasurementLocation {
  /// Unknown measurement location (default).
  unknown,

  /// Finger measurement.
  finger,

  /// Toe measurement.
  toe,

  /// Wrist measurement.
  wrist,
}
