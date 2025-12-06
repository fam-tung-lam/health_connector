part of '../health_record.dart';

@sinceV1_1_0
@immutable
final class NutritionRecord extends IntervalHealthRecord {
  const NutritionRecord({
    required super.startTime,
    required super.endTime,
    required super.metadata,
    super.id,
    super.startZoneOffsetSeconds,
    super.endZoneOffsetSeconds,
    this.foodName,
    this.mealType = MealType.unknown,
    this.energy,
    this.protein,
    this.totalCarbohydrate,
    this.totalFat,
    this.saturatedFat,
    this.monounsaturatedFat,
    this.polyunsaturatedFat,
    this.cholesterol,
    this.dietaryFiber,
    this.sugar,
    this.vitaminA,
    this.vitaminB6,
    this.vitaminB12,
    this.vitaminC,
    this.vitaminD,
    this.vitaminE,
    this.vitaminK,
    this.thiamin,
    this.riboflavin,
    this.niacin,
    this.folate,
    this.biotin,
    this.pantothenicAcid,
    this.calcium,
    this.iron,
    this.magnesium,
    this.manganese,
    this.phosphorus,
    this.potassium,
    this.selenium,
    this.sodium,
    this.zinc,
    this.caffeine,
  });

  final String? foodName;
  final MealType mealType;

  // Energy
  final Energy? energy;

  // Macronutrients
  final Mass? protein;
  final Mass? totalCarbohydrate;
  final Mass? totalFat;
  final Mass? saturatedFat;
  final Mass? monounsaturatedFat;
  final Mass? polyunsaturatedFat;
  final Mass? cholesterol;
  final Mass? dietaryFiber;
  final Mass? sugar;

  // Vitamins
  final Mass? vitaminA;
  final Mass? vitaminB6;
  final Mass? vitaminB12;
  final Mass? vitaminC;
  final Mass? vitaminD;
  final Mass? vitaminE;
  final Mass? vitaminK;
  final Mass? thiamin;
  final Mass? riboflavin;
  final Mass? niacin;
  final Mass? folate;
  final Mass? biotin;
  final Mass? pantothenicAcid;

  // Minerals
  final Mass? calcium;
  final Mass? iron;
  final Mass? magnesium;
  final Mass? manganese;
  final Mass? phosphorus;
  final Mass? potassium;
  final Mass? selenium;
  final Mass? sodium;
  final Mass? zinc;

  // Other
  final Mass? caffeine;

  @override
  String get name => 'nutrition';

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.appleHealth,
    HealthPlatform.healthConnect,
  ];
}
