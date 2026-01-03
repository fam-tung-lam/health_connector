part of '../health_record.dart';

/// Base class for vitamin nutrient health records.
///
/// ## See also
///
/// - [VitaminNutrientDataType]
///
/// {@category Health Records}
@sinceV1_1_0
@supportedOnAppleHealth
@internal
@immutable
sealed class VitaminNutrientRecord extends NutrientRecord<Mass> {
  const VitaminNutrientRecord({
    required super.value,
    required super.time,
    required super.metadata,
    super.id = HealthRecordId.none,
    super.zoneOffsetSeconds,
    super.foodName,
    super.mealType,
  });
}
