import 'package:health_connector_core/health_connector_core_internal.dart'
    show BloodGlucoseRelationToMeal, sinceV1_4_0;
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show BloodGlucoseRelationToMealDto;
import 'package:meta/meta.dart' show internal;

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
