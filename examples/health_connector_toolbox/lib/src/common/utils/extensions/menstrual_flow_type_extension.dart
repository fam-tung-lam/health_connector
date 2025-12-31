import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';

/// Extension on [MenstrualFlowType] to provide localized labels.
extension MenstrualFlowTypeExtension on MenstrualFlowType {
  /// Returns the localized label for the menstrual flow type.
  String get label {
    return switch (this) {
      MenstrualFlowType.unknown => AppTexts.unspecified,
      MenstrualFlowType.light => AppTexts.light,
      MenstrualFlowType.medium => AppTexts.medium,
      MenstrualFlowType.heavy => AppTexts.heavy,
    };
  }
}
