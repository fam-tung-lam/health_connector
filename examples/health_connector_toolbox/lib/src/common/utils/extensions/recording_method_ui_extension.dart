import 'package:flutter/material.dart';
import 'package:health_connector/health_connector.dart' show RecordingMethod;
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';

/// Extension on [RecordingMethod] to provide UI-related properties.
extension RecordingMethodUI on RecordingMethod {
  /// Returns the display name for this recording method.
  String get displayName {
    return switch (this) {
      RecordingMethod.manualEntry => AppTexts.manualEntry,
      RecordingMethod.automaticallyRecorded => AppTexts.automaticallyRecorded,
      RecordingMethod.activelyRecorded => AppTexts.activelyRecorded,
      RecordingMethod.unknown => AppTexts.unknown,
    };
  }

  /// Returns the icon for this recording method.
  IconData get icon {
    return switch (this) {
      RecordingMethod.manualEntry => AppIcons.edit,
      RecordingMethod.automaticallyRecorded => AppIcons.autoAwesome,
      RecordingMethod.activelyRecorded => AppIcons.fitnessCenter,
      RecordingMethod.unknown => AppIcons.helpOutline,
    };
  }
}
