import 'package:health_connector_core/health_connector_core.dart';
import 'package:health_connector_core/src/utils/health_record_data_type_extension.dart';
import 'package:parameterized_test/parameterized_test.dart';
import 'package:test/test.dart';

void main() {
  group(
    'HealthRecordDataTypeExtension',
    () {
      group(
        'dataType',
        () {
          // Helper function to create metadata for test records
          Metadata createTestMetadata() {
            return Metadata.manualEntry(
              dataOrigin: const DataOrigin('com.test.app'),
            );
          }

          // Helper function to create test time
          DateTime createTestTime() {
            return DateTime(2024, 1, 1, 10);
          }

          parameterizedTest(
            'GIVEN a health record → '
            'WHEN dataType getter is called → '
            'THEN returns the correct HealthDataType',
            [
              // Distance records
              [
                DistanceRecord(
                  distance: const Length.meters(1000),
                  startTime: createTestTime(),
                  endTime: createTestTime().add(const Duration(hours: 1)),
                  metadata: createTestMetadata(),
                ),
                HealthDataType.distance,
              ],

              // Basic health records
              [
                StepsRecord(
                  count: const Number(1000),
                  startTime: createTestTime(),
                  endTime: createTestTime().add(const Duration(hours: 1)),
                  metadata: createTestMetadata(),
                ),
                HealthDataType.steps,
              ],
              [
                WeightRecord(
                  weight: const Mass.kilograms(70),
                  time: createTestTime(),
                  metadata: createTestMetadata(),
                ),
                HealthDataType.weight,
              ],
              [
                HeightRecord(
                  height: const Length.centimeters(175),
                  time: createTestTime(),
                  metadata: createTestMetadata(),
                ),
                HealthDataType.height,
              ],
              [
                BloodGlucoseRecord(
                  bloodGlucose: const BloodGlucose.milligramsPerDeciliter(100),
                  time: createTestTime(),
                  metadata: createTestMetadata(),
                ),
                HealthDataType.bloodGlucose,
              ],
              [
                BodyTemperatureRecord(
                  temperature: const Temperature.celsius(37),
                  time: createTestTime(),
                  metadata: createTestMetadata(),
                ),
                HealthDataType.bodyTemperature,
              ],
              [
                ActiveCaloriesBurnedRecord(
                  energy: const Energy.kilocalories(300),
                  startTime: createTestTime(),
                  endTime: createTestTime().add(const Duration(hours: 1)),
                  metadata: createTestMetadata(),
                ),
                HealthDataType.activeCaloriesBurned,
              ],
              [
                FloorsClimbedRecord(
                  floors: const Number(10),
                  startTime: createTestTime(),
                  endTime: createTestTime().add(const Duration(hours: 1)),
                  metadata: createTestMetadata(),
                ),
                HealthDataType.floorsClimbed,
              ],
              [
                LeanBodyMassRecord(
                  mass: const Mass.kilograms(60),
                  time: createTestTime(),
                  metadata: createTestMetadata(),
                ),
                HealthDataType.leanBodyMass,
              ],
              [
                HydrationRecord(
                  volume: const Volume.liters(2),
                  startTime: createTestTime(),
                  endTime: createTestTime().add(const Duration(hours: 1)),
                  metadata: createTestMetadata(),
                ),
                HealthDataType.hydration,
              ],

              // Blood pressure records
              [
                BloodPressureRecord(
                  systolic: const Pressure.millimetersOfMercury(120),
                  diastolic: const Pressure.millimetersOfMercury(80),
                  time: createTestTime(),
                  metadata: createTestMetadata(),
                ),
                HealthDataType.bloodPressure,
              ],

              // Sleep records
              // Removed SleepSessionRecord due to complexity with
              // required id and samples

              // Sexual activity
              [
                SexualActivityRecord(
                  time: createTestTime(),
                  metadata: createTestMetadata(),
                ),
                HealthDataType.sexualActivity,
              ],

              // Mindfulness
              [
                MindfulnessSessionRecord(
                  startTime: createTestTime(),
                  endTime: createTestTime().add(const Duration(minutes: 30)),
                  metadata: createTestMetadata(),
                  sessionType: MindfulnessSessionType.meditation,
                ),
                HealthDataType.mindfulnessSession,
              ],

              // Vital signs
              [
                RestingHeartRateRecord(
                  beatsPerMinute: const Number(60),
                  time: createTestTime(),
                  metadata: createTestMetadata(),
                ),
                HealthDataType.restingHeartRate,
              ],
              [
                OxygenSaturationRecord(
                  percentage: const Percentage.fromWhole(98),
                  time: createTestTime(),
                  metadata: createTestMetadata(),
                ),
                HealthDataType.oxygenSaturation,
              ],
              [
                RespiratoryRateRecord(
                  breathsPerMin: const Number(16),
                  time: createTestTime(),
                  metadata: createTestMetadata(),
                ),
                HealthDataType.respiratoryRate,
              ],
              [
                Vo2MaxRecord(
                  mLPerKgPerMin: const Number(45),
                  time: createTestTime(),
                  metadata: createTestMetadata(),
                ),
                HealthDataType.vo2Max,
              ],

              // Nutrition records
              [
                NutritionRecord(
                  startTime: createTestTime(),
                  endTime: createTestTime().add(const Duration(hours: 1)),
                  metadata: createTestMetadata(),
                ),
                HealthDataType.nutrition,
              ],
              [
                EnergyNutrientRecord(
                  value: const Energy.kilocalories(500),
                  time: createTestTime(),
                  metadata: createTestMetadata(),
                ),
                HealthDataType.energyNutrient,
              ],
              [
                CalciumNutrientRecord(
                  value: const Mass.grams(0.8),
                  time: createTestTime(),
                  metadata: createTestMetadata(),
                ),
                HealthDataType.calcium,
              ],
              [
                VitaminCNutrientRecord(
                  value: const Mass.grams(0.09),
                  time: createTestTime(),
                  metadata: createTestMetadata(),
                ),
                HealthDataType.vitaminC,
              ],

              // Additional metrics
              [
                TotalCaloriesBurnedRecord(
                  energy: const Energy.kilocalories(2000),
                  startTime: createTestTime(),
                  endTime: createTestTime().add(const Duration(hours: 24)),
                  metadata: createTestMetadata(),
                ),
                HealthDataType.totalCaloriesBurned,
              ],
              [
                BasalBodyTemperatureRecord(
                  temperature: const Temperature.celsius(36.5),
                  time: createTestTime(),
                  metadata: createTestMetadata(),
                ),
                HealthDataType.basalBodyTemperature,
              ],
              [
                BoneMassRecord(
                  mass: const Mass.kilograms(3),
                  time: createTestTime(),
                  metadata: createTestMetadata(),
                ),
                HealthDataType.boneMass,
              ],
              [
                BodyWaterMassRecord(
                  mass: const Mass.kilograms(45),
                  time: createTestTime(),
                  metadata: createTestMetadata(),
                ),
                HealthDataType.bodyWaterMass,
              ],
              [
                HeartRateVariabilityRMSSDRecord(
                  heartRateVariabilityMillis: 50.0,
                  time: createTestTime(),
                  metadata: createTestMetadata(),
                ),
                HealthDataType.heartRateVariabilityRMSSD,
              ],
              [
                BodyMassIndexRecord(
                  bodyMassIndex: const Number(22.5),
                  time: createTestTime(),
                  metadata: createTestMetadata(),
                ),
                HealthDataType.bodyMassIndex,
              ],
              [
                WaistCircumferenceRecord(
                  circumference: const Length.centimeters(85),
                  time: createTestTime(),
                  metadata: createTestMetadata(),
                ),
                HealthDataType.waistCircumference,
              ],
            ],
            (HealthRecord record, HealthDataType expectedDataType) {
              // WHEN
              final result = record.dataType;

              // THEN
              expect(result, equals(expectedDataType));
            },
          );
        },
      );
    },
  );
}
