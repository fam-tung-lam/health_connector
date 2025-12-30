import 'package:health_connector/health_connector_internal.dart'
    show OvulationTestResultType;
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';

/// Extension methods for [OvulationTestResultType] to provide UI support.
extension OvulationTestResultTypeExtension on OvulationTestResultType {
  /// Returns a user-friendly display name for this ovulation test result.
  String get displayName {
    return switch (this) {
      OvulationTestResultType.negative => AppTexts.negative,
      OvulationTestResultType.inconclusive => AppTexts.inconclusive,
      OvulationTestResultType.high => AppTexts.high,
      OvulationTestResultType.positive => AppTexts.positive,
    };
  }
}
