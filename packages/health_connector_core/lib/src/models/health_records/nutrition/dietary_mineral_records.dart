part of '../health_record.dart';

/// Base class for mineral nutrient health records.
///
/// {@category Health Records}
@sinceV1_1_0
@supportedOnAppleHealth
@internal
@immutable
sealed class DietaryMineralRecord extends NutrientRecord<Mass> {
  const DietaryMineralRecord({
    required this.mass,
    required super.time,
    required super.metadata,
    super.id = HealthRecordId.none,
    super.zoneOffsetSeconds,
    super.foodName,
    super.mealType,
  });

  /// The mineral content of the nutrient.
  final Mass mass;
}
