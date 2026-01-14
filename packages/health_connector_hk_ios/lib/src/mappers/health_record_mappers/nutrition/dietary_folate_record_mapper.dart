import 'package:health_connector_core/health_connector_core_internal.dart'
    show DietaryFolateRecord, HealthRecordId, Mass, MealType, sinceV1_1_0;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/nutrition/meal_type_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show DietaryFolateRecordDto;
import 'package:meta/meta.dart' show internal;

/// Converts [DietaryFolateRecord] to [DietaryFolateRecordDto].
@sinceV1_1_0
@internal
extension DietaryFolateRecordToDto on DietaryFolateRecord {
  DietaryFolateRecordDto toDto() {
    return DietaryFolateRecordDto(
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

/// Converts [DietaryFolateRecordDto] to [DietaryFolateRecord].
@sinceV1_1_0
@internal
extension DietaryFolateRecordDtoToDomain on DietaryFolateRecordDto {
  DietaryFolateRecord toDomain() {
    return DietaryFolateRecord.internal(
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
