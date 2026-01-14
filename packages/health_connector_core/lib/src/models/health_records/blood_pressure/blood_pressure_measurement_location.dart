part of '../health_record.dart';

/// Represents the measurement location for a blood pressure reading.
///
/// {@category Health Records}
@sinceV1_2_0
enum BloodPressureMeasurementLocation {
  /// Unknown measurement location (default).
  unknown,

  /// Left wrist.
  leftWrist,

  /// Right wrist.
  rightWrist,

  /// Left upper arm.
  leftUpperArm,

  /// Right upper arm.
  rightUpperArm,
}
