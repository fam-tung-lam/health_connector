import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/meal_type_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';
import 'package:parameterized_test/parameterized_test.dart';
import 'package:test/test.dart';

void main() {
  group(
    'MealTypeMapper',
    () {
      group(
        'MealTypeToDto',
        () {
          parameterizedTest(
            'converts MealType to MealTypeDto',
            [
              [MealType.unknown, MealTypeDto.unknown],
              [MealType.breakfast, MealTypeDto.breakfast],
              [MealType.lunch, MealTypeDto.lunch],
              [MealType.dinner, MealTypeDto.dinner],
              [MealType.snack, MealTypeDto.snack],
            ],
            (MealType domain, MealTypeDto dto) {
              expect(domain.toDto(), dto);
            },
          );
        },
      );

      group(
        'MealTypeDtoToDomain',
        () {
          parameterizedTest(
            'converts MealTypeDto to MealType',
            [
              [MealTypeDto.unknown, MealType.unknown],
              [MealTypeDto.breakfast, MealType.breakfast],
              [MealTypeDto.lunch, MealType.lunch],
              [MealTypeDto.dinner, MealType.dinner],
              [MealTypeDto.snack, MealType.snack],
            ],
            (MealTypeDto dto, MealType domain) {
              expect(dto.toDomain(), domain);
            },
          );
        },
      );
    },
  );
}
