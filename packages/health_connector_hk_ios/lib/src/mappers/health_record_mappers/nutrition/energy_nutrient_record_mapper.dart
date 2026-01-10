import 'package:health_connector_core/health_connector_core_internal.dart'
    show EnergyNutrientRecord, HealthRecordId, MealType, sinceV1_1_0;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/nutrition/meal_type_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/measurement_unit_mappers/measurement_unit_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show EnergyNutrientRecordDto;
import 'package:meta/meta.dart' show internal;

/// Converts [EnergyNutrientRecord] to [EnergyNutrientRecordDto].
@sinceV1_1_0
@internal
extension EnergyNutrientRecordToDto on EnergyNutrientRecord {
  EnergyNutrientRecordDto toDto() {
    return EnergyNutrientRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      value: energy.toDto(),
      foodName: foodName,
      mealType: mealType.toDto(),
    );
  }
}

/// Converts [EnergyNutrientRecordDto] to [EnergyNutrientRecord].
@sinceV1_1_0
@internal
extension EnergyNutrientRecordDtoToDomain on EnergyNutrientRecordDto {
  EnergyNutrientRecord toDomain() {
    return EnergyNutrientRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time, isUtc: true),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      energy: value.toDomain(),
      foodName: foodName,
      mealType: mealType?.toDomain() ?? MealType.unknown,
    );
  }
}
