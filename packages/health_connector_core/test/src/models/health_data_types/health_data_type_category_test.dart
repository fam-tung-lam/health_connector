import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group(
    'HealthDataTypeCategory',
    () {
      test('enum values match expected categories', () {
        expect(HealthDataTypeCategory.values, hasLength(9));
        expect(
          HealthDataTypeCategory.values,
          contains(HealthDataTypeCategory.activity),
        );
        expect(
          HealthDataTypeCategory.values,
          contains(HealthDataTypeCategory.bodyMeasurement),
        );
        expect(
          HealthDataTypeCategory.values,
          contains(HealthDataTypeCategory.clinical),
        );
        expect(
          HealthDataTypeCategory.values,
          contains(HealthDataTypeCategory.mentalHealth),
        );
        expect(
          HealthDataTypeCategory.values,
          contains(HealthDataTypeCategory.mobility),
        );
        expect(
          HealthDataTypeCategory.values,
          contains(HealthDataTypeCategory.nutrition),
        );
        expect(
          HealthDataTypeCategory.values,
          contains(HealthDataTypeCategory.reproductiveHealth),
        );
        expect(
          HealthDataTypeCategory.values,
          contains(HealthDataTypeCategory.sleep),
        );
        expect(
          HealthDataTypeCategory.values,
          contains(HealthDataTypeCategory.vitals),
        );
      });

      test('toString returns correct string representation', () {
        expect(
          HealthDataTypeCategory.activity.toString(),
          'HealthDataTypeCategory.activity',
        );
        expect(
          HealthDataTypeCategory.bodyMeasurement.toString(),
          'HealthDataTypeCategory.bodyMeasurement',
        );
        expect(
          HealthDataTypeCategory.clinical.toString(),
          'HealthDataTypeCategory.clinical',
        );
        expect(
          HealthDataTypeCategory.mentalHealth.toString(),
          'HealthDataTypeCategory.mentalHealth',
        );
        expect(
          HealthDataTypeCategory.mobility.toString(),
          'HealthDataTypeCategory.mobility',
        );
        expect(
          HealthDataTypeCategory.nutrition.toString(),
          'HealthDataTypeCategory.nutrition',
        );
        expect(
          HealthDataTypeCategory.reproductiveHealth.toString(),
          'HealthDataTypeCategory.reproductiveHealth',
        );
        expect(
          HealthDataTypeCategory.sleep.toString(),
          'HealthDataTypeCategory.sleep',
        );
        expect(
          HealthDataTypeCategory.vitals.toString(),
          'HealthDataTypeCategory.vitals',
        );
      });

      test('enum equality works correctly', () {
        expect(
          HealthDataTypeCategory.activity,
          equals(HealthDataTypeCategory.activity),
        );
        expect(
          HealthDataTypeCategory.bodyMeasurement,
          isNot(equals(HealthDataTypeCategory.activity)),
        );
      });
    },
  );
}
