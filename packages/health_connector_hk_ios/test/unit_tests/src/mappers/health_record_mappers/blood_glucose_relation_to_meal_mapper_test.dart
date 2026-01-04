import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/blood_glucose/blood_glucose_relation_to_meal_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
import 'package:test/test.dart';

void main() {
  group('BloodGlucoseRelationToMealMapper', () {
    group('toDto', () {
      test('converts all values correctly', () {
        expect(
          BloodGlucoseRelationToMeal.unknown.toDto(),
          BloodGlucoseRelationToMealDto.unknown,
        );
        expect(
          BloodGlucoseRelationToMeal.general.toDto(),
          BloodGlucoseRelationToMealDto.general,
        );
        expect(
          BloodGlucoseRelationToMeal.fasting.toDto(),
          BloodGlucoseRelationToMealDto.fasting,
        );
        expect(
          BloodGlucoseRelationToMeal.beforeMeal.toDto(),
          BloodGlucoseRelationToMealDto.beforeMeal,
        );
        expect(
          BloodGlucoseRelationToMeal.afterMeal.toDto(),
          BloodGlucoseRelationToMealDto.afterMeal,
        );
      });
    });

    group('toDomain', () {
      test('converts all values correctly', () {
        expect(
          BloodGlucoseRelationToMealDto.unknown.toDomain(),
          BloodGlucoseRelationToMeal.unknown,
        );
        expect(
          BloodGlucoseRelationToMealDto.general.toDomain(),
          BloodGlucoseRelationToMeal.general,
        );
        expect(
          BloodGlucoseRelationToMealDto.fasting.toDomain(),
          BloodGlucoseRelationToMeal.fasting,
        );
        expect(
          BloodGlucoseRelationToMealDto.beforeMeal.toDomain(),
          BloodGlucoseRelationToMeal.beforeMeal,
        );
        expect(
          BloodGlucoseRelationToMealDto.afterMeal.toDomain(),
          BloodGlucoseRelationToMeal.afterMeal,
        );
      });
    });
  });
}
