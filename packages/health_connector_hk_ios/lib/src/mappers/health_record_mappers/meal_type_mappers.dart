import 'package:health_connector_core/health_connector_core_internal.dart'
    show MealType, sinceV1_1_0;
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show MealTypeDto;
import 'package:meta/meta.dart' show internal;

/// Converts [MealType] to [MealTypeDto].
@sinceV1_1_0
@internal
extension MealTypeToDtoExtension on MealType {
  MealTypeDto toDto() {
    return switch (this) {
      MealType.unknown => MealTypeDto.unknown,
      MealType.breakfast => MealTypeDto.breakfast,
      MealType.lunch => MealTypeDto.lunch,
      MealType.dinner => MealTypeDto.dinner,
      MealType.snack => MealTypeDto.snack,
    };
  }
}

/// Converts [MealTypeDto] to [MealType].
@sinceV1_1_0
@internal
extension MealTypeDtoToDomainExtension on MealTypeDto {
  MealType toDomain() {
    return switch (this) {
      MealTypeDto.unknown => MealType.unknown,
      MealTypeDto.breakfast => MealType.breakfast,
      MealTypeDto.lunch => MealType.lunch,
      MealTypeDto.dinner => MealType.dinner,
      MealTypeDto.snack => MealType.snack,
    };
  }
}
