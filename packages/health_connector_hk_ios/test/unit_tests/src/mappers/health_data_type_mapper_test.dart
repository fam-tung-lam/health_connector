import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/health_data_type_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
import 'package:parameterized_test/parameterized_test.dart';

void main() {
  group(
    'HealthDataTypeMappers',
    () {
      group(
        'HealthDataTypeDtoToDomain',
        () {
          parameterizedTest(
            'maps HealthDataTypeDto to HealthDataType',
            [
              [
                HealthDataTypeDto.activeCaloriesBurned,
                HealthDataType.activeCaloriesBurned,
              ],
              [
                HealthDataTypeDto.basalEnergyBurned,
                HealthDataType.basalEnergyBurned,
              ],
              [
                HealthDataTypeDto.walkingRunningDistance,
                HealthDataType.walkingRunningDistance,
              ],
              [HealthDataTypeDto.floorsClimbed, HealthDataType.floorsClimbed],
              [HealthDataTypeDto.height, HealthDataType.height],
              [HealthDataTypeDto.hydration, HealthDataType.hydration],
              [HealthDataTypeDto.leanBodyMass, HealthDataType.leanBodyMass],
              [
                HealthDataTypeDto.bodyFatPercentage,
                HealthDataType.bodyFatPercentage,
              ],
              [
                HealthDataTypeDto.bodyTemperature,
                HealthDataType.bodyTemperature,
              ],
              [HealthDataTypeDto.bodyMassIndex, HealthDataType.bodyMassIndex],
              [
                HealthDataTypeDto.basalBodyTemperature,
                HealthDataType.basalBodyTemperature,
              ],
              [HealthDataTypeDto.cervicalMucus, HealthDataType.cervicalMucus],
              [HealthDataTypeDto.steps, HealthDataType.steps],
              [HealthDataTypeDto.weight, HealthDataType.weight],
              [
                HealthDataTypeDto.waistCircumference,
                HealthDataType.waistCircumference,
              ],
              [
                HealthDataTypeDto.wheelchairPushes,
                HealthDataType.wheelchairPushes,
              ],
              [
                HealthDataTypeDto.heartRateMeasurementRecord,
                HealthDataType.heartRateMeasurementRecord,
              ],
              [
                HealthDataTypeDto.heartRateVariabilitySDNN,
                HealthDataType.heartRateVariabilitySDNN,
              ],
              [
                HealthDataTypeDto.cyclingPedalingCadenceMeasurementRecord,
                HealthDataType.cyclingPedalingCadenceMeasurementRecord,
              ],
              [
                HealthDataTypeDto.sleepStageRecord,
                HealthDataType.sleepStageRecord,
              ],
              [HealthDataTypeDto.sexualActivity, HealthDataType.sexualActivity],
              [HealthDataTypeDto.bloodPressure, HealthDataType.bloodPressure],
              [
                HealthDataTypeDto.systolicBloodPressure,
                HealthDataType.systolicBloodPressure,
              ],
              [
                HealthDataTypeDto.diastolicBloodPressure,
                HealthDataType.diastolicBloodPressure,
              ],
              [
                HealthDataTypeDto.restingHeartRate,
                HealthDataType.restingHeartRate,
              ],
              [HealthDataTypeDto.ovulationTest, HealthDataType.ovulationTest],
              [
                HealthDataTypeDto.intermenstrualBleeding,
                HealthDataType.intermenstrualBleeding,
              ],
              [HealthDataTypeDto.menstrualFlow, HealthDataType.menstrualFlow],
              [
                HealthDataTypeDto.oxygenSaturation,
                HealthDataType.oxygenSaturation,
              ],
              [
                HealthDataTypeDto.respiratoryRate,
                HealthDataType.respiratoryRate,
              ],
              [HealthDataTypeDto.bloodGlucose, HealthDataType.bloodGlucose],
              [HealthDataTypeDto.vo2Max, HealthDataType.vo2Max],
              [
                HealthDataTypeDto.cyclingDistance,
                HealthDataType.cyclingDistance,
              ],
              [HealthDataTypeDto.cyclingPower, HealthDataType.cyclingPower],
              [
                HealthDataTypeDto.swimmingDistance,
                HealthDataType.swimmingDistance,
              ],
              [
                HealthDataTypeDto.wheelchairDistance,
                HealthDataType.wheelchairDistance,
              ],
              [
                HealthDataTypeDto.walkingRunningDistance,
                HealthDataType.walkingRunningDistance,
              ],
              [
                HealthDataTypeDto.downhillSnowSportsDistance,
                HealthDataType.downhillSnowSportsDistance,
              ],
              [HealthDataTypeDto.rowingDistance, HealthDataType.rowingDistance],
              [
                HealthDataTypeDto.paddleSportsDistance,
                HealthDataType.paddleSportsDistance,
              ],
              [
                HealthDataTypeDto.crossCountrySkiingDistance,
                HealthDataType.crossCountrySkiingDistance,
              ],
              [
                HealthDataTypeDto.skatingSportsDistance,
                HealthDataType.skatingSportsDistance,
              ],
              [
                HealthDataTypeDto.sixMinuteWalkTestDistance,
                HealthDataType.sixMinuteWalkTestDistance,
              ],
              [HealthDataTypeDto.walkingSpeed, HealthDataType.walkingSpeed],
              [HealthDataTypeDto.runningSpeed, HealthDataType.runningSpeed],
              [
                HealthDataTypeDto.stairAscentSpeed,
                HealthDataType.stairAscentSpeed,
              ],
              [
                HealthDataTypeDto.stairDescentSpeed,
                HealthDataType.stairDescentSpeed,
              ],
              [
                HealthDataTypeDto.exerciseSession,
                HealthDataType.exerciseSession,
              ],
              [
                HealthDataTypeDto.mindfulnessSession,
                HealthDataType.mindfulnessSession,
              ],
              [HealthDataTypeDto.nutrition, HealthDataType.nutrition],
              [HealthDataTypeDto.energyNutrient, HealthDataType.energyNutrient],
              [HealthDataTypeDto.caffeine, HealthDataType.caffeine],
              [HealthDataTypeDto.protein, HealthDataType.protein],
              [
                HealthDataTypeDto.totalCarbohydrate,
                HealthDataType.totalCarbohydrate,
              ],
              [HealthDataTypeDto.totalFat, HealthDataType.totalFat],
              [HealthDataTypeDto.saturatedFat, HealthDataType.saturatedFat],
              [
                HealthDataTypeDto.monounsaturatedFat,
                HealthDataType.monounsaturatedFat,
              ],
              [
                HealthDataTypeDto.polyunsaturatedFat,
                HealthDataType.polyunsaturatedFat,
              ],
              [HealthDataTypeDto.cholesterol, HealthDataType.cholesterol],
              [HealthDataTypeDto.dietaryFiber, HealthDataType.dietaryFiber],
              [HealthDataTypeDto.sugar, HealthDataType.sugar],
              [HealthDataTypeDto.vitaminA, HealthDataType.vitaminA],
              [HealthDataTypeDto.vitaminB6, HealthDataType.vitaminB6],
              [HealthDataTypeDto.vitaminB12, HealthDataType.vitaminB12],
              [HealthDataTypeDto.vitaminC, HealthDataType.vitaminC],
              [HealthDataTypeDto.vitaminD, HealthDataType.vitaminD],
              [HealthDataTypeDto.vitaminE, HealthDataType.vitaminE],
              [HealthDataTypeDto.vitaminK, HealthDataType.vitaminK],
              [HealthDataTypeDto.thiamin, HealthDataType.thiamin],
              [HealthDataTypeDto.riboflavin, HealthDataType.riboflavin],
              [HealthDataTypeDto.niacin, HealthDataType.niacin],
              [HealthDataTypeDto.folate, HealthDataType.folate],
              [HealthDataTypeDto.biotin, HealthDataType.biotin],
              [
                HealthDataTypeDto.pantothenicAcid,
                HealthDataType.pantothenicAcid,
              ],
              [HealthDataTypeDto.calcium, HealthDataType.calcium],
              [HealthDataTypeDto.iron, HealthDataType.iron],
              [HealthDataTypeDto.magnesium, HealthDataType.magnesium],
              [HealthDataTypeDto.manganese, HealthDataType.manganese],
              [HealthDataTypeDto.phosphorus, HealthDataType.phosphorus],
              [HealthDataTypeDto.potassium, HealthDataType.potassium],
              [HealthDataTypeDto.selenium, HealthDataType.selenium],
              [HealthDataTypeDto.sodium, HealthDataType.sodium],
              [HealthDataTypeDto.zinc, HealthDataType.zinc],
            ],
            (HealthDataTypeDto dto, HealthDataType domain) {
              expect(dto.toDomain(), domain);
            },
          );
        },
      );

      group(
        'HealthDataTypeToDto',
        () {
          parameterizedTest(
            'maps HealthDataType to HealthDataTypeDto',
            [
              [
                HealthDataType.activeCaloriesBurned,
                HealthDataTypeDto.activeCaloriesBurned,
              ],
              [
                HealthDataType.basalEnergyBurned,
                HealthDataTypeDto.basalEnergyBurned,
              ],
              [
                HealthDataType.walkingRunningDistance,
                HealthDataTypeDto.walkingRunningDistance,
              ],
              [HealthDataType.floorsClimbed, HealthDataTypeDto.floorsClimbed],
              [HealthDataType.height, HealthDataTypeDto.height],
              [HealthDataType.hydration, HealthDataTypeDto.hydration],
              [HealthDataType.leanBodyMass, HealthDataTypeDto.leanBodyMass],
              [
                HealthDataType.bodyFatPercentage,
                HealthDataTypeDto.bodyFatPercentage,
              ],
              [
                HealthDataType.bodyTemperature,
                HealthDataTypeDto.bodyTemperature,
              ],
              [HealthDataType.bodyMassIndex, HealthDataTypeDto.bodyMassIndex],
              [
                HealthDataType.basalBodyTemperature,
                HealthDataTypeDto.basalBodyTemperature,
              ],
              [HealthDataType.cervicalMucus, HealthDataTypeDto.cervicalMucus],
              [HealthDataType.steps, HealthDataTypeDto.steps],
              [HealthDataType.weight, HealthDataTypeDto.weight],
              [
                HealthDataType.waistCircumference,
                HealthDataTypeDto.waistCircumference,
              ],
              [
                HealthDataType.wheelchairPushes,
                HealthDataTypeDto.wheelchairPushes,
              ],
              [
                HealthDataType.heartRateMeasurementRecord,
                HealthDataTypeDto.heartRateMeasurementRecord,
              ],
              [
                HealthDataType.heartRateVariabilitySDNN,
                HealthDataTypeDto.heartRateVariabilitySDNN,
              ],
              [
                HealthDataType.cyclingPedalingCadenceMeasurementRecord,
                HealthDataTypeDto.cyclingPedalingCadenceMeasurementRecord,
              ],
              [
                HealthDataType.sleepStageRecord,
                HealthDataTypeDto.sleepStageRecord,
              ],
              [HealthDataType.sexualActivity, HealthDataTypeDto.sexualActivity],
              [HealthDataType.bloodPressure, HealthDataTypeDto.bloodPressure],
              [
                HealthDataType.systolicBloodPressure,
                HealthDataTypeDto.systolicBloodPressure,
              ],
              [
                HealthDataType.diastolicBloodPressure,
                HealthDataTypeDto.diastolicBloodPressure,
              ],
              [
                HealthDataType.restingHeartRate,
                HealthDataTypeDto.restingHeartRate,
              ],
              [HealthDataType.ovulationTest, HealthDataTypeDto.ovulationTest],
              [
                HealthDataType.intermenstrualBleeding,
                HealthDataTypeDto.intermenstrualBleeding,
              ],
              [HealthDataType.menstrualFlow, HealthDataTypeDto.menstrualFlow],
              [
                HealthDataType.oxygenSaturation,
                HealthDataTypeDto.oxygenSaturation,
              ],
              [
                HealthDataType.respiratoryRate,
                HealthDataTypeDto.respiratoryRate,
              ],
              [HealthDataType.bloodGlucose, HealthDataTypeDto.bloodGlucose],
              [HealthDataType.vo2Max, HealthDataTypeDto.vo2Max],
              [
                HealthDataType.cyclingDistance,
                HealthDataTypeDto.cyclingDistance,
              ],
              [HealthDataType.cyclingPower, HealthDataTypeDto.cyclingPower],
              [
                HealthDataType.swimmingDistance,
                HealthDataTypeDto.swimmingDistance,
              ],
              [
                HealthDataType.wheelchairDistance,
                HealthDataTypeDto.wheelchairDistance,
              ],
              [
                HealthDataType.walkingRunningDistance,
                HealthDataTypeDto.walkingRunningDistance,
              ],
              [
                HealthDataType.downhillSnowSportsDistance,
                HealthDataTypeDto.downhillSnowSportsDistance,
              ],
              [HealthDataType.rowingDistance, HealthDataTypeDto.rowingDistance],
              [
                HealthDataType.paddleSportsDistance,
                HealthDataTypeDto.paddleSportsDistance,
              ],
              [
                HealthDataType.crossCountrySkiingDistance,
                HealthDataTypeDto.crossCountrySkiingDistance,
              ],
              [
                HealthDataType.skatingSportsDistance,
                HealthDataTypeDto.skatingSportsDistance,
              ],
              [
                HealthDataType.sixMinuteWalkTestDistance,
                HealthDataTypeDto.sixMinuteWalkTestDistance,
              ],
              [HealthDataType.walkingSpeed, HealthDataTypeDto.walkingSpeed],
              [HealthDataType.runningSpeed, HealthDataTypeDto.runningSpeed],
              [
                HealthDataType.stairAscentSpeed,
                HealthDataTypeDto.stairAscentSpeed,
              ],
              [
                HealthDataType.stairDescentSpeed,
                HealthDataTypeDto.stairDescentSpeed,
              ],
              [
                HealthDataType.exerciseSession,
                HealthDataTypeDto.exerciseSession,
              ],
              [
                HealthDataType.mindfulnessSession,
                HealthDataTypeDto.mindfulnessSession,
              ],
              [HealthDataType.nutrition, HealthDataTypeDto.nutrition],
              [HealthDataType.energyNutrient, HealthDataTypeDto.energyNutrient],
              [HealthDataType.caffeine, HealthDataTypeDto.caffeine],
              [HealthDataType.protein, HealthDataTypeDto.protein],
              [
                HealthDataType.totalCarbohydrate,
                HealthDataTypeDto.totalCarbohydrate,
              ],
              [HealthDataType.totalFat, HealthDataTypeDto.totalFat],
              [HealthDataType.saturatedFat, HealthDataTypeDto.saturatedFat],
              [
                HealthDataType.monounsaturatedFat,
                HealthDataTypeDto.monounsaturatedFat,
              ],
              [
                HealthDataType.polyunsaturatedFat,
                HealthDataTypeDto.polyunsaturatedFat,
              ],
              [HealthDataType.cholesterol, HealthDataTypeDto.cholesterol],
              [HealthDataType.dietaryFiber, HealthDataTypeDto.dietaryFiber],
              [HealthDataType.sugar, HealthDataTypeDto.sugar],
              [HealthDataType.vitaminA, HealthDataTypeDto.vitaminA],
              [HealthDataType.vitaminB6, HealthDataTypeDto.vitaminB6],
              [HealthDataType.vitaminB12, HealthDataTypeDto.vitaminB12],
              [HealthDataType.vitaminC, HealthDataTypeDto.vitaminC],
              [HealthDataType.vitaminD, HealthDataTypeDto.vitaminD],
              [HealthDataType.vitaminE, HealthDataTypeDto.vitaminE],
              [HealthDataType.vitaminK, HealthDataTypeDto.vitaminK],
              [HealthDataType.thiamin, HealthDataTypeDto.thiamin],
              [HealthDataType.riboflavin, HealthDataTypeDto.riboflavin],
              [HealthDataType.niacin, HealthDataTypeDto.niacin],
              [HealthDataType.folate, HealthDataTypeDto.folate],
              [HealthDataType.biotin, HealthDataTypeDto.biotin],
              [
                HealthDataType.pantothenicAcid,
                HealthDataTypeDto.pantothenicAcid,
              ],
              [HealthDataType.calcium, HealthDataTypeDto.calcium],
              [HealthDataType.iron, HealthDataTypeDto.iron],
              [HealthDataType.magnesium, HealthDataTypeDto.magnesium],
              [HealthDataType.manganese, HealthDataTypeDto.manganese],
              [HealthDataType.phosphorus, HealthDataTypeDto.phosphorus],
              [HealthDataType.potassium, HealthDataTypeDto.potassium],
              [HealthDataType.selenium, HealthDataTypeDto.selenium],
              [HealthDataType.sodium, HealthDataTypeDto.sodium],
              [HealthDataType.zinc, HealthDataTypeDto.zinc],
            ],
            (HealthDataType domain, HealthDataTypeDto dto) {
              expect(domain.toDto(), dto);
            },
          );

          group(
            'Unsupported conversions throw UnsupportedError',
            () {
              test(
                'throws for SpeedSeriesDataType',
                () {
                  expect(
                    () => HealthDataType.speedSeries.toDto(),
                    throwsUnsupportedError,
                  );
                },
              );

              test(
                'throws for PowerSeriesDataType',
                () {
                  expect(
                    () => HealthDataType.powerSeries.toDto(),
                    throwsUnsupportedError,
                  );
                },
              );

              test(
                'throws for SleepSessionHealthDataType',
                () {
                  expect(
                    () => HealthDataType.sleepSession.toDto(),
                    throwsUnsupportedError,
                  );
                },
              );

              test(
                'throws for HeartRateSeriesRecordHealthDataType',
                () {
                  expect(
                    () => HealthDataType.heartRateSeriesRecord.toDto(),
                    throwsUnsupportedError,
                  );
                },
              );

              test(
                'throws for CyclingPedalingCadenceSeriesRecordHealthDataType',
                () {
                  expect(
                    () => HealthDataType.cyclingPedalingCadenceSeriesRecord
                        .toDto(),
                    throwsUnsupportedError,
                  );
                },
              );

              test(
                'throws for TotalCaloriesBurnedHealthDataType',
                () {
                  expect(
                    () => HealthDataType.totalCaloriesBurned.toDto(),
                    throwsUnsupportedError,
                  );
                },
              );

              test(
                'throws for BoneMassDataType',
                () {
                  expect(
                    () => HealthDataType.boneMass.toDto(),
                    throwsUnsupportedError,
                  );
                },
              );

              test(
                'throws for BodyWaterMassDataType',
                () {
                  expect(
                    () => HealthDataType.bodyWaterMass.toDto(),
                    throwsUnsupportedError,
                  );
                },
              );

              test(
                'throws for HeartRateVariabilityRMSSDDataType',
                () {
                  expect(
                    () => HealthDataType.heartRateVariabilityRMSSD.toDto(),
                    throwsUnsupportedError,
                  );
                },
              );

              test(
                'throws for MenstrualFlowInstantDataType',
                () {
                  expect(
                    () => HealthDataType.menstrualFlowInstant.toDto(),
                    throwsUnsupportedError,
                  );
                },
              );

              test(
                'throws for DistanceHealthDataType',
                () {
                  expect(
                    () => HealthDataType.distance.toDto(),
                    throwsUnsupportedError,
                  );
                },
              );
            },
          );
        },
      );
    },
  );
}
