import 'package:health_connector_core/health_connector_core_internal.dart'
    show HealthRecordId, MealType, PhosphorusNutrientRecord, sinceV1_1_0;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/nutrition/meal_type_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/measurement_unit_mappers/measurement_unit_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show PhosphorusNutrientRecordDto;
import 'package:meta/meta.dart' show internal;

/// Converts [PhosphorusNutrientRecord] to [PhosphorusNutrientRecordDto].
@sinceV1_1_0
@internal
extension PhosphorusNutrientRecordToDto on PhosphorusNutrientRecord {
  PhosphorusNutrientRecordDto toDto() {
    return PhosphorusNutrientRecordDto(
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

/// Converts [PhosphorusNutrientRecordDto] to [PhosphorusNutrientRecord].
@sinceV1_1_0
@internal
extension PhosphorusNutrientRecordDtoToDomain on PhosphorusNutrientRecordDto {
  PhosphorusNutrientRecord toDomain() {
    return PhosphorusNutrientRecord(
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
