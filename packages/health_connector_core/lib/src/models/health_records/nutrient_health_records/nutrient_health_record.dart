part of '../health_record.dart';

@sinceV1_1_0
@supportedOnAppleHealth
@internalUse
@immutable
sealed class NutrientHealthRecord<U extends MeasurementUnit>
    extends InstantHealthRecord {
  const NutrientHealthRecord({
    required this.value,
    required super.time,
    required super.metadata,
    super.id = HealthRecordId.none,
    super.zoneOffsetSeconds,
    this.foodName,
    this.mealType = MealType.unknown,
  });

  final String? foodName;
  final U value;
  final MealType mealType;

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.appleHealth,
  ];
}

@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class EnergyNutrientRecord extends NutrientHealthRecord<Energy> {
  factory EnergyNutrientRecord({
    required Energy value,
    required DateTime time,
    required Metadata metadata,
    HealthRecordId id = HealthRecordId.none,
    int? zoneOffsetSeconds,
    String? foodName,
    MealType mealType = MealType.unknown,
  }) {
    return EnergyNutrientRecord._(
      value: value,
      time: time,
      metadata: metadata,
      id: id,
      zoneOffsetSeconds: zoneOffsetSeconds,
      foodName: foodName,
      mealType: mealType,
    );
  }

  const EnergyNutrientRecord._({
    required super.value,
    required super.time,
    required super.metadata,
    super.id = HealthRecordId.none,
    super.zoneOffsetSeconds,
    super.foodName,
    super.mealType,
  });
}

@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class CaffeineNutrientRecord extends NutrientHealthRecord<Mass> {
  factory CaffeineNutrientRecord({
    required Mass value,
    required DateTime time,
    required Metadata metadata,
    HealthRecordId id = HealthRecordId.none,
    int? zoneOffsetSeconds,
    String? foodName,
    MealType mealType = MealType.unknown,
  }) {
    return CaffeineNutrientRecord._(
      value: value,
      time: time,
      metadata: metadata,
      id: id,
      zoneOffsetSeconds: zoneOffsetSeconds,
      foodName: foodName,
      mealType: mealType,
    );
  }

  const CaffeineNutrientRecord._({
    required super.value,
    required super.time,
    required super.metadata,
    super.id = HealthRecordId.none,
    super.zoneOffsetSeconds,
    super.foodName,
    super.mealType,
  });
}
