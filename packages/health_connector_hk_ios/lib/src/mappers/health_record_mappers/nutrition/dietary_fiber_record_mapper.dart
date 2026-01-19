import 'package:health_connector_core/health_connector_core_internal.dart'
    show DietaryFiberRecord, HealthRecordId, Mass, MealType;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/nutrition/meal_type_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show DietaryFiberRecordDto;
import 'package:meta/meta.dart' show internal;

/// Converts [DietaryFiberRecord] to [DietaryFiberRecordDto].
@internal
extension DietaryFiberRecordToDto on DietaryFiberRecord {
  DietaryFiberRecordDto toDto() {
    return DietaryFiberRecordDto(
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

/// Converts [DietaryFiberRecordDto] to [DietaryFiberRecord].
@internal
extension DietaryFiberRecordDtoToDomain on DietaryFiberRecordDto {
  DietaryFiberRecord toDomain() {
    return DietaryFiberRecord.internal(
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
