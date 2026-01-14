import 'package:health_connector_core/health_connector_core_internal.dart'
    show
        BloodGlucoseRecord,
        BloodGlucoseRelationToMeal,
        BloodGlucoseSpecimenSource,
        MealType,
        HealthRecordId,
        sinceV1_4_0,
        BloodGlucose;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/blood_glucose/blood_glucose_relation_to_meal_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/blood_glucose/blood_glucose_specimen_source_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/nutrition/meal_type_mapper.dart';

import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show BloodGlucoseRecordDto;
import 'package:meta/meta.dart' show internal;

/// Converts [BloodGlucoseRecord] to [BloodGlucoseRecordDto].
@sinceV1_4_0
@internal
extension BloodGlucoseRecordToDto on BloodGlucoseRecord {
  BloodGlucoseRecordDto toDto() {
    return BloodGlucoseRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      millimolesPerLiter: glucoseLevel.inMillimolesPerLiter,
      mealType: mealType.toDto(),
      relationToMeal: relationToMeal.toDto(),
      specimenSource: specimenSource.toDto(),
    );
  }
}

/// Converts [BloodGlucoseRecordDto] to [BloodGlucoseRecord].
@sinceV1_4_0
@internal
extension BloodGlucoseRecordDtoToDomain on BloodGlucoseRecordDto {
  BloodGlucoseRecord toDomain() {
    return BloodGlucoseRecord.internal(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time, isUtc: true),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      glucoseLevel: BloodGlucose.millimolesPerLiter(millimolesPerLiter),
      mealType: mealType?.toDomain() ?? MealType.unknown,
      relationToMeal:
          relationToMeal?.toDomain() ?? BloodGlucoseRelationToMeal.unknown,
      specimenSource:
          specimenSource?.toDomain() ?? BloodGlucoseSpecimenSource.unknown,
    );
  }
}
