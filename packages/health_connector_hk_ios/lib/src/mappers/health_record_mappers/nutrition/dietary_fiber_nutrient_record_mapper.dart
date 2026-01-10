import 'package:health_connector_core/health_connector_core_internal.dart'
    show DietaryFiberNutrientRecord, HealthRecordId, MealType, sinceV1_1_0;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/nutrition/meal_type_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/measurement_unit_mappers/measurement_unit_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show DietaryFiberNutrientRecordDto;
import 'package:meta/meta.dart' show internal;

/// Converts [DietaryFiberNutrientRecord] to [DietaryFiberNutrientRecordDto].
@sinceV1_1_0
@internal
extension DietaryFiberNutrientRecordToDto on DietaryFiberNutrientRecord {
  DietaryFiberNutrientRecordDto toDto() {
    return DietaryFiberNutrientRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      value: mass.toDto(),
      foodName: foodName,
      mealType: mealType.toDto(),
    );
  }
}

/// Converts [DietaryFiberNutrientRecordDto] to [DietaryFiberNutrientRecord].
@sinceV1_1_0
@internal
extension DietaryFiberNutrientRecordDtoToDomain
    on DietaryFiberNutrientRecordDto {
  DietaryFiberNutrientRecord toDomain() {
    return DietaryFiberNutrientRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time, isUtc: true),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      mass: value.toDomain(),
      foodName: foodName,
      mealType: mealType?.toDomain() ?? MealType.unknown,
    );
  }
}
