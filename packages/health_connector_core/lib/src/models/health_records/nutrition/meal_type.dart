part of '../health_record.dart';

/// Meal type classification for nutrition records.
///
/// {@category Health Records}
@sinceV1_1_0
enum MealType {
  /// Unknown or unspecified meal type.
  unknown,

  /// Breakfast meal.
  breakfast,

  /// Lunch meal.
  lunch,

  /// Dinner meal.
  dinner,

  /// Snack between meals.
  snack,
}
