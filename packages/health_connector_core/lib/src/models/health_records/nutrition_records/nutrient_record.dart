part of '../health_record.dart';

@sinceV1_1_0
@supportedOnAppleHealth
@internalUse
@immutable
sealed class NutrientRecord<U extends MeasurementUnit>
    extends InstantHealthRecord {
  const NutrientRecord({
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
