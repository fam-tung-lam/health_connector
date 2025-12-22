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

  /// Creates a copy with the given fields replaced with the new values.
  NutritionRecord copyWith({
    DateTime? startTime,
    DateTime? endTime,
    Metadata? metadata,
    HealthRecordId? id,
    int? startZoneOffsetSeconds,
    int? endZoneOffsetSeconds,
    String? foodName,
    MealType? mealType,
    Energy? energy,
    Mass? protein,
    Mass? totalCarbohydrate,
    Mass? totalFat,
    Mass? saturatedFat,
    Mass? monounsaturatedFat,
    Mass? polyunsaturatedFat,
    Mass? cholesterol,
    Mass? dietaryFiber,
    Mass? sugar,
    Mass? vitaminA,
    Mass? vitaminB6,
    Mass? vitaminB12,
    Mass? vitaminC,
    Mass? vitaminD,
    Mass? vitaminE,
    Mass? vitaminK,
    Mass? thiamin,
    Mass? riboflavin,
    Mass? niacin,
    Mass? folate,
    Mass? biotin,
    Mass? pantothenicAcid,
    Mass? calcium,
    Mass? iron,
    Mass? magnesium,
    Mass? manganese,
    Mass? phosphorus,
    Mass? potassium,
    Mass? selenium,
    Mass? sodium,
    Mass? zinc,
    Mass? caffeine,
  }) {
    return NutritionRecord(
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      metadata: metadata ?? this.metadata,
      id: id ?? this.id,
      startZoneOffsetSeconds:
          startZoneOffsetSeconds ?? this.startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds ?? this.endZoneOffsetSeconds,
      foodName: foodName ?? this.foodName,
      mealType: mealType ?? this.mealType,
      energy: energy ?? this.energy,
      protein: protein ?? this.protein,
      totalCarbohydrate: totalCarbohydrate ?? this.totalCarbohydrate,
      totalFat: totalFat ?? this.totalFat,
      saturatedFat: saturatedFat ?? this.saturatedFat,
      monounsaturatedFat: monounsaturatedFat ?? this.monounsaturatedFat,
      polyunsaturatedFat: polyunsaturatedFat ?? this.polyunsaturatedFat,
      cholesterol: cholesterol ?? this.cholesterol,
      dietaryFiber: dietaryFiber ?? this.dietaryFiber,
      sugar: sugar ?? this.sugar,
      vitaminA: vitaminA ?? this.vitaminA,
      vitaminB6: vitaminB6 ?? this.vitaminB6,
      vitaminB12: vitaminB12 ?? this.vitaminB12,
      vitaminC: vitaminC ?? this.vitaminC,
      vitaminD: vitaminD ?? this.vitaminD,
      vitaminE: vitaminE ?? this.vitaminE,
      vitaminK: vitaminK ?? this.vitaminK,
      thiamin: thiamin ?? this.thiamin,
      riboflavin: riboflavin ?? this.riboflavin,
      niacin: niacin ?? this.niacin,
      folate: folate ?? this.folate,
      biotin: biotin ?? this.biotin,
      pantothenicAcid: pantothenicAcid ?? this.pantothenicAcid,
      calcium: calcium ?? this.calcium,
      iron: iron ?? this.iron,
      magnesium: magnesium ?? this.magnesium,
      manganese: manganese ?? this.manganese,
      phosphorus: phosphorus ?? this.phosphorus,
      potassium: potassium ?? this.potassium,
      selenium: selenium ?? this.selenium,
      sodium: sodium ?? this.sodium,
      zinc: zinc ?? this.zinc,
      caffeine: caffeine ?? this.caffeine,
    );
  }

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.appleHealth,
    HealthPlatform.healthConnect,
  ];
}
