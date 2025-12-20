import 'package:health_connector_core/health_connector_core.dart'
    show
        Energy,
        HealthRecord,
        HealthRecordId,
        Mass,
        NutritionRecord,
        sinceV1_1_0;
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/health_record_id_mappers.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/meal_type_mappers.dart';
import 'package:health_connector_hc_android/src/mappers/measurement_unit_mappers.dart';
import 'package:health_connector_hc_android/src/mappers/metadata_mappers.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show EnergyDto, HealthDataTypeDto, MassDto, NutritionRecordDto;
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
      energy: energy?.toDto() as EnergyDto?,
      protein: protein?.toDto() as MassDto?,
      totalCarbohydrate: totalCarbohydrate?.toDto() as MassDto?,
      totalFat: totalFat?.toDto() as MassDto?,
      saturatedFat: saturatedFat?.toDto() as MassDto?,
      monounsaturatedFat: monounsaturatedFat?.toDto() as MassDto?,
      polyunsaturatedFat: polyunsaturatedFat?.toDto() as MassDto?,
      cholesterol: cholesterol?.toDto() as MassDto?,
      dietaryFiber: dietaryFiber?.toDto() as MassDto?,
      sugar: sugar?.toDto() as MassDto?,
      vitaminA: vitaminA?.toDto() as MassDto?,
      vitaminB6: vitaminB6?.toDto() as MassDto?,
      vitaminB12: vitaminB12?.toDto() as MassDto?,
      vitaminC: vitaminC?.toDto() as MassDto?,
      vitaminD: vitaminD?.toDto() as MassDto?,
      vitaminE: vitaminE?.toDto() as MassDto?,
      vitaminK: vitaminK?.toDto() as MassDto?,
      thiamin: thiamin?.toDto() as MassDto?,
      riboflavin: riboflavin?.toDto() as MassDto?,
      niacin: niacin?.toDto() as MassDto?,
      folate: folate?.toDto() as MassDto?,
      biotin: biotin?.toDto() as MassDto?,
      pantothenicAcid: pantothenicAcid?.toDto() as MassDto?,
      calcium: calcium?.toDto() as MassDto?,
      iron: iron?.toDto() as MassDto?,
      magnesium: magnesium?.toDto() as MassDto?,
      manganese: manganese?.toDto() as MassDto?,
      phosphorus: phosphorus?.toDto() as MassDto?,
      potassium: potassium?.toDto() as MassDto?,
      selenium: selenium?.toDto() as MassDto?,
      sodium: sodium?.toDto() as MassDto?,
      zinc: zinc?.toDto() as MassDto?,
      caffeine: caffeine?.toDto() as MassDto?,
    );
  }
}

/// Converts [NutritionRecordDto] to domain nutrition records.
@sinceV1_1_0
@internal
extension NutritionRecordDtoToDomain on NutritionRecordDto {
  HealthRecord toDomain() {
    final id = this.id?.toDomain() ?? HealthRecordId.none;
    final time = DateTime.fromMillisecondsSinceEpoch(startTime);
    final zoneOffsetSeconds = startZoneOffsetSeconds;
    final metadata = this.metadata.toDomain();
    final foodName = this.foodName;
    final mealType = this.mealType.toDomain();

    switch (healthDataType) {
      case HealthDataTypeDto.nutrition:
        return NutritionRecord(
          id: id,
          startTime: time,
          endTime: DateTime.fromMillisecondsSinceEpoch(endTime),
          startZoneOffsetSeconds: zoneOffsetSeconds,
          endZoneOffsetSeconds: endZoneOffsetSeconds,
          metadata: metadata,
          foodName: foodName,
          mealType: mealType,
          energy: energy?.toDomain() as Energy?,
          protein: protein?.toDomain() as Mass?,
          totalCarbohydrate: totalCarbohydrate?.toDomain() as Mass?,
          totalFat: totalFat?.toDomain() as Mass?,
          saturatedFat: saturatedFat?.toDomain() as Mass?,
          monounsaturatedFat: monounsaturatedFat?.toDomain() as Mass?,
          polyunsaturatedFat: polyunsaturatedFat?.toDomain() as Mass?,
          cholesterol: cholesterol?.toDomain() as Mass?,
          dietaryFiber: dietaryFiber?.toDomain() as Mass?,
          sugar: sugar?.toDomain() as Mass?,
          vitaminA: vitaminA?.toDomain() as Mass?,
          vitaminB6: vitaminB6?.toDomain() as Mass?,
          vitaminB12: vitaminB12?.toDomain() as Mass?,
          vitaminC: vitaminC?.toDomain() as Mass?,
          vitaminD: vitaminD?.toDomain() as Mass?,
          vitaminE: vitaminE?.toDomain() as Mass?,
          vitaminK: vitaminK?.toDomain() as Mass?,
          thiamin: thiamin?.toDomain() as Mass?,
          riboflavin: riboflavin?.toDomain() as Mass?,
          niacin: niacin?.toDomain() as Mass?,
          folate: folate?.toDomain() as Mass?,
          biotin: biotin?.toDomain() as Mass?,
          pantothenicAcid: pantothenicAcid?.toDomain() as Mass?,
          calcium: calcium?.toDomain() as Mass?,
          iron: iron?.toDomain() as Mass?,
          magnesium: magnesium?.toDomain() as Mass?,
          manganese: manganese?.toDomain() as Mass?,
          phosphorus: phosphorus?.toDomain() as Mass?,
          potassium: potassium?.toDomain() as Mass?,
          selenium: selenium?.toDomain() as Mass?,
          sodium: sodium?.toDomain() as Mass?,
          zinc: zinc?.toDomain() as Mass?,
          caffeine: caffeine?.toDomain() as Mass?,
        );
      default:
        throw ArgumentError('Invalid DTO for $NutritionRecordDto: $this');
    }
  }
}

/// Maps individual nutrient domain record to [NutritionRecordDto].
