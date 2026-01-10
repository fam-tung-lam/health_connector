/// Represents the different types of sleep stages.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: Maps to `SleepSessionRecord.Stage.StageType`
/// constants
/// - **iOS HealthKit**: Maps to `HKCategoryValueSleepAnalysis` enum values
///
/// {@category Health Records}
enum SleepStage {
  /// Unknown sleep stage (fallback).
  unknown,

  /// Awake during the sleep period.
  awake,

  /// Generic sleeping (stage not specified).
  sleeping,

  /// Out of bed during the sleep period.
  outOfBed,

  /// Light sleep (also called "core" sleep on iOS HealthKit).
  light,

  /// Deep sleep.
  deep,

  /// REM (Rapid Eye Movement) sleep.
  rem,

  /// In bed but not necessarily asleep.
  inBed,
}
