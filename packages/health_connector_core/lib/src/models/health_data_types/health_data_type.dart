import 'package:health_connector_core/src/annotations/annotations.dart';
import 'package:health_connector_core/src/config/health_connector_config_constants.dart'
    show HealthConnectorConfigConstants;
import 'package:health_connector_core/src/models/health_data_sync/health_data_sync_token.dart';
import 'package:health_connector_core/src/models/health_data_types/health_data_type_capabilities/health_data_type_capabilities.dart';
import 'package:health_connector_core/src/models/health_platform.dart';
import 'package:health_connector_core/src/models/health_platform_data.dart'
    show HealthPlatformData;
import 'package:health_connector_core/src/models/health_records/health_record.dart';
import 'package:health_connector_core/src/models/measurement_units/measurement_unit.dart';
import 'package:health_connector_core/src/models/metadata/metadata.dart';
import 'package:health_connector_core/src/models/permissions/permission.dart';
import 'package:health_connector_core/src/models/requests/aggregate_requests/aggregate_request.dart';
import 'package:health_connector_core/src/models/requests/aggregate_requests/aggregation_metric.dart';
import 'package:health_connector_core/src/models/requests/delete_requests/delete_records_request.dart';
import 'package:health_connector_core/src/models/requests/read_requests/read_records_request.dart';
import 'package:meta/meta.dart' show immutable, internal;

part 'activity_intensity_data_type.dart';
part 'alcoholic_beverages_data_type.dart';
part 'blood_alcohol_content_data_type.dart';
part 'blood_glucose_data_type.dart';
part 'blood_pressure/blood_pressure_data_type.dart';
part 'blood_pressure/diastolic_blood_pressure_data_type.dart';
part 'blood_pressure/systolic_blood_pressure_data_type.dart';
part 'body_fat_percentage_data_type.dart';
part 'body_mass_index_data_type.dart';
part 'body_water_mass_data_type.dart';
part 'bone_mass_data_type.dart';
part 'cycling_pedaling_cadence/cycling_pedaling_cadence_data_type.dart';
part 'cycling_pedaling_cadence/cycling_pedaling_cadence_series_data_type.dart';
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
part 'electrodermal_activity_data_type.dart';
part 'elevation_gained_data_type.dart';
part 'energy_burned/active_energy_burned_data_type.dart';
part 'energy_burned/basal_energy_burned_data_type.dart';
part 'energy_burned/total_energy_burned_data_type.dart';
part 'events/high_heart_rate_event_data_type.dart';
part 'events/infrequent_menstrual_cycle_event_data_type.dart';
part 'events/irregular_heart_rhythm_event_data_type.dart';
part 'events/irregular_menstrual_cycle_event_data_type.dart';
part 'events/low_heart_rate_event_data_type.dart';
part 'events/persistent_intermenstrual_bleeding_event_data_type.dart';
part 'events/prolonged_menstrual_period_event_data_type.dart';
part 'exercise_session_data_type.dart';
part 'floors_climbed_data_type.dart';
part 'forced_expiratory_volume_data_type.dart';
part 'forced_vital_capacity_data_type.dart';
part 'health_data_type_category.dart';
part 'heart_rate/atrial_fibrillation_burden_data_type.dart';
part 'heart_rate/heart_rate_data_type.dart';
part 'heart_rate/heart_rate_recovery_one_minute_data_type.dart';
part 'heart_rate/heart_rate_series_data_type.dart';
part 'heart_rate/heart_rate_variability_rmssd_data_type.dart';
part 'heart_rate/heart_rate_variability_sdnn_data_type.dart';
part 'heart_rate/resting_heart_rate_data_type.dart';
part 'heart_rate/walking_heart_rate_average_data_type.dart';
part 'height_data_type.dart';
part 'hydration_data_type.dart';
part 'inhaler_usage_data_type.dart';
part 'insulin_delivery_data_type.dart';
part 'lean_body_mass_data_type.dart';
part 'menstruation/cervical_mucus_data_type.dart';
part 'menstruation/contraceptive_data_type.dart';
part 'menstruation/intermenstrual_bleeding_data_type.dart';
part 'menstruation/lactation_data_type.dart';
part 'menstruation/menstrual_flow_data_type.dart';
part 'menstruation/menstrual_flow_instant_data_type.dart';
part 'menstruation/ovulation_test_data_type.dart';
part 'menstruation/pregnancy_data_type.dart';
part 'menstruation/pregnancy_test_data_type.dart';
part 'menstruation/progesterone_test_data_type.dart';
part 'mindfulness_session_data_type.dart';
part 'number_of_times_fallen_data_type.dart';
part 'nutrition/dietary_biotin_data_type.dart';
part 'nutrition/dietary_caffeine_data_type.dart';
part 'nutrition/dietary_calcium_data_type.dart';
part 'nutrition/dietary_cholesterol_data_type.dart';
part 'nutrition/dietary_energy_consumed_data_type.dart';
part 'nutrition/dietary_fiber_nutrient_data_type.dart';
part 'nutrition/dietary_folate_data_type.dart';
part 'nutrition/dietary_iron_data_type.dart';
part 'nutrition/dietary_macronutrient_data_type.dart';
part 'nutrition/dietary_magnesium_data_type.dart';
part 'nutrition/dietary_manganese_data_type.dart';
part 'nutrition/dietary_mineral_data_type.dart';
part 'nutrition/dietary_monounsaturated_fat_data_type.dart';
part 'nutrition/dietary_niacin_data_type.dart';
part 'nutrition/dietary_nutrient_data_type.dart';
part 'nutrition/dietary_pantothenic_acid_data_type.dart';
part 'nutrition/dietary_phosphorus_data_type.dart';
part 'nutrition/dietary_polyunsaturated_fat_data_type.dart';
part 'nutrition/dietary_potassium_data_type.dart';
part 'nutrition/dietary_protein_data_type.dart';
part 'nutrition/dietary_riboflavin_data_type.dart';
part 'nutrition/dietary_saturated_fat_data_type.dart';
part 'nutrition/dietary_selenium_data_type.dart';
part 'nutrition/dietary_sodium_data_type.dart';
part 'nutrition/dietary_sugar_data_type.dart';
part 'nutrition/dietary_thiamin_data_type.dart';
part 'nutrition/dietary_total_carbohydrate_data_type.dart';
part 'nutrition/dietary_total_fat_data_type.dart';
part 'nutrition/dietary_vitamin_a_data_type.dart';
part 'nutrition/dietary_vitamin_b12_data_type.dart';
part 'nutrition/dietary_vitamin_b6_data_type.dart';
part 'nutrition/dietary_vitamin_c_data_type.dart';
part 'nutrition/dietary_vitamin_d_data_type.dart';
part 'nutrition/dietary_vitamin_data_type.dart';
part 'nutrition/dietary_vitamin_e_data_type.dart';
part 'nutrition/dietary_vitamin_k_data_type.dart';
part 'nutrition/dietary_zinc_data_type.dart';
part 'nutrition/nutrition_data_type.dart';
part 'oxygen_saturation_data_type.dart';
part 'peripheral_perfusion_index_data_type.dart';
part 'power/cycling_power_data_type.dart';
part 'power/power_series_data_type.dart';
part 'power/running_power_health_data_type.dart';
part 'respiratory_rate_data_type.dart';
part 'sexual_activity_data_type.dart';
part 'sleep/sleep_session_data_type.dart';
part 'sleep/sleep_stage_record_data_type.dart';
part 'speed/running_speed_data_type.dart';
part 'speed/speed_activity_data_type.dart';
part 'speed/speed_series_data_type.dart';
part 'speed/stair_ascent_speed_data_type.dart';
part 'speed/stair_descent_speed_data_type.dart';
part 'speed/walking_speed_data_type.dart';
part 'steps_cadence_series_data_type.dart';
part 'steps_data_type.dart';
part 'swimming_strokes_data_type.dart';
part 'temperature/basal_body_temperature_data_type.dart';
part 'temperature/body_temperature_data_type.dart';
part 'temperature/sleeping_wrist_temperature_data_type.dart';
part 'time/exercise_time_data_type.dart';
part 'time/move_time_data_type.dart';
part 'time/stand_time_data_type.dart';
part 'vo2_max_data_type.dart';
part 'waist_circumference_data_type.dart';
part 'walking/walking_asymmetry_percentage_data_type.dart';
part 'walking/walking_double_support_percentage_data_type.dart';
part 'walking/walking_steadiness_data_type.dart';
part 'walking/walking_steadiness_event_data_type.dart';
part 'walking/walking_step_length_data_type.dart';
part 'weight_data_type.dart';
part 'wheelchair_pushes_data_type.dart';

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
///   case StepsDataType(): // ...
///   case WeightDataType(): // ...
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
///   case StepsDataType(): // ...
///   case WeightDataType(): // ...
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
/// {@category Health Records}
@sinceV1_0_0
@immutable
sealed class HealthDataType<R extends HealthRecord, U extends MeasurementUnit>
    implements HealthPlatformData {
  const HealthDataType();

  /// The list of aggregation metrics that support this health record.
  List<AggregationMetric> get supportedAggregationMetrics;

  /// The list of permissions for this health record.
  List<Permission> get permissions;

  /// The category this health data type belongs to.
  ///
  /// Categories help organize health data types into logical groups for
  /// better discoverability and filtering.
  ///
  /// ## Example
  ///
  /// ```dart
  /// final category = HealthDataType.steps.category;
  /// print(category); // HealthDataTypeCategory.activity
  /// ```
  HealthDataTypeCategory get category;

  /// A unique string identifier for this health data type.
  ///
  /// This id is used for stable JSON serialization, for example when
  /// persisting a [HealthDataSyncToken].
  @internalUse
  String get id;

  @override
  String toString() => id;

  /// A map of all available health data types by their unique [id].
  ///
  /// This map is primarily used for efficient lookup during JSON
  /// deserialization.
  @internal
  static final dataTypeMap = Map.fromEntries(
    values.map((e) => MapEntry(e.id, e)),
  );

  /// Distance data type.
  ///
  /// Represents the distance traveled during activities such as walking,
  /// running, or cycling.
  @supportedOnHealthConnect
  static const distance = DistanceDataType();

  /// Cycling distance data type.
  @sinceV2_0_0
  @supportedOnAppleHealth
  static const cyclingDistance = CyclingDistanceDataType();

  /// Swimming distance data type.
  @sinceV2_0_0
  @supportedOnAppleHealth
  static const swimmingDistance = SwimmingDistanceDataType();

  /// Swimming strokes count data type.
  @sinceV3_1_0
  @supportedOnAppleHealth
  static const swimmingStrokes = SwimmingStrokesDataType();

  /// Wheelchair distance data type.
  @sinceV2_0_0
  @supportedOnAppleHealth
  static const wheelchairDistance = WheelchairDistanceDataType();

  /// Downhill snow sports distance data type.
  @sinceV2_0_0
  @supportedOnAppleHealth
  static const downhillSnowSportsDistance =
      DownhillSnowSportsDistanceDataType();

  /// Rowing distance data type.
  @sinceV2_0_0
  @supportedOnAppleHealth
  @supportedOnAppleHealthIOS18Plus
  static const rowingDistance = RowingDistanceDataType();

  /// Paddle sports distance data type.
  @sinceV2_0_0
  @supportedOnAppleHealth
  @supportedOnAppleHealthIOS18Plus
  static const paddleSportsDistance = PaddleSportsDistanceDataType();

  /// Cross-country skiing distance data type.
  @sinceV2_0_0
  @supportedOnAppleHealth
  @supportedOnAppleHealthIOS18Plus
  static const crossCountrySkiingDistance =
      CrossCountrySkiingDistanceDataType();

  /// Skating sports distance data type.
  @sinceV2_0_0
  @supportedOnAppleHealth
  @supportedOnAppleHealthIOS18Plus
  static const skatingSportsDistance = SkatingSportsDistanceDataType();

  /// Six-minute walk test distance data type.
  @sinceV2_0_0
  @supportedOnAppleHealth
  static const sixMinuteWalkTestDistance = SixMinuteWalkTestDistanceDataType();

  /// Walking running distance data type.
  @sinceV2_0_0
  @supportedOnAppleHealth
  static const walkingRunningDistance = WalkingRunningDistanceDataType();

  /// Speed data type.
  ///
  /// Represents speed measurements as a series of samples over a time interval.
  @sinceV2_0_0
  @supportedOnHealthConnect
  static const speedSeries = SpeedSeriesDataType();

  /// Walking speed data type.
  @sinceV2_0_0
  @supportedOnAppleHealth
  @supportedOnAppleHealthIOS16Plus
  static const walkingSpeed = WalkingSpeedDataType();

  /// Running speed data type.
  @sinceV2_0_0
  @supportedOnAppleHealth
  @supportedOnAppleHealthIOS16Plus
  static const runningSpeed = RunningSpeedDataType();

  /// Stair ascent speed data type.
  @sinceV2_0_0
  @supportedOnAppleHealth
  @supportedOnAppleHealthIOS16Plus
  static const stairAscentSpeed = StairAscentSpeedDataType();

  /// Stair descent speed data type.
  @sinceV2_0_0
  @supportedOnAppleHealth
  @supportedOnAppleHealthIOS16Plus
  static const stairDescentSpeed = StairDescentSpeedDataType();

  /// Step count data type.
  ///
  /// Represents the number of steps taken by the user.
  static const steps = StepsDataType();

  /// Body weight data type.
  ///
  /// Represents the user's body weight measurements.
  static const weight = WeightDataType();

  /// Blood glucose data type.
  ///
  /// Represents the concentration of glucose in the blood.

  @sinceV1_4_0
  static const bloodGlucose = BloodGlucoseDataType();

  /// Blood pressure data type (composite).
  ///
  /// Represents a composite blood pressure measurement with both systolic
  /// and diastolic values.
  @sinceV1_2_0
  static const bloodPressure = BloodPressureDataType();

  /// Systolic blood pressure data type.
  ///
  /// Represents the systolic (upper) blood pressure value.

  @sinceV1_2_0
  @supportedOnAppleHealth
  static const systolicBloodPressure = SystolicBloodPressureDataType();

  /// Diastolic blood pressure data type.
  ///
  /// Represents the diastolic (lower) blood pressure value.

  @sinceV1_2_0
  @supportedOnAppleHealth
  static const diastolicBloodPressure = DiastolicBloodPressureDataType();

  /// Body fat percentage data type.
  ///
  /// Represents the user's body fat percentage measurements.
  /// Body fat percentage is expressed as a decimal value between 0 and
  /// 1 (e.g., 0.25 = 25%).
  static const bodyFatPercentage = BodyFatPercentageDataType();

  /// Body temperature data type.
  ///
  /// Represents the user's body temperature measurements.
  static const bodyTemperature = BodyTemperatureDataType();

  /// Sleeping wrist temperature data type.
  ///
  /// Represents the temperature measured at the wrist during sleep.

  ///
  /// **Note**: This is a read-only data type.
  @sinceV3_2_0
  @supportedOnAppleHealth
  @supportedOnAppleHealthIOS16Plus
  @readOnly
  static const sleepingWristTemperature = SleepingWristTemperatureDataType();

  /// Basal body temperature data type.
  ///
  /// Represents basal body temperature measurements, which are the lowest body
  /// temperature attained during rest. Typically measured immediately after
  /// waking and before any physical activity. Commonly used for fertility
  /// tracking and menstrual cycle monitoring.
  @sinceV2_2_0
  static const basalBodyTemperature = BasalBodyTemperatureDataType();

  /// Bone mass data type.
  ///
  /// Represents the user's bone mass measurements.
  @sinceV2_2_0
  @supportedOnHealthConnect
  static const boneMass = BoneMassDataType();

  /// Body water mass data type.
  ///
  /// Represents the user's body water mass measurements.
  @sinceV2_2_0
  @supportedOnHealthConnect
  static const bodyWaterMass = BodyWaterMassDataType();

  /// Heart rate variability (RMSSD) data type.
  ///
  /// Represents the user's heart rate variability (RMSSD) measurements.
  @sinceV2_2_0
  @supportedOnHealthConnect
  static const heartRateVariabilityRMSSD = HeartRateVariabilityRMSSDDataType();

  /// Heart rate variability (SDNN) data type.
  ///
  /// Represents the user's heart rate variability (SDNN) measurements.
  @sinceV2_2_0
  @supportedOnAppleHealth
  static const heartRateVariabilitySDNN = HeartRateVariabilitySDNNDataType();

  /// Body mass index data type.
  ///
  /// Represents the user's body mass index (BMI).
  @sinceV2_2_0
  @supportedOnAppleHealth
  static const bodyMassIndex = BodyMassIndexDataType();

  /// Waist circumference data type.
  ///
  /// Represents the user's waist circumference.
  @sinceV2_2_0
  @supportedOnAppleHealth
  static const waistCircumference = WaistCircumferenceDataType();

  /// Walking asymmetry percentage data type.
  ///
  /// Represents the percentage of steps where one footstrike is moving at a
  /// different speed than the other. Used to assess gait symmetry.
  ///
  /// **Note**: This is a read-only data type.
  @sinceV3_2_0
  @supportedOnAppleHealth
  @readOnly
  static const walkingAsymmetryPercentage =
      WalkingAsymmetryPercentageDataType();

  /// Walking double support percentage data type.
  ///
  /// Represents the percentage of steps where both feet are on the ground.
  /// Used to assess gait symmetry and stability.
  ///
  /// **Note**: This is a read-only data type.
  @sinceV3_2_0
  @supportedOnAppleHealth
  static const walkingDoubleSupportPercentage =
      WalkingDoubleSupportPercentageDataType();

  /// Walking step length data type.
  ///
  /// Represents the distance between the point of initial contact of one foot
  /// and the point of initial contact of the opposite foot.
  ///
  /// **Note**: This is a read-only data type.
  @sinceV3_2_0
  @supportedOnAppleHealth
  static const walkingStepLength = WalkingStepLengthDataType();

  /// Cervical mucus data type.
  ///
  /// Represents cervical mucus observations including appearance and sensation.
  /// Used for fertility tracking.
  @sinceV2_1_0
  static const cervicalMucus = CervicalMucusDataType();

  /// Body height data type.
  ///
  /// Represents the user's body height measurements.
  static const height = HeightDataType();

  /// Active energy burned data type.
  ///
  /// Represents the amount of energy burned during physical activity over a
  /// time interval. Active energy are those burned through exercise
  /// and movement, excluding basal metabolic rate.
  static const activeEnergyBurned = ActiveEnergyBurnedDataType();

  /// Activity intensity data type.
  ///
  /// Tracks periods of moderate and vigorous physical activity.
  @sinceV3_2_0
  @supportedOnHealthConnect
  static const activityIntensity = ActivityIntensityDataType();

  /// Apple Exercise Time data type.
  ///
  /// Represents the amount of time spent exercising that contributes towards
  /// the user's daily exercise goals. Activity evaluated as exercise by Apple.
  ///
  /// **Note**: This is a read-only data type.
  @sinceV3_2_0
  @supportedOnAppleHealth
  @readOnly
  static const exerciseTime = ExerciseTimeDataType();

  /// Apple Move Time data type.
  ///
  /// Represents the amount of time the user has been moving.
  ///
  /// **Note**: This is a read-only data type.
  @sinceV3_2_0
  @supportedOnAppleHealth
  @readOnly
  static const moveTime = MoveTimeDataType();

  /// Apple Stand Time data type.
  ///
  /// Represents the amount of time the user has stood still for at least
  /// one minute in an hour.
  ///
  /// **Note**: This is a read-only data type.
  @sinceV3_2_0
  @supportedOnAppleHealth
  @readOnly
  static const standTime = StandTimeDataType();

  /// Apple Walking Steadiness data type.
  ///
  /// Represents the user's walking steadiness as a percentage, measuring the
  /// stability and regularity of a person's gait.
  ///
  /// **Note**: This is a read-only data type.
  @sinceV3_2_0
  @supportedOnAppleHealth
  @readOnly
  static const walkingSteadiness = WalkingSteadinessDataType();

  /// Number of times fallen data type.
  ///
  /// Tracks the number of times the user has fallen.
  @sinceV3_5_0
  @supportedOnAppleHealth
  static const numberOfTimesFallen = NumberOfTimesFallenDataType();

  /// Exercise session data type.
  ///
  /// Represents exercise sessions with exercise type, duration, and notes.
  @sinceV2_0_0
  static const exerciseSession = ExerciseSessionDataType();

  /// Floors climbed data type.
  ///
  /// Represents the number of floors (flights of stairs) climbed during
  /// a time interval. A floor is typically defined as a vertical distance
  /// of approximately 3 meters (10 feet).
  static const floorsClimbed = FloorsClimbedDataType();

  /// Forced vital capacity data type.
  ///
  /// Represents the user's forced vital capacity measurements.

  @sinceV3_1_0
  @supportedOnAppleHealth
  static const forcedVitalCapacity = ForcedVitalCapacityDataType();

  /// Forced expiratory volume data type.
  ///
  /// Represents the user's forced expiratory volume, 1st second (FEV1)
  /// measurements.
  @sinceV3_4_0
  @supportedOnAppleHealth
  static const forcedExpiratoryVolume = ForcedExpiratoryVolumeDataType();

  /// Elevation gained data type.
  ///
  /// Represents the elevation gain accumulated during physical activity.
  @sinceV3_1_0
  @supportedOnHealthConnect
  static const elevationGained = ElevationGainedDataType();

  /// Wheelchair pushes data type.
  ///
  /// Represents the number of wheelchair pushes performed during
  /// a time interval. A push represents a single propulsion action
  /// used to move a wheelchair forward.
  static const wheelchairPushes = WheelchairPushesDataType();

  /// Lean body mass data type.
  ///
  /// Represents the user's lean body mass measurements. Lean body mass
  /// is the total weight of the body minus the weight of body fat.
  static const leanBodyMass = LeanBodyMassDataType();

  /// Hydration (water intake) data type.
  ///
  /// Represents the volume of water consumed over a time interval.
  /// Tracks water consumption to help users monitor daily hydration levels
  /// and maintain healthy fluid intake.
  static const hydration = HydrationDataType();

  /// Electrodermal activity data type.
  ///
  /// Tracks skin conductance measurements, which increase as sweat gland
  /// activity increases. Commonly used in stress monitoring and biofeedback
  /// applications.
  @sinceV3_5_0
  @supportedOnAppleHealth
  static const electrodermalActivity = ElectrodermalActivityDataType();

  /// Inhaler usage data type.
  ///
  /// Tracks the number of puffs taken from an inhaler over a time interval.
  @sinceV3_5_0
  @supportedOnAppleHealth
  static const inhalerUsage = InhalerUsageDataType();

  /// Insulin delivery data type.
  ///
  /// Tracks the amount of insulin delivered to the user. This is typically
  /// recorded by insulin pumps and other diabetes management devices.
  @sinceV3_5_0
  @supportedOnAppleHealth
  static const insulinDelivery = InsulinDeliveryDataType();

  /// Heart rate series data type.
  ///
  /// Represents a series of heart rate measurements over a time interval.
  /// Each record has a single ID that encompasses all heart rate measurements.
  /// new measurements.
  @supportedOnHealthConnect
  static const heartRateSeries = HeartRateSeriesDataType();

  /// Atrial Fibrillation Burden data type.
  ///
  /// Represents estimates of the percentage of time a person’s heart shows
  /// signs of AFib.
  ///
  /// **Note**: This is a read-only data type.
  @sinceV3_4_0
  @supportedOnAppleHealthIOS16Plus
  @readOnly
  static const atrialFibrillationBurden = AtrialFibrillationBurdenDataType();

  /// Heart rate data type.
  ///
  /// Represents a single heart rate measurement at a specific point in time.
  /// Each record has its own UUID.
  @supportedOnAppleHealth
  static const heartRate = HeartRateDataType();

  /// Heart rate recovery one minute health data type.
  @sinceV3_5_0
  @supportedOnAppleHealthIOS16Plus
  static const heartRateRecoveryOneMinute =
      HeartRateRecoveryOneMinuteDataType();

  /// Sleep session health data type.
  ///
  /// Represents a complete sleep session with multiple sleep stages.
  /// Each sleep session has a single ID that encompasses all stages.
  @supportedOnHealthConnect
  static const sleepSession = SleepSessionDataType();

  /// Sleep stage record health data type.
  ///
  /// Sleep stage records is an individual measurements, one per sleep stage.
  /// A complete night's sleep consists of multiple records.
  /// Each record has its own UUID.
  @supportedOnAppleHealth
  static const sleepStageRecord = SleepStageDataType();

  /// Mindfulness session data type.
  ///
  /// Represents mindfulness sessions including meditation, breathing exercises,
  /// and other mindfulness activities.
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
  @sinceV1_3_0
  static const RestingHeartRateDataType restingHeartRate =
      RestingHeartRateDataType();

  /// Walking heart rate average data type.
  ///
  /// Represents a user's average heart rate while walking.
  ///
  /// **Note**: This is a read-only data type.
  @sinceV3_4_0
  @supportedOnAppleHealth
  @readOnly
  static const walkingHeartRateAverage = WalkingHeartRateAverageDataType();

  /// Low heart rate event data type.
  ///
  /// Represents events where the heart rate falls below a specific threshold.
  ///
  /// **Note**: This is a read-only data type.
  @sinceV3_3_0
  @supportedOnAppleHealth
  @readOnly
  static const lowHeartRateEvent = LowHeartRateEventDataType();

  /// High heart rate event data type.
  ///
  /// Represents events where the heart rate exceeds a specific threshold.
  ///
  /// **Note**: This is a read-only data type.
  @sinceV3_3_0
  @supportedOnAppleHealth
  @readOnly
  static const highHeartRateEvent = HighHeartRateEventDataType();

  /// Infrequent menstrual cycle event data type.
  ///
  /// Represents events where infrequent menstrual cycles are detected by
  /// HealthKit. An infrequent period is defined as having a period one or
  /// two times in the last six months.
  ///
  /// **Note**: This is a read-only data type. Available on iOS 16.0+.
  @sinceV3_4_0
  @supportedOnAppleHealth
  @readOnly
  static const infrequentMenstrualCycleEvent =
      InfrequentMenstrualCycleEventDataType();

  /// Irregular heart rhythm event data type.
  ///
  /// Represents events where an irregular heart rhythm is detected, such as
  /// atrial fibrillation (AFib).
  ///
  /// **Note**: This is a read-only data type.
  @sinceV3_3_0
  @supportedOnAppleHealth
  @readOnly
  static const irregularHeartRhythmEvent = IrregularHeartRhythmEventDataType();

  /// Irregular menstrual cycle event data type.
  ///
  /// Represents events where irregular menstrual cycles are detected by
  /// HealthKit. An irregular cycle is defined as at least a
  /// seventeen-day difference between a person’s shortest and longest cycles
  /// over the last six months.
  ///
  /// **Note**: This is a read-only data type. Available on iOS 16.0+.
  @sinceV3_4_0
  @supportedOnAppleHealth
  @readOnly
  static const irregularMenstrualCycleEvent =
      IrregularMenstrualCycleEventDataType();

  /// Persistent intermenstrual bleeding event data type.
  ///
  /// Represents events where persistent intermenstrual bleeding is detected by
  /// HealthKit. Persistent spotting is defined as spotting that occurs in at
  /// least two of your cycles in the last six months.
  ///
  /// **Note**: This is a read-only data type. Available on iOS 16.0+.
  @sinceV3_4_0
  @supportedOnAppleHealth
  @readOnly
  static const persistentIntermenstrualBleedingEvent =
      PersistentIntermenstrualBleedingEventDataType();

  /// Prolonged menstrual period event data type.
  ///
  /// Represents events where prolonged menstrual periods are detected by
  /// HealthKit. A prolonged period is defined as menstrual bleeding that lasts
  /// for ten or more days, and this has happened at least two times in the
  /// last six months.
  ///
  /// **Note**: This is a read-only data type. Available on iOS 16.0+.
  @sinceV3_4_0
  @supportedOnAppleHealth
  @readOnly
  static const prolongedMenstrualPeriodEvent =
      ProlongedMenstrualPeriodEventDataType();

  /// Running power data type.
  @sinceV3_1_0
  @supportedOnAppleHealth
  @supportedOnAppleHealthIOS16Plus
  static const RunningPowerDataType runningPower = RunningPowerDataType._();

  /// Ovulation test data type.
  ///
  /// Represents ovulation test results that detect hormonal changes to
  /// identify fertility windows. Results can be negative, inconclusive,
  /// high (estrogen surge), or positive (LH surge).
  @sinceV2_2_0
  static const ovulationTest = OvulationTestDataType();

  /// Pregnancy test data type.
  ///
  /// Represents pregnancy test results that detect the presence of human
  /// chorionic gonadotropin (hCG) hormone to determine pregnancy status.
  /// Results can be positive, negative, or inconclusive.
  @sinceV3_1_0
  @supportedOnAppleHealth
  static const pregnancyTest = PregnancyTestDataType();

  /// Pregnancy data type.
  ///
  /// Represents a pregnancy period.
  @sinceV3_1_0
  @supportedOnAppleHealth
  static const pregnancy = PregnancyDataType();

  /// Contraceptive data type.
  ///
  /// Represents contraceptive usage periods, tracking the time during which
  /// specific contraceptive methods are used.
  @sinceV3_1_0
  @supportedOnAppleHealth
  static const contraceptive = ContraceptiveDataType();

  /// Progesterone test data type.
  ///
  /// Represents progesterone test results used to confirm ovulation.
  /// Results can be positive, negative, or inconclusive.
  @sinceV3_1_0
  @supportedOnAppleHealth
  static const progesteroneTest = ProgesteroneTestDataType();

  /// Intermenstrual bleeding data type.
  ///
  /// Represents occurrences of vaginal bleeding between menstrual periods
  /// (spotting). Used for fertility tracking and cycle monitoring.
  @sinceV2_2_0
  static const intermenstrualBleeding = IntermenstrualBleedingDataType();

  /// Menstrual flow instant data type.
  ///
  /// Represents the intensity of menstrual flow at a specific point in time.
  @sinceV2_2_0
  @supportedOnHealthConnect
  static const menstrualFlowInstant = MenstrualFlowInstantDataType();

  /// Menstrual flow data type.
  ///
  /// Represents the intensity of menstrual flow over a time interval,
  /// including cycle start metadata.
  @sinceV2_2_0
  @supportedOnAppleHealth
  static const menstrualFlow = MenstrualFlowDataType();

  /// Lactation data type.
  ///
  /// Represents the act of breastfeeding or expressing breast milk.
  @sinceV3_1_0
  @supportedOnAppleHealth
  static const lactation = LactationDataType();

  /// Oxygen saturation data type.
  ///
  /// Represents the percentage of oxygen-saturated hemoglobin relative
  /// to total hemoglobin in the blood.
  @sinceV1_3_0
  static const oxygenSaturation = OxygenSaturationDataType();

  /// Peripheral perfusion index data type.
  ///
  /// Represents the blood flow to the peripheral tissues.
  @sinceV3_1_0
  @supportedOnAppleHealth
  static const peripheralPerfusionIndex = PeripheralPerfusionIndexDataType();

  /// Power data type.
  ///
  /// Represents power measurements as a series of samples over a time interval.
  @sinceV2_1_0
  @supportedOnHealthConnect
  static const powerSeries = PowerSeriesDataType();

  /// Cycling power data type.
  ///
  /// Represents cycling power output measurements.
  @sinceV2_1_0
  @supportedOnAppleHealth
  @supportedOnAppleHealthIOS17Plus
  static const cyclingPower = CyclingPowerDataType();

  /// Cycling pedaling cadence series record data type.
  ///
  /// Represents cycling cadence measurements in revolutions per minute (RPM).
  /// Each record contains multiple cadence samples over a time interval.
  ///

  @sinceV2_2_0
  @supportedOnHealthConnect
  static const cyclingPedalingCadenceSeries =
      CyclingPedalingCadenceSeriesDataType();

  /// Steps cadence series record data type.
  ///
  /// Represents steps cadence measurements in steps per minute.
  /// Each record contains multiple cadence samples over a time interval.
  ///

  @sinceV3_1_0
  @supportedOnHealthConnect
  static const stepsCadenceSeries = StepsCadenceSeriesDataType();

  /// Cycling pedaling cadence measurement record data type.
  ///
  /// Represents individual cycling cadence measurements in revolutions per
  /// minute (RPM).
  /// Each record is a discrete measurement at a specific point in time.
  ///

  @sinceV2_2_0
  @supportedOnAppleHealth
  @supportedOnAppleHealthIOS17Plus
  static const cyclingPedalingCadence = CyclingPedalingCadenceDataType();

  /// Respiratory rate data type.
  ///
  /// Represents the number of breaths a person takes per minute.
  @sinceV1_0_0
  static const respiratoryRate = RespiratoryRateDataType();

  /// VO₂ max (maximal oxygen uptake) data type.
  ///
  /// Represents the maximum rate of oxygen consumption during exercise,
  /// a key indicator of cardiorespiratory fitness.
  @sinceV1_3_0
  static const vo2Max = Vo2MaxDataType();

  /// Nutrition health data type.
  ///
  /// Represents a complete nutrition record that can contain multiple
  /// nutrients.
  @sinceV1_1_0
  static const nutrition = NutritionDataType();

  /// Dietary energy consumed data type.
  ///
  /// Represents energy intake.
  @sinceV1_1_0
  static const dietaryEnergyConsumed = DietaryEnergyConsumedDataType();

  /// Total energy burned data type.
  ///
  /// Represents the total energy burned by the user, including both
  /// active energy and basal metabolic rate.
  @sinceV2_2_0
  @supportedOnHealthConnect
  static const totalEnergyBurned = TotalEnergyBurnedDataType();

  /// Alcoholic beverages data type.
  ///
  /// Tracks the number of alcoholic beverages consumed.
  @sinceV3_1_0
  @supportedOnAppleHealth
  static const alcoholicBeverages = AlcoholicBeveragesDataType();

  /// Blood alcohol content data type.
  ///
  /// Represents the concentration of alcohol in the blood.
  @sinceV3_1_0
  @supportedOnAppleHealth
  static const bloodAlcoholContent = BloodAlcoholContentDataType();

  /// Basal energy burned data type.
  ///
  /// Represents the energy burned by the body at rest (BMR).
  @sinceV2_2_0
  @supportedOnAppleHealth
  static const basalEnergyBurned = BasalEnergyBurnedDataType();

  /// Caffeine data type.
  ///
  /// Represents caffeine intake.
  @sinceV1_1_0
  static const dietaryCaffeine = DietaryCaffeineDataType();

  /// Protein data type.
  ///
  /// Represents protein intake.
  @sinceV1_1_0
  static const dietaryProtein = DietaryProteinDataType();

  /// Total carbohydrate data type.
  ///
  /// Represents total carbohydrate intake.
  @sinceV1_1_0
  static const dietaryTotalCarbohydrate = DietaryTotalCarbohydrateDataType();

  /// Total fat data type.
  ///
  /// Represents total fat intake.
  @sinceV1_1_0
  static const dietaryTotalFat = DietaryTotalFatDataType();

  /// Saturated fat data type.
  ///
  /// Represents saturated fat intake.
  @sinceV1_1_0
  static const dietarySaturatedFat = DietarySaturatedFatDataType();

  /// Monounsaturated fat data type.
  ///
  /// Represents monounsaturated fat intake.
  @sinceV1_1_0
  static const dietaryMonounsaturatedFat = DietaryMonounsaturatedFatDataType();

  /// Polyunsaturated fat data type.
  ///
  /// Represents polyunsaturated fat intake.
  @sinceV1_1_0
  static const dietaryPolyunsaturatedFat = DietaryPolyunsaturatedFatDataType();

  /// Cholesterol data type.
  ///
  /// Represents cholesterol intake.
  @sinceV1_1_0
  static const dietaryCholesterol = DietaryCholesterolDataType();

  /// Dietary fiber data type.
  ///
  /// Represents dietary fiber intake.
  @sinceV1_1_0
  static const dietaryFiber = DietaryFiberNutrientDataType();

  /// Sugar data type.
  ///
  /// Represents sugar intake.
  @sinceV1_1_0
  static const dietarySugar = DietarySugarDataType();

  /// Calcium data type.
  ///
  /// Represents calcium intake.
  @sinceV1_1_0
  static const dietaryCalcium = DietaryCalciumDataType();

  /// Iron data type.
  ///
  /// Represents iron intake.
  @sinceV1_1_0
  static const dietaryIron = DietaryIronDataType();

  /// Magnesium data type.
  ///
  /// Represents magnesium intake.
  @sinceV1_1_0
  static const dietaryMagnesium = DietaryMagnesiumDataType();

  /// Manganese data type.
  ///
  /// Represents manganese intake.
  @sinceV1_1_0
  static const dietaryManganese = DietaryManganeseDataType();

  /// Phosphorus data type.
  ///
  /// Represents phosphorus intake.
  @sinceV1_1_0
  static const dietaryPhosphorus = DietaryPhosphorusDataType();

  /// Potassium data type.
  ///
  /// Represents potassium intake.
  @sinceV1_1_0
  static const dietaryPotassium = DietaryPotassiumDataType();

  /// Selenium data type.
  ///
  /// Represents selenium intake.
  @sinceV1_1_0
  static const dietarySelenium = DietarySeleniumDataType();

  /// Sodium data type.
  ///
  /// Represents sodium intake.
  @sinceV1_1_0
  static const dietarySodium = DietarySodiumDataType();

  /// Zinc data type.
  ///
  /// Represents zinc intake.
  @sinceV1_1_0
  static const dietaryZinc = DietaryZincDataType();

  /// Vitamin A data type.
  ///
  /// Represents vitamin A intake.
  @sinceV1_1_0
  static const dietaryVitaminA = DietaryVitaminADataType();

  /// Vitamin B6 data type.
  ///
  /// Represents vitamin B6 intake.
  @sinceV1_1_0
  static const dietaryVitaminB6 = DietaryVitaminB6DataType();

  /// Vitamin B12 data type.
  ///
  /// Represents vitamin B12 intake.
  @sinceV1_1_0
  static const dietaryVitaminB12 = DietaryVitaminB12DataType();

  /// Vitamin C data type.
  ///
  /// Represents vitamin C intake.
  @sinceV1_1_0
  static const dietaryVitaminC = DietaryVitaminCDataType();

  /// Vitamin D data type.
  ///
  /// Represents vitamin D intake.
  @sinceV1_1_0
  static const dietaryVitaminD = DietaryVitaminDDataType();

  /// Vitamin E data type.
  ///
  /// Represents vitamin E intake.
  @sinceV1_1_0
  static const dietaryVitaminE = DietaryVitaminEDataType();

  /// Vitamin K data type.
  ///
  /// Represents vitamin K intake.
  @sinceV1_1_0
  static const dietaryVitaminK = DietaryVitaminKDataType();

  /// Thiamin data type.
  ///
  /// Represents thiamin (vitamin B1) intake.
  @sinceV1_1_0
  static const dietaryThiamin = DietaryThiaminDataType();

  /// Riboflavin data type.
  ///
  /// Represents riboflavin (vitamin B2) intake.
  @sinceV1_1_0
  static const dietaryRiboflavin = DietaryRiboflavinDataType();

  /// Niacin data type.
  ///
  /// Represents niacin (vitamin B3) intake.
  @sinceV1_1_0
  static const dietaryNiacin = DietaryNiacinDataType();

  /// Folate data type.
  ///
  /// Represents folate (vitamin B9) intake.
  @sinceV1_1_0
  static const dietaryFolate = DietaryFolateDataType();

  /// Biotin data type.
  ///
  /// Represents biotin (vitamin B7) intake.
  @sinceV1_1_0
  static const dietaryBiotin = DietaryBiotinDataType();

  /// Pantothenic acid data type.
  ///
  /// Represents pantothenic acid (vitamin B5) intake.
  @sinceV1_1_0
  static const dietaryPantothenicAcid = DietaryPantothenicAcidDataType();

  /// Represents a walking steadiness event.
  ///
  /// Records an incident where the user showed a reduced score for their
  /// gait’s steadiness.
  ///
  /// **Note**: This is a read-only data type.
  @sinceV3_4_0
  @supportedOnAppleHealth
  @readOnly
  static const walkingSteadinessEvent = WalkingSteadinessEventDataType();

  /// Returns a list of all available health data types.
  static const values = <HealthDataType<HealthRecord, MeasurementUnit>>[
    activeEnergyBurned,
    activityIntensity,
    alcoholicBeverages,
    atrialFibrillationBurden,
    electrodermalActivity,
    exerciseTime,
    moveTime,
    standTime,
    numberOfTimesFallen,
    walkingSteadiness,
    basalBodyTemperature,
    basalEnergyBurned,
    dietaryBiotin,
    dietaryCaffeine,
    dietaryCalcium,
    dietaryCholesterol,
    dietaryFiber,
    dietaryEnergyConsumed,
    dietaryFolate,
    dietaryIron,
    dietaryMagnesium,
    dietaryManganese,
    dietaryMonounsaturatedFat,
    dietaryNiacin,
    dietaryPantothenicAcid,
    dietaryPhosphorus,
    dietaryPolyunsaturatedFat,
    dietaryPotassium,
    dietaryProtein,
    dietaryRiboflavin,
    dietarySaturatedFat,
    dietarySelenium,
    dietarySodium,
    dietarySugar,
    dietaryThiamin,
    dietaryTotalCarbohydrate,
    dietaryTotalFat,
    dietaryVitaminA,
    dietaryVitaminB12,
    dietaryVitaminB6,
    dietaryVitaminC,
    dietaryVitaminD,
    dietaryVitaminE,
    dietaryVitaminK,
    dietaryZinc,
    bodyWaterMass,
    boneMass,
    bodyMassIndex,
    bloodAlcoholContent,
    bloodGlucose,
    bloodPressure,
    bodyFatPercentage,
    bodyTemperature,
    cervicalMucus,
    contraceptive,
    crossCountrySkiingDistance,
    cyclingPedalingCadence,
    cyclingPedalingCadenceSeries,
    cyclingPower,
    diastolicBloodPressure,
    distance,
    downhillSnowSportsDistance,
    elevationGained,
    exerciseSession,
    floorsClimbed,
    forcedExpiratoryVolume,
    forcedVitalCapacity,
    heartRate,
    heartRateRecoveryOneMinute,
    heartRateSeries,
    heartRateVariabilityRMSSD,
    heartRateVariabilitySDNN,
    height,
    highHeartRateEvent,
    hydration,
    inhalerUsage,
    infrequentMenstrualCycleEvent,
    insulinDelivery,
    intermenstrualBleeding,
    irregularHeartRhythmEvent,
    irregularMenstrualCycleEvent,
    lactation,
    leanBodyMass,
    lowHeartRateEvent,
    menstrualFlow,
    menstrualFlowInstant,
    mindfulnessSession,
    nutrition,
    ovulationTest,
    oxygenSaturation,
    paddleSportsDistance,
    peripheralPerfusionIndex,
    persistentIntermenstrualBleedingEvent,
    powerSeries,
    pregnancy,
    pregnancyTest,
    progesteroneTest,
    prolongedMenstrualPeriodEvent,
    respiratoryRate,
    restingHeartRate,
    rowingDistance,
    runningPower,
    runningSpeed,
    sexualActivity,
    sixMinuteWalkTestDistance,
    skatingSportsDistance,
    sleepingWristTemperature,
    sleepSession,
    sleepStageRecord,
    speedSeries,
    stairAscentSpeed,
    stairDescentSpeed,
    steps,
    stepsCadenceSeries,
    swimmingDistance,
    swimmingStrokes,
    systolicBloodPressure,
    totalEnergyBurned,
    vo2Max,
    waistCircumference,
    walkingAsymmetryPercentage,
    walkingDoubleSupportPercentage,
    walkingHeartRateAverage,
    walkingRunningDistance,
    walkingSpeed,
    walkingSteadinessEvent,
    walkingStepLength,
    weight,
    wheelchairDistance,
    wheelchairPushes,
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

  /// Returns all data types, excluding general
  /// [HealthDataType.nutrition] data type.
  ///
  /// These represent individual nutrients like vitamins, minerals, and
  /// macronutrients that can be tracked separately.
  static final nutrientTypes = [
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
  ];

  /// Returns all health data types in the [HealthDataTypeCategory.activity]
  /// category.
  static final activityTypes = values
      .where(
        (type) => type.category == HealthDataTypeCategory.activity,
      )
      .toList();

  /// Returns all health data types in the
  /// [HealthDataTypeCategory.bodyMeasurement] category.
  static final bodyMeasurementTypes = values
      .where(
        (type) => type.category == HealthDataTypeCategory.bodyMeasurement,
      )
      .toList();

  /// Returns all health data types in the [HealthDataTypeCategory.clinical]
  /// category.
  static final clinicalTypes = values
      .where(
        (type) => type.category == HealthDataTypeCategory.clinical,
      )
      .toList();

  /// Returns all health data types in the [HealthDataTypeCategory.mentalHealth]
  /// category.
  static final mentalHealthTypes = values
      .where(
        (type) => type.category == HealthDataTypeCategory.mentalHealth,
      )
      .toList();

  /// Returns all health data types in the [HealthDataTypeCategory.mobility]
  /// category.
  static final mobilityTypes = values
      .where(
        (type) => type.category == HealthDataTypeCategory.mobility,
      )
      .toList();

  /// Returns all health data types in the [HealthDataTypeCategory.nutrition]
  /// category.
  static final nutritionTypes = values
      .where(
        (type) => type.category == HealthDataTypeCategory.nutrition,
      )
      .toList();

  /// Returns all health data types in the
  /// [HealthDataTypeCategory.reproductiveHealth] category.
  static final reproductiveHealthTypes = values
      .where(
        (type) => type.category == HealthDataTypeCategory.reproductiveHealth,
      )
      .toList();

  /// Returns all health data types in the [HealthDataTypeCategory.sleep]
  /// category.
  static final sleepTypes = values
      .where(
        (type) => type.category == HealthDataTypeCategory.sleep,
      )
      .toList();

  /// Returns all health data types in the [HealthDataTypeCategory.vitals]
  /// category.
  static final vitalsTypes = values
      .where(
        (type) => type.category == HealthDataTypeCategory.vitals,
      )
      .toList();
}
