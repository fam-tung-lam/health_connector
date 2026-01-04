part of '../health_record.dart';

/// Represents the relationship of a blood glucose measurement to a meal.
///
/// {@category Health Records}
@sinceV1_4_0
enum BloodGlucoseRelationToMeal {
  /// Relationship is unknown or not specified.
  unknown,

  /// General meal context without specific timing information.
  general,

  /// Measurement taken while fasting (typically 8+ hours without food).
  fasting,

  /// Measurement taken before consuming a meal (preprandial).
  beforeMeal,

  /// Measurement taken after consuming a meal (postprandial).
  afterMeal,
}
