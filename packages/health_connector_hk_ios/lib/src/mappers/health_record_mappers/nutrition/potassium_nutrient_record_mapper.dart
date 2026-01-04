import 'package:health_connector_core/health_connector_core_internal.dart'
    show HealthRecordId, MealType, PotassiumNutrientRecord, sinceV1_1_0;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/nutrition/meal_type_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/measurement_unit_mappers/measurement_unit_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show PotassiumNutrientRecordDto;
import 'package:meta/meta.dart' show internal;

/// Converts [PotassiumNutrientRecord] to [PotassiumNutrientRecordDto].
@sinceV1_1_0
@internal
extension PotassiumNutrientRecordToDto on PotassiumNutrientRecord {
  PotassiumNutrientRecordDto toDto() {
    return PotassiumNutrientRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      value: value.toDto(),
      foodName: foodName,
      mealType: mealType.toDto(),
    );
  }
}

/// Converts [PotassiumNutrientRecordDto] to [PotassiumNutrientRecord].
@sinceV1_1_0
@internal
extension PotassiumNutrientRecordDtoToDomain on PotassiumNutrientRecordDto {
  PotassiumNutrientRecord toDomain() {
    return PotassiumNutrientRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time, isUtc: true),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      value: value.toDomain(),
      foodName: foodName,
      mealType: mealType?.toDomain() ?? MealType.unknown,
    );
  }
}
