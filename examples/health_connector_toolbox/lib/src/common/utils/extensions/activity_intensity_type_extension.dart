import 'package:health_connector/health_connector.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';

/// UI extensions for [ActivityIntensityType].
extension ActivityIntensityTypeExtension on ActivityIntensityType {
  /// Returns a user-friendly display name for the [ActivityIntensityType].
  String get displayName => switch (this) {
    ActivityIntensityType.moderate => AppTexts.moderate,
    ActivityIntensityType.vigorous => AppTexts.vigorous,
  };
}
