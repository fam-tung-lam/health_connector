part of '../health_record.dart';

/// Represents the type of meal associated with the measurement.
///
/// {@category Health Records}
@sinceV1_4_0
enum BloodGlucoseMealType {
  /// Meal type unknown or unspecified.
  unknown,

  /// First meal of the day, typically morning.
  breakfast,

  /// Noon meal.
  lunch,

  /// Last meal of the day, typically evening.
  dinner,

  /// Any meal outside the usual three daily meals.
  snack,
}
