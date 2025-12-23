import 'package:health_connector/health_connector.dart'
    show HealthPlatformFeatureStatus;
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';

/// Extension on [HealthPlatformFeatureStatus] to provide UI-related properties.
extension HealthPlatformFeatureStatusUI on HealthPlatformFeatureStatus {
  /// Returns the display name for this feature status.
  String get displayName {
    return switch (this) {
      HealthPlatformFeatureStatus.available => AppTexts.available,
      HealthPlatformFeatureStatus.unavailable => AppTexts.unavailable,
    };
  }
}
