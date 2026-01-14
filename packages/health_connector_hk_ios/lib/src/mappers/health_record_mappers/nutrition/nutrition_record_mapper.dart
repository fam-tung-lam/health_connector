import 'package:health_connector_core/health_connector_core_internal.dart'
    show Energy, HealthRecordId, Mass, MealType, NutritionRecord, sinceV1_1_0;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/nutrition/meal_type_mapper.dart';
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
      energyKilocalories: energy?.inKilocalories,
      // Macronutrients
      proteinInGrams: protein?.inGrams,
      totalCarbohydrateInGrams: totalCarbohydrate?.inGrams,
      totalFatInGrams: totalFat?.inGrams,
      saturatedFatInGrams: saturatedFat?.inGrams,
      monounsaturatedFatInGrams: monounsaturatedFat?.inGrams,
      polyunsaturatedFatInGrams: polyunsaturatedFat?.inGrams,
      cholesterolInGrams: cholesterol?.inGrams,
      dietaryFiberInGrams: dietaryFiber?.inGrams,
      sugarInGrams: sugar?.inGrams,
      // Vitamins
      vitaminAInGrams: vitaminA?.inGrams,
      vitaminB6InGrams: vitaminB6?.inGrams,
      vitaminB12InGrams: vitaminB12?.inGrams,
      vitaminCInGrams: vitaminC?.inGrams,
      vitaminDInGrams: vitaminD?.inGrams,
      vitaminEInGrams: vitaminE?.inGrams,
      vitaminKInGrams: vitaminK?.inGrams,
      thiaminInGrams: thiamin?.inGrams,
      riboflavinInGrams: riboflavin?.inGrams,
      niacinInGrams: niacin?.inGrams,
      folateInGrams: folate?.inGrams,
      biotinInGrams: biotin?.inGrams,
      pantothenicAcidInGrams: pantothenicAcid?.inGrams,
      // Minerals
      calciumInGrams: calcium?.inGrams,
      ironInGrams: iron?.inGrams,
      magnesiumInGrams: magnesium?.inGrams,
      manganeseInGrams: manganese?.inGrams,
      phosphorusInGrams: phosphorus?.inGrams,
      potassiumInGrams: potassium?.inGrams,
      seleniumInGrams: selenium?.inGrams,
      sodiumInGrams: sodium?.inGrams,
      zincInGrams: zinc?.inGrams,
      // Other
      caffeineInGrams: caffeine?.inGrams,
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
      energy: energyKilocalories != null
          ? Energy.kilocalories(energyKilocalories!)
          : null,
      // Macronutrients
      protein: proteinInGrams != null ? Mass.grams(proteinInGrams!) : null,
      totalCarbohydrate: totalCarbohydrateInGrams != null
          ? Mass.grams(totalCarbohydrateInGrams!)
          : null,
      totalFat: totalFatInGrams != null ? Mass.grams(totalFatInGrams!) : null,
      saturatedFat: saturatedFatInGrams != null
          ? Mass.grams(saturatedFatInGrams!)
          : null,
      monounsaturatedFat: monounsaturatedFatInGrams != null
          ? Mass.grams(monounsaturatedFatInGrams!)
          : null,
      polyunsaturatedFat: polyunsaturatedFatInGrams != null
          ? Mass.grams(polyunsaturatedFatInGrams!)
          : null,
      cholesterol: cholesterolInGrams != null
          ? Mass.grams(cholesterolInGrams!)
          : null,
      dietaryFiber: dietaryFiberInGrams != null
          ? Mass.grams(dietaryFiberInGrams!)
          : null,
      sugar: sugarInGrams != null ? Mass.grams(sugarInGrams!) : null,
      // Vitamins
      vitaminA: vitaminAInGrams != null ? Mass.grams(vitaminAInGrams!) : null,
      vitaminB6: vitaminB6InGrams != null
          ? Mass.grams(vitaminB6InGrams!)
          : null,
      vitaminB12: vitaminB12InGrams != null
          ? Mass.grams(vitaminB12InGrams!)
          : null,
      vitaminC: vitaminCInGrams != null ? Mass.grams(vitaminCInGrams!) : null,
      vitaminD: vitaminDInGrams != null ? Mass.grams(vitaminDInGrams!) : null,
      vitaminE: vitaminEInGrams != null ? Mass.grams(vitaminEInGrams!) : null,
      vitaminK: vitaminKInGrams != null ? Mass.grams(vitaminKInGrams!) : null,
      thiamin: thiaminInGrams != null ? Mass.grams(thiaminInGrams!) : null,
      riboflavin: riboflavinInGrams != null
          ? Mass.grams(riboflavinInGrams!)
          : null,
      niacin: niacinInGrams != null ? Mass.grams(niacinInGrams!) : null,
      folate: folateInGrams != null ? Mass.grams(folateInGrams!) : null,
      biotin: biotinInGrams != null ? Mass.grams(biotinInGrams!) : null,
      pantothenicAcid: pantothenicAcidInGrams != null
          ? Mass.grams(pantothenicAcidInGrams!)
          : null,
      // Minerals
      calcium: calciumInGrams != null ? Mass.grams(calciumInGrams!) : null,
      iron: ironInGrams != null ? Mass.grams(ironInGrams!) : null,
      magnesium: magnesiumInGrams != null
          ? Mass.grams(magnesiumInGrams!)
          : null,
      manganese: manganeseInGrams != null
          ? Mass.grams(manganeseInGrams!)
          : null,
      phosphorus: phosphorusInGrams != null
          ? Mass.grams(phosphorusInGrams!)
          : null,
      potassium: potassiumInGrams != null
          ? Mass.grams(potassiumInGrams!)
          : null,
      selenium: seleniumInGrams != null ? Mass.grams(seleniumInGrams!) : null,
      sodium: sodiumInGrams != null ? Mass.grams(sodiumInGrams!) : null,
      zinc: zincInGrams != null ? Mass.grams(zincInGrams!) : null,
      // Other
      caffeine: caffeineInGrams != null ? Mass.grams(caffeineInGrams!) : null,
    );
  }
}
