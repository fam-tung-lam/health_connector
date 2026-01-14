import 'package:health_connector_core/health_connector_core_internal.dart'
    show DietaryTotalFatRecord, HealthRecordId, Mass, MealType, sinceV1_1_0;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/nutrition/meal_type_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show DietaryTotalFatRecordDto;
import 'package:meta/meta.dart' show internal;

/// Converts [DietaryTotalFatRecord] to [DietaryTotalFatRecordDto].
@sinceV1_1_0
@internal
extension DietaryTotalFatRecordToDto on DietaryTotalFatRecord {
  DietaryTotalFatRecordDto toDto() {
    return DietaryTotalFatRecordDto(
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

/// Converts [DietaryTotalFatRecordDto] to [DietaryTotalFatRecord].
@sinceV1_1_0
@internal
extension DietaryTotalFatRecordDtoToDomain on DietaryTotalFatRecordDto {
  DietaryTotalFatRecord toDomain() {
    return DietaryTotalFatRecord.internal(
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
