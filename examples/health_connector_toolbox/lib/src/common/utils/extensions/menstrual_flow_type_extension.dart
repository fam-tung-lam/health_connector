import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';

/// Extension on [MenstrualFlow] to provide localized labels.
extension MenstrualFlowExtension on MenstrualFlow {
  /// Returns the localized label for the menstrual flow type.
  String get label {
    return switch (this) {
      MenstrualFlow.unknown => AppTexts.unspecified,
      MenstrualFlow.light => AppTexts.light,
      MenstrualFlow.medium => AppTexts.medium,
      MenstrualFlow.heavy => AppTexts.heavy,
    };
  }
}
