import 'package:health_connector_core/health_connector_core_internal.dart'
    show
        DietaryEnergyConsumedRecord,
        Energy,
        HealthRecordId,
        MealType;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/nutrition/meal_type_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show DietaryEnergyConsumedRecordDto;
import 'package:meta/meta.dart' show internal;

/// Converts [DietaryEnergyConsumedRecord] to [DietaryEnergyConsumedRecordDto].
@internal
extension DietaryEnergyConsumedRecordToDto on DietaryEnergyConsumedRecord {
  DietaryEnergyConsumedRecordDto toDto() {
    return DietaryEnergyConsumedRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      kilocalories: energy.inKilocalories,
      foodName: foodName,
      mealType: mealType.toDto(),
    );
  }
}

/// Converts [DietaryEnergyConsumedRecordDto] to [DietaryEnergyConsumedRecord].
@internal
extension DietaryEnergyConsumedRecordDtoToDomain
    on DietaryEnergyConsumedRecordDto {
  DietaryEnergyConsumedRecord toDomain() {
    return DietaryEnergyConsumedRecord.internal(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time, isUtc: true),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      energy: Energy.kilocalories(kilocalories),
      foodName: foodName,
      mealType: mealType?.toDomain() ?? MealType.unknown,
    );
  }
}
