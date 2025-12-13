import 'package:health_connector_core/health_connector_core.dart'
    show MealType, sinceV1_1_0;
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show MealTypeDto;
import 'package:meta/meta.dart' show internal;

/// Converts [MealType] domain model to DTO.
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

/// Converts [MealTypeDto] to domain model.
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
