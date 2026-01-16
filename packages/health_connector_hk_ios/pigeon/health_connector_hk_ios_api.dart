import 'package:pigeon/pigeon.dart';

/// Pigeon API definition for HealthKit Flutter plugin.
///
/// This file defines the complete API contract between Dart and iOS
/// for health data operations. Pigeon generates platform-specific
/// code from these definitions.
@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/src/pigeon/health_connector_hk_ios_api.g.dart',
    dartOptions: DartOptions(),
    swiftOut:
        'ios/health_connector_hk_ios/Sources/health_connector_hk_ios/pigeon/HealthConnectorHKIOSApi.g.swift',
    swiftOptions: SwiftOptions(errorClassName: 'HealthConnectorErrorDto'),
    copyrightHeader: 'pigeon/copyright_header.txt',
    dartPackageName: 'health_connector_hk_ios',
  ),
)
/// Configuration data transfer object for Health Connector.
///
/// Contains configuration settings that are passed from Dart to native
/// platform code during client initialization.
class HealthConnectorConfigDto {
  HealthConnectorConfigDto({required this.isLoggerEnabled});

  /// Whether logging is enabled for the Health Connector.
  final bool isLoggerEnabled;
}

// region Metadata

/// Device type for health data recording.
enum DeviceTypeDto {
  /// Chest strap heart rate monitor.
  chestStrap,

  /// Fitness band or activity tracker.
  fitnessBand,

  /// Head-mounted device (e.g., AR/VR headset).
  headMounted,

  /// Mobile phone or smartphone.
  phone,

  /// Smart ring wearable.
  ring,

  /// Weight scale or body composition scale.
  scale,

  /// Smart display device.
  smartDisplay,

  /// Unknown or unspecified device type.
  unknown,

  /// Smartwatch or wearable watch.
  watch,
}

/// Recording method for health data.
enum RecordingMethodDto {
  /// Data was recorded during an active user-initiated session.
  activelyRecorded,

  /// Data was automatically recorded by a device in the background.
  automaticallyRecorded,

  /// Data was manually entered by the user.
  manualEntry,

  /// The recording method is unknown or unspecified.
  unknown,
}

/// Represents metadata for a health record.
class MetadataDto {
  MetadataDto({
    required this.dataOrigin,
    required this.recordingMethod,
    required this.deviceType,
    this.clientRecordId,
    this.clientRecordVersion,
    this.deviceName,
    this.deviceManufacturer,
    this.deviceModel,
    this.deviceHardwareVersion,
    this.deviceFirmwareVersion,
    this.deviceSoftwareVersion,
    this.deviceLocalIdentifier,
    this.deviceUdiDeviceIdentifier,
  });

  /// A custom identifier assigned by your application.
  ///
  /// Use this for client-side record tracking, deduplication, or correlation.
  final String? clientRecordId;

  /// A version number assigned by your application.
  ///
  /// Use this to implement your own versioning or tracking logic.
  final int? clientRecordVersion;

  /// The type of device that recorded the data.
  final DeviceTypeDto deviceType;

  /// The method used to record this data.
  final RecordingMethodDto recordingMethod;

  /// The package name of the source app that wrote this health record.
  final String dataOrigin;

  /// The name of the device that recorded the data (optional).
  final String? deviceName;

  /// The manufacturer of the device that recorded the data (optional).
  final String? deviceManufacturer;

  /// The model of the device that recorded the data (optional).
  final String? deviceModel;

  /// The hardware version of the device that recorded the data (optional).
  final String? deviceHardwareVersion;

  /// The firmware version of the device that recorded the data (optional).
  final String? deviceFirmwareVersion;

  /// The software version of the device that recorded the data (optional).
  final String? deviceSoftwareVersion;

  /// A local identifier for the device that recorded the data (optional).
  final String? deviceLocalIdentifier;

  /// The UDI (Unique Device Identifier) for the device that recorded
  /// the data (optional).
  final String? deviceUdiDeviceIdentifier;
}

// endregion

// region Health Records

/// Test type for VO2 max measurement (iOS HealthKit).
///
/// Maps to HKMetadataKeyVO2MaxTestType enum values.
enum Vo2MaxTestTypeDto {
  /// Direct measurement at maximum exercise (gold standard).
  maxExercise,

  /// Estimated from sub-maximal exercise.
  predictionSubMaxExercise,

  /// Estimated without exercise (e.g., from heart rate ratio).
  predictionNonExercise,

  /// Step-based protocol prediction.
  predictionStepTest,
}

/// Meal type classification for nutrient records.
///
/// Represents the type of meal associated with a nutrition or nutrient record.
enum MealTypeDto {
  /// Unknown or unspecified meal type.
  unknown,

  /// Breakfast meal.
  breakfast,

  /// Lunch meal.
  lunch,

  /// Dinner meal.
  dinner,

  /// Snack or other meal type.
  snack,
}

/// Body position during blood pressure measurement.
/// Note: Not directly supported by HealthKit - included for Android parity.
enum BodyPositionDto {
  /// Unknown body position.
  unknown,

  /// Standing up.
  standingUp,

  /// Sitting down.
  sittingDown,

  /// Lying down.
  lyingDown,

  /// Reclining.
  reclining,
}

/// Measurement location for blood pressure reading.
/// Note: Not directly supported by HealthKit - included for Android parity.
enum MeasurementLocationDto {
  /// Unknown location.
  unknown,

  /// Left wrist.
  leftWrist,

  /// Right wrist.
  rightWrist,

  /// Left upper arm.
  leftUpperArm,

  /// Right upper arm.
  rightUpperArm,
}

/// Relationship of a blood glucose measurement to a meal.
enum BloodGlucoseRelationToMealDto {
  /// Unknown relationship.
  unknown,

  /// General relationship (not specific to a meal).
  general,

  /// Fasting state (no recent meal).
  fasting,

  /// Measurement taken before a meal.
  beforeMeal,

  /// Measurement taken after a meal.
  afterMeal,
}

/// Source of the biological specimen for valid blood glucose measurement.
enum BloodGlucoseSpecimenSourceDto {
  /// Unknown specimen source.
  unknown,

  /// Interstitial fluid.
  interstitialFluid,

  /// Capillary blood.
  capillaryBlood,

  /// Plasma.
  plasma,

  /// Serum.
  serum,

  /// Tears.
  tears,

  /// Whole blood.
  wholeBlood,
}

/// Represents the type of distance-based activity.
///
/// Maps to different iOS HKQuantityTypeIdentifier values.
enum DistanceActivityTypeDto {
  /// Walking or running distance.
  /// Maps to HKQuantityTypeIdentifier.distanceWalkingRunning.
  walkingRunning,

  /// Cycling distance.
  /// Maps to HKQuantityTypeIdentifier.distanceCycling.
  cycling,

  /// Swimming distance.
  /// Maps to HKQuantityTypeIdentifier.distanceSwimming.
  swimming,

  /// Wheelchair distance.
  /// Maps to HKQuantityTypeIdentifier.distanceWheelchair.
  wheelchair,

  /// Downhill snow sports distance.
  /// Maps to HKQuantityTypeIdentifier.distanceDownhillSnowSports.
  downhillSnowSports,

  /// Rowing distance.
  /// Maps to HKQuantityTypeIdentifier.distanceRowing (iOS 18+).
  rowing,

  /// Paddle sports distance.
  /// Maps to HKQuantityTypeIdentifier.distancePaddleSports (iOS 18+).
  paddleSports,

  /// Cross-country skiing distance.
  /// Maps to HKQuantityTypeIdentifier.distanceCrossCountrySkiing (iOS 18+).
  crossCountrySkiing,

  /// Skating sports distance.
  /// Maps to HKQuantityTypeIdentifier.distanceSkatingSports (iOS 18+).
  skatingSports,

  /// Six-minute walk test distance.
  /// Maps to HKQuantityTypeIdentifier.sixMinuteWalkTestDistance.
  sixMinuteWalkTest,
}

/// Represents the type of sleep stage.
///
/// Maps to iOS HKCategoryValueSleepAnalysis values.
enum SleepStageDto {
  /// Unknown or unspecified sleep stage.
  unknown,

  /// Awake in bed.
  awake,

  /// Asleep (generic, when detailed stage unavailable).
  sleeping,

  /// Out of bed.
  outOfBed,

  /// Light sleep stage.
  light,

  /// Deep sleep stage.
  deep,

  /// REM (Rapid Eye Movement) sleep stage.
  rem,

  /// In bed (not yet asleep).
  inBed,
}

/// Cervical mucus appearance classification.
///
/// Maps to iOS HealthKit `HKCategoryValueCervicalMucusQuality` enum.
///
/// **iOS HealthKit Limitation**: Only `dry`, `sticky`, `creamy`, `watery`, and
/// `eggWhite` are natively supported via `HKCategoryValueCervicalMucusQuality`.
/// Values `unusual` and `unknown` require custom metadata handling in Swift.
enum CervicalMucusAppearanceDto {
  /// Unknown appearance (custom metadata on iOS).
  unknown,

  /// Dry appearance.
  dry,

  /// Sticky appearance.
  sticky,

  /// Creamy appearance.
  creamy,

  /// Watery appearance.
  watery,

  /// Egg white appearance.
  eggWhite,

  /// Unusual appearance (custom metadata on iOS).
  unusual,
}

/// Cervical mucus sensation classification.
///
/// **iOS HealthKit Limitation**: HealthKit's HKCategoryTypeIdentifier.
/// cervicalMucusQuality only tracks appearance, not sensation.
/// All sensation values require custom metadata handling in Swift.
enum CervicalMucusSensationDto {
  /// Unknown sensation (custom metadata on iOS).
  unknown,

  /// Light sensation (custom metadata on iOS).
  light,

  /// Medium sensation (custom metadata on iOS).
  medium,

  /// Heavy sensation (custom metadata on iOS).
  heavy,
}

/// Sexual activity protection used classification.
///
/// Maps to Android Health Connect SexualActivityRecord protection types
/// and iOS HealthKit HKMetadataKeySexualActivityProtectionUsed metadata key.
enum SexualActivityProtectionUsedDto {
  /// Protection was used.
  protected,

  /// Protection was not used.
  unprotected,

  /// Unknown whether protection was used.
  unknown,
}

/// Ovulation test result classification.
///
/// Maps to Android Health Connect OvulationTestRecord result constants
/// and iOS HealthKit HKCategoryValueOvulationTestResult enum.
enum OvulationTestResultDto {
  /// Test result is negative (no hormonal surge).
  negative,

  /// Test result is inconclusive.
  inconclusive,

  /// Test result shows high estrogen levels.
  high,

  /// Test result is positive (LH surge detected).
  positive,
}

/// Pregnancy test result classification.
///
/// Maps to iOS HealthKit HKCategoryValuePregnancyTestResult enum.
/// iOS only (iOS 15.0+).
enum PregnancyTestResultDto {
  /// Test result is positive (pregnancy detected).
  positive,

  /// Test result is negative (no pregnancy detected).
  negative,

  /// Test result is inconclusive.
  inconclusive,
}

/// Progesterone test result classification.
///
/// Maps to iOS HealthKit HKCategoryValueProgesteroneTestResult enum.
/// iOS only (iOS 15.0+).
enum ProgesteroneTestResultDto {
  /// Test result is positive (progesterone surge detected).
  positive,

  /// Test result is negative (no progesterone surge detected).
  negative,

  /// Test result is inconclusive.
  inconclusive,
}

/// Contraceptive type classification.
///
/// Maps to iOS HealthKit HKCategoryValueContraceptive enum.
/// iOS only (iOS 14.3+).
enum ContraceptiveTypeDto {
  /// Unspecified or unknown contraceptive method.
  unknown,

  /// Contraceptive implant.
  implant,

  /// Contraceptive injection.
  injection,

  /// Intrauterine device (IUD).
  intrauterineDevice,

  /// Intravaginal ring.
  intravaginalRing,

  /// Oral contraceptive (birth control pill).
  oral,

  /// Contraceptive patch.
  patch,
}

/// Measurement location for basal body temperature reading.
enum BasalBodyTemperatureMeasurementLocationDto {
  /// Unknown location.
  unknown,

  /// Armpit measurement.
  armpit,

  /// Ear measurement.
  ear,

  /// Finger measurement.
  finger,

  /// Forehead measurement.
  forehead,

  /// Mouth measurement.
  mouth,

  /// Rectum measurement.
  rectum,

  /// Temporal artery measurement.
  temporalArtery,

  /// Toe measurement.
  toe,

  /// Vagina measurement.
  vagina,

  /// Wrist measurement.
  wrist,
}

/// Menstrual flow intensity classification.
///
/// Maps to Android Health Connect MenstruationFlowRecord.FLOW_* constants
/// and iOS HealthKit HKCategoryValueMenstrualFlow (iOS ≤17) or
/// HKCategoryValueVaginalBleeding (iOS ≥18) enum values.
enum MenstrualFlowDto {
  /// Flow is unknown or unspecified.
  /// - Android: FLOW_UNKNOWN
  /// - iOS ≤ 17: HKCategoryValueMenstrualFlow.unspecified/.none
  /// - iOS ≥ 18: HKCategoryValueVaginalBleeding.unspecified/.none
  unknown,

  /// Light menstrual flow.
  /// - Android: FLOW_LIGHT
  /// - iOS ≤17: HKCategoryValueMenstrualFlow.light
  /// - iOS ≥18: HKCategoryValueVaginalBleeding.light
  light,

  /// Medium menstrual flow.
  /// - Android: FLOW_MEDIUM
  /// - iOS ≤17: HKCategoryValueMenstrualFlow.medium
  /// - iOS ≥18: HKCategoryValueVaginalBleeding.medium
  medium,

  /// Heavy menstrual flow.
  /// - Android: FLOW_HEAVY
  /// - iOS ≤17: HKCategoryValueMenstrualFlow.heavy
  /// - iOS ≥18: HKCategoryValueVaginalBleeding.heavy
  heavy,
}

/// Represents the type of speed-based activity.
///
/// Maps to different iOS HKQuantityTypeIdentifier values.
enum SpeedActivityTypeDto {
  /// Walking speed.
  /// Maps to HKQuantityTypeIdentifier.walkingSpeed.
  walking,

  /// Running speed.
  /// Maps to HKQuantityTypeIdentifier.runningSpeed.
  running,

  /// Stair ascent speed.
  /// Maps to HKQuantityTypeIdentifier.stairAscentSpeed.
  stairAscent,

  /// Stair descent speed.
  /// Maps to HKQuantityTypeIdentifier.stairDescentSpeed.
  stairDescent,
}

/// Exercise type classification for exercise sessions.
///
/// Maps to iOS HealthKit HKWorkoutActivityType.
/// Some types are iOS-specific and may not have equivalent Health Connect
/// types.
enum ExerciseTypeDto {
  /// Other or unclassified exercise type.
  other,

  /// Cardio & Walking/Running
  running,
  walking,
  cycling,
  hiking,
  handCycling,
  trackAndField,

  /// Water Sports
  swimming,
  surfing,
  waterPolo,
  rowing,
  sailing,
  paddling,
  diving,
  waterFitness,
  waterSports,

  /// Strength Training
  strengthTraining,

  /// Team Sports
  basketball,
  soccer,
  americanFootball,
  frisbeeDisc,
  australianFootball,
  baseball,
  softball,
  volleyball,
  rugby,
  cricket,
  handball,
  hockey,
  lacrosse,
  discSports,

  /// Racquet Sports
  tennis,
  tableTennis,
  badminton,
  squash,
  racquetball,
  pickleball,

  /// Winter Sports
  snowboarding,
  skating,
  crossCountrySkiing,
  curling,
  downhillSkiing,
  snowSports,

  /// Martial Arts & Combat Sports
  boxing,
  kickboxing,
  martialArts,
  wrestling,
  fencing,
  taiChi,

  /// Dance & Gymnastics
  gymnastics,
  barre,
  cardioDance,
  socialDance,

  /// Fitness & Conditioning
  yoga,
  pilates,
  highIntensityIntervalTraining,
  elliptical,
  stairClimbing,
  crossTraining,
  jumpRope,
  stepTraining,
  fitnessGaming,
  coreTraining,
  flexibility,
  cooldown,
  mixedCardio,
  mindAndBody,
  preparationAndRecovery,

  /// Golf & Precision Sports
  golf,
  archery,
  bowling,

  /// Outdoor & Adventure
  climbing,
  equestrianSports,
  fishing,
  hunting,
  play,

  /// Wheelchair Activities
  wheelchairWalkPace,
  wheelchairRunPace,

  /// Multisport
  transition,
  swimBikeRun,
}

/// Mindfulness session type classification.
///
/// Maps to Android Health Connect MindfulnessSessionRecord session type.
enum MindfulnessSessionTypeDto {
  /// Unknown or unspecified session type.
  unknown,

  /// Meditation session.
  meditation,

  /// Breathing exercise session.
  breathing,

  /// Music-based mindfulness session.
  music,

  /// Movement-based mindfulness session.
  movement,

  /// Unguided mindfulness session.
  unguided,
}

/// Represents a health data type.
enum HealthDataTypeDto {
  /// Active energy burned data.
  activeCaloriesBurned,

  /// Alcoholic beverages data (iOS only).
  alcoholicBeverages,

  /// Blood alcohol content data (iOS only).
  bloodAlcoholContent,

  /// Distance traveled data (generic).
  distance,

  /// Cycling distance.
  cyclingDistance,

  /// Cycling power data (iOS 16+).
  cyclingPower,

  /// Swimming distance.
  swimmingDistance,

  /// Swimming stroke count data.
  swimmingStrokes,

  /// Running power data (iOS 16+).
  runningPower,

  /// Basal energy burned data.
  basalEnergyBurned,

  /// Wheelchair distance.
  wheelchairDistance,

  /// Walking or running distance.
  walkingRunningDistance,

  /// Downhill snow sports distance.
  downhillSnowSportsDistance,

  /// Rowing distance (iOS 18+).
  rowingDistance,

  /// Paddle sports distance (iOS 18+).
  paddleSportsDistance,

  /// Cross-country skiing distance (iOS 18+).
  crossCountrySkiingDistance,

  /// Skating sports distance (iOS 18+).
  skatingSportsDistance,

  /// Six-minute walk test distance.
  sixMinuteWalkTestDistance,

  /// Floors climbed data.
  floorsClimbed,

  /// Step count data.
  steps,

  /// Body weight data.
  weight,

  /// Body height data.
  height,

  /// Body fat percentage data.
  bodyFatPercentage,

  /// Body temperature data.
  bodyTemperature,

  /// Basal body temperature data.
  basalBodyTemperature,

  /// Cervical mucus observation data.
  cervicalMucus,

  /// Lean body mass data.
  leanBodyMass,

  /// Wheelchair pushes data.
  wheelchairPushes,

  /// Hydration (water intake) data.
  hydration,

  /// Heart rate measurement record data (iOS HealthKit).
  heartRateMeasurementRecord,

  /// Cycling pedaling cadence measurement record data (iOS HealthKit).
  cyclingPedalingCadence,

  /// Sleep stage record data (iOS HealthKit).
  sleepStageRecord,

  /// Sexual activity data.
  sexualActivity,

  /// Peripheral perfusion index data.
  peripheralPerfusionIndex,

  // SPEED TYPES (4)
  /// Walking speed data.
  walkingSpeed,

  /// Running speed data.
  runningSpeed,

  /// Stair ascent speed data.
  stairAscentSpeed,

  /// Stair descent speed data.
  stairDescentSpeed,

  // NUTRIENT TYPES - Energy & Other (2)
  /// Energy nutrient data (calories consumed).
  dietaryEnergyConsumed,

  /// Caffeine nutrient data.
  caffeine,

  // NUTRIENT TYPES - Macronutrients (9)
  /// Protein nutrient data.
  protein,

  /// Total carbohydrate nutrient data.
  totalCarbohydrate,

  /// Total fat nutrient data.
  totalFat,

  /// Saturated fat nutrient data.
  saturatedFat,

  /// Monounsaturated fat nutrient data.
  monounsaturatedFat,

  /// Polyunsaturated fat nutrient data.
  polyunsaturatedFat,

  /// Cholesterol nutrient data.
  cholesterol,

  /// Dietary fiber nutrient data.
  dietaryFiber,

  /// Sugar nutrient data.
  sugar,

  // NUTRIENT TYPES - Vitamins (13)
  /// Vitamin A nutrient data.
  vitaminA,

  /// Vitamin B6 nutrient data.
  vitaminB6,

  /// Vitamin B12 nutrient data.
  vitaminB12,

  /// Vitamin C nutrient data.
  vitaminC,

  /// Vitamin D nutrient data.
  vitaminD,

  /// Vitamin E nutrient data.
  vitaminE,

  /// Vitamin K nutrient data.
  vitaminK,

  /// Thiamin (Vitamin B1) nutrient data.
  thiamin,

  /// Riboflavin (Vitamin B2) nutrient data.
  riboflavin,

  /// Niacin (Vitamin B3) nutrient data.
  niacin,

  /// Folate (Vitamin B9) nutrient data.
  folate,

  /// Biotin (Vitamin B7) nutrient data.
  biotin,

  /// Pantothenic acid (Vitamin B5) nutrient data.
  pantothenicAcid,

  // NUTRIENT TYPES - Minerals (9)
  /// Calcium nutrient data.
  calcium,

  /// Iron nutrient data.
  iron,

  /// Magnesium nutrient data.
  magnesium,

  /// Manganese nutrient data.
  manganese,

  /// Phosphorus nutrient data.
  phosphorus,

  /// Potassium nutrient data.
  potassium,

  /// Selenium nutrient data.
  selenium,

  /// Sodium nutrient data.
  sodium,

  /// Zinc nutrient data.
  zinc,

  /// Combined nutrition record (HKCorrelation.food).
  nutrition,

  /// Resting heart rate data.
  restingHeartRate,

  /// Composite blood pressure (HKCorrelationType.bloodPressure).
  bloodPressure,

  /// Systolic blood pressure (HKQuantityType.bloodPressureSystolic).
  systolicBloodPressure,

  /// Diastolic blood pressure (HKQuantityType.bloodPressureDiastolic).
  diastolicBloodPressure,

  /// Ovulation test data.
  ovulationTest,

  /// Pregnancy test data (iOS only).
  pregnancyTest,

  /// Pregnancy data (iOS only).
  pregnancy,

  /// Contraceptive data (iOS only).
  contraceptive,

  /// Progesterone test data (iOS only).
  progesteroneTest,

  /// Lactation data (iOS only).
  lactation,

  /// Ovulation test result.
  ovulationTestResult,

  /// Progesterone test result (iOS only).
  progesteroneTestResult,

  /// Sleep stage type.
  sleepStage,

  /// Intermenstrual bleeding data.
  intermenstrualBleeding,

  /// Menstrual flow data (iOS HealthKit only).
  menstrualFlow,

  /// Oxygen saturation data.
  oxygenSaturation,

  /// Respiratory rate data.
  respiratoryRate,

  /// VO2 max (maximal oxygen uptake) data.
  vo2Max,

  /// Blood glucose data.
  bloodGlucose,

  /// Exercise session data.
  exerciseSession,

  /// Mindfulness session data.
  mindfulnessSession,

  /// Body mass index data.
  bodyMassIndex,

  /// Waist circumference data.
  waistCircumference,

  /// The forced vital capacity (FVC) data.
  forcedVitalCapacity,

  /// Heart rate variability (SDNN) data.
  heartRateVariabilitySDNN,
}

/// Sealed class for all health record DTOs.
sealed class HealthRecordDto {}

/// Represents a resting heart rate record for platform transfer.
class RestingHeartRateRecordDto extends HealthRecordDto {
  RestingHeartRateRecordDto({
    required this.id,
    required this.time,
    required this.metadata,
    required this.beatsPerMinute,
    this.zoneOffsetSeconds,
  });

  /// Platform-assigned unique identifier.
  final String? id;

  /// Measurement time in milliseconds since epoch (UTC).
  final int time;

  /// Metadata about this record.
  final MetadataDto metadata;

  /// Resting heart rate in beats per minute.
  final double beatsPerMinute;

  /// Timezone offset in seconds for measurement time (optional).
  final int? zoneOffsetSeconds;
}

/// Represents a VO2 max record for platform transfer.
///
/// VO2 max is the maximum rate of oxygen consumption during exercise,
/// typically measured in mL/kg/min.
class Vo2MaxRecordDto extends HealthRecordDto {
  Vo2MaxRecordDto({
    required this.id,
    required this.time,
    required this.metadata,
    required this.millilitersPerKilogramPerMinute,
    this.testType,
    this.zoneOffsetSeconds,
  });

  /// Platform-assigned unique identifier.
  final String? id;

  /// Measurement time in milliseconds since epoch (UTC).
  final int time;

  /// Metadata about this record.
  final MetadataDto metadata;

  /// The VO2 max value in mL/kg/min.
  final double millilitersPerKilogramPerMinute;

  /// The test type used to determine VO2 max.
  ///
  /// Maps to HKMetadataKeyVO2MaxTestType.
  final Vo2MaxTestTypeDto? testType;

  /// Timezone offset in seconds for measurement time (optional).
  final int? zoneOffsetSeconds;
}

/// Represents a forced vital capacity record for platform transfer.
class ForcedVitalCapacityRecordDto extends HealthRecordDto {
  ForcedVitalCapacityRecordDto({
    required this.id,
    required this.time,
    required this.metadata,
    required this.liters,
    this.zoneOffsetSeconds,
  });

  /// Platform-assigned unique identifier.
  final String? id;

  /// Measurement time in milliseconds since epoch (UTC).
  final int time;

  /// Metadata about this record.
  final MetadataDto metadata;

  /// The volume in liters.
  final double liters;

  /// Timezone offset in seconds for measurement time (optional).
  final int? zoneOffsetSeconds;
}

/// Represents a body mass index record for platform transfer.
class BodyMassIndexRecordDto extends HealthRecordDto {
  BodyMassIndexRecordDto({
    required this.id,
    required this.time,
    required this.metadata,
    required this.bodyMassIndex,
    this.zoneOffsetSeconds,
  });

  /// Platform-assigned unique identifier.
  final String? id;

  /// Measurement time in milliseconds since epoch (UTC).
  final int time;

  /// Metadata about this record.
  final MetadataDto metadata;

  /// The body mass index value.
  final double bodyMassIndex;

  /// Timezone offset in seconds for measurement time (optional).
  final int? zoneOffsetSeconds;
}

/// Represents a waist circumference record for platform transfer.
class WaistCircumferenceRecordDto extends HealthRecordDto {
  WaistCircumferenceRecordDto({
    required this.id,
    required this.time,
    required this.metadata,
    required this.meters,
    this.zoneOffsetSeconds,
  });

  /// Platform-assigned unique identifier.
  final String? id;

  /// Measurement time in milliseconds since epoch (UTC).
  final int time;

  /// Metadata about this record.
  final MetadataDto metadata;

  /// The waist circumference measurement.
  final double meters;

  /// Timezone offset in seconds for measurement time (optional).
  final int? zoneOffsetSeconds;
}

/// Represents a heart rate variability (SDNN) record for platform transfer.
class HeartRateVariabilitySDNNRecordDto extends HealthRecordDto {
  HeartRateVariabilitySDNNRecordDto({
    required this.id,
    required this.time,
    required this.metadata,
    required this.heartRateVariabilityMillis,
    this.zoneOffsetSeconds,
  });

  /// Platform-assigned unique identifier.
  final String? id;

  /// Measurement time in milliseconds since epoch (UTC).
  final int time;

  /// Metadata about this record.
  final MetadataDto metadata;

  /// The heart rate variability SDNN value in milliseconds.
  final double heartRateVariabilityMillis;

  /// Timezone offset in seconds for measurement time (optional).
  final int? zoneOffsetSeconds;
}

/// Represents a blood glucose record for platform transfer.
class BloodGlucoseRecordDto extends HealthRecordDto {
  BloodGlucoseRecordDto({
    required this.id,
    required this.time,
    required this.metadata,
    required this.millimolesPerLiter,
    this.mealType,
    this.relationToMeal,
    this.specimenSource,
    this.zoneOffsetSeconds,
  });

  /// Platform-assigned unique identifier.
  final String? id;

  /// Measurement time in milliseconds since epoch (UTC).
  final int time;

  /// Metadata about this record.
  final MetadataDto metadata;

  /// The blood glucose measurement.
  final double millimolesPerLiter;

  /// The type of meal associated with this measurement.
  final MealTypeDto? mealType;

  /// The relationship of this measurement to a meal.
  final BloodGlucoseRelationToMealDto? relationToMeal;

  /// The source of the specimen used for this measurement.
  final BloodGlucoseSpecimenSourceDto? specimenSource;

  /// Timezone offset in seconds for measurement time (optional).
  final int? zoneOffsetSeconds;
}

/// Represents an exercise session record for platform transfer.
///
/// Maps to iOS HealthKit HKWorkout.
class ExerciseSessionRecordDto extends HealthRecordDto {
  ExerciseSessionRecordDto({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.metadata,
    required this.exerciseType,
    this.title,
    this.notes,
    this.startZoneOffsetSeconds,
    this.endZoneOffsetSeconds,
  });

  /// Platform-assigned unique identifier.
  final String? id;

  /// Start time in milliseconds since epoch (UTC).
  final int startTime;

  /// End time in milliseconds since epoch (UTC).
  final int endTime;

  /// Metadata about this record.
  final MetadataDto metadata;

  /// Type of exercise performed.
  final ExerciseTypeDto exerciseType;

  /// Optional title for the exercise session.
  final String? title;

  /// Optional notes about the exercise session.
  final String? notes;

  /// Timezone offset in seconds for start time (optional).
  final int? startZoneOffsetSeconds;

  /// Timezone offset in seconds for end time (optional).
  final int? endZoneOffsetSeconds;
}

/// Represents a mindfulness session record for platform transfer.
///
/// Maps to iOS HealthKit HKCategoryType.mindfulSession.
/// Note: HealthKit only supports generic mindfulness category. Session types
/// are stored in custom metadata when writing to HealthKit.
class MindfulnessSessionRecordDto extends HealthRecordDto {
  MindfulnessSessionRecordDto({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.metadata,
    required this.sessionType,
    this.title,
    this.notes,
    this.startZoneOffsetSeconds,
    this.endZoneOffsetSeconds,
  });

  /// Platform-assigned unique identifier.
  final String? id;

  /// Start time in milliseconds since epoch (UTC).
  final int startTime;

  /// End time in milliseconds since epoch (UTC).
  final int endTime;

  /// Metadata about this record.
  final MetadataDto metadata;

  /// Type of mindfulness session.
  final MindfulnessSessionTypeDto sessionType;

  /// Optional title for the mindfulness session.
  final String? title;

  /// Optional notes about the mindfulness session.
  final String? notes;

  /// Timezone offset in seconds for start time (optional).
  final int? startZoneOffsetSeconds;

  /// Timezone offset in seconds for end time (optional).
  final int? endZoneOffsetSeconds;
}

class ActiveEnergyBurnedRecordDto extends HealthRecordDto {
  ActiveEnergyBurnedRecordDto({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.metadata,
    required this.kilocalories,
    this.startZoneOffsetSeconds,
    this.endZoneOffsetSeconds,
  });

  /// Energy burned during the interval.
  final double kilocalories;

  /// End time in milliseconds since epoch (UTC).
  final int endTime;

  /// Platform-assigned unique identifier.
  final String? id;

  /// Metadata about this record.
  final MetadataDto metadata;

  /// Start time in milliseconds since epoch (UTC).
  final int startTime;

  /// Timezone offset in seconds for start time (optional).
  final int? startZoneOffsetSeconds;

  /// Timezone offset in seconds for end time (optional).
  final int? endZoneOffsetSeconds;
}

/// Represents an alcoholic beverages record for platform transfer.
class AlcoholicBeveragesRecordDto extends HealthRecordDto {
  AlcoholicBeveragesRecordDto({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.metadata,
    required this.count,
    this.startZoneOffsetSeconds,
    this.endZoneOffsetSeconds,
  });

  /// Number of alcoholic beverages consumed during the interval (must be >= 0).
  final double count;

  /// End time in milliseconds since epoch (UTC).
  final int endTime;

  /// Platform-assigned unique identifier.
  final String? id;

  /// Metadata about this record.
  final MetadataDto metadata;

  /// Start time in milliseconds since epoch (UTC).
  final int startTime;

  /// Timezone offset in seconds for start time (optional).
  final int? startZoneOffsetSeconds;

  /// Timezone offset in seconds for end time (optional).
  final int? endZoneOffsetSeconds;
}

/// Represents a distance activity record for platform transfer.
class DistanceActivityRecordDto extends HealthRecordDto {
  DistanceActivityRecordDto({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.metadata,
    required this.meters,
    required this.activityType,
    this.startZoneOffsetSeconds,
    this.endZoneOffsetSeconds,
  });

  /// Distance traveled during the interval.
  final double meters;

  /// The type of distance activity.
  final DistanceActivityTypeDto activityType;

  /// End time in milliseconds since epoch (UTC).
  final int endTime;

  /// Platform-assigned unique identifier.
  final String? id;

  /// Metadata about this record.
  final MetadataDto metadata;

  /// Start time in milliseconds since epoch (UTC).
  final int startTime;

  /// Timezone offset in seconds for start time (optional).
  final int? startZoneOffsetSeconds;

  /// Timezone offset in seconds for end time (optional).
  final int? endZoneOffsetSeconds;
}

/// Represents a speed activity record for platform transfer.
///
/// Speed activity records are instant records (single point in time)
/// representing speed measurements for specific activity types.
class SpeedActivityRecordDto extends HealthRecordDto {
  SpeedActivityRecordDto({
    required this.id,
    required this.time,
    required this.metadata,
    required this.metersPerSecond,
    required this.activityType,
    this.zoneOffsetSeconds,
  });

  /// Speed measurement.
  final double metersPerSecond;

  /// The type of speed activity.
  final SpeedActivityTypeDto activityType;

  /// Measurement time in milliseconds since epoch (UTC).
  final int time;

  /// Platform-assigned unique identifier.
  final String? id;

  /// Metadata about this record.
  final MetadataDto metadata;

  /// Timezone offset in seconds (optional).
  final int? zoneOffsetSeconds;
}

/// Represents a floors climbed record for platform transfer.
class FloorsClimbedRecordDto extends HealthRecordDto {
  FloorsClimbedRecordDto({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.metadata,
    required this.floors,
    this.startZoneOffsetSeconds,
    this.endZoneOffsetSeconds,
  });

  /// Number of floors (flights of stairs) climbed during the interval.
  final double floors;

  /// End time in milliseconds since epoch (UTC).
  final int endTime;

  /// Platform-assigned unique identifier.
  final String? id;

  /// Metadata about this record.
  final MetadataDto metadata;

  /// Start time in milliseconds since epoch (UTC).
  final int startTime;

  /// Timezone offset in seconds for start time (optional).
  final int? startZoneOffsetSeconds;

  /// Timezone offset in seconds for end time (optional).
  final int? endZoneOffsetSeconds;
}

/// Represents a wheelchair pushes record for platform transfer.
class WheelchairPushesRecordDto extends HealthRecordDto {
  WheelchairPushesRecordDto({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.metadata,
    required this.pushes,
    this.startZoneOffsetSeconds,
    this.endZoneOffsetSeconds,
  });

  /// Number of wheelchair pushes performed during the interval.
  final double pushes;

  /// End time in milliseconds since epoch (UTC).
  final int endTime;

  /// Platform-assigned unique identifier.
  final String? id;

  /// Metadata about this record.
  final MetadataDto metadata;

  /// Start time in milliseconds since epoch (UTC).
  final int startTime;

  /// Timezone offset in seconds for start time (optional).
  final int? startZoneOffsetSeconds;

  /// Timezone offset in seconds for end time (optional).
  final int? endZoneOffsetSeconds;
}

/// Represents a step count record for platform transfer.
class StepsRecordDto extends HealthRecordDto {
  StepsRecordDto({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.metadata,
    required this.count,
    this.startZoneOffsetSeconds,
    this.endZoneOffsetSeconds,
  });

  /// Number of steps taken during the interval (must be >= 0).
  final double count;

  /// End time in milliseconds since epoch (UTC).
  final int endTime;

  /// Platform-assigned unique identifier.
  final String? id;

  /// Metadata about this record.
  final MetadataDto metadata;

  /// Start time in milliseconds since epoch (UTC).
  final int startTime;

  /// Timezone offset in seconds for start time (optional).
  final int? startZoneOffsetSeconds;

  /// Timezone offset in seconds for end time (optional).
  final int? endZoneOffsetSeconds;
}

class SwimmingStrokesRecordDto extends HealthRecordDto {
  SwimmingStrokesRecordDto({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.metadata,
    required this.count,
    this.startZoneOffsetSeconds,
    this.endZoneOffsetSeconds,
  });

  /// Number of strokes taken during the interval (must be >= 0).
  final double count;

  /// End time in milliseconds since epoch (UTC).
  final int endTime;

  /// Platform-assigned unique identifier.
  final String? id;

  /// Metadata about this record.
  final MetadataDto metadata;

  /// Start time in milliseconds since epoch (UTC).
  final int startTime;

  /// Timezone offset in seconds for start time (optional).
  final int? startZoneOffsetSeconds;

  /// Timezone offset in seconds for end time (optional).
  final int? endZoneOffsetSeconds;
}

/// Represents a weight record for platform transfer.
class WeightRecordDto extends HealthRecordDto {
  WeightRecordDto({
    required this.id,
    required this.time,
    required this.metadata,
    required this.kilograms,
    this.zoneOffsetSeconds,
  });

  /// Platform-assigned unique identifier.
  final String? id;

  /// Metadata about this record.
  final MetadataDto metadata;

  /// Measurement time in milliseconds since epoch (UTC).
  final int time;

  /// Weight measurement.
  final double kilograms;

  /// Timezone offset in seconds for measurement time (optional).
  final int? zoneOffsetSeconds;
}

/// Represents a composite blood pressure record for platform transfer.
/// Maps to HKCorrelationType.bloodPressure.
class BloodPressureRecordDto extends HealthRecordDto {
  BloodPressureRecordDto({
    required this.id,
    required this.time,
    required this.metadata,
    required this.systolicInMillimetersOfMercury,
    required this.diastolicInMillimetersOfMercury,
    required this.bodyPosition,
    required this.measurementLocation,
    this.zoneOffsetSeconds,
  });

  /// Platform-assigned unique identifier.
  final String? id;

  /// Metadata about this record.
  final MetadataDto metadata;

  /// Measurement time in milliseconds since epoch (UTC).
  final int time;

  /// Systolic blood pressure measurement.
  final double systolicInMillimetersOfMercury;

  /// Diastolic blood pressure measurement.
  final double diastolicInMillimetersOfMercury;

  /// Body position during measurement (Android Health Connect Only, always
  /// unknown on iOS HealthKit).
  final BodyPositionDto bodyPosition;

  /// Location where measurement was taken (Android Health Connect Only,
  /// always unknown on iOS HealthKit).
  final MeasurementLocationDto measurementLocation;

  /// Timezone offset in seconds for measurement time (optional).
  final int? zoneOffsetSeconds;
}

/// Represents a systolic blood pressure record for platform transfer.
/// Maps to HKQuantityType.bloodPressureSystolic.
class SystolicBloodPressureRecordDto extends HealthRecordDto {
  SystolicBloodPressureRecordDto({
    required this.id,
    required this.time,
    required this.metadata,
    required this.millimetersOfMercury,
    required this.bodyPosition,
    required this.measurementLocation,
    this.zoneOffsetSeconds,
  });

  /// Platform-assigned unique identifier.
  final String? id;

  /// Metadata about this record.
  final MetadataDto metadata;

  /// Measurement time in milliseconds since epoch (UTC).
  final int time;

  /// Systolic blood pressure measurement.
  final double millimetersOfMercury;

  /// Body position during measurement (Android Health Connect Only, always
  /// unknown on iOS HealthKit).
  final BodyPositionDto bodyPosition;

  /// Location where measurement was taken (Android Health Connect Only,
  /// always unknown on iOS HealthKit).
  final MeasurementLocationDto measurementLocation;

  /// Timezone offset in seconds for measurement time (optional).
  final int? zoneOffsetSeconds;
}

/// Represents a diastolic blood pressure record for platform transfer.
/// Maps to HKQuantityType.bloodPressureDiastolic.
class DiastolicBloodPressureRecordDto extends HealthRecordDto {
  DiastolicBloodPressureRecordDto({
    required this.id,
    required this.time,
    required this.metadata,
    required this.millimetersOfMercury,
    required this.bodyPosition,
    required this.measurementLocation,
    this.zoneOffsetSeconds,
  });

  /// Platform-assigned unique identifier.
  final String? id;

  /// Metadata about this record.
  final MetadataDto metadata;

  /// Measurement time in milliseconds since epoch (UTC).
  final int time;

  /// Diastolic blood pressure measurement.
  final double millimetersOfMercury;

  /// Body position during measurement (Android Health Connect Only, always
  /// unknown on iOS HealthKit).
  final BodyPositionDto bodyPosition;

  /// Location where measurement was taken (Android Health Connect Only,
  /// always unknown on iOS HealthKit).
  final MeasurementLocationDto measurementLocation;

  /// Timezone offset in seconds for measurement time (optional).
  final int? zoneOffsetSeconds;
}

/// DTO for lean body mass health data.
class LeanBodyMassRecordDto extends HealthRecordDto {
  LeanBodyMassRecordDto({
    required this.id,
    required this.time,
    required this.metadata,
    required this.kilograms,
    this.zoneOffsetSeconds,
  });

  /// Platform-assigned unique identifier.
  final String? id;

  /// Metadata about this record.
  final MetadataDto metadata;

  /// Measurement time in milliseconds since epoch (UTC).
  final int time;

  /// Lean body mass measurement.
  final double kilograms;

  /// Timezone offset in seconds for measurement time (optional).
  final int? zoneOffsetSeconds;
}

/// DTO for body height health data.
class HeightRecordDto extends HealthRecordDto {
  HeightRecordDto({
    required this.id,
    required this.time,
    required this.metadata,
    required this.meters,
    this.zoneOffsetSeconds,
  });

  /// Platform-assigned unique identifier.
  final String? id;

  /// Metadata about this record.
  final MetadataDto metadata;

  /// Measurement time in milliseconds since epoch (UTC).
  final int time;

  /// Height measurement.
  final double meters;

  /// Timezone offset in seconds for measurement time (optional).
  final int? zoneOffsetSeconds;
}

/// DTO for body fat percentage health data.
/// Represents a blood alcohol content record.
class BloodAlcoholContentRecordDto extends HealthRecordDto {
  BloodAlcoholContentRecordDto({
    required this.id,
    required this.time,
    required this.metadata,
    required this.percentage,
    this.zoneOffsetSeconds,
  });

  final String? id;
  final MetadataDto metadata;
  final int time;
  final int? zoneOffsetSeconds;
  final double percentage;
}

class BodyFatPercentageRecordDto extends HealthRecordDto {
  BodyFatPercentageRecordDto({
    required this.id,
    required this.time,
    required this.metadata,
    required this.percentage,
    this.zoneOffsetSeconds,
  });

  /// Platform-assigned unique identifier.
  final String? id;

  /// Metadata about this record.
  final MetadataDto metadata;

  /// Measurement time in milliseconds since epoch (UTC).
  final int time;

  /// Body fat percentage measurement.
  final double percentage;

  /// Timezone offset in seconds for measurement time (optional).
  final int? zoneOffsetSeconds;
}

/// DTO for body temperature health data.
class BodyTemperatureRecordDto extends HealthRecordDto {
  BodyTemperatureRecordDto({
    required this.id,
    required this.time,
    required this.metadata,
    required this.celsius,
    this.zoneOffsetSeconds,
  });

  /// Platform-assigned unique identifier.
  final String? id;

  /// Metadata about this record.
  final MetadataDto metadata;

  /// Measurement time in milliseconds since epoch (UTC).
  final int time;

  /// Body temperature measurement.
  final double celsius;

  /// Timezone offset in seconds for measurement time (optional).
  final int? zoneOffsetSeconds;
}

/// DTO for basal body temperature health data.
class BasalBodyTemperatureRecordDto extends HealthRecordDto {
  BasalBodyTemperatureRecordDto({
    required this.id,
    required this.time,
    required this.metadata,
    required this.celsius,
    required this.measurementLocation,
    this.zoneOffsetSeconds,
  });

  /// Platform-assigned unique identifier.
  final String? id;

  /// Metadata about this record.
  final MetadataDto metadata;

  /// Measurement time in milliseconds since epoch (UTC).
  final int time;

  /// Basal body temperature measurement.
  final double celsius;

  /// The location on the body where the measurement was taken.
  final BasalBodyTemperatureMeasurementLocationDto measurementLocation;

  /// Timezone offset in seconds for measurement time (optional).
  final int? zoneOffsetSeconds;
}

/// Represents a cervical mucus observation record for platform transfer.
///
/// Maps to iOS HealthKit HKCategoryTypeIdentifier.cervicalMucusQuality.
///
/// **iOS Platform Limitations:**
/// - `appearance`: Only `dry`, `sticky`, `creamy`, `watery`, `eggWhite`
///   use native HKCategoryValueCervicalMucusQuality mapping. Values `unusual`
///   and `unknown` require custom metadata handling in Swift.
/// - `sensation`: Not natively supported by iOS HealthKit. All sensation
///   values require custom metadata handling in Swift.
class CervicalMucusRecordDto extends HealthRecordDto {
  CervicalMucusRecordDto({
    required this.id,
    required this.time,
    required this.metadata,
    required this.appearance,
    required this.sensation,
    this.zoneOffsetSeconds,
  });

  /// Platform-assigned unique identifier.
  final String? id;

  /// Metadata about this record.
  final MetadataDto metadata;

  /// Observation time in milliseconds since epoch (UTC).
  final int time;

  /// Timezone offset in seconds for observation time (optional).
  final int? zoneOffsetSeconds;

  /// Cervical mucus appearance.
  /// Values `unusual` and `unknown` use custom metadata on iOS.
  final CervicalMucusAppearanceDto appearance;

  /// Cervical mucus sensation.
  /// All values use custom metadata on iOS (HealthKit limitation).
  final CervicalMucusSensationDto sensation;
}

/// DTO for cycling power health data.
class CyclingPowerRecordDto extends HealthRecordDto {
  CyclingPowerRecordDto({
    required this.id,
    required this.time,
    required this.metadata,
    required this.watts,
    this.zoneOffsetSeconds,
  });

  /// Platform-assigned unique identifier.
  final String? id;

  /// Metadata about this record.
  final MetadataDto metadata;

  /// Measurement time in milliseconds since epoch (UTC).
  final int time;

  /// Cycling power measurement.
  final double watts;

  /// Timezone offset in seconds for measurement time (optional).
  final int? zoneOffsetSeconds;
}

/// DTO for running power health data.
class RunningPowerRecordDto extends HealthRecordDto {
  RunningPowerRecordDto({
    required this.id,
    required this.time,
    required this.metadata,
    required this.watts,
    this.zoneOffsetSeconds,
  });

  /// Platform-assigned unique identifier.
  final String? id;

  /// Metadata about this record.
  final MetadataDto metadata;

  /// Measurement time in milliseconds since epoch (UTC).
  final int time;

  /// Running power measurement in Watts.
  final double watts;

  /// Timezone offset in seconds for measurement time (optional).
  final int? zoneOffsetSeconds;
}

/// Represents an oxygen saturation record for platform transfer.
class OxygenSaturationRecordDto extends HealthRecordDto {
  OxygenSaturationRecordDto({
    required this.id,
    required this.time,
    required this.metadata,
    required this.percentage,
    this.zoneOffsetSeconds,
  });

  /// Platform-assigned unique identifier.
  final String? id;

  /// Measurement time in milliseconds since epoch (UTC).
  final int time;

  /// Metadata about this record.
  final MetadataDto metadata;

  /// Oxygen saturation percentage.
  final double percentage;

  /// Timezone offset in seconds for measurement time (optional).
  final int? zoneOffsetSeconds;
}

/// Represents an ovulation test record for platform transfer.
class OvulationTestRecordDto extends HealthRecordDto {
  OvulationTestRecordDto({
    required this.id,
    required this.metadata,
    required this.time,
    required this.result,
    this.zoneOffsetSeconds,
  });

  /// Platform-assigned unique identifier.
  final String? id;

  /// Metadata about this record.
  final MetadataDto metadata;

  /// Measurement time in milliseconds since epoch (UTC).
  final int time;

  /// Timezone offset in seconds for measurement time (optional).
  final int? zoneOffsetSeconds;

  /// The ovulation test result.
  final OvulationTestResultDto result;
}

/// Represents a pregnancy test record for platform transfer.
class PregnancyTestRecordDto extends HealthRecordDto {
  PregnancyTestRecordDto({
    required this.id,
    required this.metadata,
    required this.time,
    required this.result,
    this.zoneOffsetSeconds,
  });

  /// Platform-assigned unique identifier.
  final String? id;

  /// Metadata about this record.
  final MetadataDto metadata;

  /// Measurement time in milliseconds since epoch (UTC).
  final int time;

  /// Timezone offset in seconds for measurement time (optional).
  final int? zoneOffsetSeconds;

  /// The pregnancy test result.
  final PregnancyTestResultDto result;
}

/// Represents a pregnancy record for platform transfer (iOS HealthKit).
class PregnancyRecordDto extends HealthRecordDto {
  PregnancyRecordDto({
    required this.id,
    required this.metadata,
    required this.startTime,
    required this.endTime,
    this.startZoneOffsetSeconds,
    this.endZoneOffsetSeconds,
  });

  /// Platform-assigned unique identifier.
  final String? id;

  /// Metadata about this record.
  final MetadataDto metadata;

  /// Start time in milliseconds since epoch (UTC).
  final int startTime;

  /// End time in milliseconds since epoch (UTC).
  final int endTime;

  /// Timezone offset in seconds for start time (optional).
  final int? startZoneOffsetSeconds;

  /// Timezone offset in seconds for end time (optional).
  final int? endZoneOffsetSeconds;
}

/// Represents a contraceptive record for platform transfer (iOS HealthKit).
class ContraceptiveRecordDto extends HealthRecordDto {
  ContraceptiveRecordDto({
    required this.id,
    required this.metadata,
    required this.startTime,
    required this.endTime,
    required this.contraceptiveType,
    this.startZoneOffsetSeconds,
    this.endZoneOffsetSeconds,
  });

  /// Platform-assigned unique identifier.
  final String? id;

  /// Metadata about this record.
  final MetadataDto metadata;

  /// Start time in milliseconds since epoch (UTC).
  final int startTime;

  /// End time in milliseconds since epoch (UTC).
  final int endTime;

  /// The type of contraceptive method used during this period.
  final ContraceptiveTypeDto contraceptiveType;

  /// Timezone offset in seconds for start time (optional).
  final int? startZoneOffsetSeconds;

  /// Timezone offset in seconds for end time (optional).
  final int? endZoneOffsetSeconds;
}

/// Represents a progesterone test record for platform transfer.
class ProgesteroneTestRecordDto extends HealthRecordDto {
  ProgesteroneTestRecordDto({
    required this.id,
    required this.metadata,
    required this.time,
    required this.result,
    this.zoneOffsetSeconds,
  });

  /// Platform-assigned unique identifier.
  final String? id;

  /// Metadata about this record.
  final MetadataDto metadata;

  /// Measurement time in milliseconds since epoch (UTC).
  final int time;

  /// Timezone offset in seconds for measurement time (optional).
  final int? zoneOffsetSeconds;

  /// The progesterone test result.
  final ProgesteroneTestResultDto result;
}

/// Represents an intermenstrual bleeding record for platform transfer.
class IntermenstrualBleedingRecordDto extends HealthRecordDto {
  IntermenstrualBleedingRecordDto({
    required this.id,
    required this.metadata,
    required this.time,
    this.zoneOffsetSeconds,
  });

  /// Platform-assigned unique identifier.
  final String? id;

  /// Metadata about this record.
  final MetadataDto metadata;

  /// Measurement time in milliseconds since epoch (UTC).
  final int time;

  /// Timezone offset in seconds for measurement time (optional).
  final int? zoneOffsetSeconds;
}

/// Represents a menstrual flow interval record for platform transfer (iOS).
///
/// This DTO is used for iOS HealthKit's menstrualFlow category type,
/// which tracks flow intensity over a time interval and includes
/// cycle start metadata.
class MenstrualFlowRecordDto extends HealthRecordDto {
  MenstrualFlowRecordDto({
    required this.id,
    required this.metadata,
    required this.startTime,
    required this.endTime,
    required this.flow,
    required this.isCycleStart,
    this.startZoneOffsetSeconds,
    this.endZoneOffsetSeconds,
  });

  /// Platform-assigned unique identifier.
  final String? id;

  /// Metadata about this record.
  final MetadataDto metadata;

  /// Start time in milliseconds since epoch (UTC).
  final int startTime;

  /// End time in milliseconds since epoch (UTC).
  final int endTime;

  /// Timezone offset in seconds for start time (optional).
  final int? startZoneOffsetSeconds;

  /// Timezone offset in seconds for end time (optional).
  final int? endZoneOffsetSeconds;

  /// The menstrual flow intensity.
  final MenstrualFlowDto flow;

  /// Whether this sample marks the start of a menstrual cycle.
  /// Maps to HKMetadataKeyMenstrualCycleStart in iOS HealthKit.
  final bool isCycleStart;
}

/// Represents a respiratory rate record for platform transfer.
class RespiratoryRateRecordDto extends HealthRecordDto {
  RespiratoryRateRecordDto({
    required this.id,
    required this.time,
    required this.metadata,
    required this.breathsPerMinute,
    this.zoneOffsetSeconds,
  });

  /// Platform-assigned unique identifier.
  final String? id;

  /// Measurement time in milliseconds since epoch (UTC).
  final int time;

  /// Metadata about this record.
  final MetadataDto metadata;

  /// Respiratory rate in breaths per minute.
  final double breathsPerMinute;

  /// Timezone offset in seconds for measurement time (optional).
  final int? zoneOffsetSeconds;
}

/// Represents a hydration (water intake) record for platform transfer.
class HydrationRecordDto extends HealthRecordDto {
  HydrationRecordDto({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.metadata,
    required this.liters,
    this.startZoneOffsetSeconds,
    this.endZoneOffsetSeconds,
  });

  /// Platform-assigned unique identifier.
  final String? id;

  /// Start time in milliseconds since epoch (UTC).
  final int startTime;

  /// End time in milliseconds since epoch (UTC).
  final int endTime;

  /// Metadata about this record.
  final MetadataDto metadata;

  /// Volume of water consumed during the interval.
  final double liters;

  /// Timezone offset in seconds for start time (optional).
  final int? startZoneOffsetSeconds;

  /// Timezone offset in seconds for end time (optional).
  final int? endZoneOffsetSeconds;
}

/// Represents a single heart rate measurement for platform transfer.
///
/// This is a platform-agnostic value class used within heart rate records.
/// It contains a timestamp and BPM value without ID or metadata.
class HeartRateMeasurementDto {
  HeartRateMeasurementDto({
    required this.time,
    required this.beatsPerMinute,
  });

  /// Timestamp in milliseconds since epoch (UTC).
  final int time;

  /// Heart rate value in beats per minute (BPM).
  final double beatsPerMinute;
}

/// Represents a heart rate measurement record for platform
/// transfer (iOS HealthKit only).
class HeartRateRecordDto extends HealthRecordDto {
  HeartRateRecordDto({
    required this.id,
    required this.time,
    required this.metadata,
    required this.beatsPerMinute,
    this.zoneOffsetSeconds,
  });

  /// Platform-assigned unique identifier.
  final String? id;

  /// Measurement time in milliseconds since epoch (UTC).
  final int time;

  /// Metadata about this record.
  final MetadataDto metadata;

  /// The heart rate value in beats per minute (BPM).
  final double beatsPerMinute;

  /// Timezone offset in seconds for measurement time (optional).
  final int? zoneOffsetSeconds;
}

/// Represents a cycling pedaling cadence measurement record (iOS HealthKit).
class CyclingPedalingCadenceRecordDto extends HealthRecordDto {
  CyclingPedalingCadenceRecordDto({
    required this.id,
    required this.time,
    required this.metadata,
    required this.revolutionsPerMinute,
    this.zoneOffsetSeconds,
  });

  /// Platform-assigned unique identifier.
  final String? id;

  /// Cycling cadence value in revolutions per minute (RPM).
  final double revolutionsPerMinute;

  /// Time in milliseconds since epoch (UTC).
  final int time;

  /// Timezone offset in seconds. Null if unknown.
  final int? zoneOffsetSeconds;

  /// Metadata for this record.
  final MetadataDto metadata;
}

/// Represents a sleep stage record for platform transfer (iOS HealthKit).
///
/// Sleep data in HealthKit uses HKCategorySample with categoryType
/// .sleepAnalysis. Each record represents a single continuous period in one
/// stage.
class SleepStageRecordDto extends HealthRecordDto {
  SleepStageRecordDto({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.metadata,
    required this.stageType,
    this.startZoneOffsetSeconds,
    this.endZoneOffsetSeconds,
  });

  /// Platform-assigned unique identifier.
  final String? id;

  /// Start time in milliseconds since epoch (UTC).
  final int startTime;

  /// End time in milliseconds since epoch (UTC).
  final int endTime;

  /// Metadata about this record.
  final MetadataDto metadata;

  /// The sleep stage type for this record.
  final SleepStageDto stageType;

  /// Timezone offset in seconds for start time (optional).
  final int? startZoneOffsetSeconds;

  /// Timezone offset in seconds for end time (optional).
  final int? endZoneOffsetSeconds;
}

/// Represents a sexual activity record for platform transfer.
class SexualActivityRecordDto extends HealthRecordDto {
  SexualActivityRecordDto({
    required this.id,
    required this.metadata,
    required this.time,
    required this.protectionUsed,
    this.zoneOffsetSeconds,
  });

  /// Platform-assigned unique identifier.
  final String? id;

  /// Metadata about this record.
  final MetadataDto metadata;

  /// Time in milliseconds since epoch (UTC).
  final int time;

  /// Timezone offset in seconds (optional).
  final int? zoneOffsetSeconds;

  /// Whether protection was used (optional).
  final SexualActivityProtectionUsedDto protectionUsed;
}

/// Represents energy nutrient data for platform transfer.
///
/// Maps to:
/// - HealthKit: `HKQuantityTypeIdentifier.dietaryEnergyConsumed`
/// - Domain: `DietaryEnergyRecord`
class DietaryEnergyConsumedRecordDto extends HealthRecordDto {
  DietaryEnergyConsumedRecordDto({
    required this.id,
    required this.metadata,
    required this.time,
    required this.kilocalories,
    this.zoneOffsetSeconds,
    this.foodName,
    this.mealType,
  });

  /// Platform-assigned unique identifier.
  final String? id;

  /// Metadata about this record.
  final MetadataDto metadata;

  /// Time in milliseconds since epoch (UTC).
  final int time;

  /// Timezone offset in seconds (optional).
  final int? zoneOffsetSeconds;

  /// Energy value (in kilocalories).
  final double kilocalories;

  /// Name of the food (optional).
  final String? foodName;

  /// Meal type classification.
  final MealTypeDto? mealType;
}

/// Represents caffeine nutrient data for platform transfer.
class DietaryCaffeineRecordDto extends HealthRecordDto {
  DietaryCaffeineRecordDto({
    required this.id,
    required this.metadata,
    required this.time,
    required this.grams,
    this.zoneOffsetSeconds,
    this.foodName,
    this.mealType,
  });

  final String? id;
  final MetadataDto metadata;
  final int time;
  final int? zoneOffsetSeconds;
  final double grams;
  final String? foodName;
  final MealTypeDto? mealType;
}

/// Represents protein nutrient data for platform transfer.
class DietaryProteinRecordDto extends HealthRecordDto {
  DietaryProteinRecordDto({
    required this.id,
    required this.metadata,
    required this.time,
    required this.grams,
    this.zoneOffsetSeconds,
    this.foodName,
    this.mealType,
  });

  final String? id;
  final MetadataDto metadata;
  final int time;
  final int? zoneOffsetSeconds;
  final double grams;
  final String? foodName;
  final MealTypeDto? mealType;
}

/// Represents total carbohydrate nutrient data for platform transfer.
class DietaryTotalCarbohydrateRecordDto extends HealthRecordDto {
  DietaryTotalCarbohydrateRecordDto({
    required this.id,
    required this.metadata,
    required this.time,
    required this.grams,
    this.zoneOffsetSeconds,
    this.foodName,
    this.mealType,
  });

  final String? id;
  final MetadataDto metadata;
  final int time;
  final int? zoneOffsetSeconds;
  final double grams;
  final String? foodName;
  final MealTypeDto? mealType;
}

/// Represents total fat nutrient data for platform transfer.
class DietaryTotalFatRecordDto extends HealthRecordDto {
  DietaryTotalFatRecordDto({
    required this.id,
    required this.metadata,
    required this.time,
    required this.grams,
    this.zoneOffsetSeconds,
    this.foodName,
    this.mealType,
  });

  final String? id;
  final MetadataDto metadata;
  final int time;
  final int? zoneOffsetSeconds;
  final double grams;
  final String? foodName;
  final MealTypeDto? mealType;
}

/// Represents saturated fat nutrient data for platform transfer.
class DietarySaturatedFatRecordDto extends HealthRecordDto {
  DietarySaturatedFatRecordDto({
    required this.id,
    required this.metadata,
    required this.time,
    required this.grams,
    this.zoneOffsetSeconds,
    this.foodName,
    this.mealType,
  });

  final String? id;
  final MetadataDto metadata;
  final int time;
  final int? zoneOffsetSeconds;
  final double grams;
  final String? foodName;
  final MealTypeDto? mealType;
}

/// Represents monounsaturated fat nutrient data for platform transfer.
class DietaryMonounsaturatedFatRecordDto extends HealthRecordDto {
  DietaryMonounsaturatedFatRecordDto({
    required this.id,
    required this.metadata,
    required this.time,
    required this.grams,
    this.zoneOffsetSeconds,
    this.foodName,
    this.mealType,
  });

  final String? id;
  final MetadataDto metadata;
  final int time;
  final int? zoneOffsetSeconds;
  final double grams;
  final String? foodName;
  final MealTypeDto? mealType;
}

/// Represents polyunsaturated fat nutrient data for platform transfer.
class DietaryPolyunsaturatedFatRecordDto extends HealthRecordDto {
  DietaryPolyunsaturatedFatRecordDto({
    required this.id,
    required this.metadata,
    required this.time,
    required this.grams,
    this.zoneOffsetSeconds,
    this.foodName,
    this.mealType,
  });

  final String? id;
  final MetadataDto metadata;
  final int time;
  final int? zoneOffsetSeconds;
  final double grams;
  final String? foodName;
  final MealTypeDto? mealType;
}

/// Represents cholesterol nutrient data for platform transfer.
class DietaryCholesterolRecordDto extends HealthRecordDto {
  DietaryCholesterolRecordDto({
    required this.id,
    required this.metadata,
    required this.time,
    required this.grams,
    this.zoneOffsetSeconds,
    this.foodName,
    this.mealType,
  });

  final String? id;
  final MetadataDto metadata;
  final int time;
  final int? zoneOffsetSeconds;
  final double grams;
  final String? foodName;
  final MealTypeDto? mealType;
}

/// Represents dietary fiber nutrient data for platform transfer.
class DietaryFiberRecordDto extends HealthRecordDto {
  DietaryFiberRecordDto({
    required this.id,
    required this.metadata,
    required this.time,
    required this.grams,
    this.zoneOffsetSeconds,
    this.foodName,
    this.mealType,
  });

  final String? id;
  final MetadataDto metadata;
  final int time;
  final int? zoneOffsetSeconds;
  final double grams;
  final String? foodName;
  final MealTypeDto? mealType;
}

/// Represents sugar nutrient data for platform transfer.
class DietarySugarRecordDto extends HealthRecordDto {
  DietarySugarRecordDto({
    required this.id,
    required this.metadata,
    required this.time,
    required this.grams,
    this.zoneOffsetSeconds,
    this.foodName,
    this.mealType,
  });

  final String? id;
  final MetadataDto metadata;
  final int time;
  final int? zoneOffsetSeconds;
  final double grams;
  final String? foodName;
  final MealTypeDto? mealType;
}

/// Represents vitamin A nutrient data for platform transfer.
class DietaryVitaminARecordDto extends HealthRecordDto {
  DietaryVitaminARecordDto({
    required this.id,
    required this.metadata,
    required this.time,
    required this.grams,
    this.zoneOffsetSeconds,
    this.foodName,
    this.mealType,
  });

  final String? id;
  final MetadataDto metadata;
  final int time;
  final int? zoneOffsetSeconds;
  final double grams;
  final String? foodName;
  final MealTypeDto? mealType;
}

/// Represents vitamin B6 nutrient data for platform transfer.
class DietaryVitaminB6RecordDto extends HealthRecordDto {
  DietaryVitaminB6RecordDto({
    required this.id,
    required this.metadata,
    required this.time,
    required this.grams,
    this.zoneOffsetSeconds,
    this.foodName,
    this.mealType,
  });

  final String? id;
  final MetadataDto metadata;
  final int time;
  final int? zoneOffsetSeconds;
  final double grams;
  final String? foodName;
  final MealTypeDto? mealType;
}

/// Represents vitamin B12 nutrient data for platform transfer.
class DietaryVitaminB12RecordDto extends HealthRecordDto {
  DietaryVitaminB12RecordDto({
    required this.id,
    required this.metadata,
    required this.time,
    required this.grams,
    this.zoneOffsetSeconds,
    this.foodName,
    this.mealType,
  });

  final String? id;
  final MetadataDto metadata;
  final int time;
  final int? zoneOffsetSeconds;
  final double grams;
  final String? foodName;
  final MealTypeDto? mealType;
}

/// Represents vitamin C nutrient data for platform transfer.
class DietaryVitaminCRecordDto extends HealthRecordDto {
  DietaryVitaminCRecordDto({
    required this.id,
    required this.metadata,
    required this.time,
    required this.grams,
    this.zoneOffsetSeconds,
    this.foodName,
    this.mealType,
  });

  final String? id;
  final MetadataDto metadata;
  final int time;
  final int? zoneOffsetSeconds;
  final double grams;
  final String? foodName;
  final MealTypeDto? mealType;
}

/// Represents vitamin D nutrient data for platform transfer.
class DietaryVitaminDRecordDto extends HealthRecordDto {
  DietaryVitaminDRecordDto({
    required this.id,
    required this.metadata,
    required this.time,
    required this.grams,
    this.zoneOffsetSeconds,
    this.foodName,
    this.mealType,
  });

  final String? id;
  final MetadataDto metadata;
  final int time;
  final int? zoneOffsetSeconds;
  final double grams;
  final String? foodName;
  final MealTypeDto? mealType;
}

/// Represents vitamin E nutrient data for platform transfer.
class DietaryVitaminERecordDto extends HealthRecordDto {
  DietaryVitaminERecordDto({
    required this.id,
    required this.metadata,
    required this.time,
    required this.grams,
    this.zoneOffsetSeconds,
    this.foodName,
    this.mealType,
  });

  final String? id;
  final MetadataDto metadata;
  final int time;
  final int? zoneOffsetSeconds;
  final double grams;
  final String? foodName;
  final MealTypeDto? mealType;
}

/// Represents lactation data for platform transfer (iOS only).
class LactationRecordDto extends HealthRecordDto {
  LactationRecordDto({
    required this.id,
    required this.metadata,
    required this.startTime,
    required this.endTime,
    this.startZoneOffsetSeconds,
    this.endZoneOffsetSeconds,
  });

  final String? id;
  final MetadataDto metadata;
  final int startTime;
  final int endTime;
  final int? startZoneOffsetSeconds;
  final int? endZoneOffsetSeconds;
}

/// Represents vitamin K nutrient data for platform transfer.
class DietaryVitaminKRecordDto extends HealthRecordDto {
  DietaryVitaminKRecordDto({
    required this.id,
    required this.metadata,
    required this.time,
    required this.grams,
    this.zoneOffsetSeconds,
    this.foodName,
    this.mealType,
  });

  final String? id;
  final MetadataDto metadata;
  final int time;
  final int? zoneOffsetSeconds;
  final double grams;
  final String? foodName;
  final MealTypeDto? mealType;
}

/// Represents thiamin (vitamin B1) nutrient data for platform transfer.
class DietaryThiaminRecordDto extends HealthRecordDto {
  DietaryThiaminRecordDto({
    required this.id,
    required this.metadata,
    required this.time,
    required this.grams,
    this.zoneOffsetSeconds,
    this.foodName,
    this.mealType,
  });

  final String? id;
  final MetadataDto metadata;
  final int time;
  final int? zoneOffsetSeconds;
  final double grams;
  final String? foodName;
  final MealTypeDto? mealType;
}

/// Represents riboflavin (vitamin B2) nutrient data for platform transfer.
class DietaryRiboflavinRecordDto extends HealthRecordDto {
  DietaryRiboflavinRecordDto({
    required this.id,
    required this.metadata,
    required this.time,
    required this.grams,
    this.zoneOffsetSeconds,
    this.foodName,
    this.mealType,
  });

  final String? id;
  final MetadataDto metadata;
  final int time;
  final int? zoneOffsetSeconds;
  final double grams;
  final String? foodName;
  final MealTypeDto? mealType;
}

/// Represents niacin (vitamin B3) nutrient data for platform transfer.
class DietaryNiacinRecordDto extends HealthRecordDto {
  DietaryNiacinRecordDto({
    required this.id,
    required this.metadata,
    required this.time,
    required this.grams,
    this.zoneOffsetSeconds,
    this.foodName,
    this.mealType,
  });

  final String? id;
  final MetadataDto metadata;
  final int time;
  final int? zoneOffsetSeconds;
  final double grams;
  final String? foodName;
  final MealTypeDto? mealType;
}

/// Represents folate (vitamin B9) nutrient data for platform transfer.
class DietaryFolateRecordDto extends HealthRecordDto {
  DietaryFolateRecordDto({
    required this.id,
    required this.metadata,
    required this.time,
    required this.grams,
    this.zoneOffsetSeconds,
    this.foodName,
    this.mealType,
  });

  final String? id;
  final MetadataDto metadata;
  final int time;
  final int? zoneOffsetSeconds;
  final double grams;
  final String? foodName;
  final MealTypeDto? mealType;
}

/// Represents biotin (vitamin B7) nutrient data for platform transfer.
class DietaryBiotinRecordDto extends HealthRecordDto {
  DietaryBiotinRecordDto({
    required this.id,
    required this.metadata,
    required this.time,
    required this.grams,
    this.zoneOffsetSeconds,
    this.foodName,
    this.mealType,
  });

  final String? id;
  final MetadataDto metadata;
  final int time;
  final int? zoneOffsetSeconds;
  final double grams;
  final String? foodName;
  final MealTypeDto? mealType;
}

/// Represents pantothenic acid (vitamin B5) nutrient data.
class DietaryPantothenicAcidRecordDto extends HealthRecordDto {
  DietaryPantothenicAcidRecordDto({
    required this.id,
    required this.metadata,
    required this.time,
    required this.grams,
    this.zoneOffsetSeconds,
    this.foodName,
    this.mealType,
  });

  final String? id;
  final MetadataDto metadata;
  final int time;
  final int? zoneOffsetSeconds;
  final double grams;
  final String? foodName;
  final MealTypeDto? mealType;
}

/// Represents calcium nutrient data for platform transfer.
class DietaryCalciumRecordDto extends HealthRecordDto {
  DietaryCalciumRecordDto({
    required this.id,
    required this.metadata,
    required this.time,
    required this.grams,
    this.zoneOffsetSeconds,
    this.foodName,
    this.mealType,
  });

  final String? id;
  final MetadataDto metadata;
  final int time;
  final int? zoneOffsetSeconds;
  final double grams;
  final String? foodName;
  final MealTypeDto? mealType;
}

/// Represents iron nutrient data for platform transfer.
class DietaryIronRecordDto extends HealthRecordDto {
  DietaryIronRecordDto({
    required this.id,
    required this.metadata,
    required this.time,
    required this.grams,
    this.zoneOffsetSeconds,
    this.foodName,
    this.mealType,
  });

  final String? id;
  final MetadataDto metadata;
  final int time;
  final int? zoneOffsetSeconds;
  final double grams;
  final String? foodName;
  final MealTypeDto? mealType;
}

/// Represents magnesium nutrient data for platform transfer.
class DietaryMagnesiumRecordDto extends HealthRecordDto {
  DietaryMagnesiumRecordDto({
    required this.id,
    required this.metadata,
    required this.time,
    required this.grams,
    this.zoneOffsetSeconds,
    this.foodName,
    this.mealType,
  });

  final String? id;
  final MetadataDto metadata;
  final int time;
  final int? zoneOffsetSeconds;
  final double grams;
  final String? foodName;
  final MealTypeDto? mealType;
}

/// Represents manganese nutrient data for platform transfer.
class DietaryManganeseRecordDto extends HealthRecordDto {
  DietaryManganeseRecordDto({
    required this.id,
    required this.metadata,
    required this.time,
    required this.grams,
    this.zoneOffsetSeconds,
    this.foodName,
    this.mealType,
  });

  final String? id;
  final MetadataDto metadata;
  final int time;
  final int? zoneOffsetSeconds;
  final double grams;
  final String? foodName;
  final MealTypeDto? mealType;
}

/// Represents phosphorus nutrient data for platform transfer.
class DietaryPhosphorusRecordDto extends HealthRecordDto {
  DietaryPhosphorusRecordDto({
    required this.id,
    required this.metadata,
    required this.time,
    required this.grams,
    this.zoneOffsetSeconds,
    this.foodName,
    this.mealType,
  });

  final String? id;
  final MetadataDto metadata;
  final int time;
  final int? zoneOffsetSeconds;
  final double grams;
  final String? foodName;
  final MealTypeDto? mealType;
}

/// Represents potassium nutrient data for platform transfer.
class DietaryPotassiumRecordDto extends HealthRecordDto {
  DietaryPotassiumRecordDto({
    required this.id,
    required this.metadata,
    required this.time,
    required this.grams,
    this.zoneOffsetSeconds,
    this.foodName,
    this.mealType,
  });

  final String? id;
  final MetadataDto metadata;
  final int time;
  final int? zoneOffsetSeconds;
  final double grams;
  final String? foodName;
  final MealTypeDto? mealType;
}

/// Represents selenium nutrient data for platform transfer.
class DietarySeleniumRecordDto extends HealthRecordDto {
  DietarySeleniumRecordDto({
    required this.id,
    required this.metadata,
    required this.time,
    required this.grams,
    this.zoneOffsetSeconds,
    this.foodName,
    this.mealType,
  });

  final String? id;
  final MetadataDto metadata;
  final int time;
  final int? zoneOffsetSeconds;
  final double grams;
  final String? foodName;
  final MealTypeDto? mealType;
}

/// Represents sodium nutrient data for platform transfer.
class DietarySodiumRecordDto extends HealthRecordDto {
  DietarySodiumRecordDto({
    required this.id,
    required this.metadata,
    required this.time,
    required this.grams,
    this.zoneOffsetSeconds,
    this.foodName,
    this.mealType,
  });

  final String? id;
  final MetadataDto metadata;
  final int time;
  final int? zoneOffsetSeconds;
  final double grams;
  final String? foodName;
  final MealTypeDto? mealType;
}

/// Represents zinc nutrient data for platform transfer.
class DietaryZincRecordDto extends HealthRecordDto {
  DietaryZincRecordDto({
    required this.id,
    required this.metadata,
    required this.time,
    required this.grams,
    this.zoneOffsetSeconds,
    this.foodName,
    this.mealType,
  });

  final String? id;
  final MetadataDto metadata;
  final int time;
  final int? zoneOffsetSeconds;
  final double grams;
  final String? foodName;
  final MealTypeDto? mealType;
}

/// Represents a combined nutrition record for platform transfer.
///
/// Maps to:
/// - HealthKit: `HKCorrelationType.food` (HKCorrelation)
/// - Domain: `NutritionRecord`
///
/// This DTO groups all nutrients from a single meal/food entry.
/// On iOS, this is stored as an HKCorrelation containing multiple
/// HKQuantitySample objects for each nutrient.
class NutritionRecordDto extends HealthRecordDto {
  NutritionRecordDto({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.metadata,
    this.startZoneOffsetSeconds,
    this.endZoneOffsetSeconds,
    this.foodName,
    this.mealType,
    // Energy
    this.energyKilocalories,
    // Macronutrients
    this.proteinInGrams,
    this.totalCarbohydrateInGrams,
    this.totalFatInGrams,
    this.saturatedFatInGrams,
    this.monounsaturatedFatInGrams,
    this.polyunsaturatedFatInGrams,
    this.cholesterolInGrams,
    this.dietaryFiberInGrams,
    this.sugarInGrams,
    // Vitamins
    this.vitaminAInGrams,
    this.vitaminB6InGrams,
    this.vitaminB12InGrams,
    this.vitaminCInGrams,
    this.vitaminDInGrams,
    this.vitaminEInGrams,
    this.vitaminKInGrams,
    this.thiaminInGrams,
    this.riboflavinInGrams,
    this.niacinInGrams,
    this.folateInGrams,
    this.biotinInGrams,
    this.pantothenicAcidInGrams,
    // Minerals
    this.calciumInGrams,
    this.ironInGrams,
    this.magnesiumInGrams,
    this.manganeseInGrams,
    this.phosphorusInGrams,
    this.potassiumInGrams,
    this.seleniumInGrams,
    this.sodiumInGrams,
    this.zincInGrams,
    // Other
    this.caffeineInGrams,
  });

  /// Platform-assigned unique identifier.
  final String? id;

  /// Start time in milliseconds since epoch (UTC).
  final int startTime;

  /// End time in milliseconds since epoch (UTC).
  final int endTime;

  /// Metadata about this record.
  final MetadataDto metadata;

  /// Timezone offset in seconds for start time (optional).
  final int? startZoneOffsetSeconds;

  /// Timezone offset in seconds for end time (optional).
  final int? endZoneOffsetSeconds;

  /// Name of the food (stored in HKMetadataKeyFoodType).
  final String? foodName;

  /// Meal type classification.
  final MealTypeDto? mealType;

  // Energy
  /// Energy value (in kilocalories).
  final double? energyKilocalories;

  // Macronutrients (all Mass)
  /// Protein amount.
  final double? proteinInGrams;

  /// Total carbohydrate amount.
  final double? totalCarbohydrateInGrams;

  /// Total fat amount.
  final double? totalFatInGrams;

  /// Saturated fat amount.
  final double? saturatedFatInGrams;

  /// Monounsaturated fat amount.
  final double? monounsaturatedFatInGrams;

  /// Polyunsaturated fat amount.
  final double? polyunsaturatedFatInGrams;

  /// Cholesterol amount.
  final double? cholesterolInGrams;

  /// Dietary fiber amount.
  final double? dietaryFiberInGrams;

  /// Sugar amount.
  final double? sugarInGrams;

  // Vitamins (all Mass)
  /// Vitamin A amount.
  final double? vitaminAInGrams;

  /// Vitamin B6 amount.
  final double? vitaminB6InGrams;

  /// Vitamin B12 amount.
  final double? vitaminB12InGrams;

  /// Vitamin C amount.
  final double? vitaminCInGrams;

  /// Vitamin D amount.
  final double? vitaminDInGrams;

  /// Vitamin E amount.
  final double? vitaminEInGrams;

  /// Vitamin K amount.
  final double? vitaminKInGrams;

  /// Thiamin amount.
  final double? thiaminInGrams;

  /// Riboflavin amount.
  final double? riboflavinInGrams;

  /// Niacin amount.
  final double? niacinInGrams;

  /// Folate amount.
  final double? folateInGrams;

  /// Biotin amount.
  final double? biotinInGrams;

  /// Pantothenic acid amount.
  final double? pantothenicAcidInGrams;

  // Minerals (all Mass)
  /// Calcium amount.
  final double? calciumInGrams;

  /// Iron amount.
  final double? ironInGrams;

  /// Magnesium amount.
  final double? magnesiumInGrams;

  /// Manganese amount.
  final double? manganeseInGrams;

  /// Phosphorus amount.
  final double? phosphorusInGrams;

  /// Potassium amount.
  final double? potassiumInGrams;

  /// Selenium amount.
  final double? seleniumInGrams;

  /// Sodium amount.
  final double? sodiumInGrams;

  final double? zincInGrams;

  // Other
  /// Caffeine amount.
  final double? caffeineInGrams;
}

/// Represents a basal energy burned record for platform transfer.
class BasalEnergyBurnedRecordDto extends HealthRecordDto {
  BasalEnergyBurnedRecordDto({
    required this.id,
    required this.metadata,
    required this.startTime,
    required this.endTime,
    required this.kilocalories,
    this.startZoneOffsetSeconds,
    this.endZoneOffsetSeconds,
  });

  /// Platform-assigned unique identifier.
  final String? id;

  /// Metadata about this record.
  final MetadataDto metadata;

  /// Start time in milliseconds since epoch (UTC).
  final int startTime;

  /// End time in milliseconds since epoch (UTC).
  final int endTime;

  /// Timezone offset in seconds for start time (optional).
  final int? startZoneOffsetSeconds;

  /// Timezone offset in seconds for end time (optional).
  final int? endZoneOffsetSeconds;

  /// Energy burned.
  final double kilocalories;
}

// region Sync DTOs

class HealthDataSyncTokenDto {
  HealthDataSyncTokenDto({
    required this.token,
    required this.dataTypes,
    required this.createdAtMillis,
  });

  final String token;
  final List<HealthDataTypeDto> dataTypes;
  final int createdAtMillis;
}

class HealthDataSyncResultDto {
  HealthDataSyncResultDto({
    required this.upsertedRecords,
    required this.deletedRecordIds,
    required this.hasMore,
    this.nextSyncToken,
  });

  final List<HealthRecordDto> upsertedRecords;
  final List<String> deletedRecordIds;
  final bool hasMore;
  final HealthDataSyncTokenDto? nextSyncToken;
}

// endregion

// endregion

// region Requests/Responses

/// Error codes that native platforms can use when throwing error.
enum HealthConnectorErrorCodeDto {
  /// Permission to access health data was not granted.
  permissionNotGranted,

  /// Required permission not declared in app configuration.
  permissionNotDeclared,

  /// Invalid parameter, malformed record, or expired change token.
  invalidArgument,

  /// Health service is not available on this device.
  healthServiceUnavailable,

  /// Health service usage is restricted by policy.
  healthServiceRestricted,

  /// Health database is protected and inaccessible.
  healthServiceDatabaseInaccessible,

  /// Operation or data type not supported on this platform.
  unsupportedOperation,

  /// An unclassified or internal system error occurred.
  unknownError,
}

/// Represents the status of the health platform on the device.
enum HealthPlatformStatusDto {
  /// The health platform is available and ready to use.
  available,

  /// The health platform is not available on this device.
  notAvailable,
}

/// Represents a permission request for accessing specific health data.
class HealthDataPermissionDto {
  HealthDataPermissionDto({
    required this.healthDataType,
    required this.accessType,
  });

  /// The type of access being requested (read or write).
  final PermissionAccessTypeDto accessType;

  /// The type of health data for which permission is requested.
  final HealthDataTypeDto healthDataType;
}

/// Represents the type of access requested for health data.
enum PermissionAccessTypeDto {
  /// Read access to health data.
  read,

  /// Write access to health data.
  write,
}

/// Represents the status of a permission.
enum PermissionStatusDto {
  /// Permission has been explicitly denied by the user.
  denied,

  /// Permission has been explicitly granted by the user.
  granted,

  /// The permission status cannot be determined.
  unknown,
}

/// Represents the result of a health data permission request.
class HealthDataPermissionRequestResultDto {
  HealthDataPermissionRequestResultDto({
    required this.permission,
    required this.status,
  });

  /// The health data permission that was requested.
  final HealthDataPermissionDto permission;

  /// The status of the permission after the request.
  final PermissionStatusDto status;
}

/// Represents a permissions request.
class PermissionsRequestDto {
  PermissionsRequestDto({
    required this.healthDataPermissions,
  });

  /// List of health data permissions to request.
  final List<HealthDataPermissionDto> healthDataPermissions;
}

/// Aggregation metric types for health data queries.
enum AggregationMetricDto {
  /// Average (mean) value across all data points.
  avg,

  /// Maximum value in the dataset.
  max,

  /// Minimum value in the dataset.
  min,

  /// Sum of all values in the time range.
  sum,
}

/// Defines the sort order for health record queries.
///
/// Combines both field (time) and direction (ascending/descending) into
/// a single enum for simplicity in the DTO layer.
enum SortOrderDto {
  /// Sort by HKSample.startTime in ascending order (oldest to newest).
  timeAscending,

  /// Sort by HKSample.startTime in descending order (newest to oldest).
  timeDescending,
}

/// Request to perform aggregation on health records.
class AggregateRequestDto {
  AggregateRequestDto({
    required this.dataType,
    required this.aggregationMetric,
    required this.startTime,
    required this.endTime,
  });

  /// The type of aggregation to perform.
  final AggregationMetricDto aggregationMetric;

  /// The type of health data to aggregate.
  final HealthDataTypeDto dataType;

  /// End of time range in milliseconds since epoch (UTC), exclusive.
  final int endTime;

  /// Start of time range in milliseconds since epoch (UTC), inclusive.
  final int startTime;
}

/// Request to delete records.
sealed class DeleteRecordsRequestDto {}

/// Request to delete specific records by their IDs.
class DeleteRecordsByIdsRequestDto extends DeleteRecordsRequestDto {
  DeleteRecordsByIdsRequestDto({
    required this.dataType,
    required this.recordIds,
  });

  /// The type of health data to delete.
  final HealthDataTypeDto dataType;

  /// List of unique identifiers for records to delete.
  final List<String> recordIds;
}

/// Request to delete records by time range.
class DeleteRecordsByTimeRangeRequestDto extends DeleteRecordsRequestDto {
  DeleteRecordsByTimeRangeRequestDto({
    required this.dataType,
    required this.startTime,
    required this.endTime,
  });

  /// The type of health data to delete.
  final HealthDataTypeDto dataType;

  /// End of time range in milliseconds since epoch (UTC), exclusive.
  final int endTime;

  /// Start of time range in milliseconds since epoch (UTC), inclusive.
  final int startTime;
}

/// Request to read a single health record by ID.
class ReadRecordRequestDto {
  ReadRecordRequestDto(this.recordId, this.dataType);

  /// The unique identifier of the record to read.
  final String recordId;

  /// The type of health data to read.
  final HealthDataTypeDto dataType;
}

/// Request to read multiple health records within a time range.
class ReadRecordsRequestDto {
  ReadRecordsRequestDto({
    required this.dataType,
    required this.pageSize,
    required this.startTime,
    required this.endTime,
    this.pageToken,
    this.dataOriginPackageNames = const [],
    this.sortOrder = SortOrderDto.timeDescending,
  });

  /// The type of health data to read.
  final HealthDataTypeDto dataType;

  /// Maximum number of records to return per page (1-10,000).
  final int pageSize;

  /// Opaque pagination token for fetching next page (optional).
  ///
  /// Provided by previous response's nextPageToken.
  final String? pageToken;

  /// Start of time range in milliseconds since epoch (UTC), inclusive.
  final int startTime;

  /// End of time range in milliseconds since epoch (UTC), exclusive.
  final int endTime;

  /// List of package names to filter by.
  final List<String> dataOriginPackageNames;

  /// Sort order for the query results.
  final SortOrderDto sortOrder;
}

/// Response containing paginated health records.
class ReadRecordsResponseDto {
  ReadRecordsResponseDto(
    this.records, {
    this.nextPageToken,
  });

  /// Token for fetching next page, null if no more pages exist.
  final String? nextPageToken;

  /// List of health records that were read.
  final List<HealthRecordDto> records;
}

// endregion

// region Log Event Streaming DTOs

/// Log level classification for Health Connector log events.
enum HealthConnectorLogLevelDto {
  /// Debug level for detailed diagnostic information.
  debug,

  /// Info level for general informational messages.
  info,

  /// Warning level for potential problems or unexpected behavior.
  warning,

  /// Error level for serious problems.
  error,
}

/// Represents exception for log events.
class HealthConnectorExceptionDto {
  HealthConnectorExceptionDto({
    required this.code,
    required this.message,
    this.cause,
  });

  /// The error code from HealthConnectorErrorCodeDto.
  final HealthConnectorErrorCodeDto code;

  /// Human-readable error message.
  final String message;

  /// Optional cause/original exception message.
  final String? cause;
}

/// Represents a structured log event from the native platform code.
class HealthConnectorLogDto {
  HealthConnectorLogDto({
    required this.level,
    required this.tag,
    required this.millisecondsSinceEpoch,
    required this.message,
    this.operation,
    this.context,
    this.exception,
    this.stackTrace,
  });

  /// The severity level of the log event.
  final HealthConnectorLogLevelDto level;

  /// The tag/category for the log entry.
  final String tag;

  /// Timestamp in milliseconds since epoch (UTC) when the log was created.
  final int millisecondsSinceEpoch;

  /// Human-readable message describing the log entry.
  final String message;

  /// The operation being performed.
  final String? operation;

  /// Optional exception information if this log contains error data.
  final HealthConnectorExceptionDto? exception;

  /// Optional stack trace as a string.
  final String? stackTrace;

  /// Optional structured context data.
  final Map<String?, Object?>? context;
}

// endregion

/// FlutterApi for receiving log events from the native platform.
///
/// This API is implemented on the Flutter side and called by the native
/// platform to deliver log events in real-time. It serves as the callback
/// handler for the event channel stream.
///
/// Platform flow:
/// - iOS: Native code calls this method for each log event emitted by
///   the Health Connector SDK operations
@FlutterApi()
abstract class HealthConnectorNativeLogApi {
  /// Called by native code when a log event occurs.
  ///
  /// This method is invoked from the native platform whenever the Health
  /// Connector SDK emits a log event during operations such as reading,
  /// writing, or synchronizing health data.
  ///
  /// Parameters:
  /// - [log]: The log event data containing level, message, timestamp,
  ///   and optional exception information
  ///
  /// Note: This method should execute quickly to avoid blocking the
  /// native platform's logging pipeline.
  void onNativeLogEvent(HealthConnectorLogDto log);
}

/// The main API for communicating with the health platform.
@HostApi()
abstract class HealthConnectorHKIOSApi {
  @async
  void initialize(HealthConnectorConfigDto config);

  @async
  double aggregate(AggregateRequestDto request);

  @async
  void deleteRecords(DeleteRecordsRequestDto request);

  @async
  HealthPlatformStatusDto getHealthPlatformStatus();

  @async
  List<HealthDataPermissionRequestResultDto> requestPermissions(
    PermissionsRequestDto request,
  );

  @async
  PermissionStatusDto getPermissionStatus(HealthDataPermissionDto permission);

  @async
  HealthRecordDto? readRecord(ReadRecordRequestDto request);

  @async
  ReadRecordsResponseDto readRecords(ReadRecordsRequestDto request);

  @async
  String writeRecord(HealthRecordDto record);

  @async
  List<String> writeRecords(List<HealthRecordDto> records);

  @async
  HealthDataSyncResultDto synchronize(
    List<HealthDataTypeDto> dataTypes,
    HealthDataSyncTokenDto? syncToken,
  );
}

/// Represents a peripheral perfusion index record.
class PeripheralPerfusionIndexRecordDto extends HealthRecordDto {
  PeripheralPerfusionIndexRecordDto({
    required this.percentage,
    required this.time,
    required this.metadata,
    this.zoneOffsetSeconds,
    this.id,
  });

  /// The peripheral perfusion index value (0.0 - 1.0).
  final double percentage;

  /// The time the sample was taken.
  final int time;

  /// Time zone offset in seconds.
  ///
  /// The offset is the difference between local time and UTC in seconds.
  /// For example, valid values include -28800 (UTC-8), 18000 (UTC+5), etc.
  final int? zoneOffsetSeconds;

  /// Platform-assigned unique identifier.
  final String? id;

  /// Metadata associated with the record.
  final MetadataDto metadata;
}
