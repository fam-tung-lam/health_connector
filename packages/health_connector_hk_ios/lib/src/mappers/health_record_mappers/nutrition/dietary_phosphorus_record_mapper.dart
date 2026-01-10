import 'package:health_connector_core/health_connector_core_internal.dart'
    show HealthRecordId, MealType, DietaryPhosphorusRecord, sinceV1_1_0;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/nutrition/meal_type_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/measurement_unit_mappers/measurement_unit_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show DietaryPhosphorusRecordDto;
import 'package:meta/meta.dart' show internal;

/// Converts [DietaryPhosphorusRecord] to [DietaryPhosphorusRecordDto].
@sinceV1_1_0
@internal
extension DietaryPhosphorusRecordToDto on DietaryPhosphorusRecord {
  DietaryPhosphorusRecordDto toDto() {
    return DietaryPhosphorusRecordDto(
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

/// Converts [DietaryPhosphorusRecordDto] to [DietaryPhosphorusRecord].
@sinceV1_1_0
@internal
extension DietaryPhosphorusRecordDtoToDomain on DietaryPhosphorusRecordDto {
  DietaryPhosphorusRecord toDomain() {
    return DietaryPhosphorusRecord.internal(
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
