import 'package:health_connector_core/health_connector_core_internal.dart'
    show DietaryProteinRecord, HealthRecordId, Mass, MealType, sinceV1_1_0;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/nutrition/meal_type_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show DietaryProteinRecordDto;
import 'package:meta/meta.dart' show internal;

/// Converts [DietaryProteinRecord] to [DietaryProteinRecordDto].
@sinceV1_1_0
@internal
extension DietaryProteinRecordToDto on DietaryProteinRecord {
  DietaryProteinRecordDto toDto() {
    return DietaryProteinRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      grams: mass.inGrams,
      foodName: foodName,
      mealType: mealType.toDto(),
    );
  }
}

/// Converts [DietaryProteinRecordDto] to [DietaryProteinRecord].
@sinceV1_1_0
@internal
extension DietaryProteinRecordDtoToDomain on DietaryProteinRecordDto {
  DietaryProteinRecord toDomain() {
    return DietaryProteinRecord.internal(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time, isUtc: true),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      mass: Mass.grams(grams),
      foodName: foodName,
      mealType: mealType?.toDomain() ?? MealType.unknown,
    );
  }
}
