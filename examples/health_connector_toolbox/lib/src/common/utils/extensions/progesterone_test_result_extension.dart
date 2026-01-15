import 'package:health_connector/health_connector.dart';

/// Extension methods for [ProgesteroneTestResult].
extension ProgesteroneTestResultExtension on ProgesteroneTestResult {
  /// Returns a user-friendly display name for the test result.
  String get displayName {
    return switch (this) {
      ProgesteroneTestResult.positive => 'Positive',
      ProgesteroneTestResult.negative => 'Negative',
      ProgesteroneTestResult.inconclusive => 'Inconclusive',
    };
  }
}
