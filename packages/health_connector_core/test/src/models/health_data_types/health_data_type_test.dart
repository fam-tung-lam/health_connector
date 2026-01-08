import 'package:health_connector_core/health_connector_core.dart';
import 'package:parameterized_test/parameterized_test.dart';
import 'package:test/test.dart';

void main() {
  group(
    'HealthDataType Category Getters',
    () {
      parameterizedTest(
        'returns only data types for specific category',
        [
          [
            HealthDataType.activityTypes.toList(),
            HealthDataTypeCategory.activity,
            <HealthDataType>[
              HealthDataType.activeCaloriesBurned,
              HealthDataType.basalEnergyBurned,
              HealthDataType.crossCountrySkiingDistance,
              HealthDataType.cyclingPedalingCadenceMeasurementRecord,
              HealthDataType.cyclingPedalingCadenceSeriesRecord,
              HealthDataType.cyclingPower,
              HealthDataType.distance,
              HealthDataType.downhillSnowSportsDistance,
              HealthDataType.exerciseSession,
              HealthDataType.floorsClimbed,
              HealthDataType.paddleSportsDistance,
              HealthDataType.powerSeries,
              HealthDataType.rowingDistance,
              HealthDataType.skatingSportsDistance,
              HealthDataType.speedSeries,
              HealthDataType.steps,
              HealthDataType.swimmingDistance,
              HealthDataType.totalCaloriesBurned,
              HealthDataType.walkingRunningDistance,
              HealthDataType.wheelchairDistance,
              HealthDataType.wheelchairPushes,
            ],
          ],
          [
            HealthDataType.bodyMeasurementTypes.toList(),
            HealthDataTypeCategory.bodyMeasurement,
            <HealthDataType>[
              HealthDataType.bodyWaterMass,
              HealthDataType.boneMass,
              HealthDataType.bodyMassIndex,
              HealthDataType.bodyFatPercentage,
              HealthDataType.height,
              HealthDataType.leanBodyMass,
              HealthDataType.waistCircumference,
              HealthDataType.weight,
            ],
          ],
          [
            HealthDataType.clinicalTypes.toList(),
            HealthDataTypeCategory.clinical,
            <HealthDataType>[],
          ],
          [
            HealthDataType.mentalHealthTypes.toList(),
            HealthDataTypeCategory.mentalHealth,
            <HealthDataType>[HealthDataType.mindfulnessSession],
          ],
          [
            HealthDataType.mobilityTypes.toList(),
            HealthDataTypeCategory.mobility,
            <HealthDataType>[
              HealthDataType.runningSpeed,
              HealthDataType.sixMinuteWalkTestDistance,
              HealthDataType.stairAscentSpeed,
              HealthDataType.stairDescentSpeed,
              HealthDataType.walkingSpeed,
            ],
          ],
          [
            HealthDataType.nutritionTypes.toList(),
            HealthDataTypeCategory.nutrition,
            <HealthDataType>[
              HealthDataType.biotin,
              HealthDataType.caffeine,
              HealthDataType.calcium,
              HealthDataType.cholesterol,
              HealthDataType.dietaryFiber,
              HealthDataType.energyNutrient,
              HealthDataType.folate,
              HealthDataType.hydration,
              HealthDataType.iron,
              HealthDataType.magnesium,
              HealthDataType.manganese,
              HealthDataType.monounsaturatedFat,
              HealthDataType.niacin,
              HealthDataType.nutrition,
              HealthDataType.pantothenicAcid,
              HealthDataType.phosphorus,
              HealthDataType.polyunsaturatedFat,
              HealthDataType.potassium,
              HealthDataType.protein,
              HealthDataType.riboflavin,
              HealthDataType.saturatedFat,
              HealthDataType.selenium,
              HealthDataType.sodium,
              HealthDataType.sugar,
              HealthDataType.thiamin,
              HealthDataType.totalCarbohydrate,
              HealthDataType.totalFat,
              HealthDataType.vitaminA,
              HealthDataType.vitaminB12,
              HealthDataType.vitaminB6,
              HealthDataType.vitaminC,
              HealthDataType.vitaminD,
              HealthDataType.vitaminE,
              HealthDataType.vitaminK,
              HealthDataType.zinc,
            ],
          ],
          [
            HealthDataType.reproductiveHealthTypes.toList(),
            HealthDataTypeCategory.reproductiveHealth,
            <HealthDataType>[
              HealthDataType.basalBodyTemperature,
              HealthDataType.cervicalMucus,
              HealthDataType.intermenstrualBleeding,
              HealthDataType.menstrualFlow,
              HealthDataType.menstrualFlowInstant,
              HealthDataType.ovulationTest,
              HealthDataType.sexualActivity,
            ],
          ],
          [
            HealthDataType.sleepTypes.toList(),
            HealthDataTypeCategory.sleep,
            <HealthDataType>[
              HealthDataType.sleepSession,
              HealthDataType.sleepStageRecord,
            ],
          ],
          [
            HealthDataType.vitalsTypes.toList(),
            HealthDataTypeCategory.vitals,
            <HealthDataType>[
              HealthDataType.bloodGlucose,
              HealthDataType.bloodPressure,
              HealthDataType.bodyTemperature,
              HealthDataType.diastolicBloodPressure,
              HealthDataType.heartRateMeasurementRecord,
              HealthDataType.heartRateSeriesRecord,
              HealthDataType.heartRateVariabilityRMSSD,
              HealthDataType.heartRateVariabilitySDNN,
              HealthDataType.oxygenSaturation,
              HealthDataType.respiratoryRate,
              HealthDataType.restingHeartRate,
              HealthDataType.systolicBloodPressure,
              HealthDataType.vo2Max,
            ],
          ],
        ],
        (
          List<HealthDataType> dataTypes,
          HealthDataTypeCategory expectedCategory,
          List<HealthDataType> expectedDataTypes,
        ) {
          for (final dataType in dataTypes) {
            expect(
              dataType.category,
              equals(expectedCategory),
              reason: '$dataType should be in $expectedCategory category',
            );
          }

          expect(
            dataTypes,
            equals(expectedDataTypes),
            reason: '$expectedCategory should contain all expected data types',
          );
        },
      );

      test('all data types are categorized', () {
        final allDataTypes = HealthDataType.values.toSet();
        final categorizedTypes = <HealthDataType>{};

        categorizedTypes.addAll(HealthDataType.activityTypes);
        categorizedTypes.addAll(HealthDataType.bodyMeasurementTypes);
        categorizedTypes.addAll(HealthDataType.clinicalTypes);
        categorizedTypes.addAll(HealthDataType.mentalHealthTypes);
        categorizedTypes.addAll(HealthDataType.mobilityTypes);
        categorizedTypes.addAll(HealthDataType.nutritionTypes);
        categorizedTypes.addAll(HealthDataType.reproductiveHealthTypes);
        categorizedTypes.addAll(HealthDataType.sleepTypes);
        categorizedTypes.addAll(HealthDataType.vitalsTypes);

        expect(
          categorizedTypes,
          equals(allDataTypes),
          reason: 'Every data type should be assigned to exactly one category',
        );
      });
    },
  );
}
