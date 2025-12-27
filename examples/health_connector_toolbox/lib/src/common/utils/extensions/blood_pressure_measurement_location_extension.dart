import 'package:health_connector/health_connector_internal.dart'
    show BloodPressureMeasurementLocation;
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';

/// Extension providing display names for [BloodPressureMeasurementLocation].
extension BloodPressureMeasurementLocationExtension
    on BloodPressureMeasurementLocation {
  /// User-friendly display name for this measurement location.
  String get displayName => switch (this) {
    BloodPressureMeasurementLocation.leftWrist => AppTexts.leftWrist,
    BloodPressureMeasurementLocation.rightWrist => AppTexts.rightWrist,
    BloodPressureMeasurementLocation.leftUpperArm => AppTexts.leftUpperArm,
    BloodPressureMeasurementLocation.rightUpperArm => AppTexts.rightUpperArm,
    BloodPressureMeasurementLocation.unknown => AppTexts.unknown,
  };
}
