import 'package:health_connector_core/health_connector_core_internal.dart'
    show DietaryZincRecord, HealthRecordId, Mass, MealType;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/nutrition/meal_type_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show DietaryZincRecordDto;
import 'package:meta/meta.dart' show internal;

/// Converts [DietaryZincRecord] to [DietaryZincRecordDto].
@internal
extension DietaryZincRecordToDto on DietaryZincRecord {
  DietaryZincRecordDto toDto() {
    return DietaryZincRecordDto(
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

/// Converts [DietaryZincRecordDto] to [DietaryZincRecord].
@internal
extension DietaryZincRecordDtoToDomain on DietaryZincRecordDto {
  DietaryZincRecord toDomain() {
    return DietaryZincRecord.internal(
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
