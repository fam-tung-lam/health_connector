import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/blood_glucose/blood_glucose_relation_to_meal_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';
import 'package:parameterized_test/parameterized_test.dart';
import 'package:test/test.dart';

void main() {
  group(
    'BloodGlucoseRelationToMealMapper',
    () {
      parameterizedTest(
        'converts BloodGlucoseRelationToMeal to/from DTO',
        [
          [
            BloodGlucoseRelationToMeal.unknown,
            BloodGlucoseRelationToMealDto.unknown,
          ],
          [
            BloodGlucoseRelationToMeal.general,
            BloodGlucoseRelationToMealDto.general,
          ],
          [
            BloodGlucoseRelationToMeal.fasting,
            BloodGlucoseRelationToMealDto.fasting,
          ],
          [
            BloodGlucoseRelationToMeal.beforeMeal,
            BloodGlucoseRelationToMealDto.beforeMeal,
          ],
          [
            BloodGlucoseRelationToMeal.afterMeal,
            BloodGlucoseRelationToMealDto.afterMeal,
          ],
        ],
        (
          BloodGlucoseRelationToMeal domain,
          BloodGlucoseRelationToMealDto dto,
        ) {
          // When
          final actualDto = domain.toDto();
          final actualDomain = dto.toDomain();

          // Then
          expect(actualDto, dto);
          expect(actualDomain, domain);
        },
      );
    },
  );
}
