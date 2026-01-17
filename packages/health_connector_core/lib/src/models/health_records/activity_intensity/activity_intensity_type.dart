part of '../health_record.dart';

/// Activity intensity classification.
///
/// Represents the intensity level of physical activity during a time period.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: Maps to
///   `ActivityIntensityRecord.ACTIVITY_INTENSITY_TYPE_*` constants
/// - **iOS HealthKit**: Not supported
///
/// {@category Health Records}
@sinceV3_2_0
@supportedOnHealthConnect
enum ActivityIntensityType {
  /// Moderate intensity activity.
  moderate,

  /// Vigorous intensity activity.
  vigorous,
}
