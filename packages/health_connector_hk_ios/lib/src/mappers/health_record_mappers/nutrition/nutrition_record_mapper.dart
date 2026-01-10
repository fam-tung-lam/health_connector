import 'package:health_connector_core/health_connector_core_internal.dart'
    show HealthRecordId, MealType, NutritionRecord, sinceV1_1_0;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/nutrition/meal_type_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/measurement_unit_mappers/measurement_unit_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show NutritionRecordDto;
import 'package:meta/meta.dart' show internal;

/// Converts [NutritionRecord] to [NutritionRecordDto].
@sinceV1_1_0
@internal
extension NutritionRecordToDto on NutritionRecord {
  NutritionRecordDto toDto() {
    return NutritionRecordDto(
      id: id.toDto(),
      startTime: startTime.millisecondsSinceEpoch,
      endTime: endTime.millisecondsSinceEpoch,
      metadata: metadata.toDto(),
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
      foodName: foodName,
      mealType: mealType.toDto(),
      // Energy
      energy: energy?.toDto(),
      // Macronutrients
      protein: protein?.toDto(),
      totalCarbohydrate: totalCarbohydrate?.toDto(),
      totalFat: totalFat?.toDto(),
      saturatedFat: saturatedFat?.toDto(),
      monounsaturatedFat: monounsaturatedFat?.toDto(),
      polyunsaturatedFat: polyunsaturatedFat?.toDto(),
      cholesterol: cholesterol?.toDto(),
      dietaryFiber: dietaryFiber?.toDto(),
      sugar: sugar?.toDto(),
      // Vitamins
      vitaminA: vitaminA?.toDto(),
      vitaminB6: vitaminB6?.toDto(),
      vitaminB12: vitaminB12?.toDto(),
      vitaminC: vitaminC?.toDto(),
      vitaminD: vitaminD?.toDto(),
      vitaminE: vitaminE?.toDto(),
      vitaminK: vitaminK?.toDto(),
      thiamin: thiamin?.toDto(),
      riboflavin: riboflavin?.toDto(),
      niacin: niacin?.toDto(),
      folate: folate?.toDto(),
      biotin: biotin?.toDto(),
      pantothenicAcid: pantothenicAcid?.toDto(),
      // Minerals
      calcium: calcium?.toDto(),
      iron: iron?.toDto(),
      magnesium: magnesium?.toDto(),
      manganese: manganese?.toDto(),
      phosphorus: phosphorus?.toDto(),
      potassium: potassium?.toDto(),
      selenium: selenium?.toDto(),
      sodium: sodium?.toDto(),
      zinc: zinc?.toDto(),
      // Other
      caffeine: caffeine?.toDto(),
    );
  }
}

/// Converts [NutritionRecordDto] to [NutritionRecord].
@sinceV1_1_0
@internal
extension NutritionRecordDtoToDomain on NutritionRecordDto {
  NutritionRecord toDomain() {
    return NutritionRecord.internal(
      id: id?.toDomain() ?? HealthRecordId.none,
      startTime: DateTime.fromMillisecondsSinceEpoch(startTime, isUtc: true),
      endTime: DateTime.fromMillisecondsSinceEpoch(endTime, isUtc: true),
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
      metadata: metadata.toDomain(),
      foodName: foodName,
      mealType: mealType?.toDomain() ?? MealType.unknown,
      // Energy
      energy: energy?.toDomain(),
      // Macronutrients
      protein: protein?.toDomain(),
      totalCarbohydrate: totalCarbohydrate?.toDomain(),
      totalFat: totalFat?.toDomain(),
      saturatedFat: saturatedFat?.toDomain(),
      monounsaturatedFat: monounsaturatedFat?.toDomain(),
      polyunsaturatedFat: polyunsaturatedFat?.toDomain(),
      cholesterol: cholesterol?.toDomain(),
      dietaryFiber: dietaryFiber?.toDomain(),
      sugar: sugar?.toDomain(),
      // Vitamins
      vitaminA: vitaminA?.toDomain(),
      vitaminB6: vitaminB6?.toDomain(),
      vitaminB12: vitaminB12?.toDomain(),
      vitaminC: vitaminC?.toDomain(),
      vitaminD: vitaminD?.toDomain(),
      vitaminE: vitaminE?.toDomain(),
      vitaminK: vitaminK?.toDomain(),
      thiamin: thiamin?.toDomain(),
      riboflavin: riboflavin?.toDomain(),
      niacin: niacin?.toDomain(),
      folate: folate?.toDomain(),
      biotin: biotin?.toDomain(),
      pantothenicAcid: pantothenicAcid?.toDomain(),
      // Minerals
      calcium: calcium?.toDomain(),
      iron: iron?.toDomain(),
      magnesium: magnesium?.toDomain(),
      manganese: manganese?.toDomain(),
      phosphorus: phosphorus?.toDomain(),
      potassium: potassium?.toDomain(),
      selenium: selenium?.toDomain(),
      sodium: sodium?.toDomain(),
      zinc: zinc?.toDomain(),
      // Other
      caffeine: caffeine?.toDomain(),
    );
  }
}
