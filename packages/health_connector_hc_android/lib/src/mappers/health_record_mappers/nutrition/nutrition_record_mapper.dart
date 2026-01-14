import 'package:health_connector_core/health_connector_core_internal.dart'
    show
        HealthRecord,
        HealthRecordId,
        NutritionRecord,
        sinceV1_1_0,
        Mass,
        Energy;
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/nutrition/meal_type_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show HealthDataTypeDto, NutritionRecordDto;
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
      healthDataType: HealthDataTypeDto.nutrition,
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
      metadata: metadata.toDto(),
      foodName: foodName,
      mealType: mealType.toDto(),
      energyInKilocalories: energy?.inKilocalories,
      proteinInGrams: protein?.inGrams,
      totalCarbohydrateInGrams: totalCarbohydrate?.inGrams,
      totalFatInGrams: totalFat?.inGrams,
      saturatedFatInGrams: saturatedFat?.inGrams,
      monounsaturatedFatInGrams: monounsaturatedFat?.inGrams,
      polyunsaturatedFatInGrams: polyunsaturatedFat?.inGrams,
      cholesterolInGrams: cholesterol?.inGrams,
      dietaryFiberInGrams: dietaryFiber?.inGrams,
      sugarInGrams: sugar?.inGrams,
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
      calciumInGrams: calcium?.inGrams,
      ironInGrams: iron?.inGrams,
      magnesiumInGrams: magnesium?.inGrams,
      manganeseInGrams: manganese?.inGrams,
      phosphorusInGrams: phosphorus?.inGrams,
      potassiumInGrams: potassium?.inGrams,
      seleniumInGrams: selenium?.inGrams,
      sodiumInGrams: sodium?.inGrams,
      zincInGrams: zinc?.inGrams,
      caffeineInGrams: caffeine?.inGrams,
    );
  }
}

/// Converts [NutritionRecordDto] to domain nutrition records.
@sinceV1_1_0
@internal
extension NutritionRecordDtoToDomain on NutritionRecordDto {
  HealthRecord toDomain() {
    final id = this.id?.toDomain() ?? HealthRecordId.none;
    final zoneOffsetSeconds = startZoneOffsetSeconds;
    final metadata = this.metadata.toDomain();
    final foodName = this.foodName;
    final mealType = this.mealType.toDomain();

    switch (healthDataType) {
      case HealthDataTypeDto.nutrition:
        return NutritionRecord.internal(
          id: id,
          startTime: DateTime.fromMillisecondsSinceEpoch(
            startTime,
            isUtc: true,
          ),
          endTime: DateTime.fromMillisecondsSinceEpoch(endTime, isUtc: true),
          startZoneOffsetSeconds: zoneOffsetSeconds,
          endZoneOffsetSeconds: endZoneOffsetSeconds,
          metadata: metadata,
          foodName: foodName,
          mealType: mealType,
          energy: energyInKilocalories != null
              ? Energy.kilocalories(energyInKilocalories!)
              : null,
          protein: proteinInGrams != null ? Mass.grams(proteinInGrams!) : null,
          totalCarbohydrate: totalCarbohydrateInGrams != null
              ? Mass.grams(totalCarbohydrateInGrams!)
              : null,
          totalFat: totalFatInGrams != null
              ? Mass.grams(totalFatInGrams!)
              : null,
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
          vitaminA: vitaminAInGrams != null
              ? Mass.grams(vitaminAInGrams!)
              : null,
          vitaminB6: vitaminB6InGrams != null
              ? Mass.grams(vitaminB6InGrams!)
              : null,
          vitaminB12: vitaminB12InGrams != null
              ? Mass.grams(vitaminB12InGrams!)
              : null,
          vitaminC: vitaminCInGrams != null
              ? Mass.grams(vitaminCInGrams!)
              : null,
          vitaminD: vitaminDInGrams != null
              ? Mass.grams(vitaminDInGrams!)
              : null,
          vitaminE: vitaminEInGrams != null
              ? Mass.grams(vitaminEInGrams!)
              : null,
          vitaminK: vitaminKInGrams != null
              ? Mass.grams(vitaminKInGrams!)
              : null,
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
          selenium: seleniumInGrams != null
              ? Mass.grams(seleniumInGrams!)
              : null,
          sodium: sodiumInGrams != null ? Mass.grams(sodiumInGrams!) : null,
          zinc: zincInGrams != null ? Mass.grams(zincInGrams!) : null,
          caffeine: caffeineInGrams != null
              ? Mass.grams(caffeineInGrams!)
              : null,
        );
      default:
        throw ArgumentError('Invalid DTO for $NutritionRecordDto: $this');
    }
  }
}

/// Maps individual nutrient domain record to [NutritionRecordDto].
