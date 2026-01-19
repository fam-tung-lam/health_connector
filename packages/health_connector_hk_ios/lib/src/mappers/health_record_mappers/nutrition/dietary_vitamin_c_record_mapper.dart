import 'package:health_connector_core/health_connector_core_internal.dart'
    show DietaryVitaminCRecord, HealthRecordId, Mass, MealType;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/nutrition/meal_type_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show DietaryVitaminCRecordDto;
import 'package:meta/meta.dart' show internal;

/// Converts [DietaryVitaminCRecord] to [DietaryVitaminCRecordDto].
@internal
extension DietaryVitaminCRecordToDto on DietaryVitaminCRecord {
  DietaryVitaminCRecordDto toDto() {
    return DietaryVitaminCRecordDto(
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

/// Converts [DietaryVitaminCRecordDto] to [DietaryVitaminCRecord].
@internal
extension DietaryVitaminCRecordDtoToDomain on DietaryVitaminCRecordDto {
  DietaryVitaminCRecord toDomain() {
    return DietaryVitaminCRecord.internal(
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
