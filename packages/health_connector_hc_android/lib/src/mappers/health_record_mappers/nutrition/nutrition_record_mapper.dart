import 'package:health_connector_core/health_connector_core_internal.dart'
    show HealthRecord, HealthRecordId, NutritionRecord, sinceV1_1_0;
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/nutrition/meal_type_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/measurement_unit_mappers/measurement_unit_mapper.dart';
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
      energy: energy?.toDto(),
      protein: protein?.toDto(),
      totalCarbohydrate: totalCarbohydrate?.toDto(),
      totalFat: totalFat?.toDto(),
      saturatedFat: saturatedFat?.toDto(),
      monounsaturatedFat: monounsaturatedFat?.toDto(),
      polyunsaturatedFat: polyunsaturatedFat?.toDto(),
      cholesterol: cholesterol?.toDto(),
      dietaryFiber: dietaryFiber?.toDto(),
      sugar: sugar?.toDto(),
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
      calcium: calcium?.toDto(),
      iron: iron?.toDto(),
      magnesium: magnesium?.toDto(),
      manganese: manganese?.toDto(),
      phosphorus: phosphorus?.toDto(),
      potassium: potassium?.toDto(),
      selenium: selenium?.toDto(),
      sodium: sodium?.toDto(),
      zinc: zinc?.toDto(),
      caffeine: caffeine?.toDto(),
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
        return NutritionRecord(
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
          energy: energy?.toDomain(),
          protein: protein?.toDomain(),
          totalCarbohydrate: totalCarbohydrate?.toDomain(),
          totalFat: totalFat?.toDomain(),
          saturatedFat: saturatedFat?.toDomain(),
          monounsaturatedFat: monounsaturatedFat?.toDomain(),
          polyunsaturatedFat: polyunsaturatedFat?.toDomain(),
          cholesterol: cholesterol?.toDomain(),
          dietaryFiber: dietaryFiber?.toDomain(),
          sugar: sugar?.toDomain(),
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
          calcium: calcium?.toDomain(),
          iron: iron?.toDomain(),
          magnesium: magnesium?.toDomain(),
          manganese: manganese?.toDomain(),
          phosphorus: phosphorus?.toDomain(),
          potassium: potassium?.toDomain(),
          selenium: selenium?.toDomain(),
          sodium: sodium?.toDomain(),
          zinc: zinc?.toDomain(),
          caffeine: caffeine?.toDomain(),
        );
      default:
        throw ArgumentError('Invalid DTO for $NutritionRecordDto: $this');
    }
  }
}

/// Maps individual nutrient domain record to [NutritionRecordDto].
