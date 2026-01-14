import 'package:health_connector_core/health_connector_core_internal.dart'
    show DietaryCaffeineRecord, HealthRecordId, Mass, MealType, sinceV1_1_0;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/nutrition/meal_type_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show DietaryCaffeineRecordDto;
import 'package:meta/meta.dart' show internal;

/// Converts [DietaryCaffeineRecord] to [DietaryCaffeineRecordDto].
@sinceV1_1_0
@internal
extension DietaryCaffeineRecordToDto on DietaryCaffeineRecord {
  DietaryCaffeineRecordDto toDto() {
    return DietaryCaffeineRecordDto(
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

/// Converts [DietaryCaffeineRecordDto] to [DietaryCaffeineRecord].
@sinceV1_1_0
@internal
extension DietaryCaffeineRecordDtoToDomain on DietaryCaffeineRecordDto {
  DietaryCaffeineRecord toDomain() {
    return DietaryCaffeineRecord.internal(
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
