import 'package:health_connector/health_connector_internal.dart'
    show OvulationTestResult;
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';

/// Extension methods for [OvulationTestResult] to provide UI support.
extension OvulationTestResultTypeExtension on OvulationTestResult {
  /// Returns a user-friendly display name for this ovulation test result.
  String get displayName {
    return switch (this) {
      OvulationTestResult.negative => AppTexts.negative,
      OvulationTestResult.inconclusive => AppTexts.inconclusive,
      OvulationTestResult.high => AppTexts.high,
      OvulationTestResult.positive => AppTexts.positive,
    };
  }
}
