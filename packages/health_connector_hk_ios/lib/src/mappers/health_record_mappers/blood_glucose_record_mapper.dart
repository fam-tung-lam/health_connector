import 'package:health_connector_core/health_connector_core_internal.dart'
    show
        BloodGlucoseRecord,
        BloodGlucoseRelationToMeal,
        BloodGlucoseSpecimenSource,
        BloodGlucoseMealType,
        HealthRecordId,
        sinceV1_4_0;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/measurement_unit_mappers/measurement_unit_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show
        BloodGlucoseRecordDto,
        BloodGlucoseRelationToMealDto,
        BloodGlucoseSpecimenSourceDto,
        MealTypeDto;
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
      bloodGlucose: bloodGlucose.toDto(),
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
    return BloodGlucoseRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time, isUtc: true),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      bloodGlucose: bloodGlucose.toDomain(),
      mealType:
          mealType?.toBloodGlucoseMealType() ?? BloodGlucoseMealType.unknown,
      relationToMeal:
          relationToMeal?.toDomain() ?? BloodGlucoseRelationToMeal.unknown,
      specimenSource:
          specimenSource?.toDomain() ?? BloodGlucoseSpecimenSource.unknown,
    );
  }
}

/// Converts [BloodGlucoseRelationToMeal] to [BloodGlucoseRelationToMealDto].
@sinceV1_4_0
@internal
extension BloodGlucoseRelationToMealToDto on BloodGlucoseRelationToMeal {
  /// Converts [BloodGlucoseRelationToMeal] to [BloodGlucoseRelationToMealDto].
  BloodGlucoseRelationToMealDto toDto() {
    return switch (this) {
      BloodGlucoseRelationToMeal.unknown =>
        BloodGlucoseRelationToMealDto.unknown,
      BloodGlucoseRelationToMeal.general =>
        BloodGlucoseRelationToMealDto.general,
      BloodGlucoseRelationToMeal.fasting =>
        BloodGlucoseRelationToMealDto.fasting,
      BloodGlucoseRelationToMeal.beforeMeal =>
        BloodGlucoseRelationToMealDto.beforeMeal,
      BloodGlucoseRelationToMeal.afterMeal =>
        BloodGlucoseRelationToMealDto.afterMeal,
    };
  }
}

/// Converts [BloodGlucoseRelationToMealDto] to [BloodGlucoseRelationToMeal].
@sinceV1_4_0
@internal
extension BloodGlucoseRelationToMealDtoToDomain
    on BloodGlucoseRelationToMealDto {
  BloodGlucoseRelationToMeal toDomain() {
    return switch (this) {
      BloodGlucoseRelationToMealDto.unknown =>
        BloodGlucoseRelationToMeal.unknown,
      BloodGlucoseRelationToMealDto.general =>
        BloodGlucoseRelationToMeal.general,
      BloodGlucoseRelationToMealDto.fasting =>
        BloodGlucoseRelationToMeal.fasting,
      BloodGlucoseRelationToMealDto.beforeMeal =>
        BloodGlucoseRelationToMeal.beforeMeal,
      BloodGlucoseRelationToMealDto.afterMeal =>
        BloodGlucoseRelationToMeal.afterMeal,
    };
  }
}

/// Converts [BloodGlucoseSpecimenSource] to [BloodGlucoseSpecimenSourceDto].
@sinceV1_4_0
@internal
extension BloodGlucoseSpecimenSourceToDto on BloodGlucoseSpecimenSource {
  /// Converts [BloodGlucoseSpecimenSource] to [BloodGlucoseSpecimenSourceDto].
  BloodGlucoseSpecimenSourceDto toDto() {
    return switch (this) {
      BloodGlucoseSpecimenSource.unknown =>
        BloodGlucoseSpecimenSourceDto.unknown,
      BloodGlucoseSpecimenSource.interstitialFluid =>
        BloodGlucoseSpecimenSourceDto.interstitialFluid,
      BloodGlucoseSpecimenSource.capillaryBlood =>
        BloodGlucoseSpecimenSourceDto.capillaryBlood,
      BloodGlucoseSpecimenSource.plasma => BloodGlucoseSpecimenSourceDto.plasma,
      BloodGlucoseSpecimenSource.serum => BloodGlucoseSpecimenSourceDto.serum,
      BloodGlucoseSpecimenSource.tears => BloodGlucoseSpecimenSourceDto.tears,
      BloodGlucoseSpecimenSource.wholeBlood =>
        BloodGlucoseSpecimenSourceDto.wholeBlood,
    };
  }
}

/// Converts [BloodGlucoseSpecimenSourceDto] to [BloodGlucoseSpecimenSource].
@sinceV1_4_0
@internal
extension BloodGlucoseSpecimenSourceDtoToDomain
    on BloodGlucoseSpecimenSourceDto {
  BloodGlucoseSpecimenSource toDomain() {
    return switch (this) {
      BloodGlucoseSpecimenSourceDto.unknown =>
        BloodGlucoseSpecimenSource.unknown,
      BloodGlucoseSpecimenSourceDto.interstitialFluid =>
        BloodGlucoseSpecimenSource.interstitialFluid,
      BloodGlucoseSpecimenSourceDto.capillaryBlood =>
        BloodGlucoseSpecimenSource.capillaryBlood,
      BloodGlucoseSpecimenSourceDto.plasma => BloodGlucoseSpecimenSource.plasma,
      BloodGlucoseSpecimenSourceDto.serum => BloodGlucoseSpecimenSource.serum,
      BloodGlucoseSpecimenSourceDto.tears => BloodGlucoseSpecimenSource.tears,
      BloodGlucoseSpecimenSourceDto.wholeBlood =>
        BloodGlucoseSpecimenSource.wholeBlood,
    };
  }
}

/// Converts [BloodGlucoseMealType] to [MealTypeDto].
@sinceV1_4_0
@internal
extension BloodGlucoseMealTypeToDto on BloodGlucoseMealType {
  MealTypeDto toDto() {
    return switch (this) {
      BloodGlucoseMealType.unknown => MealTypeDto.unknown,
      BloodGlucoseMealType.breakfast => MealTypeDto.breakfast,
      BloodGlucoseMealType.lunch => MealTypeDto.lunch,
      BloodGlucoseMealType.dinner => MealTypeDto.dinner,
      BloodGlucoseMealType.snack => MealTypeDto.snack,
    };
  }
}

/// Converts [MealTypeDto] to [BloodGlucoseMealType].
@sinceV1_4_0
@internal
extension MealTypeDtoToBloodGlucoseMealType on MealTypeDto {
  BloodGlucoseMealType toBloodGlucoseMealType() {
    return switch (this) {
      MealTypeDto.unknown => BloodGlucoseMealType.unknown,
      MealTypeDto.breakfast => BloodGlucoseMealType.breakfast,
      MealTypeDto.lunch => BloodGlucoseMealType.lunch,
      MealTypeDto.dinner => BloodGlucoseMealType.dinner,
      MealTypeDto.snack => BloodGlucoseMealType.snack,
    };
  }
}
