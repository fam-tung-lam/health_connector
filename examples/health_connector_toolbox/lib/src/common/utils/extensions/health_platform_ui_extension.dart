import 'package:flutter/material.dart';
import 'package:health_connector/health_connector.dart' show HealthPlatform;
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';

/// Extension on [HealthPlatform] to provide UI-related properties.
extension HealthPlatformUI on HealthPlatform {
  /// Returns the display name for this health platform.
  String get displayName {
    return switch (this) {
      HealthPlatform.appleHealth => AppTexts.appleHealth,
      HealthPlatform.healthConnect => AppTexts.healthConnect,
    };
  }

  /// Returns the icon for this health platform.
  IconData get icon {
    return switch (this) {
      HealthPlatform.appleHealth => AppIcons.apple,
      HealthPlatform.healthConnect => AppIcons.android,
    };
  }
}
