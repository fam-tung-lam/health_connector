part of '../../health_record.dart';

/// Represents the result of a pregnancy test.
///
/// Pregnancy tests detect the presence of human chorionic gonadotropin (hCG)
/// hormone to determine pregnancy status. This enum provides three possible
/// test results.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: Not currently supported
/// - **iOS HealthKit**: Maps to `HKCategoryValuePregnancyTestResult` enum
///   values
///
/// {@category Health Records}
@sinceV3_1_0
@supportedOnAppleHealth
enum PregnancyTestResult {
  /// Test result is positive (pregnancy detected).
  positive,

  /// Test result is negative (no pregnancy detected).
  negative,

  /// Test result is inconclusive (unable to determine).
  inconclusive,
}
