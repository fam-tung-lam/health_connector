import 'package:health_connector_core/health_connector_core.dart';
import 'package:health_connector_core/src/utils/double_to_measurement_unit_extension.dart';
import 'package:parameterized_test/parameterized_test.dart';
import 'package:test/test.dart';

void main() {
  group('DoubleToMeasurementUnit', () {
    group('Energy types', () {
      parameterizedTest(
        'converts energy data types to kilocalories',
        [
          [100.0, HealthDataType.activeEnergyBurned],
          [50.5, HealthDataType.basalEnergyBurned],
          [150.75, HealthDataType.totalEnergyBurned],
          [2000.0, HealthDataType.dietaryEnergyConsumed],
        ],
        (double value, HealthDataType dataType) {
          expect(
            value.toMeasurementUnit(dataType),
            equals(Energy.kilocalories(value)),
          );
        },
      );
    });

    group('Distance/Length types', () {
      parameterizedTest(
        'converts distance/length data types to meters',
        [
          [1000.0, HealthDataType.distance],
          [5000.0, HealthDataType.crossCountrySkiingDistance],
          [20000.0, HealthDataType.cyclingDistance],
          [3000.0, HealthDataType.downhillSnowSportsDistance],
          [500.0, HealthDataType.elevationGained],
          [1.75, HealthDataType.height],
          [2500.0, HealthDataType.paddleSportsDistance],
          [5000.0, HealthDataType.rowingDistance],
          [1.2, HealthDataType.runningStrideLength],
          [450.0, HealthDataType.sixMinuteWalkTestDistance],
          [8000.0, HealthDataType.skatingSportsDistance],
          [1500.0, HealthDataType.swimmingDistance],
          [0.85, HealthDataType.waistCircumference],
          [10000.0, HealthDataType.walkingRunningDistance],
          [0.75, HealthDataType.walkingStepLength],
          [3000.0, HealthDataType.wheelchairDistance],
        ],
        (double value, HealthDataType dataType) {
          expect(
            value.toMeasurementUnit(dataType),
            equals(Length.meters(value)),
          );
        },
      );
    });

    group('Body mass types', () {
      parameterizedTest(
        'converts body mass data types to kilograms',
        [
          [70.5, HealthDataType.weight],
          [55.2, HealthDataType.leanBodyMass],
          [42.0, HealthDataType.bodyWaterMass],
        ],
        (double value, HealthDataType dataType) {
          expect(
            value.toMeasurementUnit(dataType),
            equals(Mass.kilograms(value)),
          );
        },
      );
    });

    group('Nutrition mass types', () {
      parameterizedTest(
        'converts nutrition data types to grams',
        [
          [0.00003, HealthDataType.dietaryBiotin],
          [0.1, HealthDataType.dietaryCaffeine],
          [1.2, HealthDataType.dietaryCalcium],
          [0.3, HealthDataType.dietaryCholesterol],
          [30.0, HealthDataType.dietaryFiber],
          [0.0004, HealthDataType.dietaryFolate],
          [0.018, HealthDataType.dietaryIron],
          [0.4, HealthDataType.dietaryMagnesium],
          [0.002, HealthDataType.dietaryManganese],
          [15.0, HealthDataType.dietaryMonounsaturatedFat],
          [0.016, HealthDataType.dietaryNiacin],
          [0.005, HealthDataType.dietaryPantothenicAcid],
          [1.25, HealthDataType.dietaryPhosphorus],
          [10.0, HealthDataType.dietaryPolyunsaturatedFat],
          [3.5, HealthDataType.dietaryPotassium],
          [25.5, HealthDataType.dietaryProtein],
          [0.0013, HealthDataType.dietaryRiboflavin],
          [20.0, HealthDataType.dietarySaturatedFat],
          [0.000055, HealthDataType.dietarySelenium],
          [2.3, HealthDataType.dietarySodium],
          [50.0, HealthDataType.dietarySugar],
          [0.0012, HealthDataType.dietaryThiamin],
          [150.0, HealthDataType.dietaryTotalCarbohydrate],
          [65.0, HealthDataType.dietaryTotalFat],
          [0.0009, HealthDataType.dietaryVitaminA],
          [0.0017, HealthDataType.dietaryVitaminB6],
          [0.0000024, HealthDataType.dietaryVitaminB12],
          [0.09, HealthDataType.dietaryVitaminC],
          [0.00002, HealthDataType.dietaryVitaminD],
          [0.015, HealthDataType.dietaryVitaminE],
          [0.00012, HealthDataType.dietaryVitaminK],
          [0.011, HealthDataType.dietaryZinc],
        ],
        (double value, HealthDataType dataType) {
          expect(
            value.toMeasurementUnit(dataType),
            equals(Mass.grams(value)),
          );
        },
      );
    });

    group('Volume types', () {
      parameterizedTest(
        'converts volume data types to liters',
        [
          [2.5, HealthDataType.hydration],
          [3.8, HealthDataType.forcedExpiratoryVolume],
          [4.5, HealthDataType.forcedVitalCapacity],
        ],
        (double value, HealthDataType dataType) {
          expect(
            value.toMeasurementUnit(dataType),
            equals(Volume.liters(value)),
          );
        },
      );
    });

    group('Percentage types', () {
      parameterizedTest(
        'converts percentage data types using decimal format',
        [
          [0.12, HealthDataType.atrialFibrillationBurden],
          [0.08, HealthDataType.bloodAlcoholContent],
          [0.98, HealthDataType.oxygenSaturation],
          [0.85, HealthDataType.peripheralPerfusionIndex],
          [0.05, HealthDataType.walkingAsymmetryPercentage],
          [0.30, HealthDataType.walkingDoubleSupportPercentage],
          [0.75, HealthDataType.walkingSteadiness],
        ],
        (double value, HealthDataType dataType) {
          expect(
            value.toMeasurementUnit(dataType),
            equals(Percentage.fromDecimal(value)),
          );
        },
      );
    });

    group('Frequency types', () {
      parameterizedTest(
        'converts frequency data types to perMinute',
        [
          [90.0, HealthDataType.cyclingPedalingCadence],
          [85.0, HealthDataType.cyclingPedalingCadenceSeries],
          [72.0, HealthDataType.heartRate],
          [20.0, HealthDataType.heartRateRecoveryOneMinute],
          [75.0, HealthDataType.heartRateSeries],
          [60.0, HealthDataType.restingHeartRate],
          [95.0, HealthDataType.walkingHeartRateAverage],
          [16.0, HealthDataType.respiratoryRate],
          [180.0, HealthDataType.stepsCadenceSeries],
        ],
        (double value, HealthDataType dataType) {
          expect(
            value.toMeasurementUnit(dataType),
            equals(Frequency.perMinute(value)),
          );
        },
      );
    });

    group('Blood pressure types', () {
      parameterizedTest(
        'converts blood pressure data types to mmHg',
        [
          [120.0, HealthDataType.bloodPressure],
          [120.0, HealthDataType.systolicBloodPressure],
          [80.0, HealthDataType.diastolicBloodPressure],
        ],
        (double value, HealthDataType dataType) {
          expect(
            value.toMeasurementUnit(dataType),
            equals(Pressure.millimetersOfMercury(value)),
          );
        },
      );
    });

    group('Temperature types', () {
      parameterizedTest(
        'converts temperature data types to celsius',
        [
          [35.5, HealthDataType.sleepingWristTemperature],
        ],
        (double value, HealthDataType dataType) {
          expect(
            value.toMeasurementUnit(dataType),
            equals(Temperature.celsius(value)),
          );
        },
      );
    });

    group('Blood glucose types', () {
      parameterizedTest(
        'converts blood glucose data types to millimolesPerLiter',
        [
          [5.5, HealthDataType.bloodGlucose],
        ],
        (double value, HealthDataType dataType) {
          expect(
            value.toMeasurementUnit(dataType),
            equals(BloodGlucose.millimolesPerLiter(value)),
          );
        },
      );
    });

    group('Power types', () {
      parameterizedTest(
        'converts power data types to watts',
        [
          [250.0, HealthDataType.powerSeries],
          [200.0, HealthDataType.cyclingPower],
          [300.0, HealthDataType.runningPower],
        ],
        (double value, HealthDataType dataType) {
          expect(
            value.toMeasurementUnit(dataType),
            equals(Power.watts(value)),
          );
        },
      );
    });

    group('Velocity types', () {
      parameterizedTest(
        'converts velocity data types to metersPerSecond',
        [
          [3.5, HealthDataType.runningSpeed],
          [5.5, HealthDataType.speedSeries],
          [0.5, HealthDataType.stairAscentSpeed],
          [0.6, HealthDataType.stairDescentSpeed],
          [1.4, HealthDataType.walkingSpeed],
        ],
        (double value, HealthDataType dataType) {
          expect(
            value.toMeasurementUnit(dataType),
            equals(Velocity.metersPerSecond(value)),
          );
        },
      );
    });

    group('Time duration types', () {
      parameterizedTest(
        'converts time duration data types to seconds',
        [
          [1200.0, HealthDataType.activityIntensity],
          [3600.0, HealthDataType.exerciseTime],
          [45.0, HealthDataType.heartRateVariabilitySDNN],
          [1800.0, HealthDataType.moveTime],
          [0.25, HealthDataType.runningGroundContactTime],
          [600.0, HealthDataType.standTime],
          [3600.0, HealthDataType.exerciseSession],
          [900.0, HealthDataType.mindfulnessSession],
          [28800.0, HealthDataType.sleepSession],
          [5400.0, HealthDataType.sleepStageRecord],
        ],
        (double value, HealthDataType dataType) {
          expect(
            value.toMeasurementUnit(dataType),
            equals(TimeDuration.seconds(value)),
          );
        },
      );
    });

    group('Number types', () {
      parameterizedTest(
        'converts number data types to Number',
        [
          [2.0, HealthDataType.alcoholicBeverages],
          [22.5, HealthDataType.bodyMassIndex],
          [0.5, HealthDataType.electrodermalActivity],
          [10000.0, HealthDataType.steps],
          [15.0, HealthDataType.floorsClimbed],
          [3.0, HealthDataType.inhalerUsage],
          [10.5, HealthDataType.insulinDelivery],
          [2.0, HealthDataType.numberOfTimesFallen],
          [1200.0, HealthDataType.swimmingStrokes],
          [45.5, HealthDataType.vo2Max],
          [50.0, HealthDataType.wheelchairPushes],
        ],
        (double value, HealthDataType dataType) {
          expect(
            value.toMeasurementUnit(dataType),
            equals(Number(value)),
          );
        },
      );
    });

    group('Edge cases', () {
      parameterizedTest(
        'handles edge case values',
        [
          [0.0, HealthDataType.steps, const Number(0.0)],
          [1000000.0, HealthDataType.steps, const Number(1000000.0)],
          [
            0.123456789,
            HealthDataType.oxygenSaturation,
            const Percentage.fromDecimal(0.123456789),
          ],
        ],
        (double value, HealthDataType dataType, MeasurementUnit expected) {
          expect(
            value.toMeasurementUnit(dataType),
            equals(expected),
          );
        },
      );
    });

    group('Non-aggregatable types', () {
      group('Event types', () {
        parameterizedTest(
          'throws ArgumentError for event data types',
          [
            HealthDataType.highHeartRateEvent,
            HealthDataType.infrequentMenstrualCycleEvent,
            HealthDataType.irregularHeartRhythmEvent,
            HealthDataType.irregularMenstrualCycleEvent,
            HealthDataType.lowHeartRateEvent,
            HealthDataType.persistentIntermenstrualBleedingEvent,
            HealthDataType.prolongedMenstrualPeriodEvent,
            HealthDataType.walkingSteadinessEvent,
          ],
          (HealthDataType dataType) {
            expect(
              () => 100.0.toMeasurementUnit(dataType),
              throwsArgumentError,
            );
          },
        );
      });

      group('Categorical types', () {
        parameterizedTest(
          'throws ArgumentError for categorical data types',
          [
            HealthDataType.cervicalMucus,
            HealthDataType.contraceptive,
            HealthDataType.intermenstrualBleeding,
            HealthDataType.lactation,
            HealthDataType.menstrualFlow,
            HealthDataType.menstrualFlowInstant,
            HealthDataType.ovulationTest,
            HealthDataType.pregnancy,
            HealthDataType.pregnancyTest,
            HealthDataType.progesteroneTest,
            HealthDataType.sexualActivity,
          ],
          (HealthDataType dataType) {
            expect(
              () => 100.0.toMeasurementUnit(dataType),
              throwsArgumentError,
            );
          },
        );
      });

      group('Non-aggregatable measurement types', () {
        parameterizedTest(
          'throws ArgumentError for non-aggregatable measurement data types',
          [
            HealthDataType.basalBodyTemperature,
            HealthDataType.bodyFatPercentage,
            HealthDataType.bodyTemperature,
            HealthDataType.boneMass,
            HealthDataType.heartRateVariabilityRMSSD,
            HealthDataType.nutrition,
          ],
          (HealthDataType dataType) {
            expect(
              () => 100.0.toMeasurementUnit(dataType),
              throwsArgumentError,
            );
          },
        );
      });

      test('error message includes data type', () {
        expect(
          () => 100.0.toMeasurementUnit(HealthDataType.cervicalMucus),
          throwsA(
            isA<ArgumentError>().having(
              (e) => e.message,
              'message',
              contains('cervical_mucus'),
            ),
          ),
        );
      });
    });
  });
}
