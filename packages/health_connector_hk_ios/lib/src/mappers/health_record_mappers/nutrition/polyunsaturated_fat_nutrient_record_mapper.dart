import 'package:health_connector_core/health_connector_core_internal.dart'
    show
        HealthRecordId,
        MealType,
        PolyunsaturatedFatNutrientRecord,
        sinceV1_1_0;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/nutrition/meal_type_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/measurement_unit_mappers/measurement_unit_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show PolyunsaturatedFatNutrientRecordDto;
import 'package:meta/meta.dart' show internal;

/// Converts [PolyunsaturatedFatNutrientRecord] to
/// [PolyunsaturatedFatNutrientRecordDto].
@sinceV1_1_0
@internal
extension PolyunsaturatedFatNutrientRecordToDto
    on PolyunsaturatedFatNutrientRecord {
  PolyunsaturatedFatNutrientRecordDto toDto() {
    return PolyunsaturatedFatNutrientRecordDto(
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

/// Converts [PolyunsaturatedFatNutrientRecordDto] to
/// [PolyunsaturatedFatNutrientRecord].
@sinceV1_1_0
@internal
extension PolyunsaturatedFatNutrientRecordDtoToDomain
    on PolyunsaturatedFatNutrientRecordDto {
  PolyunsaturatedFatNutrientRecord toDomain() {
    return PolyunsaturatedFatNutrientRecord(
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
