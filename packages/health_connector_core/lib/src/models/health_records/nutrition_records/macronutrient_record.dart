part of '../health_record.dart';

/// Base class for macronutrient health records.
///
/// {@category Health Records}
@sinceV1_1_0
@supportedOnAppleHealth
@internal
@immutable
sealed class MacronutrientRecord extends NutrientRecord<Mass> {
  const MacronutrientRecord({
    required super.value,
    required super.time,
    required super.metadata,
    super.id = HealthRecordId.none,
    super.zoneOffsetSeconds,
    super.foodName,
    super.mealType,
  });
}
