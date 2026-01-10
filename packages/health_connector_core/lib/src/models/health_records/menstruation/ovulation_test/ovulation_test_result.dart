part of '../../health_record.dart';

/// Represents the result of an ovulation test.
///
/// Ovulation tests detect hormonal changes to identify fertility windows.
/// This enum provides four possible test results.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: Maps to
///   `OvulationTestRecord.RESULT_*` constants
/// - **iOS HealthKit**: Maps to
///   `HKCategoryValueOvulationTestResult` enum values
///
/// {@category Health Records}
@sinceV2_2_0
enum OvulationTestResult {
  /// Test result is negative (no hormonal surge detected).
  negative,

  /// Test result is inconclusive (unable to determine).
  inconclusive,

  /// Test result shows high estrogen levels (estrogen surge detected).
  high,

  /// Test result is positive (LH surge detected, peak fertility).
  positive,
}
