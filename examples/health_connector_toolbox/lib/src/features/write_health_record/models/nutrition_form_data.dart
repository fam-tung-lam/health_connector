import 'package:flutter/foundation.dart' show immutable;
import 'package:health_connector/health_connector_internal.dart';

/// Data class encapsulating all nutrition form values.
///
/// This replaces the 30-parameter callback signature with a clean data object
/// that can be passed to callbacks and used for record creation.
@immutable
final class NutritionData {
  const NutritionData({
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

  /// Optional food name.
  final String? foodName;

  /// Meal type (breakfast, lunch, dinner, etc.).
  final MealType mealType;

  // region Energy Nutrient

  /// Energy value in kilocalories.
  final Energy? energy;

  // endregion

  // region Macronutrients

  /// Protein in grams.
  final Mass? protein;

  /// Total carbohydrate in grams.
  final Mass? totalCarbohydrate;

  /// Total fat in grams.
  final Mass? totalFat;

  /// Saturated fat in grams.
  final Mass? saturatedFat;

  /// Monounsaturated fat in grams.
  final Mass? monounsaturatedFat;

  /// Polyunsaturated fat in grams.
  final Mass? polyunsaturatedFat;

  /// Cholesterol in milligrams.
  final Mass? cholesterol;

  /// Dietary fiber in grams.
  final Mass? dietaryFiber;

  /// Sugar in grams.
  final Mass? sugar;

  // endregion

  // region Vitamins

  /// Vitamin A in micrograms.
  final Mass? vitaminA;

  /// Vitamin B6 in milligrams.
  final Mass? vitaminB6;

  /// Vitamin B12 in micrograms.
  final Mass? vitaminB12;

  /// Vitamin C in milligrams.
  final Mass? vitaminC;

  /// Vitamin D in micrograms.
  final Mass? vitaminD;

  /// Vitamin E in milligrams.
  final Mass? vitaminE;

  /// Vitamin K in micrograms.
  final Mass? vitaminK;

  /// Thiamin (B1) in milligrams.
  final Mass? thiamin;

  /// Riboflavin (B2) in milligrams.
  final Mass? riboflavin;

  /// Niacin (B3) in milligrams.
  final Mass? niacin;

  /// Folate (B9) in micrograms.
  final Mass? folate;

  /// Biotin (B7) in micrograms.
  final Mass? biotin;

  /// Pantothenic acid (B5) in milligrams.
  final Mass? pantothenicAcid;

  // endregion

  // region Minerals

  /// Calcium in milligrams.
  final Mass? calcium;

  /// Iron in milligrams.
  final Mass? iron;

  /// Magnesium in milligrams.
  final Mass? magnesium;

  /// Manganese in milligrams.
  final Mass? manganese;

  /// Phosphorus in milligrams.
  final Mass? phosphorus;

  /// Potassium in milligrams.
  final Mass? potassium;

  /// Selenium in micrograms.
  final Mass? selenium;

  /// Sodium in milligrams.
  final Mass? sodium;

  /// Zinc in milligrams.
  final Mass? zinc;

  // endregion

  // region Other

  /// Caffeine in milligrams.
  final Mass? caffeine;

  // endregion

  /// Creates a copy with updated values.
  NutritionData copyWith({
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
    return NutritionData(
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

  /// Creates a copy with an updated nutrient value.
  NutritionData withNutrient(HealthDataType type, dynamic value) {
    switch (type) {
      case HealthDataType.dietaryEnergyConsumed:
        return copyWith(energy: value as Energy?);
      case HealthDataType.protein:
        return copyWith(protein: value as Mass?);
      case HealthDataType.totalCarbohydrate:
        return copyWith(totalCarbohydrate: value as Mass?);
      case HealthDataType.totalFat:
        return copyWith(totalFat: value as Mass?);
      case HealthDataType.saturatedFat:
        return copyWith(saturatedFat: value as Mass?);
      case HealthDataType.monounsaturatedFat:
        return copyWith(monounsaturatedFat: value as Mass?);
      case HealthDataType.polyunsaturatedFat:
        return copyWith(polyunsaturatedFat: value as Mass?);
      case HealthDataType.cholesterol:
        return copyWith(cholesterol: value as Mass?);
      case HealthDataType.dietaryFiber:
        return copyWith(dietaryFiber: value as Mass?);
      case HealthDataType.sugar:
        return copyWith(sugar: value as Mass?);
      case HealthDataType.vitaminA:
        return copyWith(vitaminA: value as Mass?);
      case HealthDataType.vitaminB6:
        return copyWith(vitaminB6: value as Mass?);
      case HealthDataType.vitaminB12:
        return copyWith(vitaminB12: value as Mass?);
      case HealthDataType.vitaminC:
        return copyWith(vitaminC: value as Mass?);
      case HealthDataType.vitaminD:
        return copyWith(vitaminD: value as Mass?);
      case HealthDataType.vitaminE:
        return copyWith(vitaminE: value as Mass?);
      case HealthDataType.vitaminK:
        return copyWith(vitaminK: value as Mass?);
      case HealthDataType.thiamin:
        return copyWith(thiamin: value as Mass?);
      case HealthDataType.riboflavin:
        return copyWith(riboflavin: value as Mass?);
      case HealthDataType.niacin:
        return copyWith(niacin: value as Mass?);
      case HealthDataType.folate:
        return copyWith(folate: value as Mass?);
      case HealthDataType.biotin:
        return copyWith(biotin: value as Mass?);
      case HealthDataType.pantothenicAcid:
        return copyWith(pantothenicAcid: value as Mass?);
      case HealthDataType.calcium:
        return copyWith(calcium: value as Mass?);
      case HealthDataType.iron:
        return copyWith(iron: value as Mass?);
      case HealthDataType.magnesium:
        return copyWith(magnesium: value as Mass?);
      case HealthDataType.manganese:
        return copyWith(manganese: value as Mass?);
      case HealthDataType.phosphorus:
        return copyWith(phosphorus: value as Mass?);
      case HealthDataType.potassium:
        return copyWith(potassium: value as Mass?);
      case HealthDataType.selenium:
        return copyWith(selenium: value as Mass?);
      case HealthDataType.sodium:
        return copyWith(sodium: value as Mass?);
      case HealthDataType.zinc:
        return copyWith(zinc: value as Mass?);
      case HealthDataType.caffeine:
        return copyWith(caffeine: value as Mass?);
      default:
        return this;
    }
  }
}
