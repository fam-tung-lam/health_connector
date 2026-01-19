import 'package:health_connector_core/health_connector_core_internal.dart'
    show DietaryMagnesiumRecord, HealthRecordId, Mass, MealType;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/nutrition/meal_type_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show DietaryMagnesiumRecordDto;
import 'package:meta/meta.dart' show internal;

/// Converts [DietaryMagnesiumRecord] to [DietaryMagnesiumRecordDto].
@internal
extension DietaryMagnesiumRecordToDto on DietaryMagnesiumRecord {
  DietaryMagnesiumRecordDto toDto() {
    return DietaryMagnesiumRecordDto(
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

/// Converts [DietaryMagnesiumRecordDto] to [DietaryMagnesiumRecord].
@internal
extension DietaryMagnesiumRecordDtoToDomain on DietaryMagnesiumRecordDto {
  DietaryMagnesiumRecord toDomain() {
    return DietaryMagnesiumRecord.internal(
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
