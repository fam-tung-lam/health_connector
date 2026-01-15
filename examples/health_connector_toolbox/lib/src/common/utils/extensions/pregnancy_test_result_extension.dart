import 'package:health_connector/health_connector.dart';

/// Extension methods for [PregnancyTestResult].
extension PregnancyTestResultExtension on PregnancyTestResult {
  /// Returns a user-friendly display name for the test result.
  String get displayName {
    return switch (this) {
      PregnancyTestResult.positive => 'Positive',
      PregnancyTestResult.negative => 'Negative',
      PregnancyTestResult.inconclusive => 'Inconclusive',
    };
  }
}
