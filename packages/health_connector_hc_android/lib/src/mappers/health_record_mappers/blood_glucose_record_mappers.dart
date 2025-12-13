import 'package:health_connector_core/health_connector_core.dart'
    show
        BloodGlucoseRecord,
        BloodGlucose,
        BloodGlucoseRelationToMeal,
        BloodGlucoseSpecimenSource,
        BloodGlucoseMealType,
        HealthRecordId,
        sinceV1_4_0;
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/health_record_id_mappers.dart';
import 'package:health_connector_hc_android/src/mappers/measurement_unit_mappers.dart';
import 'package:health_connector_hc_android/src/mappers/metadata_mappers.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show
        BloodGlucoseRecordDto,
        BloodGlucoseDto,
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
      bloodGlucose: bloodGlucose.toDto() as BloodGlucoseDto,
      relationToMeal: relationToMeal.toDto(),
      specimenSource: specimenSource.toDto(),
      mealType: mealType.toDto(),
    );
  }
}

/// Converts [BloodGlucoseRecordDto] to [BloodGlucoseRecord].
@sinceV1_4_0
@internal
extension BloodGlucoseRecordDtoToDomain on BloodGlucoseRecordDto {
  BloodGlucoseRecord toDomain() {
    return BloodGlucoseRecord(
      id: id?.toHealthRecordId() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      bloodGlucose: bloodGlucose.toDomain() as BloodGlucose,
      relationToMeal:
          relationToMeal?.toDomain() ?? BloodGlucoseRelationToMeal.unknown,
      specimenSource:
          specimenSource?.toDomain() ?? BloodGlucoseSpecimenSource.unknown,
      mealType:
          mealType?.toBloodGlucoseMealType() ?? BloodGlucoseMealType.unknown,
    );
  }
}

/// Converts [BloodGlucoseRelationToMeal] to [BloodGlucoseRelationToMealDto].
@sinceV1_4_0
@internal
extension BloodGlucoseRelationToMealToDto on BloodGlucoseRelationToMeal {
  /// Converts [BloodGlucoseRelationToMeal] to [BloodGlucoseRelationToMealDto].
  BloodGlucoseRelationToMealDto toDto() {
    switch (this) {
      case BloodGlucoseRelationToMeal.unknown:
        return BloodGlucoseRelationToMealDto.unknown;
      case BloodGlucoseRelationToMeal.general:
        return BloodGlucoseRelationToMealDto.general;
      case BloodGlucoseRelationToMeal.fasting:
        return BloodGlucoseRelationToMealDto.fasting;
      case BloodGlucoseRelationToMeal.beforeMeal:
        return BloodGlucoseRelationToMealDto.beforeMeal;
      case BloodGlucoseRelationToMeal.afterMeal:
        return BloodGlucoseRelationToMealDto.afterMeal;
    }
  }
}

/// Converts [BloodGlucoseRelationToMealDto] to [BloodGlucoseRelationToMeal].
@sinceV1_4_0
@internal
extension BloodGlucoseRelationToMealDtoToDomain
    on BloodGlucoseRelationToMealDto {
  BloodGlucoseRelationToMeal toDomain() {
    switch (this) {
      case BloodGlucoseRelationToMealDto.unknown:
        return BloodGlucoseRelationToMeal.unknown;
      case BloodGlucoseRelationToMealDto.general:
        return BloodGlucoseRelationToMeal.general;
      case BloodGlucoseRelationToMealDto.fasting:
        return BloodGlucoseRelationToMeal.fasting;
      case BloodGlucoseRelationToMealDto.beforeMeal:
        return BloodGlucoseRelationToMeal.beforeMeal;
      case BloodGlucoseRelationToMealDto.afterMeal:
        return BloodGlucoseRelationToMeal.afterMeal;
    }
  }
}

/// Converts [BloodGlucoseSpecimenSource] to [BloodGlucoseSpecimenSourceDto].
@sinceV1_4_0
@internal
extension BloodGlucoseSpecimenSourceToDto on BloodGlucoseSpecimenSource {
  /// Converts [BloodGlucoseSpecimenSource] to [BloodGlucoseSpecimenSourceDto].
  BloodGlucoseSpecimenSourceDto toDto() {
    switch (this) {
      case BloodGlucoseSpecimenSource.unknown:
        return BloodGlucoseSpecimenSourceDto.unknown;
      case BloodGlucoseSpecimenSource.interstitialFluid:
        return BloodGlucoseSpecimenSourceDto.interstitialFluid;
      case BloodGlucoseSpecimenSource.capillaryBlood:
        return BloodGlucoseSpecimenSourceDto.capillaryBlood;
      case BloodGlucoseSpecimenSource.plasma:
        return BloodGlucoseSpecimenSourceDto.plasma;
      case BloodGlucoseSpecimenSource.serum:
        return BloodGlucoseSpecimenSourceDto.serum;
      case BloodGlucoseSpecimenSource.tears:
        return BloodGlucoseSpecimenSourceDto.tears;
      case BloodGlucoseSpecimenSource.wholeBlood:
        return BloodGlucoseSpecimenSourceDto.wholeBlood;
    }
  }
}

/// Converts [BloodGlucoseSpecimenSourceDto] to [BloodGlucoseSpecimenSource].
@sinceV1_4_0
@internal
extension BloodGlucoseSpecimenSourceDtoToDomain
    on BloodGlucoseSpecimenSourceDto {
  BloodGlucoseSpecimenSource toDomain() {
    switch (this) {
      case BloodGlucoseSpecimenSourceDto.unknown:
        return BloodGlucoseSpecimenSource.unknown;
      case BloodGlucoseSpecimenSourceDto.interstitialFluid:
        return BloodGlucoseSpecimenSource.interstitialFluid;
      case BloodGlucoseSpecimenSourceDto.capillaryBlood:
        return BloodGlucoseSpecimenSource.capillaryBlood;
      case BloodGlucoseSpecimenSourceDto.plasma:
        return BloodGlucoseSpecimenSource.plasma;
      case BloodGlucoseSpecimenSourceDto.serum:
        return BloodGlucoseSpecimenSource.serum;
      case BloodGlucoseSpecimenSourceDto.tears:
        return BloodGlucoseSpecimenSource.tears;
      case BloodGlucoseSpecimenSourceDto.wholeBlood:
        return BloodGlucoseSpecimenSource.wholeBlood;
    }
  }
}

/// Converts [BloodGlucoseMealType] to [MealTypeDto].
@sinceV1_4_0
@internal
extension BloodGlucoseMealTypeToDto on BloodGlucoseMealType {
  MealTypeDto toDto() {
    switch (this) {
      case BloodGlucoseMealType.unknown:
        return MealTypeDto.unknown;
      case BloodGlucoseMealType.breakfast:
        return MealTypeDto.breakfast;
      case BloodGlucoseMealType.lunch:
        return MealTypeDto.lunch;
      case BloodGlucoseMealType.dinner:
        return MealTypeDto.dinner;
      case BloodGlucoseMealType.snack:
        return MealTypeDto.snack;
    }
  }
}

/// Converts [MealTypeDto] to [BloodGlucoseMealType].
@sinceV1_4_0
@internal
extension MealTypeDtoToBloodGlucoseMealType on MealTypeDto {
  BloodGlucoseMealType toBloodGlucoseMealType() {
    switch (this) {
      case MealTypeDto.unknown:
        return BloodGlucoseMealType.unknown;
      case MealTypeDto.breakfast:
        return BloodGlucoseMealType.breakfast;
      case MealTypeDto.lunch:
        return BloodGlucoseMealType.lunch;
      case MealTypeDto.dinner:
        return BloodGlucoseMealType.dinner;
      case MealTypeDto.snack:
        return BloodGlucoseMealType.snack;
    }
  }
}
