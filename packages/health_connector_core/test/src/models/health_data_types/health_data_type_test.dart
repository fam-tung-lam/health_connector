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
              HealthDataType.activeEnergyBurned,
              HealthDataType.activityIntensity,
              HealthDataType.exerciseTime,
              HealthDataType.moveTime,
              HealthDataType.standTime,
              HealthDataType.basalEnergyBurned,
              HealthDataType.crossCountrySkiingDistance,
              HealthDataType.cyclingPedalingCadence,
              HealthDataType.cyclingPedalingCadenceSeries,
              HealthDataType.cyclingPower,
              HealthDataType.distance,
              HealthDataType.downhillSnowSportsDistance,
              HealthDataType.elevationGained,
              HealthDataType.exerciseSession,
              HealthDataType.floorsClimbed,
              HealthDataType.paddleSportsDistance,
              HealthDataType.powerSeries,
              HealthDataType.rowingDistance,
              HealthDataType.runningPower,
              HealthDataType.skatingSportsDistance,
              HealthDataType.speedSeries,
              HealthDataType.steps,
              HealthDataType.stepsCadenceSeries,
              HealthDataType.swimmingDistance,
              HealthDataType.swimmingStrokes,
              HealthDataType.totalEnergyBurned,
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
              HealthDataType.walkingSteadiness,
              HealthDataType.runningSpeed,
              HealthDataType.sixMinuteWalkTestDistance,
              HealthDataType.stairAscentSpeed,
              HealthDataType.stairDescentSpeed,
              HealthDataType.walkingAsymmetryPercentage,
              HealthDataType.walkingDoubleSupportPercentage,
              HealthDataType.walkingSpeed,
              HealthDataType.walkingSteadinessEvent,
              HealthDataType.walkingStepLength,
            ],
          ],
          [
            HealthDataType.nutritionTypes.toList(),
            HealthDataTypeCategory.nutrition,
            <HealthDataType>[
              HealthDataType.alcoholicBeverages,
              HealthDataType.dietaryBiotin,
              HealthDataType.dietaryCaffeine,
              HealthDataType.dietaryCalcium,
              HealthDataType.dietaryCholesterol,
              HealthDataType.dietaryFiber,
              HealthDataType.dietaryEnergyConsumed,
              HealthDataType.dietaryFolate,
              HealthDataType.dietaryIron,
              HealthDataType.dietaryMagnesium,
              HealthDataType.dietaryManganese,
              HealthDataType.dietaryMonounsaturatedFat,
              HealthDataType.dietaryNiacin,
              HealthDataType.dietaryPantothenicAcid,
              HealthDataType.dietaryPhosphorus,
              HealthDataType.dietaryPolyunsaturatedFat,
              HealthDataType.dietaryPotassium,
              HealthDataType.dietaryProtein,
              HealthDataType.dietaryRiboflavin,
              HealthDataType.dietarySaturatedFat,
              HealthDataType.dietarySelenium,
              HealthDataType.dietarySodium,
              HealthDataType.dietarySugar,
              HealthDataType.dietaryThiamin,
              HealthDataType.dietaryTotalCarbohydrate,
              HealthDataType.dietaryTotalFat,
              HealthDataType.dietaryVitaminA,
              HealthDataType.dietaryVitaminB12,
              HealthDataType.dietaryVitaminB6,
              HealthDataType.dietaryVitaminC,
              HealthDataType.dietaryVitaminD,
              HealthDataType.dietaryVitaminE,
              HealthDataType.dietaryVitaminK,
              HealthDataType.dietaryZinc,
              HealthDataType.hydration,
              HealthDataType.nutrition,
            ],
          ],
          [
            HealthDataType.reproductiveHealthTypes.toList(),
            HealthDataTypeCategory.reproductiveHealth,
            <HealthDataType>[
              HealthDataType.basalBodyTemperature,
              HealthDataType.cervicalMucus,
              HealthDataType.contraceptive,
              HealthDataType.infrequentMenstrualCycleEvent,
              HealthDataType.intermenstrualBleeding,
              HealthDataType.irregularMenstrualCycleEvent,
              HealthDataType.lactation,
              HealthDataType.menstrualFlow,
              HealthDataType.menstrualFlowInstant,
              HealthDataType.ovulationTest,
              HealthDataType.persistentIntermenstrualBleedingEvent,
              HealthDataType.pregnancy,
              HealthDataType.pregnancyTest,
              HealthDataType.progesteroneTest,
              HealthDataType.prolongedMenstrualPeriodEvent,
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
              HealthDataType.atrialFibrillationBurden,
              HealthDataType.bloodAlcoholContent,
              HealthDataType.bloodGlucose,
              HealthDataType.bloodPressure,
              HealthDataType.bodyTemperature,
              HealthDataType.diastolicBloodPressure,
              HealthDataType.forcedVitalCapacity,
              HealthDataType.heartRate,
              HealthDataType.heartRateSeries,
              HealthDataType.heartRateVariabilityRMSSD,
              HealthDataType.heartRateVariabilitySDNN,
              HealthDataType.highHeartRateEvent,
              HealthDataType.irregularHeartRhythmEvent,
              HealthDataType.lowHeartRateEvent,
              HealthDataType.oxygenSaturation,
              HealthDataType.peripheralPerfusionIndex,
              HealthDataType.respiratoryRate,
              HealthDataType.restingHeartRate,
              HealthDataType.sleepingWristTemperature,
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
        [
          HealthDataType.atrialFibrillationBurden,
          'atrial_fibrillation_burden',
        ],
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
        [HealthDataType.activeEnergyBurned, 'active_calories_burned'],
        [HealthDataType.exerciseSession, 'exercise_session'],
        [HealthDataType.floorsClimbed, 'floors_climbed'],
        [HealthDataType.wheelchairPushes, 'wheelchair_pushes'],
        [HealthDataType.leanBodyMass, 'lean_body_mass'],
        [HealthDataType.hydration, 'hydration'],
        [HealthDataType.heartRateSeries, 'heart_rate_series'],
        [
          HealthDataType.heartRate,
          'heart_rate',
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
          HealthDataType.cyclingPedalingCadenceSeries,
          'cycling_pedaling_cadence_series',
        ],
        [
          HealthDataType.cyclingPedalingCadence,
          'cycling_pedaling_cadence',
        ],
        [HealthDataType.respiratoryRate, 'respiratory_rate'],
        [HealthDataType.vo2Max, 'vo2_max'],
        [HealthDataType.totalEnergyBurned, 'total_calories_burned'],
        [HealthDataType.basalEnergyBurned, 'basal_energy_burned'],
        [HealthDataType.nutrition, 'nutrition'],
        [HealthDataType.dietaryEnergyConsumed, 'dietary_energy_consumed'],
        [HealthDataType.dietaryCaffeine, 'dietary_caffeine'],
        [HealthDataType.dietaryProtein, 'dietary_protein'],
        [
          HealthDataType.dietaryTotalCarbohydrate,
          'dietary_total_carbohydrate',
        ],
        [HealthDataType.dietaryTotalFat, 'dietary_total_fat'],
        [HealthDataType.dietarySaturatedFat, 'dietary_saturated_fat'],
        [
          HealthDataType.dietaryMonounsaturatedFat,
          'dietary_monounsaturated_fat',
        ],
        [
          HealthDataType.dietaryPolyunsaturatedFat,
          'dietary_polyunsaturated_fat',
        ],
        [HealthDataType.dietaryCholesterol, 'dietary_cholesterol'],
        [HealthDataType.dietaryFiber, 'dietary_fiber'],
        [HealthDataType.dietarySugar, 'dietary_sugar'],
        [HealthDataType.dietaryCalcium, 'dietary_calcium'],
        [HealthDataType.dietaryIron, 'dietary_iron'],
        [HealthDataType.dietaryMagnesium, 'dietary_magnesium'],
        [HealthDataType.dietaryManganese, 'dietary_manganese'],
        [HealthDataType.dietaryPhosphorus, 'dietary_phosphorus'],
        [HealthDataType.dietaryPotassium, 'dietary_potassium'],
        [HealthDataType.dietarySelenium, 'dietary_selenium'],
        [HealthDataType.dietarySodium, 'dietary_sodium'],
        [HealthDataType.dietaryZinc, 'dietary_zinc'],
        [HealthDataType.dietaryVitaminA, 'dietary_vitamin_a'],
        [HealthDataType.dietaryVitaminB6, 'dietary_vitamin_b6'],
        [HealthDataType.dietaryVitaminB12, 'dietary_vitamin_b12'],
        [HealthDataType.dietaryVitaminC, 'dietary_vitamin_c'],
        [HealthDataType.dietaryVitaminD, 'dietary_vitamin_d'],
        [HealthDataType.dietaryVitaminE, 'dietary_vitamin_e'],
        [HealthDataType.dietaryVitaminK, 'dietary_vitamin_k'],
        [HealthDataType.dietaryThiamin, 'dietary_thiamin'],
        [HealthDataType.dietaryRiboflavin, 'dietary_riboflavin'],
        [HealthDataType.dietaryNiacin, 'dietary_niacin'],
        [HealthDataType.dietaryFolate, 'dietary_folate'],
        [HealthDataType.dietaryBiotin, 'dietary_biotin'],
        [HealthDataType.dietaryPantothenicAcid, 'dietary_pantothenic_acid'],
        [HealthDataType.walkingStepLength, 'walking_step_length'],
        [
          HealthDataType.walkingSteadinessEvent,
          'walking_steadiness_event',
        ],
        [
          HealthDataType.infrequentMenstrualCycleEvent,
          'infrequent_menstrual_cycle_event',
        ],
        [
          HealthDataType.irregularMenstrualCycleEvent,
          'irregular_menstrual_cycle_event',
        ],
      ],
      (HealthDataType type, String expectedKey) {
        expect(type.id, equals(expectedKey));
      },
    );
  });
}
