import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/health_data_type_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';
import 'package:parameterized_test/parameterized_test.dart';

void main() {
  group(
    'HealthDataTypeMapper',
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
              [HealthDataTypeDto.distance, HealthDataType.distance],
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
              [
                HealthDataTypeDto.basalBodyTemperature,
                HealthDataType.basalBodyTemperature,
              ],
              [HealthDataTypeDto.cervicalMucus, HealthDataType.cervicalMucus],
              [HealthDataTypeDto.steps, HealthDataType.steps],
              [HealthDataTypeDto.weight, HealthDataType.weight],
              [
                HealthDataTypeDto.wheelchairPushes,
                HealthDataType.wheelchairPushes,
              ],
              [
                HealthDataTypeDto.heartRateSeriesRecord,
                HealthDataType.heartRateSeries,
              ],
              [
                HealthDataTypeDto.cyclingPedalingCadenceSeriesRecord,
                HealthDataType.cyclingPedalingCadenceSeries,
              ],
              [HealthDataTypeDto.sexualActivity, HealthDataType.sexualActivity],
              [HealthDataTypeDto.sleepSession, HealthDataType.sleepSession],
              [
                HealthDataTypeDto.exerciseSession,
                HealthDataType.exerciseSession,
              ],
              [HealthDataTypeDto.nutrition, HealthDataType.nutrition],
              [
                HealthDataTypeDto.restingHeartRate,
                HealthDataType.restingHeartRate,
              ],
              [HealthDataTypeDto.bloodPressure, HealthDataType.bloodPressure],
              [HealthDataTypeDto.ovulationTest, HealthDataType.ovulationTest],
              [
                HealthDataTypeDto.intermenstrualBleeding,
                HealthDataType.intermenstrualBleeding,
              ],
              [
                HealthDataTypeDto.menstrualFlowInstant,
                HealthDataType.menstrualFlowInstant,
              ],
              [
                HealthDataTypeDto.oxygenSaturation,
                HealthDataType.oxygenSaturation,
              ],
              [
                HealthDataTypeDto.respiratoryRate,
                HealthDataType.respiratoryRate,
              ],
              [HealthDataTypeDto.vo2Max, HealthDataType.vo2Max],
              [HealthDataTypeDto.bloodGlucose, HealthDataType.bloodGlucose],
              [HealthDataTypeDto.powerSeries, HealthDataType.powerSeries],
              [HealthDataTypeDto.speedSeries, HealthDataType.speedSeries],
              [
                HealthDataTypeDto.totalCaloriesBurned,
                HealthDataType.totalEnergyBurned,
              ],
              [
                HealthDataTypeDto.mindfulnessSession,
                HealthDataType.mindfulnessSession,
              ],
              [HealthDataTypeDto.boneMass, HealthDataType.boneMass],
              [HealthDataTypeDto.bodyWaterMass, HealthDataType.bodyWaterMass],
              [
                HealthDataTypeDto.heartRateVariabilityRMSSD,
                HealthDataType.heartRateVariabilityRMSSD,
              ],
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
              [HealthDataType.distance, HealthDataTypeDto.distance],
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
              [
                HealthDataType.basalBodyTemperature,
                HealthDataTypeDto.basalBodyTemperature,
              ],
              [HealthDataType.cervicalMucus, HealthDataTypeDto.cervicalMucus],
              [HealthDataType.steps, HealthDataTypeDto.steps],
              [HealthDataType.weight, HealthDataTypeDto.weight],
              [
                HealthDataType.wheelchairPushes,
                HealthDataTypeDto.wheelchairPushes,
              ],
              [
                HealthDataType.heartRateSeries,
                HealthDataTypeDto.heartRateSeriesRecord,
              ],
              [
                HealthDataType.cyclingPedalingCadenceSeries,
                HealthDataTypeDto.cyclingPedalingCadenceSeriesRecord,
              ],
              [HealthDataType.sexualActivity, HealthDataTypeDto.sexualActivity],
              [HealthDataType.sleepSession, HealthDataTypeDto.sleepSession],
              [
                HealthDataType.exerciseSession,
                HealthDataTypeDto.exerciseSession,
              ],
              [
                HealthDataType.mindfulnessSession,
                HealthDataTypeDto.mindfulnessSession,
              ],
              [HealthDataType.boneMass, HealthDataTypeDto.boneMass],
              [HealthDataType.bodyWaterMass, HealthDataTypeDto.bodyWaterMass],
              [
                HealthDataType.heartRateVariabilityRMSSD,
                HealthDataTypeDto.heartRateVariabilityRMSSD,
              ],
              [HealthDataType.bloodPressure, HealthDataTypeDto.bloodPressure],
              [HealthDataType.ovulationTest, HealthDataTypeDto.ovulationTest],
              [
                HealthDataType.intermenstrualBleeding,
                HealthDataTypeDto.intermenstrualBleeding,
              ],
              [
                HealthDataType.menstrualFlowInstant,
                HealthDataTypeDto.menstrualFlowInstant,
              ],
              [
                HealthDataType.oxygenSaturation,
                HealthDataTypeDto.oxygenSaturation,
              ],
              [
                HealthDataType.respiratoryRate,
                HealthDataTypeDto.respiratoryRate,
              ],
              [HealthDataType.nutrition, HealthDataTypeDto.nutrition],
              [
                HealthDataType.restingHeartRate,
                HealthDataTypeDto.restingHeartRate,
              ],
              [HealthDataType.vo2Max, HealthDataTypeDto.vo2Max],
              [HealthDataType.bloodGlucose, HealthDataTypeDto.bloodGlucose],
              [
                HealthDataType.totalEnergyBurned,
                HealthDataTypeDto.totalCaloriesBurned,
              ],
              [HealthDataType.speedSeries, HealthDataTypeDto.speedSeries],
              [HealthDataType.powerSeries, HealthDataTypeDto.powerSeries],
            ],
            (HealthDataType domain, HealthDataTypeDto dto) {
              expect(domain.toDto(), dto);
            },
          );

          group(
            'Unsupported conversions should throw UnsupportedError',
            () {
              final unsupportedTypes = <HealthDataType>[
                HealthDataType.dietaryEnergyConsumed,
                HealthDataType.dietaryCaffeine,
                HealthDataType.dietaryProtein,
                HealthDataType.dietaryTotalCarbohydrate,
                HealthDataType.dietaryTotalFat,
                HealthDataType.dietarySaturatedFat,
                HealthDataType.dietaryMonounsaturatedFat,
                HealthDataType.dietaryPolyunsaturatedFat,
                HealthDataType.dietaryCholesterol,
                HealthDataType.dietaryFiber,
                HealthDataType.dietarySugar,
                HealthDataType.dietaryVitaminA,
                HealthDataType.dietaryVitaminB6,
                HealthDataType.dietaryVitaminB12,
                HealthDataType.dietaryVitaminC,
                HealthDataType.dietaryVitaminD,
                HealthDataType.dietaryVitaminE,
                HealthDataType.dietaryVitaminK,
                HealthDataType.dietaryThiamin,
                HealthDataType.dietaryRiboflavin,
                HealthDataType.dietaryNiacin,
                HealthDataType.dietaryFolate,
                HealthDataType.dietaryBiotin,
                HealthDataType.dietaryPantothenicAcid,
                HealthDataType.dietaryCalcium,
                HealthDataType.dietaryIron,
                HealthDataType.dietaryMagnesium,
                HealthDataType.dietaryManganese,
                HealthDataType.dietaryPhosphorus,
                HealthDataType.dietaryPotassium,
                HealthDataType.dietarySelenium,
                HealthDataType.dietarySodium,
                HealthDataType.dietaryZinc,
                HealthDataType.basalEnergyBurned,
                HealthDataType.sleepStageRecord,
                HealthDataType.heartRate,
                HealthDataType.cyclingPedalingCadence,
                HealthDataType.systolicBloodPressure,
                HealthDataType.diastolicBloodPressure,
                HealthDataType.cyclingDistance,
                HealthDataType.swimmingDistance,
                HealthDataType.wheelchairDistance,
                HealthDataType.downhillSnowSportsDistance,
                HealthDataType.rowingDistance,
                HealthDataType.paddleSportsDistance,
                HealthDataType.crossCountrySkiingDistance,
                HealthDataType.skatingSportsDistance,
                HealthDataType.sixMinuteWalkTestDistance,
                HealthDataType.walkingRunningDistance,
                HealthDataType.cyclingPower,
                HealthDataType.walkingSpeed,
                HealthDataType.runningSpeed,
                HealthDataType.stairAscentSpeed,
                HealthDataType.stairDescentSpeed,
                HealthDataType.bodyMassIndex,
                HealthDataType.waistCircumference,
                HealthDataType.heartRateVariabilitySDNN,
                HealthDataType.menstrualFlow,
              ];

              parameterizedTest(
                'throws UnsupportedError',
                unsupportedTypes.map((type) => [type]).toList(),
                (HealthDataType type) {
                  expect(() => type.toDto(), throwsUnsupportedError);
                },
              );
            },
          );
        },
      );
    },
  );
}
