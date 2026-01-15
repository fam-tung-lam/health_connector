part of '../../health_record.dart';

/// Represents the result of a progesterone test.
///
/// Progesterone tests detect the presence of progesterone hormone to confirm
/// ovulation. This enum provides three possible test results.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: Not currently supported
/// - **iOS HealthKit**: Maps to `HKCategoryValueProgesteroneTestResult` enum
///   values
///
/// {@category Health Records}
@sinceV3_1_0
@supportedOnAppleHealth
enum ProgesteroneTestResult {
  /// Test result is positive (progesterone surge detected).
  positive,

  /// Test result is negative (no progesterone surge detected).
  negative,

  /// Test result is inconclusive (unable to determine).
  inconclusive,
}
