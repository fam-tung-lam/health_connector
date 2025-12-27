import 'package:health_connector/health_connector_internal.dart'
    show
        HealthPlatformFeature,
        HealthPlatformFeatureReadHealthDataHistory,
        HealthPlatformFeatureReadHealthDataInBackground;
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';

/// Extension on [HealthPlatformFeature] to provide UI-related properties.
extension HealthPlatformFeatureUI on HealthPlatformFeature {
  /// Returns the display name for this feature.
  String get displayName {
    return switch (this) {
      HealthPlatformFeatureReadHealthDataHistory _ =>
        AppTexts.readHealthDataHistory,
      HealthPlatformFeatureReadHealthDataInBackground _ =>
        AppTexts.readHealthDataInBackground,
    };
  }
}
