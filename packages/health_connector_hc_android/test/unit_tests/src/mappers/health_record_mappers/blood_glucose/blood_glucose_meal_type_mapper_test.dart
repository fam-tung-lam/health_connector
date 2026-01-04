import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/blood_glucose/blood_glucose_meal_type_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';
import 'package:parameterized_test/parameterized_test.dart';
import 'package:test/test.dart';

void main() {
  group(
    'BloodGlucoseMealTypeMapper',
    () {
      parameterizedTest(
        'converts BloodGlucoseMealType to/from MealTypeDto',
        [
          [BloodGlucoseMealType.unknown, MealTypeDto.unknown],
          [BloodGlucoseMealType.breakfast, MealTypeDto.breakfast],
          [BloodGlucoseMealType.lunch, MealTypeDto.lunch],
          [BloodGlucoseMealType.dinner, MealTypeDto.dinner],
          [BloodGlucoseMealType.snack, MealTypeDto.snack],
        ],
        (BloodGlucoseMealType domain, MealTypeDto dto) {
          // When
          final actualDto = domain.toDto();
          final actualDomain = dto.toBloodGlucoseMealType();

          // Then
          expect(actualDto, dto);
          expect(actualDomain, domain);
        },
      );
    },
  );
}
