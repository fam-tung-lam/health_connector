import 'package:health_connector_core/health_connector_core_internal.dart'
    show DietaryVitaminDRecord, HealthRecordId, Mass, MealType, sinceV1_1_0;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/nutrition/meal_type_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show DietaryVitaminDRecordDto;
import 'package:meta/meta.dart' show internal;

/// Converts [DietaryVitaminDRecord] to [DietaryVitaminDRecordDto].
@sinceV1_1_0
@internal
extension DietaryVitaminDRecordToDto on DietaryVitaminDRecord {
  DietaryVitaminDRecordDto toDto() {
    return DietaryVitaminDRecordDto(
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

/// Converts [DietaryVitaminDRecordDto] to [DietaryVitaminDRecord].
@sinceV1_1_0
@internal
extension DietaryVitaminDRecordDtoToDomain on DietaryVitaminDRecordDto {
  DietaryVitaminDRecord toDomain() {
    return DietaryVitaminDRecord.internal(
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
