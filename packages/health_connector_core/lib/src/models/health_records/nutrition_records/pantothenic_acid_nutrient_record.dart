part of '../health_record.dart';

/// Health record for pantothenic acid (vitamin B5) intake.
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class PantothenicAcidNutrientRecord extends VitaminNutrientRecord {
  factory PantothenicAcidNutrientRecord({
    required Mass value,
    required DateTime time,
    required Metadata metadata,
    HealthRecordId id = HealthRecordId.none,
    int? zoneOffsetSeconds,
    String? foodName,
    MealType mealType = MealType.unknown,
  }) {
    return PantothenicAcidNutrientRecord._(
      value: value,
      time: time,
      metadata: metadata,
      id: id,
      zoneOffsetSeconds: zoneOffsetSeconds,
      foodName: foodName,
      mealType: mealType,
    );
  }

  const PantothenicAcidNutrientRecord._({
    required super.value,
    required super.time,
    required super.metadata,
    super.id = HealthRecordId.none,
    super.zoneOffsetSeconds,
    super.foodName,
    super.mealType,
  });
}
