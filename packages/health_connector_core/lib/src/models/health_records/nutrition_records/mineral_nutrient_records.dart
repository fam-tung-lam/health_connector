part of '../health_record.dart';

/// Base class for mineral nutrient health records.
@sinceV1_1_0
@supportedOnAppleHealth
@internal
@immutable
sealed class MineralNutrientRecord extends NutrientRecord<Mass> {
  const MineralNutrientRecord({
    required super.value,
    required super.time,
    required super.metadata,
    super.id = HealthRecordId.none,
    super.zoneOffsetSeconds,
    super.foodName,
    super.mealType,
  });
}
