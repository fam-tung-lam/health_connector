import 'package:health_connector_core/health_connector_core_internal.dart'
    show HealthRecordId, MealType, VitaminCNutrientRecord, sinceV1_1_0;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/nutrition/meal_type_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/measurement_unit_mappers/measurement_unit_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show VitaminCNutrientRecordDto;
import 'package:meta/meta.dart' show internal;

/// Converts [VitaminCNutrientRecord] to [VitaminCNutrientRecordDto].
@sinceV1_1_0
@internal
extension VitaminCNutrientRecordToDto on VitaminCNutrientRecord {
  VitaminCNutrientRecordDto toDto() {
    return VitaminCNutrientRecordDto(
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

/// Converts [VitaminCNutrientRecordDto] to [VitaminCNutrientRecord].
@sinceV1_1_0
@internal
extension VitaminCNutrientRecordDtoToDomain on VitaminCNutrientRecordDto {
  VitaminCNutrientRecord toDomain() {
    return VitaminCNutrientRecord(
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
