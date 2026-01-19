import 'package:health_connector_core/health_connector_core_internal.dart'
    show BloodGlucoseRelationToMeal;
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show BloodGlucoseRelationToMealDto;
import 'package:meta/meta.dart' show internal;

/// Converts [BloodGlucoseRelationToMeal] to [BloodGlucoseRelationToMealDto].
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
