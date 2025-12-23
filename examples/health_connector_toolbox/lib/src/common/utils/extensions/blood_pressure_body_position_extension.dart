import 'package:health_connector/health_connector.dart'
    show BloodPressureBodyPosition;
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';

/// Extension providing display names for [BloodPressureBodyPosition] enum.
extension BloodPressureBodyPositionExtension on BloodPressureBodyPosition {
  /// User-friendly display name for this body position.
  String get displayName => switch (this) {
    BloodPressureBodyPosition.standingUp => AppTexts.standingUp,
    BloodPressureBodyPosition.sittingDown => AppTexts.sittingDown,
    BloodPressureBodyPosition.lyingDown => AppTexts.lyingDown,
    BloodPressureBodyPosition.reclining => AppTexts.reclining,
    BloodPressureBodyPosition.unknown => AppTexts.unknown,
  };
}
