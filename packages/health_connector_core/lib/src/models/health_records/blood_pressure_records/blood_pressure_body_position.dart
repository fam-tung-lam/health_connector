import 'package:health_connector_core/src/annotations/annotations.dart'
    show sinceV1_2_0;

/// Represents the body position during a blood pressure measurement.
@sinceV1_2_0
enum BloodPressureBodyPosition {
  /// Unknown body position (default).
  unknown,

  /// Standing up during measurement.
  standingUp,

  /// Sitting down during measurement.
  sittingDown,

  /// Lying down during measurement.
  lyingDown,

  /// Reclining during measurement.
  reclining,
}
