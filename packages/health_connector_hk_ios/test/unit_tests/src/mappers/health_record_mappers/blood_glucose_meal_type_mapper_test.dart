import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/blood_glucose/blood_glucose_meal_type_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';

void main() {
  group('BloodGlucoseMealTypeMapper', () {
    group('toDto', () {
      test('converts all values correctly', () {
        expect(
          BloodGlucoseMealType.unknown.toDto(),
          MealTypeDto.unknown,
        );
        expect(
          BloodGlucoseMealType.breakfast.toDto(),
          MealTypeDto.breakfast,
        );
        expect(
          BloodGlucoseMealType.lunch.toDto(),
          MealTypeDto.lunch,
        );
        expect(
          BloodGlucoseMealType.dinner.toDto(),
          MealTypeDto.dinner,
        );
        expect(
          BloodGlucoseMealType.snack.toDto(),
          MealTypeDto.snack,
        );
      });
    });

    group('toBloodGlucoseMealType', () {
      test('converts all values correctly', () {
        expect(
          MealTypeDto.unknown.toBloodGlucoseMealType(),
          BloodGlucoseMealType.unknown,
        );
        expect(
          MealTypeDto.breakfast.toBloodGlucoseMealType(),
          BloodGlucoseMealType.breakfast,
        );
        expect(
          MealTypeDto.lunch.toBloodGlucoseMealType(),
          BloodGlucoseMealType.lunch,
        );
        expect(
          MealTypeDto.dinner.toBloodGlucoseMealType(),
          BloodGlucoseMealType.dinner,
        );
        expect(
          MealTypeDto.snack.toBloodGlucoseMealType(),
          BloodGlucoseMealType.snack,
        );
      });
    });
  });
}
