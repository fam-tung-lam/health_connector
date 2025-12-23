part of '../health_record.dart';

/// Represents a comprehensive nutrition record over a time interval.
///
/// [NutritionRecord] captures detailed nutritional information for food
/// consumed
/// during a specific time period. This record can track energy (calories),
/// macronutrients (protein, carbohydrates, fats), vitamins, minerals, and other
/// nutritional components.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: `NutritionRecord`
/// - **iOS HealthKit**: Multiple `HKQuantityType` correlations for individual
///   nutrients
///
/// ## Example
///
/// ```dart
/// final record = NutritionRecord(
///   startTime: DateTime.now().subtract(Duration(minutes: 30)),
///   endTime: DateTime.now(),
///   foodName: 'Chicken Breast with Rice',
///   mealType: MealType.lunch,
///   energy: Energy.kilocalories(450),
///   protein: Mass.grams(35),
///   totalCarbohydrate: Mass.grams(50),
///   totalFat: Mass.grams(10),
///   metadata: Metadata.manualEntry(
///     dataOrigin: DataOrigin(packageName: 'com.example.app'),
///   ),
/// );
/// ```
@sinceV1_1_0
@immutable
final class NutritionRecord extends IntervalHealthRecord {
  /// Creates a nutrition record.
  ///
  /// ## Parameters
  ///
  /// - [startTime]: The start of the eating interval (inclusive).
  /// - [endTime]: The end of the eating interval (exclusive).
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [id]: The unique identifier for this record.
  /// - [startZoneOffsetSeconds]: Optional timezone offset for start time.
  /// - [endZoneOffsetSeconds]: Optional timezone offset for end time.
  /// - [foodName]: Optional name/description of the food consumed.
  /// - [mealType]: The type of meal (breakfast, lunch, dinner, snack, unknown).
  /// - [energy]: Energy (calories) consumed.
  /// - [protein]: Protein content.
  /// - [totalCarbohydrate]: Total carbohydrate content.
  /// - [totalFat]: Total fat content.
  /// - [saturatedFat]: Saturated fat content.
  /// - [monounsaturatedFat]: Monounsaturated fat content.
  /// - [polyunsaturatedFat]: Polyunsaturated fat content.
  /// - [cholesterol]: Cholesterol content.
  /// - [dietaryFiber]: Dietary fiber content.
  /// - [sugar]: Sugar content.
  /// - [vitaminA] through [caffeine]: Various vitamin, mineral, and other
  ///   nutrient contents.
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [endTime] is not after [startTime].
  const NutritionRecord({
    required super.startTime,
    required super.endTime,
    required super.metadata,
    super.id = HealthRecordId.none,
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

  /// Optional name or description of the food consumed.
  final String? foodName;

  /// The type of meal (breakfast, lunch, dinner, snack, or unknown).
  final MealType mealType;

  /// Energy (calories) consumed.
  final Energy? energy;

  /// Protein content in grams.
  final Mass? protein;

  /// Total carbohydrate content in grams.
  final Mass? totalCarbohydrate;

  /// Total fat content in grams.
  final Mass? totalFat;

  /// Saturated fat content in grams.
  final Mass? saturatedFat;

  /// Monounsaturated fat content in grams.
  final Mass? monounsaturatedFat;

  /// Polyunsaturated fat content in grams.
  final Mass? polyunsaturatedFat;

  /// Cholesterol content in milligrams.
  final Mass? cholesterol;

  /// Dietary fiber content in grams.
  final Mass? dietaryFiber;

  /// Sugar content in grams.
  final Mass? sugar;

  /// Vitamin A content.
  final Mass? vitaminA;

  /// Vitamin B6 content.
  final Mass? vitaminB6;

  /// Vitamin B12 content.
  final Mass? vitaminB12;

  /// Vitamin C content.
  final Mass? vitaminC;

  /// Vitamin D content.
  final Mass? vitaminD;

  /// Vitamin E content.
  final Mass? vitaminE;

  /// Vitamin K content.
  final Mass? vitaminK;

  /// Thiamin (Vitamin B1) content.
  final Mass? thiamin;

  /// Riboflavin (Vitamin B2) content.
  final Mass? riboflavin;

  /// Niacin (Vitamin B3) content.
  final Mass? niacin;

  /// Folate (Vitamin B9) content.
  final Mass? folate;

  /// Biotin (Vitamin B7) content.
  final Mass? biotin;

  /// Pantothenic acid (Vitamin B5) content.
  final Mass? pantothenicAcid;

  /// Calcium content.
  final Mass? calcium;

  /// Iron content.
  final Mass? iron;

  /// Magnesium content.
  final Mass? magnesium;

  /// Manganese content.
  final Mass? manganese;

  /// Phosphorus content.
  final Mass? phosphorus;

  /// Potassium content.
  final Mass? potassium;

  /// Selenium content.
  final Mass? selenium;

  /// Sodium content.
  final Mass? sodium;

  /// Zinc content.
  final Mass? zinc;

  /// Caffeine content.
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
