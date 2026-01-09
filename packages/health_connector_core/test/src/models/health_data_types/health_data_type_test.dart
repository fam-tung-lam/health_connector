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

  group('HealthDataType.id', () {
    parameterizedTest(
      'verify explicit id values',
      [
        [HealthDataType.distance, 'distance'],
        [HealthDataType.cyclingDistance, 'cycling_distance'],
        [HealthDataType.swimmingDistance, 'swimming_distance'],
        [HealthDataType.wheelchairDistance, 'wheelchair_distance'],
        [
          HealthDataType.downhillSnowSportsDistance,
          'downhill_snow_sports_distance',
        ],
        [HealthDataType.rowingDistance, 'rowing_distance'],
        [HealthDataType.paddleSportsDistance, 'paddle_sports_distance'],
        [
          HealthDataType.crossCountrySkiingDistance,
          'cross_country_skiing_distance',
        ],
        [HealthDataType.skatingSportsDistance, 'skating_sports_distance'],
        [
          HealthDataType.sixMinuteWalkTestDistance,
          'six_minute_walk_test_distance',
        ],
        [HealthDataType.walkingRunningDistance, 'walking_running_distance'],
        [HealthDataType.speedSeries, 'speed_series'],
        [HealthDataType.walkingSpeed, 'walking_speed'],
        [HealthDataType.runningSpeed, 'running_speed'],
        [HealthDataType.stairAscentSpeed, 'stair_ascent_speed'],
        [HealthDataType.stairDescentSpeed, 'stair_descent_speed'],
        [HealthDataType.steps, 'steps'],
        [HealthDataType.weight, 'weight'],
        [HealthDataType.bloodGlucose, 'blood_glucose'],
        [HealthDataType.bloodPressure, 'blood_pressure'],
        [HealthDataType.systolicBloodPressure, 'systolic_blood_pressure'],
        [HealthDataType.diastolicBloodPressure, 'diastolic_blood_pressure'],
        [HealthDataType.bodyFatPercentage, 'body_fat_percentage'],
        [HealthDataType.bodyTemperature, 'body_temperature'],
        [HealthDataType.basalBodyTemperature, 'basal_body_temperature'],
        [HealthDataType.boneMass, 'bone_mass'],
        [HealthDataType.bodyWaterMass, 'body_water_mass'],
        [
          HealthDataType.heartRateVariabilityRMSSD,
          'heart_rate_variability_rmssd',
        ],
        [
          HealthDataType.heartRateVariabilitySDNN,
          'heart_rate_variability_sdnn',
        ],
        [HealthDataType.bodyMassIndex, 'body_mass_index'],
        [HealthDataType.waistCircumference, 'waist_circumference'],
        [HealthDataType.cervicalMucus, 'cervical_mucus'],
        [HealthDataType.height, 'height'],
        [HealthDataType.activeCaloriesBurned, 'active_calories_burned'],
        [HealthDataType.exerciseSession, 'exercise_session'],
        [HealthDataType.floorsClimbed, 'floors_climbed'],
        [HealthDataType.wheelchairPushes, 'wheelchair_pushes'],
        [HealthDataType.leanBodyMass, 'lean_body_mass'],
        [HealthDataType.hydration, 'hydration'],
        [HealthDataType.heartRateSeriesRecord, 'heart_rate_series_record'],
        [
          HealthDataType.heartRateMeasurementRecord,
          'heart_rate_measurement_record',
        ],
        [HealthDataType.sleepSession, 'sleep_session'],
        [HealthDataType.sleepStageRecord, 'sleep_stage'],
        [HealthDataType.mindfulnessSession, 'mindfulness_session'],
        [HealthDataType.sexualActivity, 'sexual_activity'],
        [HealthDataType.restingHeartRate, 'resting_heart_rate'],
        [HealthDataType.ovulationTest, 'ovulation_test'],
        [HealthDataType.intermenstrualBleeding, 'intermenstrual_bleeding'],
        [HealthDataType.menstrualFlowInstant, 'menstrual_flow_instant'],
        [HealthDataType.menstrualFlow, 'menstrual_flow'],
        [HealthDataType.oxygenSaturation, 'oxygen_saturation'],
        [HealthDataType.powerSeries, 'power_series'],
        [HealthDataType.cyclingPower, 'cycling_power'],
        [
          HealthDataType.cyclingPedalingCadenceSeriesRecord,
          'cycling_pedaling_cadence_series_record',
        ],
        [
          HealthDataType.cyclingPedalingCadenceMeasurementRecord,
          'cycling_pedaling_cadence_measurement_record',
        ],
        [HealthDataType.respiratoryRate, 'respiratory_rate'],
        [HealthDataType.vo2Max, 'vo2_max'],
        [HealthDataType.nutrition, 'nutrition'],
        [HealthDataType.energyNutrient, 'energy_nutrient'],
        [HealthDataType.totalCaloriesBurned, 'total_calories_burned'],
        [HealthDataType.basalEnergyBurned, 'basal_energy_burned'],
        [HealthDataType.caffeine, 'caffeine_nutrient'],
        [HealthDataType.protein, 'protein_nutrient'],
        [HealthDataType.totalCarbohydrate, 'total_carbohydrate_nutrient'],
        [HealthDataType.totalFat, 'total_fat_nutrient'],
        [HealthDataType.saturatedFat, 'saturated_fat_nutrient'],
        [HealthDataType.monounsaturatedFat, 'monounsaturated_fat_nutrient'],
        [HealthDataType.polyunsaturatedFat, 'polyunsaturated_fat_nutrient'],
        [HealthDataType.cholesterol, 'cholesterol_nutrient'],
        [HealthDataType.dietaryFiber, 'dietary_fiber_nutrient'],
        [HealthDataType.sugar, 'sugar_nutrient'],
        [HealthDataType.calcium, 'calcium_nutrient'],
        [HealthDataType.iron, 'iron_nutrient'],
        [HealthDataType.magnesium, 'magnesium_nutrient'],
        [HealthDataType.manganese, 'manganese_nutrient'],
        [HealthDataType.phosphorus, 'phosphorus_nutrient'],
        [HealthDataType.potassium, 'potassium_nutrient'],
        [HealthDataType.selenium, 'selenium_nutrient'],
        [HealthDataType.sodium, 'sodium_nutrient'],
        [HealthDataType.zinc, 'zinc_nutrient'],
        [HealthDataType.vitaminA, 'vitamin_a_nutrient'],
        [HealthDataType.vitaminB6, 'vitamin_b6_nutrient'],
        [HealthDataType.vitaminB12, 'vitamin_b12_nutrient'],
        [HealthDataType.vitaminC, 'vitamin_c_nutrient'],
        [HealthDataType.vitaminD, 'vitamin_d_nutrient'],
        [HealthDataType.vitaminE, 'vitamin_e_nutrient'],
        [HealthDataType.vitaminK, 'vitamin_k_nutrient'],
        [HealthDataType.thiamin, 'thiamin_nutrient'],
        [HealthDataType.riboflavin, 'riboflavin_nutrient'],
        [HealthDataType.niacin, 'niacin_nutrient'],
        [HealthDataType.folate, 'folate_nutrient'],
        [HealthDataType.biotin, 'biotin_nutrient'],
        [HealthDataType.pantothenicAcid, 'pantothenic_acid_nutrient'],
      ],
      (HealthDataType type, String expectedKey) {
        expect(type.id, equals(expectedKey));
      },
    );
  });
}
