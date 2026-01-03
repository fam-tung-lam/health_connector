import 'package:health_connector_core/src/annotations/annotations.dart';
import 'package:health_connector_core/src/config/health_connector_config_constants.dart'
    show HealthConnectorConfigConstants;
import 'package:health_connector_core/src/models/health_data_types/health_data_type_capabilities/health_data_type_capabilities.dart';
import 'package:health_connector_core/src/models/health_platform.dart';
import 'package:health_connector_core/src/models/health_platform_data.dart'
    show HealthPlatformData;
import 'package:health_connector_core/src/models/health_records/health_record.dart';
import 'package:health_connector_core/src/models/measurement_units/measurement_unit.dart';
import 'package:health_connector_core/src/models/metadata/metadata.dart';
import 'package:health_connector_core/src/models/permissions/permission.dart';
import 'package:health_connector_core/src/models/requests/aggregate_request.dart';
import 'package:health_connector_core/src/models/requests/aggregation_metric.dart';
import 'package:health_connector_core/src/models/requests/delete_records_request.dart';
import 'package:health_connector_core/src/models/requests/read_records_request.dart';
import 'package:meta/meta.dart' show immutable, internal;

part 'energy_burned/active_calories_burned_health_data_type.dart';
part 'temperature/basal_body_temperature_health_data_type.dart';
part 'energy_burned/basal_energy_burned_health_data_type.dart';
part 'blood_glucose_health_data_type.dart';
part 'blood_pressure/blood_pressure_health_data_type.dart';
part 'blood_pressure/diastolic_blood_pressure_health_data_type.dart';
part 'blood_pressure/systolic_blood_pressure_health_data_type.dart';
part 'body_fat_percentage_health_data_type.dart';
part 'body_mass_index_health_data_type.dart';
part 'temperature/body_temperature_health_data_type.dart';
part 'body_water_mass_health_data_type.dart';
part 'bone_mass_health_data_type.dart';
part 'menstruation/cervical_mucus_data_type.dart';
part 'cycling_pedaling_cadence/cycling_pedaling_cadence_measurement_record_health_data_type.dart';
part 'cycling_pedaling_cadence/cycling_pedaling_cadence_series_record_health_data_type.dart';
part 'distance/cross_country_skiing_distance_data_type.dart';
part 'distance/cycling_distance_data_type.dart';
part 'distance/distance_activity_data_type.dart';
part 'distance/distance_data_type.dart';
part 'distance/downhill_snow_sports_distance_data_type.dart';
part 'distance/paddle_sports_distance_data_type.dart';
part 'distance/rowing_distance_data_type.dart';
part 'distance/six_minute_walk_test_distance_data_type.dart';
part 'distance/skating_sports_distance_data_type.dart';
part 'distance/swimming_distance_data_type.dart';
part 'distance/walking_running_distance_data_type.dart';
part 'distance/wheelchair_distance_data_type.dart';
part 'exercise_session_health_data_type.dart';
part 'floors_climbed_health_data_type.dart';
part 'heart_rate/heart_rate_measurement_record_health_data_type.dart';
part 'heart_rate/heart_rate_series_record_health_data_type.dart';
part 'heart_rate/heart_rate_variability_rmssd_health_data_type.dart';
part 'heart_rate/heart_rate_variability_sdnn_health_data_type.dart';
part 'height_health_data_type.dart';
part 'hydration_health_data_type.dart';
part 'menstruation/intermenstrual_bleeding_data_type.dart';
part 'lean_body_mass_health_data_type.dart';
part 'menstruation/menstrual_flow_data_type.dart';
part 'menstruation/menstrual_flow_instant_data_type.dart';
part 'mindfulness_session_data_type.dart';
part 'nutrition/biotin_nutrient_data_type.dart';
part 'nutrition/caffeine_nutrient_data_type.dart';
part 'nutrition/calcium_nutrient_data_type.dart';
part 'nutrition/cholesterol_nutrient_data_type.dart';
part 'nutrition/dietary_fiber_nutrient_data_type.dart';
part 'nutrition/energy_nutrient_data_type.dart';
part 'nutrition/folate_nutrient_data_type.dart';
part 'nutrition/iron_nutrient_data_type.dart';
part 'nutrition/macronutrient_data_type.dart';
part 'nutrition/magnesium_nutrient_data_type.dart';
part 'nutrition/manganese_nutrient_data_type.dart';
part 'nutrition/mineral_nutrient_data_type.dart';
part 'nutrition/monounsaturated_fat_nutrient_data_type.dart';
part 'nutrition/niacin_nutrient_data_type.dart';
part 'nutrition/nutrient_data_type.dart';
part 'nutrition/nutrition_data_type.dart';
part 'nutrition/pantothenic_acid_nutrient_data_type.dart';
part 'nutrition/phosphorus_nutrient_data_type.dart';
part 'nutrition/polyunsaturated_fat_nutrient_data_type.dart';
part 'nutrition/potassium_nutrient_data_type.dart';
part 'nutrition/protein_nutrient_data_type.dart';
part 'nutrition/riboflavin_nutrient_data_type.dart';
part 'nutrition/saturated_fat_nutrient_data_type.dart';
part 'nutrition/selenium_nutrient_data_type.dart';
part 'nutrition/sodium_nutrient_data_type.dart';
part 'nutrition/sugar_nutrient_data_type.dart';
part 'nutrition/thiamin_nutrient_data_type.dart';
part 'nutrition/total_carbohydrate_nutrient_data_type.dart';
part 'nutrition/total_fat_nutrient_data_type.dart';
part 'nutrition/vitamin_a_nutrient_data_type.dart';
part 'nutrition/vitamin_b12_nutrient_data_type.dart';
part 'nutrition/vitamin_b6_nutrient_data_type.dart';
part 'nutrition/vitamin_c_nutrient_data_type.dart';
part 'nutrition/vitamin_d_nutrient_data_type.dart';
part 'nutrition/vitamin_e_nutrient_data_type.dart';
part 'nutrition/vitamin_k_nutrient_data_type.dart';
part 'nutrition/vitamin_nutrient_data_type.dart';
part 'nutrition/zinc_nutrient_data_type.dart';
part 'ovulation_test_data_type.dart';
part 'oxygen_saturation_health_data_type.dart';
part 'power/cycling_power_data_type.dart';
part 'power/power_series_data_type.dart';
part 'respiratory_rate_health_data_type.dart';
part 'heart_rate/resting_heart_rate_health_data_type.dart';
part 'sexual_activity_data_type.dart';
part 'sleep/sleep_session_health_data_type.dart';
part 'sleep/sleep_stage_record_health_data_type.dart';
part 'speed/running_speed_data_type.dart';
part 'speed/speed_activity_data_type.dart';
part 'speed/speed_series_data_type.dart';
part 'speed/stair_ascent_speed_data_type.dart';
part 'speed/stair_descent_speed_data_type.dart';
part 'speed/walking_speed_data_type.dart';
part 'steps_health_data_type.dart';
part 'energy_burned/total_calories_burned_health_data_type.dart';
part 'vo2_max_health_data_type.dart';
part 'waist_circumference_health_data_type.dart';
part 'weight_health_data_type.dart';
part 'wheelchair_pushes_health_data_type.dart';

/// [HealthDataType] represents different kinds of health and fitness data
/// that can be read from or written to health platforms.
///
/// ## Type Parameters
///
/// - `R`: The [HealthRecord] type associated with this data type
/// - `U`: The unit type for aggregations (e.g. [Mass], [Energy])
///
/// ## **Internal Implementation Note**: Capability Model Design
///
/// This class uses **interface classes** instead of mixins to represent
/// capabilities (readable, writeable, deletable, aggregateable).
///
/// ### Why Not Mixins?
///
/// Initially, capabilities were implemented using `base mixin`, but
/// this caused issues with Dart's switch-case exhaustiveness checking:
///
/// ```dart
/// // With base mixins, this switch is NOT exhaustive:
/// switch (dataType) {
///   case StepsHealthDataType(): // ...
///   case WeightHealthDataType(): // ...
///   // ERROR: Must also handle ReadableHealthDataType, WriteableHealthDataType,
///   // SumAggregatableHealthDataType, etc., even though all instances are
///   // already covered by the concrete types above!
/// }
/// ```
///
/// The problem is that `mixin` with `base` makes mixins part of the sealed
/// type hierarchy, causing the analyzer to require handling them as separate
/// cases, even when they're already covered by concrete implementations.
///
/// ### Why Interface Classes?
///
/// Using `abstract interface class` solves this problem, as interfaces don't
/// participate in sealed type exhaustiveness checking, so you only need to
/// handle concrete types:
/// ```dart
/// switch (dataType) {
///   case StepsHealthDataType(): // ...
///   case WeightHealthDataType(): // ...
///   // No need to handle interface types!
/// }
/// ```
///
/// ### Trade-offs
///
/// The main trade-off is code duplication: each concrete type must implement
/// all methods from the interfaces it supports.
/// However, this is acceptable because:
/// - The implementations are straightforward (mostly creating request objects)
/// - It eliminates the switch-case exhaustiveness problem
///
/// {@category Health Data Types}
@sinceV1_0_0
@immutable
sealed class HealthDataType<R extends HealthRecord, U extends MeasurementUnit>
    implements HealthPlatformData {
  const HealthDataType();

  @override
  List<HealthPlatform> get supportedHealthPlatforms => HealthPlatform.values;

  /// The list of aggregation metrics that support this health record.
  List<AggregationMetric> get supportedAggregationMetrics => [];

  /// The list of permissions for this health record.
  List<Permission> get permissions;

  /// Distance data type.
  ///
  /// Represents the distance traveled during activities such as walking,
  /// running, or cycling. Supports both reading existing distance data
  /// and writing new distance measurements.
  @supportedOnHealthConnect
  static const distance = DistanceHealthDataType();

  /// Cycling distance data type.
  @sinceV2_0_0
  @supportedOnAppleHealth
  static const cyclingDistance = CyclingDistanceDataType();

  /// Swimming distance data type.
  @sinceV2_0_0
  @supportedOnAppleHealth
  static const swimmingDistance = SwimmingDistanceDataType();

  /// Wheelchair distance data type.
  @sinceV2_0_0
  @supportedOnAppleHealth
  static const wheelchairDistance = WheelchairDistanceDataType();

  /// Downhill snow sports distance data type.
  @sinceV2_0_0
  @supportedOnAppleHealth
  static const downhillSnowSportsDistance =
      DownhillSnowSportsDistanceDataType();

  /// Rowing distance data type (iOS 18+).
  @sinceV2_0_0
  @supportedOnAppleHealth
  static const rowingDistance = RowingDistanceDataType();

  /// Paddle sports distance data type (iOS 18+).
  @sinceV2_0_0
  @supportedOnAppleHealth
  static const paddleSportsDistance = PaddleSportsDistanceDataType();

  /// Cross-country skiing distance data type (iOS 18+).
  @sinceV2_0_0
  @supportedOnAppleHealth
  static const crossCountrySkiingDistance =
      CrossCountrySkiingDistanceDataType();

  /// Skating sports distance data type (iOS 18+).
  @sinceV2_0_0
  @supportedOnAppleHealth
  static const skatingSportsDistance = SkatingSportsDistanceDataType();

  /// Six-minute walk test distance data type.
  @sinceV2_0_0
  @supportedOnAppleHealth
  static const sixMinuteWalkTestDistance = SixMinuteWalkTestDistanceDataType();

  /// Walking running distance data type.
  @sinceV2_0_0
  @supportedOnAppleHealth
  static const walkingRunningDistance = WalkingRunningDistanceDataType();

  /// Speed data type (Android Health Connect only).
  ///
  /// Represents speed measurements as a series of samples over a time interval.
  /// For iOS, use the activity-specific speed types.
  @sinceV2_0_0
  @supportedOnHealthConnect
  static const speedSeries = SpeedSeriesDataType();

  /// Walking speed data type (iOS HealthKit only).
  @sinceV2_0_0
  @supportedOnAppleHealth
  static const walkingSpeed = WalkingSpeedDataType();

  /// Running speed data type (iOS HealthKit only).
  @sinceV2_0_0
  @supportedOnAppleHealth
  static const runningSpeed = RunningSpeedDataType();

  /// Stair ascent speed data type (iOS HealthKit only).
  @sinceV2_0_0
  @supportedOnAppleHealth
  static const stairAscentSpeed = StairAscentSpeedDataType();

  /// Stair descent speed data type (iOS HealthKit only).
  @sinceV2_0_0
  @supportedOnAppleHealth
  static const stairDescentSpeed = StairDescentSpeedDataType();

  /// Step count data type.
  ///
  /// Represents the number of steps taken by the user. Supports both reading
  /// existing step count data and writing new step count entries.
  static const steps = StepsHealthDataType();

  /// Body weight data type.
  ///
  /// Represents the user's body weight measurements. Supports both reading
  /// existing weight data and writing new weight measurements.
  static const weight = WeightHealthDataType();

  /// Blood glucose data type.
  ///
  /// Represents the concentration of glucose in the blood.
  /// Supports AVG, MIN, MAX aggregation.
  @sinceV1_4_0
  static const bloodGlucose = BloodGlucoseHealthDataType();

  /// Blood pressure data type (composite).
  ///
  /// Represents a composite blood pressure measurement with both systolic
  /// and diastolic values. Supports AVG, MIN, MAX aggregation.
  @sinceV1_2_0
  static const bloodPressure = BloodPressureHealthDataType();

  /// Systolic blood pressure data type.
  ///
  /// Represents the systolic (upper) blood pressure value.
  /// Supports AVG, MIN, MAX aggregation.
  @sinceV1_2_0
  @supportedOnAppleHealth
  static const systolicBloodPressure = SystolicBloodPressureHealthDataType();

  /// Diastolic blood pressure data type.
  ///
  /// Represents the diastolic (lower) blood pressure value.
  /// Supports AVG, MIN, MAX aggregation.
  @sinceV1_2_0
  @supportedOnAppleHealth
  static const diastolicBloodPressure = DiastolicBloodPressureHealthDataType();

  /// Body fat percentage data type.
  ///
  /// Represents the user's body fat percentage measurements.
  /// Body fat percentage is expressed as a decimal value between 0 and
  /// 1 (e.g., 0.25 = 25%). Supports both reading existing body fat percentage
  /// data and writing new measurements.
  static const bodyFatPercentage = BodyFatPercentageHealthDataType();

  /// Body temperature data type.
  ///
  /// Represents the user's body temperature measurements. Supports both reading
  /// existing body temperature data and writing new measurements.
  static const bodyTemperature = BodyTemperatureHealthDataType();

  /// Basal body temperature data type.
  ///
  /// Represents basal body temperature measurements, which are the lowest body
  /// temperature attained during rest. Typically measured immediately after
  /// waking and before any physical activity. Commonly used for fertility
  /// tracking and menstrual cycle monitoring.
  @sinceV2_2_0
  static const basalBodyTemperature = BasalBodyTemperatureHealthDataType();

  /// Bone mass data type.
  ///
  /// Represents the user's bone mass measurements.
  /// Supports reading, writing, and deletion.
  @sinceV2_2_0
  @supportedOnHealthConnect
  static const boneMass = BoneMassDataType();

  /// Body water mass data type.
  ///
  /// Represents the user's body water mass measurements.
  /// Supports reading, writing, and deletion.
  @sinceV2_2_0
  @supportedOnHealthConnect
  static const bodyWaterMass = BodyWaterMassDataType();

  /// Heart rate variability (RMSSD) data type.
  ///
  /// Represents the user's heart rate variability (RMSSD) measurements.
  /// Supports reading, writing, and deletion.
  @sinceV2_2_0
  @supportedOnHealthConnect
  static const heartRateVariabilityRMSSD = HeartRateVariabilityRMSSDDataType();

  /// Heart rate variability (SDNN) data type.
  ///
  /// Represents the user's heart rate variability (SDNN) measurements.
  /// Supports reading, writing, and deletion.
  @sinceV2_2_0
  @supportedOnAppleHealth
  static const heartRateVariabilitySDNN = HeartRateVariabilitySDNNDataType();

  /// Body mass index data type.
  ///
  /// Represents the user's body mass index (BMI).
  /// Supports reading, writing, and deletion.
  @sinceV2_2_0
  @supportedOnAppleHealth
  static const bodyMassIndex = BodyMassIndexHealthDataType();

  /// Waist circumference data type.
  ///
  /// Represents the user's waist circumference.
  /// Supports reading, writing, and deletion.
  @sinceV2_2_0
  @supportedOnAppleHealth
  static const waistCircumference = WaistCircumferenceHealthDataType();

  /// Cervical mucus data type.
  ///
  /// Represents cervical mucus observations including appearance and sensation.
  /// Used for fertility tracking. Supports reading, writing, and deletion of
  /// cervical mucus records.
  @sinceV2_1_0
  static const cervicalMucus = CervicalMucusDataType();

  /// Body height data type.
  ///
  /// Represents the user's body height measurements. Supports both reading
  /// existing height data and writing new height measurements.
  static const height = HeightHealthDataType();

  /// Active calories burned data type.
  ///
  /// Represents the amount of energy (calories) burned during physical activity
  /// over a time interval. Active calories are those burned through exercise
  /// and movement, excluding basal metabolic rate. Supports both reading
  /// existing active calories data and writing new measurements.
  static const activeCaloriesBurned = ActiveCaloriesBurnedHealthDataType();

  /// Exercise session data type.
  ///
  /// Represents exercise sessions with exercise type, duration, and notes.
  /// Supports reading, writing, sum aggregation, and deletion.
  @sinceV2_0_0
  static const exerciseSession = ExerciseSessionHealthDataType();

  /// Floors climbed data type.
  ///
  /// Represents the number of floors (flights of stairs) climbed during
  /// a time interval. A floor is typically defined as a vertical distance
  /// of approximately 3 meters (10 feet). Supports both reading existing
  /// floors climbed data and writing new measurements.
  static const floorsClimbed = FloorsClimbedHealthDataType();

  /// Wheelchair pushes data type.
  ///
  /// Represents the number of wheelchair pushes performed during
  /// a time interval. A push represents a single propulsion action
  /// used to move a wheelchair forward. Supports both reading existing
  /// wheelchair pushes data and writing new measurements.
  static const wheelchairPushes = WheelchairPushesHealthDataType();

  /// Lean body mass data type.
  ///
  /// Represents the user's lean body mass measurements. Lean body mass
  /// is the total weight of the body minus the weight of body fat.
  /// Supports both reading existing lean body mass data and writing
  /// new measurements.
  static const leanBodyMass = LeanBodyMassHealthDataType();

  /// Hydration (water intake) data type.
  ///
  /// Represents the volume of water consumed over a time interval.
  /// Tracks water consumption to help users monitor daily hydration levels
  /// and maintain healthy fluid intake. Supports both reading existing
  /// hydration data and writing new measurements.
  static const hydration = HydrationHealthDataType();

  /// Heart rate series record data type (Android Health Connect only).
  ///
  /// Represents a series of heart rate measurements over a time interval.
  /// Each record has a single ID that encompasses all heart rate measurements.
  ///
  /// Supports both reading existing heart rate data and writing
  /// new measurements.
  @supportedOnHealthConnect
  static const heartRateSeriesRecord = HeartRateSeriesRecordHealthDataType();

  /// Heart rate measurement record data type (iOS HealthKit only).
  ///
  /// Represents a single heart rate measurement at a specific point in time.
  /// Each record has its own UUID.
  ///
  /// Supports both reading existing heart rate data and writing
  /// new measurements.
  @supportedOnAppleHealth
  static const heartRateMeasurementRecord =
      HeartRateMeasurementRecordHealthDataType();

  /// Sleep session health data type (Android Health Connect only).
  ///
  /// Represents a complete sleep session with multiple sleep stages.
  /// Each sleep session has a single ID that encompasses all stages.
  ///
  /// Supports both reading existing sleep data and writing new sessions.
  @supportedOnHealthConnect
  static const sleepSession = SleepSessionHealthDataType();

  /// Sleep stage record health data type (iOS HealthKit only).
  ///
  /// Sleep stage records is an individual measurements, one per sleep stage.
  /// A complete night's sleep consists of multiple records.
  /// Each record has its own UUID.
  ///
  /// Supports both reading existing sleep data and writing new measurements.
  @supportedOnAppleHealth
  static const sleepStageRecord = SleepStageHealthDataType();

  /// Mindfulness session data type.
  ///
  /// Represents mindfulness sessions including meditation, breathing exercises,
  /// and other mindfulness activities. Supports reading, writing, deletion,
  /// and SUM aggregation for total mindfulness duration.
  @sinceV2_1_0
  static const mindfulnessSession = MindfulnessSessionDataType();

  /// Sexual activity data type.
  ///
  /// Represents sexual activity sessions with optional information about
  /// whether protection was used.
  @sinceV2_1_0
  static const sexualActivity = SexualActivityDataType();

  /// Resting heart rate data type.
  ///
  /// Represents the heart rate while at complete rest, typically measured
  /// first thing in the morning before getting out of bed.
  /// Supports AVG, MIN, MAX aggregation.
  @sinceV1_3_0
  static const restingHeartRate = RestingHeartRateHealthDataType();

  /// Ovulation test data type.
  ///
  /// Represents ovulation test results that detect hormonal changes to
  /// identify fertility windows. Results can be negative, inconclusive,
  /// high (estrogen surge), or positive (LH surge).
  @sinceV2_2_0
  static const ovulationTest = OvulationTestDataType();

  /// Intermenstrual bleeding data type.
  ///
  /// Represents occurrences of vaginal bleeding between menstrual periods
  /// (spotting). Used for fertility tracking and cycle monitoring.
  @sinceV2_2_0
  static const intermenstrualBleeding = IntermenstrualBleedingDataType();

  /// Menstrual flow instant data type.
  ///
  /// Represents the intensity of menstrual flow at a specific point in time.
  /// This data type is for Android Health Connect only. iOS uses
  /// [menstrualFlow] instead, which tracks flow over intervals with
  /// cycle start metadata.
  @sinceV2_2_0
  @supportedOnHealthConnect
  static const menstrualFlowInstant = MenstrualFlowInstantDataType();

  /// Menstrual flow data type.
  ///
  /// Represents the intensity of menstrual flow over a time interval,
  /// including cycle start metadata. This data type is for iOS HealthKit only.
  /// Android uses [menstrualFlowInstant] instead, which tracks flow at
  /// specific points in time.
  @sinceV2_2_0
  @supportedOnAppleHealth
  static const menstrualFlow = MenstrualFlowDataType();

  /// Oxygen saturation data type.
  ///
  /// Represents the percentage of oxygen-saturated hemoglobin relative
  /// to total hemoglobin in the blood. Supports reading and writing
  /// oxygen saturation measurements.
  @sinceV1_3_0
  static const oxygenSaturation = OxygenSaturationHealthDataType();

  /// Power data type (Android Health Connect only).
  ///
  /// Represents power measurements as a series of samples over a time interval.
  /// For iOS, use [cyclingPower].
  @sinceV2_1_0
  @supportedOnHealthConnect
  static const powerSeries = PowerSeriesDataType();

  /// Cycling power data type (iOS HealthKit only).
  ///
  /// Represents cycling power output measurements.
  /// For Android, use [powerSeries].
  @sinceV2_1_0
  @supportedOnAppleHealth
  static const cyclingPower = CyclingPowerDataType();

  /// Cycling pedaling cadence series record data type.
  ///
  /// Represents cycling cadence measurements in revolutions per minute (RPM).
  /// Each record contains multiple cadence samples over a time interval.
  ///
  /// Supports AVG, MIN, MAX aggregation.
  @sinceV2_2_0
  @supportedOnHealthConnect
  static const cyclingPedalingCadenceSeriesRecord =
      CyclingPedalingCadenceSeriesRecordHealthDataType();

  /// Cycling pedaling cadence measurement record data type.
  ///
  /// Represents individual cycling cadence measurements in revolutions per
  /// minute (RPM).
  /// Each record is a discrete measurement at a specific point in time.
  ///
  /// Supports AVG, MIN, MAX aggregation.
  @sinceV2_2_0
  @supportedOnAppleHealth
  static const cyclingPedalingCadenceMeasurementRecord =
      CyclingPedalingCadenceMeasurementRecordHealthDataType();

  /// Respiratory rate data type.
  ///
  /// Represents the number of breaths a person takes per minute.
  /// Supports reading and writing respiratory rate measurements.
  @sinceV1_0_0
  static const respiratoryRate = RespiratoryRateHealthDataType();

  /// VO₂ max (maximal oxygen uptake) data type.
  ///
  /// Represents the maximum rate of oxygen consumption during exercise,
  /// a key indicator of cardiorespiratory fitness.
  /// Supports AVG, MIN, MAX aggregation.
  @sinceV1_3_0
  static const vo2Max = Vo2MaxHealthDataType();

  /// Nutrition health data type.
  ///
  /// Represents a complete nutrition record that can contain multiple
  /// nutrients.
  @sinceV1_1_0
  static const nutrition = NutritionHealthDataType();

  /// Energy (calorie) nutrient data type.
  ///
  /// Represents energy intake in calories. Supports reading, writing,
  /// and sum aggregation of energy nutrient records.
  @sinceV1_1_0
  static const energyNutrient = EnergyNutrientDataType();

  /// Total calories burned data type.
  ///
  /// Represents the total energy burned by the user, including both
  /// active energy and basal metabolic rate.
  ///
  /// Supports reading, writing, and sum aggregation.
  @sinceV2_2_0
  @supportedOnHealthConnect
  static const totalCaloriesBurned = TotalCaloriesBurnedHealthDataType();

  /// Basal energy burned data type.
  ///
  /// Represents the energy burned by the body at rest (BMR).
  ///
  /// Supports reading, writing, and sum aggregation.
  @sinceV2_2_0
  @supportedOnAppleHealth
  static const basalEnergyBurned = BasalEnergyBurnedHealthDataType();

  /// Caffeine nutrient data type.
  ///
  /// Represents caffeine intake. Supports reading, writing,
  /// and sum aggregation of caffeine nutrient records.
  @sinceV1_1_0
  static const caffeine = CaffeineNutrientDataType();

  /// Protein nutrient data type.
  ///
  /// Represents protein intake. Supports reading, writing,
  /// and sum aggregation of protein nutrient records.
  @sinceV1_1_0
  static const protein = ProteinNutrientDataType();

  /// Total carbohydrate nutrient data type.
  ///
  /// Represents total carbohydrate intake. Supports reading, writing,
  /// and sum aggregation of total carbohydrate nutrient records.
  @sinceV1_1_0
  static const totalCarbohydrate = TotalCarbohydrateNutrientDataType();

  /// Total fat nutrient data type.
  ///
  /// Represents total fat intake. Supports reading, writing,
  /// and sum aggregation of total fat nutrient records.
  @sinceV1_1_0
  static const totalFat = TotalFatNutrientDataType();

  /// Saturated fat nutrient data type.
  ///
  /// Represents saturated fat intake. Supports reading, writing,
  /// and sum aggregation of saturated fat nutrient records.
  @sinceV1_1_0
  static const saturatedFat = SaturatedFatNutrientDataType();

  /// Monounsaturated fat nutrient data type.
  ///
  /// Represents monounsaturated fat intake. Supports reading, writing,
  /// and sum aggregation of monounsaturated fat nutrient records.
  @sinceV1_1_0
  static const monounsaturatedFat = MonounsaturatedFatNutrientDataType();

  /// Polyunsaturated fat nutrient data type.
  ///
  /// Represents polyunsaturated fat intake. Supports reading, writing,
  /// and sum aggregation of polyunsaturated fat nutrient records.
  @sinceV1_1_0
  static const polyunsaturatedFat = PolyunsaturatedFatNutrientDataType();

  /// Cholesterol nutrient data type.
  ///
  /// Represents cholesterol intake. Supports reading, writing,
  /// and sum aggregation of cholesterol nutrient records.
  @sinceV1_1_0
  static const cholesterol = CholesterolNutrientDataType();

  /// Dietary fiber nutrient data type.
  ///
  /// Represents dietary fiber intake. Supports reading, writing,
  /// and sum aggregation of dietary fiber nutrient records.
  @sinceV1_1_0
  static const dietaryFiber = DietaryFiberNutrientDataType();

  /// Sugar nutrient data type.
  ///
  /// Represents sugar intake. Supports reading, writing,
  /// and sum aggregation of sugar nutrient records.
  @sinceV1_1_0
  static const sugar = SugarNutrientDataType();

  /// Calcium nutrient data type.
  ///
  /// Represents calcium intake. Supports reading, writing,
  /// and sum aggregation of calcium nutrient records.
  @sinceV1_1_0
  static const calcium = CalciumNutrientDataType();

  /// Iron nutrient data type.
  ///
  /// Represents iron intake. Supports reading, writing,
  /// and sum aggregation of iron nutrient records.
  @sinceV1_1_0
  static const iron = IronNutrientDataType();

  /// Magnesium nutrient data type.
  ///
  /// Represents magnesium intake. Supports reading, writing,
  /// and sum aggregation of magnesium nutrient records.
  @sinceV1_1_0
  static const magnesium = MagnesiumNutrientDataType();

  /// Manganese nutrient data type.
  ///
  /// Represents manganese intake. Supports reading, writing,
  /// and sum aggregation of manganese nutrient records.
  @sinceV1_1_0
  static const manganese = ManganeseNutrientDataType();

  /// Phosphorus nutrient data type.
  ///
  /// Represents phosphorus intake. Supports reading, writing,
  /// and sum aggregation of phosphorus nutrient records.
  @sinceV1_1_0
  static const phosphorus = PhosphorusNutrientDataType();

  /// Potassium nutrient data type.
  ///
  /// Represents potassium intake. Supports reading, writing,
  /// and sum aggregation of potassium nutrient records.
  @sinceV1_1_0
  static const potassium = PotassiumNutrientDataType();

  /// Selenium nutrient data type.
  ///
  /// Represents selenium intake. Supports reading, writing,
  /// and sum aggregation of selenium nutrient records.
  @sinceV1_1_0
  static const selenium = SeleniumNutrientDataType();

  /// Sodium nutrient data type.
  ///
  /// Represents sodium intake. Supports reading, writing,
  /// and sum aggregation of sodium nutrient records.
  @sinceV1_1_0
  static const sodium = SodiumNutrientDataType();

  /// Zinc nutrient data type.
  ///
  /// Represents zinc intake. Supports reading, writing,
  /// and sum aggregation of zinc nutrient records.
  @sinceV1_1_0
  static const zinc = ZincNutrientDataType();

  /// Vitamin A nutrient data type.
  ///
  /// Represents vitamin A intake. Supports reading, writing,
  /// and sum aggregation of vitamin A nutrient records.
  @sinceV1_1_0
  static const vitaminA = VitaminANutrientDataType();

  /// Vitamin B6 nutrient data type.
  ///
  /// Represents vitamin B6 intake. Supports reading, writing,
  /// and sum aggregation of vitamin B6 nutrient records.
  @sinceV1_1_0
  static const vitaminB6 = VitaminB6NutrientDataType();

  /// Vitamin B12 nutrient data type.
  ///
  /// Represents vitamin B12 intake. Supports reading, writing,
  /// and sum aggregation of vitamin B12 nutrient records.
  @sinceV1_1_0
  static const vitaminB12 = VitaminB12NutrientDataType();

  /// Vitamin C nutrient data type.
  ///
  /// Represents vitamin C intake. Supports reading, writing,
  /// and sum aggregation of vitamin C nutrient records.
  @sinceV1_1_0
  static const vitaminC = VitaminCNutrientDataType();

  /// Vitamin D nutrient data type.
  ///
  /// Represents vitamin D intake. Supports reading, writing,
  /// and sum aggregation of vitamin D nutrient records.
  @sinceV1_1_0
  static const vitaminD = VitaminDNutrientDataType();

  /// Vitamin E nutrient data type.
  ///
  /// Represents vitamin E intake. Supports reading, writing,
  /// and sum aggregation of vitamin E nutrient records.
  @sinceV1_1_0
  static const vitaminE = VitaminENutrientDataType();

  /// Vitamin K nutrient data type.
  ///
  /// Represents vitamin K intake. Supports reading, writing,
  /// and sum aggregation of vitamin K nutrient records.
  @sinceV1_1_0
  static const vitaminK = VitaminKNutrientDataType();

  /// Thiamin nutrient data type.
  ///
  /// Represents thiamin (vitamin B1) intake. Supports reading, writing,
  /// and sum aggregation of thiamin nutrient records.
  @sinceV1_1_0
  static const thiamin = ThiaminNutrientDataType();

  /// Riboflavin nutrient data type.
  ///
  /// Represents riboflavin (vitamin B2) intake. Supports reading, writing,
  /// and sum aggregation of riboflavin nutrient records.
  @sinceV1_1_0
  static const riboflavin = RiboflavinNutrientDataType();

  /// Niacin nutrient data type.
  ///
  /// Represents niacin (vitamin B3) intake. Supports reading, writing,
  /// and sum aggregation of niacin nutrient records.
  @sinceV1_1_0
  static const niacin = NiacinNutrientDataType();

  /// Folate nutrient data type.
  ///
  /// Represents folate (vitamin B9) intake. Supports reading, writing,
  /// and sum aggregation of folate nutrient records.
  @sinceV1_1_0
  static const folate = FolateNutrientDataType();

  /// Biotin nutrient data type.
  ///
  /// Represents biotin (vitamin B7) intake. Supports reading, writing,
  /// and sum aggregation of biotin nutrient records.
  @sinceV1_1_0
  static const biotin = BiotinNutrientDataType();

  /// Pantothenic acid nutrient data type.
  ///
  /// Represents pantothenic acid (vitamin B5) intake.
  @sinceV1_1_0
  static const pantothenicAcid = PantothenicAcidNutrientDataType();

  /// Returns a list of all available health data types.
  static const values = <HealthDataType<HealthRecord, MeasurementUnit>>[
    activeCaloriesBurned,
    basalBodyTemperature,
    basalEnergyBurned,
    biotin,
    bodyWaterMass,
    boneMass,
    bodyMassIndex,
    bloodGlucose,
    bloodPressure,
    bodyFatPercentage,
    bodyTemperature,
    caffeine,
    calcium,
    cervicalMucus,
    cholesterol,
    crossCountrySkiingDistance,
    cyclingPedalingCadenceMeasurementRecord,
    cyclingPedalingCadenceSeriesRecord,
    cyclingPower,
    diastolicBloodPressure,
    dietaryFiber,
    distance,
    downhillSnowSportsDistance,
    energyNutrient,
    exerciseSession,
    floorsClimbed,
    folate,
    heartRateMeasurementRecord,
    heartRateSeriesRecord,
    heartRateVariabilityRMSSD,
    heartRateVariabilitySDNN,
    height,
    hydration,
    intermenstrualBleeding,
    iron,
    leanBodyMass,
    magnesium,
    manganese,
    menstrualFlow,
    menstrualFlowInstant,
    mindfulnessSession,
    monounsaturatedFat,
    niacin,
    nutrition,
    ovulationTest,
    oxygenSaturation,
    paddleSportsDistance,
    pantothenicAcid,
    phosphorus,
    polyunsaturatedFat,
    potassium,
    powerSeries,
    protein,
    respiratoryRate,
    restingHeartRate,
    riboflavin,
    rowingDistance,
    runningSpeed,
    saturatedFat,
    selenium,
    sexualActivity,
    sixMinuteWalkTestDistance,
    skatingSportsDistance,
    sleepSession,
    sleepStageRecord,
    sodium,
    speedSeries,
    stairAscentSpeed,
    stairDescentSpeed,
    steps,
    sugar,
    swimmingDistance,
    systolicBloodPressure,
    thiamin,
    totalCaloriesBurned,
    totalCarbohydrate,
    totalFat,
    vitaminA,
    vitaminB12,
    vitaminB6,
    vitaminC,
    vitaminD,
    vitaminE,
    vitaminK,
    vo2Max,
    waistCircumference,
    walkingRunningDistance,
    walkingSpeed,
    weight,
    wheelchairDistance,
    wheelchairPushes,
    zinc,
  ];

  /// Returns a list of all available health data types for
  /// [HealthPlatform.healthConnect].
  static final healthConnectDataTypes = values.where(
    (type) => type.supportedHealthPlatforms.contains(
      HealthPlatform.healthConnect,
    ),
  );

  /// Returns a list of all available health data types for
  /// [HealthPlatform.appleHealth].
  static final appleHealthDataTypes = values.where(
    (type) => type.supportedHealthPlatforms.contains(
      HealthPlatform.appleHealth,
    ),
  );

  /// Set of all nutrient data types, excluding [HealthDataType.nutrition]
  /// container data type.
  ///
  /// These represent individual nutrients like vitamins, minerals, and
  /// macronutrients that can be tracked separately.
  static final nutrientTypes = <HealthDataType<HealthRecord, MeasurementUnit>>[
    HealthDataType.biotin,
    HealthDataType.caffeine,
    HealthDataType.calcium,
    HealthDataType.cholesterol,
    HealthDataType.dietaryFiber,
    HealthDataType.energyNutrient,
    HealthDataType.folate,
    HealthDataType.iron,
    HealthDataType.magnesium,
    HealthDataType.manganese,
    HealthDataType.monounsaturatedFat,
    HealthDataType.niacin,
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
  ];
}
