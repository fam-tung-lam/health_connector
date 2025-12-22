import 'package:health_connector_core/health_connector_core.dart'
    show Permission, ReadRecordByIdRequest, sinceV1_4_0;
import 'package:health_connector_core/src/annotations/annotations.dart'
    show
        sinceV1_0_0,
        supportedOnHealthConnect,
        supportedOnAppleHealth,
        sinceV1_1_0,
        sinceV1_2_0,
        sinceV1_3_0,
        sinceV2_0_0;
import 'package:health_connector_core/src/config/health_connector_config_constants.dart'
    show HealthConnectorConfigConstants;
import 'package:health_connector_core/src/models/health_data_types/health_data_type_capabilities/health_data_type_capabilities.dart';
import 'package:health_connector_core/src/models/health_platform.dart'
    show HealthPlatform;
import 'package:health_connector_core/src/models/health_platform_data.dart'
    show HealthPlatformData;
import 'package:health_connector_core/src/models/health_records/health_record.dart'
    show
        ActiveCaloriesBurnedRecord,
        BiotinNutrientRecord,
        BloodPressureRecord,
        BloodGlucoseRecord,
        BodyFatPercentageRecord,
        BodyTemperatureRecord,
        CaffeineNutrientRecord,
        CalciumNutrientRecord,
        CholesterolNutrientRecord,
        CrossCountrySkiingDistanceRecord,
        CyclingDistanceRecord,
        DiastolicBloodPressureRecord,
        DietaryFiberNutrientRecord,
        DistanceActivityRecord,
        DistanceRecord,
        DownhillSnowSportsDistanceRecord,
        EnergyNutrientRecord,
        FloorsClimbedRecord,
        FolateNutrientRecord,
        HealthRecord,
        HealthRecordId,
        HeartRateMeasurementRecord,
        HeartRateSeriesRecord,
        HeightRecord,
        HydrationRecord,
        IronNutrientRecord,
        LeanBodyMassRecord,
        MagnesiumNutrientRecord,
        ManganeseNutrientRecord,
        MonounsaturatedFatNutrientRecord,
        NiacinNutrientRecord,
        NutritionRecord,
        OxygenSaturationRecord,
        PaddleSportsDistanceRecord,
        PantothenicAcidNutrientRecord,
        PhosphorusNutrientRecord,
        PolyunsaturatedFatNutrientRecord,
        PotassiumNutrientRecord,
        ProteinNutrientRecord,
        RespiratoryRateRecord,
        RestingHeartRateRecord,
        RiboflavinNutrientRecord,
        RowingDistanceRecord,
        SaturatedFatNutrientRecord,
        SeleniumNutrientRecord,
        SixMinuteWalkTestDistanceRecord,
        SkatingSportsDistanceRecord,
        SleepSessionRecord,
        SleepStageRecord,
        SodiumNutrientRecord,
        StepsRecord,
        SugarNutrientRecord,
        SwimmingDistanceRecord,
        SystolicBloodPressureRecord,
        ThiaminNutrientRecord,
        TotalCarbohydrateNutrientRecord,
        TotalFatNutrientRecord,
        VitaminANutrientRecord,
        VitaminB12NutrientRecord,
        VitaminB6NutrientRecord,
        VitaminCNutrientRecord,
        VitaminDNutrientRecord,
        VitaminENutrientRecord,
        VitaminKNutrientRecord,
        Vo2MaxRecord,
        WeightRecord,
        WheelchairDistanceRecord,
        WheelchairPushesRecord,
        ZincNutrientRecord,
        WalkingRunningDistanceRecord;
import 'package:health_connector_core/src/models/measurement_units/measurement_unit.dart'
    show
        BloodGlucose,
        Number,
        Energy,
        TimeDuration,
        Length,
        Mass,
        MeasurementUnit,
        Percentage,
        Pressure,
        Temperature,
        Volume;
import 'package:health_connector_core/src/models/permissions/permission.dart'
    show HealthDataPermission;
import 'package:health_connector_core/src/models/requests/aggregate_request.dart'
    show
        AggregateRequest,
        BloodPressureAggregateRequest,
        CommonAggregateRequest;
import 'package:health_connector_core/src/models/requests/aggregation_metric.dart'
    show AggregationMetric;
import 'package:health_connector_core/src/models/requests/delete_records_request.dart'
    show DeleteRecordsByIdsRequest, DeleteRecordsInTimeRangeRequest;
import 'package:health_connector_core/src/models/requests/read_records_request.dart'
    show ReadRecordsInTimeRangeRequest;
import 'package:meta/meta.dart' show immutable, internal;

part 'active_calories_burned_health_data_type.dart';
part 'blood_glucose_health_data_type.dart';
part 'blood_pressure_health_data_types/blood_pressure_health_data_type.dart';
part 'blood_pressure_health_data_types/diastolic_blood_pressure_health_data_type.dart';
part 'blood_pressure_health_data_types/systolic_blood_pressure_health_data_type.dart';
part 'body_fat_percentage_health_data_type.dart';
part 'body_temperature_health_data_type.dart';
part 'distance_data_types/cross_country_skiing_distance_data_type.dart';
part 'distance_data_types/cycling_distance_data_type.dart';
part 'distance_data_types/distance_activity_data_type.dart';
part 'distance_data_types/distance_data_type.dart';
part 'distance_data_types/downhill_snow_sports_distance_data_type.dart';
part 'distance_data_types/paddle_sports_distance_data_type.dart';
part 'distance_data_types/rowing_distance_data_type.dart';
part 'distance_data_types/six_minute_walk_test_distance_data_type.dart';
part 'distance_data_types/skating_sports_distance_data_type.dart';
part 'distance_data_types/swimming_distance_data_type.dart';
part 'distance_data_types/walking_running_distance_data_type.dart';
part 'distance_data_types/wheelchair_distance_data_type.dart';
part 'floors_climbed_health_data_type.dart';
part 'heart_rate_measurement_record_health_data_type.dart';
part 'heart_rate_series_record_health_data_type.dart';
part 'height_health_data_type.dart';
part 'hydration_health_data_type.dart';
part 'lean_body_mass_health_data_type.dart';
part 'nutrient_data_types/biotin_nutrient_data_type.dart';
part 'nutrient_data_types/caffeine_nutrient_data_type.dart';
part 'nutrient_data_types/calcium_nutrient_data_type.dart';
part 'nutrient_data_types/cholesterol_nutrient_data_type.dart';
part 'nutrient_data_types/dietary_fiber_nutrient_data_type.dart';
part 'nutrient_data_types/energy_nutrient_data_type.dart';
part 'nutrient_data_types/folate_nutrient_data_type.dart';
part 'nutrient_data_types/iron_nutrient_data_type.dart';
part 'nutrient_data_types/macronutrient_data_type.dart';
part 'nutrient_data_types/magnesium_nutrient_data_type.dart';
part 'nutrient_data_types/manganese_nutrient_data_type.dart';
part 'nutrient_data_types/mineral_nutrient_data_type.dart';
part 'nutrient_data_types/monounsaturated_fat_nutrient_data_type.dart';
part 'nutrient_data_types/niacin_nutrient_data_type.dart';
part 'nutrient_data_types/nutrient_data_type.dart';
part 'nutrient_data_types/nutrition_data_type.dart';
part 'nutrient_data_types/pantothenic_acid_nutrient_data_type.dart';
part 'nutrient_data_types/phosphorus_nutrient_data_type.dart';
part 'nutrient_data_types/polyunsaturated_fat_nutrient_data_type.dart';
part 'nutrient_data_types/potassium_nutrient_data_type.dart';
part 'nutrient_data_types/protein_nutrient_data_type.dart';
part 'nutrient_data_types/riboflavin_nutrient_data_type.dart';
part 'nutrient_data_types/saturated_fat_nutrient_data_type.dart';
part 'nutrient_data_types/selenium_nutrient_data_type.dart';
part 'nutrient_data_types/sodium_nutrient_data_type.dart';
part 'nutrient_data_types/sugar_nutrient_data_type.dart';
part 'nutrient_data_types/thiamin_nutrient_data_type.dart';
part 'nutrient_data_types/total_carbohydrate_nutrient_data_type.dart';
part 'nutrient_data_types/total_fat_nutrient_data_type.dart';
part 'nutrient_data_types/vitamin_a_nutrient_data_type.dart';
part 'nutrient_data_types/vitamin_b12_nutrient_data_type.dart';
part 'nutrient_data_types/vitamin_b6_nutrient_data_type.dart';
part 'nutrient_data_types/vitamin_c_nutrient_data_type.dart';
part 'nutrient_data_types/vitamin_d_nutrient_data_type.dart';
part 'nutrient_data_types/vitamin_e_nutrient_data_type.dart';
part 'nutrient_data_types/vitamin_k_nutrient_data_type.dart';
part 'nutrient_data_types/vitamin_nutrient_data_type.dart';
part 'nutrient_data_types/zinc_nutrient_data_type.dart';
part 'oxygen_saturation_health_data_type.dart';
part 'respiratory_rate_health_data_type.dart';
part 'resting_heart_rate_health_data_type.dart';
part 'sleep_session_health_data_type.dart';
part 'sleep_stage_record_health_data_type.dart';
part 'steps_health_data_type.dart';
part 'vo2_max_health_data_type.dart';
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
/// ## Capability Model Design
///
/// This class uses **interface classes** instead of mixins to represent
/// capabilities reading, writing, aggregation).
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
@sinceV1_0_0
@immutable
sealed class HealthDataType<R extends HealthRecord, U extends MeasurementUnit>
    implements HealthPlatformData {
  const HealthDataType();

  @override
  List<HealthPlatform> get supportedHealthPlatforms => HealthPlatform.values;

  /// The unique identifier for this data type.
  ///
  /// This identifier is used for platform communication, serialization,
  /// and distinguishing between different health data types.
  String get identifier;

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

  /// Resting heart rate data type.
  ///
  /// Represents the heart rate while at complete rest, typically measured
  /// first thing in the morning before getting out of bed.
  /// Supports AVG, MIN, MAX aggregation.
  @sinceV1_3_0
  static const restingHeartRate = RestingHeartRateHealthDataType();

  /// Oxygen saturation data type.
  ///
  /// Represents the percentage of oxygen-saturated hemoglobin relative
  /// to total hemoglobin in the blood. Supports reading and writing
  /// oxygen saturation measurements.
  @sinceV1_3_0
  static const oxygenSaturation = OxygenSaturationHealthDataType();

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
  ///
  /// This list contains all data types currently supported by the plugin.
  /// As new data types are added, they will automatically appear in this list.
  static const List<HealthDataType<HealthRecord, MeasurementUnit>> values = [
    activeCaloriesBurned,
    biotin,
    bloodGlucose,
    bloodPressure,
    bodyFatPercentage,
    bodyTemperature,
    caffeine,
    calcium,
    cholesterol,
    crossCountrySkiingDistance,
    cyclingDistance,
    diastolicBloodPressure,
    dietaryFiber,
    distance,
    downhillSnowSportsDistance,
    energyNutrient,
    floorsClimbed,
    folate,
    heartRateMeasurementRecord,
    heartRateSeriesRecord,
    height,
    hydration,
    iron,
    leanBodyMass,
    magnesium,
    manganese,
    monounsaturatedFat,
    niacin,
    nutrition,
    oxygenSaturation,
    pantothenicAcid,
    phosphorus,
    polyunsaturatedFat,
    potassium,
    protein,
    respiratoryRate,
    restingHeartRate,
    riboflavin,
    saturatedFat,
    selenium,
    sleepSession,
    sleepStageRecord,
    sodium,
    steps,
    sugar,
    systolicBloodPressure,
    thiamin,
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
    weight,
    wheelchairPushes,
    zinc,
    // iOS-only distance activity types
    paddleSportsDistance,
    rowingDistance,
    sixMinuteWalkTestDistance,
    skatingSportsDistance,
    swimmingDistance,
    wheelchairDistance,
    walkingRunningDistance,
  ];
}
