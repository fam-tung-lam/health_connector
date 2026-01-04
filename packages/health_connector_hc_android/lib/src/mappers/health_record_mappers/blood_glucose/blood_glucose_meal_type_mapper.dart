import 'package:health_connector_core/health_connector_core_internal.dart'
    show BloodGlucoseMealType, sinceV1_4_0;
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show MealTypeDto;
import 'package:meta/meta.dart' show internal;

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
