import 'package:health_connector_core/health_connector_core_internal.dart'
    show DietaryPotassiumRecord, HealthRecordId, Mass, MealType, sinceV1_1_0;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/nutrition/meal_type_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show DietaryPotassiumRecordDto;
import 'package:meta/meta.dart' show internal;

/// Converts [DietaryPotassiumRecord] to [DietaryPotassiumRecordDto].
@sinceV1_1_0
@internal
extension DietaryPotassiumRecordToDto on DietaryPotassiumRecord {
  DietaryPotassiumRecordDto toDto() {
    return DietaryPotassiumRecordDto(
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

/// Converts [DietaryPotassiumRecordDto] to [DietaryPotassiumRecord].
@sinceV1_1_0
@internal
extension DietaryPotassiumRecordDtoToDomain on DietaryPotassiumRecordDto {
  DietaryPotassiumRecord toDomain() {
    return DietaryPotassiumRecord.internal(
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
