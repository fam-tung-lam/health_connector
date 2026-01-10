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
                HealthDataType.activeEnergyBurned,
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
                HealthDataType.heartRate,
              ],
              [
                HealthDataTypeDto.heartRateVariabilitySDNN,
                HealthDataType.heartRateVariabilitySDNN,
              ],
              [
                HealthDataTypeDto.cyclingPedalingCadence,
                HealthDataType.cyclingPedalingCadence,
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
              [
                HealthDataTypeDto.dietaryEnergyConsumed,
                HealthDataType.dietaryEnergyConsumed,
              ],
              [HealthDataTypeDto.caffeine, HealthDataType.dietaryCaffeine],
              [HealthDataTypeDto.protein, HealthDataType.dietaryProtein],
              [
                HealthDataTypeDto.totalCarbohydrate,
                HealthDataType.dietaryTotalCarbohydrate,
              ],
              [HealthDataTypeDto.totalFat, HealthDataType.dietaryTotalFat],
              [
                HealthDataTypeDto.saturatedFat,
                HealthDataType.dietarySaturatedFat,
              ],
              [
                HealthDataTypeDto.monounsaturatedFat,
                HealthDataType.dietaryMonounsaturatedFat,
              ],
              [
                HealthDataTypeDto.polyunsaturatedFat,
                HealthDataType.dietaryPolyunsaturatedFat,
              ],
              [
                HealthDataTypeDto.cholesterol,
                HealthDataType.dietaryCholesterol,
              ],
              [HealthDataTypeDto.dietaryFiber, HealthDataType.dietaryFiber],
              [HealthDataTypeDto.sugar, HealthDataType.dietarySugar],
              [HealthDataTypeDto.vitaminA, HealthDataType.dietaryVitaminA],
              [HealthDataTypeDto.vitaminB6, HealthDataType.dietaryVitaminB6],
              [HealthDataTypeDto.vitaminB12, HealthDataType.dietaryVitaminB12],
              [HealthDataTypeDto.vitaminC, HealthDataType.dietaryVitaminC],
              [HealthDataTypeDto.vitaminD, HealthDataType.dietaryVitaminD],
              [HealthDataTypeDto.vitaminE, HealthDataType.dietaryVitaminE],
              [HealthDataTypeDto.vitaminK, HealthDataType.dietaryVitaminK],
              [HealthDataTypeDto.thiamin, HealthDataType.dietaryThiamin],
              [HealthDataTypeDto.riboflavin, HealthDataType.dietaryRiboflavin],
              [HealthDataTypeDto.niacin, HealthDataType.dietaryNiacin],
              [HealthDataTypeDto.folate, HealthDataType.dietaryFolate],
              [HealthDataTypeDto.biotin, HealthDataType.dietaryBiotin],
              [
                HealthDataTypeDto.pantothenicAcid,
                HealthDataType.dietaryPantothenicAcid,
              ],
              [HealthDataTypeDto.calcium, HealthDataType.dietaryCalcium],
              [HealthDataTypeDto.iron, HealthDataType.dietaryIron],
              [HealthDataTypeDto.magnesium, HealthDataType.dietaryMagnesium],
              [HealthDataTypeDto.manganese, HealthDataType.dietaryManganese],
              [HealthDataTypeDto.phosphorus, HealthDataType.dietaryPhosphorus],
              [HealthDataTypeDto.potassium, HealthDataType.dietaryPotassium],
              [HealthDataTypeDto.selenium, HealthDataType.dietarySelenium],
              [HealthDataTypeDto.sodium, HealthDataType.dietarySodium],
              [HealthDataTypeDto.zinc, HealthDataType.dietaryZinc],
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
                HealthDataType.activeEnergyBurned,
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
                HealthDataType.heartRate,
                HealthDataTypeDto.heartRateMeasurementRecord,
              ],
              [
                HealthDataType.heartRateVariabilitySDNN,
                HealthDataTypeDto.heartRateVariabilitySDNN,
              ],
              [
                HealthDataType.cyclingPedalingCadence,
                HealthDataTypeDto.cyclingPedalingCadence,
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
              [
                HealthDataType.dietaryEnergyConsumed,
                HealthDataTypeDto.dietaryEnergyConsumed,
              ],
              [HealthDataType.dietaryCaffeine, HealthDataTypeDto.caffeine],
              [HealthDataType.dietaryProtein, HealthDataTypeDto.protein],
              [
                HealthDataType.dietaryTotalCarbohydrate,
                HealthDataTypeDto.totalCarbohydrate,
              ],
              [HealthDataType.dietaryTotalFat, HealthDataTypeDto.totalFat],
              [
                HealthDataType.dietarySaturatedFat,
                HealthDataTypeDto.saturatedFat,
              ],
              [
                HealthDataType.dietaryMonounsaturatedFat,
                HealthDataTypeDto.monounsaturatedFat,
              ],
              [
                HealthDataType.dietaryPolyunsaturatedFat,
                HealthDataTypeDto.polyunsaturatedFat,
              ],
              [
                HealthDataType.dietaryCholesterol,
                HealthDataTypeDto.cholesterol,
              ],
              [HealthDataType.dietaryFiber, HealthDataTypeDto.dietaryFiber],
              [HealthDataType.dietarySugar, HealthDataTypeDto.sugar],
              [HealthDataType.dietaryVitaminA, HealthDataTypeDto.vitaminA],
              [HealthDataType.dietaryVitaminB6, HealthDataTypeDto.vitaminB6],
              [HealthDataType.dietaryVitaminB12, HealthDataTypeDto.vitaminB12],
              [HealthDataType.dietaryVitaminC, HealthDataTypeDto.vitaminC],
              [HealthDataType.dietaryVitaminD, HealthDataTypeDto.vitaminD],
              [HealthDataType.dietaryVitaminE, HealthDataTypeDto.vitaminE],
              [HealthDataType.dietaryVitaminK, HealthDataTypeDto.vitaminK],
              [HealthDataType.dietaryThiamin, HealthDataTypeDto.thiamin],
              [HealthDataType.dietaryRiboflavin, HealthDataTypeDto.riboflavin],
              [HealthDataType.dietaryNiacin, HealthDataTypeDto.niacin],
              [HealthDataType.dietaryFolate, HealthDataTypeDto.folate],
              [HealthDataType.dietaryBiotin, HealthDataTypeDto.biotin],
              [
                HealthDataType.dietaryPantothenicAcid,
                HealthDataTypeDto.pantothenicAcid,
              ],
              [HealthDataType.dietaryCalcium, HealthDataTypeDto.calcium],
              [HealthDataType.dietaryIron, HealthDataTypeDto.iron],
              [HealthDataType.dietaryMagnesium, HealthDataTypeDto.magnesium],
              [HealthDataType.dietaryManganese, HealthDataTypeDto.manganese],
              [HealthDataType.dietaryPhosphorus, HealthDataTypeDto.phosphorus],
              [HealthDataType.dietaryPotassium, HealthDataTypeDto.potassium],
              [HealthDataType.dietarySelenium, HealthDataTypeDto.selenium],
              [HealthDataType.dietarySodium, HealthDataTypeDto.sodium],
              [HealthDataType.dietaryZinc, HealthDataTypeDto.zinc],
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
                'throws for SleepSessionDataType',
                () {
                  expect(
                    () => HealthDataType.sleepSession.toDto(),
                    throwsUnsupportedError,
                  );
                },
              );

              test(
                'throws for HeartRateSeriesDataType',
                () {
                  expect(
                    () => HealthDataType.heartRateSeries.toDto(),
                    throwsUnsupportedError,
                  );
                },
              );

              test(
                'throws for CyclingPedalingCadenceSeriesRecordDataType',
                () {
                  expect(
                    () => HealthDataType.cyclingPedalingCadenceSeries.toDto(),
                    throwsUnsupportedError,
                  );
                },
              );

              test(
                'throws for TotalEnergyBurnedDataType',
                () {
                  expect(
                    () => HealthDataType.totalEnergyBurned.toDto(),
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
                'throws for DistanceDataType',
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
