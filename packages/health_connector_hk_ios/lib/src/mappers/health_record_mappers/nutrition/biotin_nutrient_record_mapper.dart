import 'package:health_connector_core/health_connector_core_internal.dart'
    show BiotinNutrientRecord, HealthRecordId, MealType, sinceV1_1_0;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/nutrition/meal_type_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/measurement_unit_mappers/measurement_unit_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show BiotinNutrientRecordDto;
import 'package:meta/meta.dart' show internal;

/// Converts [BiotinNutrientRecord] to [BiotinNutrientRecordDto].
@sinceV1_1_0
@internal
extension BiotinNutrientRecordToDto on BiotinNutrientRecord {
  BiotinNutrientRecordDto toDto() {
    return BiotinNutrientRecordDto(
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

/// Converts [BiotinNutrientRecordDto] to [BiotinNutrientRecord].
@sinceV1_1_0
@internal
extension BiotinNutrientRecordDtoToDomain on BiotinNutrientRecordDto {
  BiotinNutrientRecord toDomain() {
    return BiotinNutrientRecord(
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
