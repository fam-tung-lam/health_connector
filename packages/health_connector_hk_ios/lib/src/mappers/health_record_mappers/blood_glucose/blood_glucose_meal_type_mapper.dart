import 'package:health_connector_core/health_connector_core_internal.dart'
    show BloodGlucoseMealType, sinceV1_4_0;
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show MealTypeDto;
import 'package:meta/meta.dart' show internal;

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
