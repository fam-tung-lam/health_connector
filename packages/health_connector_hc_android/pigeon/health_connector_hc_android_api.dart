import 'package:pigeon/pigeon.dart';

/// Pigeon API definition for Health Connector Flutter plugin.
///
/// This file defines the complete API contract between Dart and Android
/// for health data operations. Pigeon generates platform-specific
/// code from these definitions.
@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/src/pigeon/health_connector_hc_android_api.g.dart',
    dartOptions: DartOptions(),
    kotlinOut:
        'android/src/main/kotlin/com/phamtunglam/health_connector_hc_android/pigeon/HealthConnectorHCAndroidApi.g.kt',
    kotlinOptions: KotlinOptions(
      package: 'com.phamtunglam.health_connector_hc_android.pigeon',
      errorClassName: 'HealthConnectorErrorDto',
    ),
    copyrightHeader: 'pigeon/copyright_header.txt',
    dartPackageName: 'health_connector_hc_android',
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
    this.lastModifiedTime,
    this.clientRecordId,
    this.clientRecordVersion,
    this.deviceManufacturer,
    this.deviceModel,
  });

  /// A custom identifier assigned by your application.
  ///
  /// Use this for client-side record tracking, deduplication, or correlation.
  final String? clientRecordId;

  /// A version number assigned by your application.
  ///
  /// Use this to implement your own versioning or tracking logic.
  final int? clientRecordVersion;

  /// The package name of the source app that wrote this health record.
  final String dataOrigin;

  /// The type of device that recorded the data.
  final DeviceTypeDto deviceType;

  /// The method used to record this data.
  final RecordingMethodDto recordingMethod;

  /// The manufacturer of the device that recorded the data (optional).
  final String? deviceManufacturer;

  /// The model of the device that recorded the data (optional).
  final String? deviceModel;

  /// The timestamp when this record was last modified on the platform.
  ///
  /// Unix timestamp in milliseconds since epoch (UTC).
  /// Automatically maintained by Health Connect.
  final int? lastModifiedTime;
}

// endregion

// region Health Records

/// Cervical mucus appearance classification.
///
/// Maps to Android Health Connect CervicalMucusRecord appearance types
/// and iOS HealthKit HKCategoryValueCervicalMucusQuality enum.
enum CervicalMucusAppearanceDto {
  /// Unknown appearance.
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

  /// Unusual appearance.
  unusual,
}

/// Cervical mucus sensation classification.
///
/// Maps to Android Health Connect CervicalMucusRecord sensation types.
/// Note: Not natively supported on iOS HealthKit.
enum CervicalMucusSensationDto {
  /// Unknown sensation.
  unknown,

  /// Light sensation.
  light,

  /// Medium sensation.
  medium,

  /// Heavy sensation.
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
/// Maps to Android Health Connect MenstruationFlowRecord.FLOW_* constants.
enum MenstrualFlowDto {
  /// Flow is unknown or unspecified.
  unknown,

  /// Light menstrual flow.
  light,

  /// Medium menstrual flow.
  medium,

  /// Heavy menstrual flow.
  heavy,
}

/// Measurement method for VO2 max calculation (Android Health Connect).
///
/// Maps to Health Connect Vo2MaxMeasurementMethod constants.
enum Vo2MaxMeasurementMethodDto {
  /// Other or unknown measurement method (0).
  other,

  /// Direct measurement using metabolic cart gas exchange analysis (1).
  metabolicCart,

  /// Calculated using heart rate ratio (maxHR / restingHR) (2).
  heartRateRatio,

  /// Based on the Cooper 12-minute run test (3).
  cooperTest,

  /// Based on the multistage fitness test (beep test) (4).
  multistageFitnessTest,

  /// Based on the Rockport 1-mile walk test (5).
  rockportFitnessTest,
}

/// Meal type classification for nutrition records.
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

/// Activity intensity type classification.
///
/// Maps to Android Health Connect ActivityIntensityRecord intensity types.
enum ActivityIntensityTypeDto {
  /// Moderate intensity activity.
  moderate,

  /// Vigorous intensity activity.
  vigorous,
}

/// Exercise type classification for exercise sessions.
///
/// Maps to Android Health Connect ExerciseSessionRecord exercise types
/// and iOS HealthKit HKWorkoutActivityType.
/// Some types are iOS-only and will be rejected on Android Health Connect.
enum ExerciseTypeDto {
  /// Other or unclassified exercise type.
  other,

  /// Cardio & Walking/Running
  running,
  runningTreadmill,
  walking,
  cycling,
  cyclingStationary,
  hiking,

  /// Water Sports
  swimmingOpenWater,
  swimmingPool,
  surfing,
  waterPolo,
  rowing,
  sailing,
  paddling,
  diving,

  /// Strength Training
  strengthTraining,
  weightlifting,
  calisthenics,

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
  iceHockey,
  rollerHockey,
  hockey,

  /// Racquet Sports
  tennis,
  tableTennis,
  badminton,
  squash,
  racquetball,

  /// Winter Sports
  skiing,
  snowboarding,
  snowshoeing,
  skating,

  /// Martial Arts & Combat Sports
  boxing,
  kickboxing,
  martialArts,
  wrestling,
  fencing,

  /// Dance & Gymnastics
  dancing,
  gymnastics,

  /// Fitness & Conditioning
  yoga,
  pilates,
  highIntensityIntervalTraining,
  elliptical,
  exerciseClass,
  bootCamp,
  guidedBreathing,
  stairClimbing,
  flexibility,

  /// Golf & Precision Sports
  golf,

  /// Outdoor & Adventure
  paragliding,
  climbing,

  /// Wheelchair Activities
  wheelchair,
}

/// Mindfulness session type classification.
///
/// Maps to Android Health Connect MindfulnessSessionRecord session type
/// constants.
///
/// Note: iOS HealthKit only supports a single generic mindfulness category
/// type. Session types are stored in custom metadata when writing to HealthKit.
enum MindfulnessSessionTypeDto {
  /// Unknown or unspecified session type (0).
  unknown,

  /// Meditation session (1).
  meditation,

  /// Breathing exercise session (2).
  breathing,

  /// Music-based mindfulness session (3).
  music,

  /// Movement-based mindfulness session (4).
  movement,

  /// Unguided mindfulness session (5).
  unguided,
}

/// Sealed class for all health record DTOs.
sealed class HealthRecordDto {}

/// Represents a health data type.
enum HealthDataTypeDto {
  /// Active energy burned data.
  activeCaloriesBurned,

  /// Activity intensity data.
  activityIntensity,

  /// Distance traveled data.
  distance,

  /// Elevation gained data.
  elevationGained,

  /// Floors climbed data.
  floorsClimbed,

  /// Exercise session data.
  exerciseSession,

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

  /// Heart rate series record data.
  heartRateSeriesRecord,

  /// Cycling pedaling cadence series record data.
  cyclingPedalingCadenceSeriesRecord,

  /// Sexual activity data.
  sexualActivity,

  /// Sleep session data.
  sleepSession,

  /// Combined nutrition record with all nutrients.
  nutrition,

  /// Resting heart rate data.
  restingHeartRate,

  /// Composite blood pressure data (systolic + diastolic).
  bloodPressure,

  /// Ovulation test data.
  ovulationTest,

  /// Intermenstrual bleeding data.
  intermenstrualBleeding,

  /// Menstrual flow instant data (Android Health Connect).
  menstrualFlowInstant,

  /// Oxygen saturation data.
  oxygenSaturation,

  /// Power data.
  powerSeries,

  /// Respiratory rate data.
  respiratoryRate,

  /// VO2 max (maximal oxygen uptake) data.
  vo2Max,

  /// Blood glucose data.
  bloodGlucose,

  /// Speed data.
  speedSeries,

  /// Mindfulness session data.
  mindfulnessSession,

  /// Total energy burned data.
  totalCaloriesBurned,

  /// Bone mass data.
  boneMass,

  /// Heart rate variability (RMSSD) data.
  heartRateVariabilityRMSSD,

  /// Body water mass data.
  bodyWaterMass,

  /// Steps cadence series record data.
  stepsCadenceSeriesRecord,
}

/// Represents a blood glucose record for platform transfer.
class BloodGlucoseRecordDto extends HealthRecordDto {
  BloodGlucoseRecordDto({
    required this.id,
    required this.time,
    required this.metadata,
    required this.millimolesPerLiter,
    this.relationToMeal,
    this.specimenSource,
    this.mealType,
    this.zoneOffsetSeconds,
  });

  /// Platform-assigned unique identifier.
  final String? id;

  /// Measurement time in milliseconds since epoch (UTC).
  final int time;

  /// Metadata about this record.
  final MetadataDto metadata;

  /// The blood glucose level.
  final double millimolesPerLiter;

  /// The relationship to a meal (optional).
  final BloodGlucoseRelationToMealDto? relationToMeal;

  /// The source of the specimen (optional).
  final BloodGlucoseSpecimenSourceDto? specimenSource;

  /// The type of meal (optional).
  final MealTypeDto? mealType;

  /// Timezone offset in seconds for measurement time (optional).
  final int? zoneOffsetSeconds;
}

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

  /// The oxygen saturation percentage.
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

/// Represents a menstrual flow instant record for platform transfer (Android).
///
/// This DTO is used for Android Health Connect's MenstruationFlowRecord,
/// which tracks flow intensity at a single point in time.
class MenstrualFlowInstantRecordDto extends HealthRecordDto {
  MenstrualFlowInstantRecordDto({
    required this.id,
    required this.metadata,
    required this.time,
    required this.flow,
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

  /// The menstrual flow intensity.
  final MenstrualFlowDto flow;
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
    this.measurementMethod,
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

  /// The method used to measure or estimate VO2 max.
  ///
  /// Maps to Health Connect's Vo2MaxMeasurementMethod.
  final Vo2MaxMeasurementMethodDto? measurementMethod;

  /// Timezone offset in seconds for measurement time (optional).
  final int? zoneOffsetSeconds;
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

  /// Timezone offset in seconds for end time (optional).
  final int? endZoneOffsetSeconds;

  /// Timezone offset in seconds for start time (optional).
  final int? startZoneOffsetSeconds;
}

/// Represents a distance record for platform transfer.
class DistanceRecordDto extends HealthRecordDto {
  DistanceRecordDto({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.metadata,
    required this.meters,
    this.startZoneOffsetSeconds,
    this.endZoneOffsetSeconds,
  });

  /// Distance traveled during the interval.
  final double meters;

  /// End time in milliseconds since epoch (UTC).
  final int endTime;

  /// Platform-assigned unique identifier.
  final String? id;

  /// Metadata about this record.
  final MetadataDto metadata;

  /// Start time in milliseconds since epoch (UTC).
  final int startTime;

  /// Timezone offset in seconds for end time (optional).
  final int? endZoneOffsetSeconds;

  /// Timezone offset in seconds for start time (optional).
  final int? startZoneOffsetSeconds;
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

  /// Timezone offset in seconds for end time (optional).
  final int? endZoneOffsetSeconds;

  /// Timezone offset in seconds for start time (optional).
  final int? startZoneOffsetSeconds;
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

  /// Timezone offset in seconds for end time (optional).
  final int? endZoneOffsetSeconds;

  /// Timezone offset in seconds for start time (optional).
  final int? startZoneOffsetSeconds;
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

  /// Timezone offset in seconds for end time (optional).
  final int? endZoneOffsetSeconds;

  /// Timezone offset in seconds for start time (optional).
  final int? startZoneOffsetSeconds;
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

  /// Body position during measurement.
  final BodyPositionDto bodyPosition;

  /// Location where measurement was taken.
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

  /// Cervical mucus appearance (optional).
  final CervicalMucusAppearanceDto appearance;

  /// Cervical mucus sensation (optional).
  final CervicalMucusSensationDto sensation;
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
class HeartRateSampleDto {
  HeartRateSampleDto({
    required this.time,
    required this.beatsPerMinute,
  });

  /// Timestamp in milliseconds since epoch (UTC).
  final int time;

  /// Heart rate value in beats per minute (BPM).
  final double beatsPerMinute;
}

/// Represents a heart rate series record for platform transfer.
class HeartRateSeriesRecordDto extends HealthRecordDto {
  HeartRateSeriesRecordDto({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.metadata,
    required this.samples,
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

  /// List of heart rate measurements within this time interval.
  final List<HeartRateSampleDto> samples;

  /// Timezone offset in seconds for start time (optional).
  final int? startZoneOffsetSeconds;

  /// Timezone offset in seconds for end time (optional).
  final int? endZoneOffsetSeconds;
}

/// Represents a single cycling pedaling cadence measurement.
///
/// This is a platform-agnostic value class used within cycling pedaling
/// cadence records.
/// It contains a timestamp and RPM value without ID or metadata.
class CyclingPedalingCadenceSampleDto {
  CyclingPedalingCadenceSampleDto({
    required this.time,
    required this.revolutionsPerMinute,
  });

  /// Timestamp in milliseconds since epoch (UTC).
  final int time;

  /// Cycling cadence value in revolutions per minute (RPM).
  final double revolutionsPerMinute;
}

/// Represents a cycling pedaling cadence series record.
class CyclingPedalingCadenceSeriesRecordDto extends HealthRecordDto {
  CyclingPedalingCadenceSeriesRecordDto({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.metadata,
    required this.samples,
    this.startZoneOffsetSeconds,
    this.endZoneOffsetSeconds,
  });

  /// Platform-assigned unique identifier. Null if not yet synced.
  final String? id;

  /// Start time in milliseconds since epoch (UTC).
  final int startTime;

  /// End time in milliseconds since epoch (UTC).
  final int endTime;

  /// Start timezone offset in seconds. Null if unknown.
  final int? startZoneOffsetSeconds;

  /// End timezone offset in seconds. Null if unknown.
  final int? endZoneOffsetSeconds;

  /// Metadata for this record.
  final MetadataDto metadata;

  /// List of cadence measurements.
  final List<CyclingPedalingCadenceSampleDto> samples;
}

/// Represents a single steps cadence measurement.
class StepsCadenceSampleDto {
  StepsCadenceSampleDto({
    required this.time,
    required this.stepsPerMinute,
  });

  /// Timestamp in milliseconds since epoch (UTC).
  final int time;

  /// Steps cadence measurement in steps per minute.
  final double stepsPerMinute;
}

/// Represents a steps cadence series record.
class StepsCadenceSeriesRecordDto extends HealthRecordDto {
  StepsCadenceSeriesRecordDto({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.metadata,
    required this.samples,
    this.startZoneOffsetSeconds,
    this.endZoneOffsetSeconds,
  });

  /// Platform-assigned unique identifier. Null if not yet synced.
  final String? id;

  /// Start time in milliseconds since epoch (UTC).
  final int startTime;

  /// End time in milliseconds since epoch (UTC).
  final int endTime;

  /// Start timezone offset in seconds. Null if unknown.
  final int? startZoneOffsetSeconds;

  /// End timezone offset in seconds. Null if unknown.
  final int? endZoneOffsetSeconds;

  /// Metadata for this record.
  final MetadataDto metadata;

  /// List of cadence measurements.
  final List<StepsCadenceSampleDto?> samples;
}

/// Represents an elevation gained record for platform transfer (Android Only).
class ElevationGainedRecordDto extends HealthRecordDto {
  ElevationGainedRecordDto({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.metadata,
    required this.meters,
    this.startZoneOffsetSeconds,
    this.endZoneOffsetSeconds,
  });

  /// Elevation gained in meters.
  final double meters;

  /// End time in milliseconds since epoch (UTC).
  final int endTime;

  /// Platform-assigned unique identifier.
  final String? id;

  /// Metadata about this record.
  final MetadataDto metadata;

  /// Start time in milliseconds since epoch (UTC).
  final int startTime;

  /// Start timezone offset in seconds. Null if unknown.
  final int? startZoneOffsetSeconds;

  /// End timezone offset in seconds. Null if unknown.
  final int? endZoneOffsetSeconds;
}

/// Represents a single speed measurement within a [SpeedSeriesRecordDto].
class SpeedSampleDto {
  SpeedSampleDto({
    required this.time,
    required this.metersPerSecond,
  });

  /// Timestamp in milliseconds since epoch (UTC).
  final int time;

  /// Speed measurement.
  final double metersPerSecond;
}

/// Represents a speed series record for platform transfer.
class SpeedSeriesRecordDto extends HealthRecordDto {
  SpeedSeriesRecordDto({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.metadata,
    required this.samples,
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

  /// List of speed measurements within this time interval.
  final List<SpeedSampleDto> samples;

  /// Timezone offset in seconds for start time (optional).
  final int? startZoneOffsetSeconds;

  /// Timezone offset in seconds for end time (optional).
  final int? endZoneOffsetSeconds;
}

/// Represents a single power measurement within a [PowerSeriesRecordDto].
class PowerSampleDto {
  PowerSampleDto({
    required this.time,
    required this.watts,
  });

  /// Timestamp in milliseconds since epoch (UTC).
  final int time;

  /// Power measurement.
  final double watts;
}

/// Represents a power series record for platform transfer.
class PowerSeriesRecordDto extends HealthRecordDto {
  PowerSeriesRecordDto({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.metadata,
    required this.samples,
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

  /// List of power measurements within this time interval.
  final List<PowerSampleDto> samples;

  /// Timezone offset in seconds for start time (optional).
  final int? startZoneOffsetSeconds;

  /// Timezone offset in seconds for end time (optional).
  final int? endZoneOffsetSeconds;
}

/// Sleep stage type enum.
enum SleepStageDto {
  unknown,
  awake,
  sleeping,
  outOfBed,
  light,
  deep,
  rem,
  inBed,
}

/// DTO for a sleep stage value.
class SleepStageSampleDto {
  SleepStageSampleDto({
    required this.startTime,
    required this.endTime,
    required this.stage,
  });

  /// Start time (milliseconds since epoch).
  final int startTime;

  /// End time (milliseconds since epoch).
  final int endTime;

  /// The sleep stage type.
  final SleepStageDto stage;
}

/// DTO for sleep session.
class SleepSessionRecordDto extends HealthRecordDto {
  SleepSessionRecordDto({
    required this.id,
    required this.metadata,
    required this.startTime,
    required this.endTime,
    required this.stages,
    this.startZoneOffsetSeconds,
    this.endZoneOffsetSeconds,
    this.title,
    this.notes,
  });

  /// Platform-assigned unique identifier.
  final String? id;
  final MetadataDto metadata;
  final int startTime;
  final int endTime;
  final int? startZoneOffsetSeconds;
  final int? endZoneOffsetSeconds;
  final String? title;
  final String? notes;
  final List<SleepStageSampleDto> stages;
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

  /// Measurement time in milliseconds since epoch (UTC).
  final int time;

  /// Timezone offset in seconds for measurement time (optional).
  final int? zoneOffsetSeconds;

  /// Whether protection was used (optional).
  final SexualActivityProtectionUsedDto protectionUsed;
}

/// Represents an exercise session record for platform transfer.
class ExerciseSessionRecordDto extends HealthRecordDto {
  ExerciseSessionRecordDto({
    required this.id,
    required this.metadata,
    required this.startTime,
    required this.endTime,
    required this.exerciseType,
    this.startZoneOffsetSeconds,
    this.endZoneOffsetSeconds,
    this.title,
    this.notes,
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

  /// Type of exercise performed.
  final ExerciseTypeDto exerciseType;

  /// Optional title for the exercise session.
  final String? title;

  /// Optional notes about the exercise session.
  final String? notes;
}

/// Represents an activity intensity record for platform transfer.
///
/// Maps to Android Health Connect ActivityIntensityRecord.
class ActivityIntensityRecordDto extends HealthRecordDto {
  ActivityIntensityRecordDto({
    required this.id,
    required this.metadata,
    required this.startTime,
    required this.endTime,
    required this.activityIntensityType,
    this.startZoneOffsetSeconds,
    this.endZoneOffsetSeconds,
    this.title,
    this.notes,
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

  /// The intensity type of the activity.
  final ActivityIntensityTypeDto activityIntensityType;

  /// Optional title for the activity period.
  final String? title;

  /// Optional notes about the activity period.
  final String? notes;
}

/// Represents a mindfulness session record for platform transfer.
///
/// Note: iOS HealthKit only supports generic mindfulness category. The session
/// type is stored in custom metadata when writing to HealthKit.
class MindfulnessSessionRecordDto extends HealthRecordDto {
  MindfulnessSessionRecordDto({
    required this.id,
    required this.metadata,
    required this.startTime,
    required this.endTime,
    required this.sessionType,
    this.startZoneOffsetSeconds,
    this.endZoneOffsetSeconds,
    this.title,
    this.notes,
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

  /// Type of mindfulness session.
  final MindfulnessSessionTypeDto sessionType;

  /// Optional title for the mindfulness session.
  final String? title;

  /// Optional notes about the mindfulness session.
  final String? notes;
}

/// Represents unified nutrition record.
///
/// Unified DTO that combines all:
/// - Individual nutrient DTOs
/// - And the combined nutrition record.
///
/// Uses `healthDataType` to indicate which nutrient field(s) are populated.
class NutritionRecordDto extends HealthRecordDto {
  NutritionRecordDto({
    required this.id,
    required this.metadata,
    required this.startTime,
    required this.endTime,
    required this.healthDataType,
    required this.mealType,
    this.startZoneOffsetSeconds,
    this.endZoneOffsetSeconds,
    this.foodName,
    this.energyInKilocalories,
    this.proteinInGrams,
    this.totalCarbohydrateInGrams,
    this.totalFatInGrams,
    this.saturatedFatInGrams,
    this.monounsaturatedFatInGrams,
    this.polyunsaturatedFatInGrams,
    this.cholesterolInGrams,
    this.dietaryFiberInGrams,
    this.sugarInGrams,
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
    this.calciumInGrams,
    this.ironInGrams,
    this.magnesiumInGrams,
    this.manganeseInGrams,
    this.phosphorusInGrams,
    this.potassiumInGrams,
    this.seleniumInGrams,
    this.sodiumInGrams,
    this.zincInGrams,
    this.caffeineInGrams,
  });

  /// Platform-assigned unique identifier.
  final String? id;

  /// Metadata about this record.
  final MetadataDto metadata;

  /// Start time in milliseconds since epoch (UTC).
  final int startTime;

  /// End time in milliseconds since epoch (UTC).
  final int endTime;

  /// Health data type indicating which nutrient field(s) are populated.
  /// - For individual nutrients: use specific nutrient type
  /// - For combined nutrition: use `nutrition`
  final HealthDataTypeDto healthDataType;

  /// Timezone offset in seconds for start time (optional).
  final int? startZoneOffsetSeconds;

  /// Timezone offset in seconds for end time (optional).
  final int? endZoneOffsetSeconds;

  /// Name of the food (optional).
  final String? foodName;

  /// Meal type classification.
  final MealTypeDto mealType;

  // All nutrient fields (all optional)

  /// Energy nutrient (kilocalories).
  final double? energyInKilocalories;

  /// Protein nutrient (grams).
  final double? proteinInGrams;

  /// Total carbohydrate nutrient (grams).
  final double? totalCarbohydrateInGrams;

  /// Total fat nutrient (grams).
  final double? totalFatInGrams;

  /// Saturated fat nutrient (grams).
  final double? saturatedFatInGrams;

  /// Monounsaturated fat nutrient (grams).
  final double? monounsaturatedFatInGrams;

  /// Polyunsaturated fat nutrient (grams).
  final double? polyunsaturatedFatInGrams;

  /// Cholesterol nutrient (grams).
  final double? cholesterolInGrams;

  /// Dietary fiber nutrient (grams).
  final double? dietaryFiberInGrams;

  /// Sugar nutrient (grams).
  final double? sugarInGrams;

  /// Vitamin A nutrient (grams).
  final double? vitaminAInGrams;

  /// Vitamin B6 nutrient (grams).
  final double? vitaminB6InGrams;

  /// Vitamin B12 nutrient (grams).
  final double? vitaminB12InGrams;

  /// Vitamin C nutrient (grams).
  final double? vitaminCInGrams;

  /// Vitamin D nutrient (grams).
  final double? vitaminDInGrams;

  /// Vitamin E nutrient (grams).
  final double? vitaminEInGrams;

  /// Vitamin K nutrient (grams).
  final double? vitaminKInGrams;

  /// Thiamin (vitamin B1) nutrient (grams).
  final double? thiaminInGrams;

  /// Riboflavin (vitamin B2) nutrient (grams).
  final double? riboflavinInGrams;

  /// Niacin (vitamin B3) nutrient (grams).
  final double? niacinInGrams;

  /// Folate (vitamin B9) nutrient (grams).
  final double? folateInGrams;

  /// Biotin (vitamin B7) nutrient (grams).
  final double? biotinInGrams;

  /// Pantothenic acid (vitamin B5) nutrient (grams).
  final double? pantothenicAcidInGrams;

  /// Calcium nutrient (grams).
  final double? calciumInGrams;

  /// Iron nutrient (grams).
  final double? ironInGrams;

  /// Magnesium nutrient (grams).
  final double? magnesiumInGrams;

  /// Manganese nutrient (grams).
  final double? manganeseInGrams;

  /// Phosphorus nutrient (grams).
  final double? phosphorusInGrams;

  /// Potassium nutrient (grams).
  final double? potassiumInGrams;

  /// Selenium nutrient (grams).
  final double? seleniumInGrams;

  /// Sodium nutrient (grams).
  final double? sodiumInGrams;

  /// Zinc nutrient (grams).
  final double? zincInGrams;

  /// Caffeine nutrient (grams).
  final double? caffeineInGrams;
}

/// Represents a total energy burned record for platform transfer.
class TotalEnergyBurnedRecordDto extends HealthRecordDto {
  TotalEnergyBurnedRecordDto({
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

/// Represents a bone mass record for platform transfer.
class BoneMassRecordDto extends HealthRecordDto {
  BoneMassRecordDto({
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

  /// Bone mass measurement.
  final double kilograms;

  /// Timezone offset in seconds for measurement time (optional).
  final int? zoneOffsetSeconds;
}

/// Represents a heart rate variability (RMSSD) record for platform transfer.
class HeartRateVariabilityRMSSDRecordDto extends HealthRecordDto {
  HeartRateVariabilityRMSSDRecordDto({
    required this.id,
    required this.time,
    required this.metadata,
    required this.heartRateVariabilityMillis,
    this.zoneOffsetSeconds,
  });

  /// Platform-assigned unique identifier.
  final String? id;

  /// Metadata about this record.
  final MetadataDto metadata;

  /// Measurement time in milliseconds since epoch (UTC).
  final int time;

  /// Heart rate variability in milliseconds.
  final double heartRateVariabilityMillis;

  /// Timezone offset in seconds for measurement time (optional).
  final int? zoneOffsetSeconds;
}

/// Represents a body water mass record for platform transfer.
class BodyWaterMassRecordDto extends HealthRecordDto {
  BodyWaterMassRecordDto({
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

  /// Body water mass measurement.
  final double kilograms;

  /// Timezone offset in seconds for measurement time (optional).
  final int? zoneOffsetSeconds;
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

  /// Health Connect app not installed or update required (Android only).
  healthServiceNotInstalledOrUpdateRequired,

  /// Storage read/write operation failed.
  ioError,

  /// IPC communication with health service failed.
  remoteError,

  /// API rate limit has been exhausted.
  rateLimitExceeded,

  /// Health service is syncing data, operations blocked.
  dataSyncInProgress,

  /// Operation or data type not supported on this platform.
  unsupportedOperation,

  /// An unclassified or internal system error occurred.
  unknownError,
}

/// Represents the status of the health platform on the device.
enum HealthPlatformStatusDto {
  /// The health platform is available and ready to use.
  available,

  /// The health platform is not installed or not supported.
  ///
  /// Note: Health Connect only.
  installationOrUpdateRequired,

  /// The health platform is not available on this device.
  notAvailable,
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

/// Represents a health platform feature.
enum HealthPlatformFeatureDto {
  /// Read health data in the background.
  readHealthDataInBackground,

  /// Read historical health data from the past.
  readHealthDataHistory,
}

/// Represents the availability status of a feature.
enum HealthPlatformFeatureStatusDto {
  /// The feature is available on this platform.
  available,

  /// The feature is not available on this platform.
  unavailable,
}

/// Represents a permission request.
sealed class PermissionRequestDto {}

/// Represents the result of a permission request.
sealed class PermissionRequestResultDto {}

/// Represents the result of a feature permission request.
class HealthPlatformFeaturePermissionRequestResultDto
    extends PermissionRequestResultDto {
  HealthPlatformFeaturePermissionRequestResultDto({
    required this.feature,
    required this.status,
  });

  /// The feature for which permission was requested.
  final HealthPlatformFeatureDto feature;

  /// The status of the permission after the request.
  final PermissionStatusDto status;
}

/// Represents a permission request for accessing specific health data.
class HealthDataPermissionRequestDto extends PermissionRequestDto {
  HealthDataPermissionRequestDto({
    required this.healthDataType,
    required this.accessType,
  });

  /// The type of access being requested (read or write).
  final PermissionAccessTypeDto accessType;

  /// The type of health data for which permission is requested.
  final HealthDataTypeDto healthDataType;
}

/// Represents the result of a health data permission request.
class HealthDataPermissionRequestResultDto extends PermissionRequestResultDto {
  HealthDataPermissionRequestResultDto({
    required this.permission,
    required this.status,
  });

  /// The health data permission that was requested.
  final HealthDataPermissionRequestDto permission;

  /// The status of the permission after the request.
  final PermissionStatusDto status;
}

class HealthPlatformFeaturePermissionRequest extends PermissionRequestDto {
  HealthPlatformFeaturePermissionRequest(this.feature);

  /// Feature for which to request permission.
  final HealthPlatformFeatureDto feature;
}

/// Represents a permission requests.
class PermissionRequestsDto {
  PermissionRequestsDto(this.permissionRequests);

  /// List of permission requests.
  final List<PermissionRequestDto> permissionRequests;
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
  /// Sort by time in ascending order (oldest to newest).
  ///
  /// For instant records: sorts by time field.
  /// For interval records: sorts by startTime field.
  timeAscending,

  /// Sort by time in descending order (newest to oldest).
  ///
  /// For instant records: sorts by time field.
  /// For interval records: sorts by startTime field.
  timeDescending,
}

/// Sealed class for all aggregation request DTOs.
sealed class AggregateRequestDto {}

/// Request to perform aggregation on common health records.
class CommonAggregateRequestDto extends AggregateRequestDto {
  CommonAggregateRequestDto({
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

enum BloodPressureDataTypeDto {
  diastolic,
  systolic,
}

/// Request to perform aggregation on blood pressure health record.
class BloodPressureAggregateRequestDto extends AggregateRequestDto {
  BloodPressureAggregateRequestDto({
    required this.bloodPressureDataType,
    required this.aggregationMetric,
    required this.startTime,
    required this.endTime,
  });

  /// The type of aggregation to perform.
  final AggregationMetricDto aggregationMetric;

  /// The type of blood pressure to aggregate.
  final BloodPressureDataTypeDto bloodPressureDataType;

  /// End of time range in milliseconds since epoch (UTC), exclusive.
  final int endTime;

  /// Start of time range in milliseconds since epoch (UTC), inclusive.
  final int startTime;
}

/// Request to perform aggregation on activity intensity health record.
class ActivityIntensityAggregateRequestDto extends AggregateRequestDto {
  ActivityIntensityAggregateRequestDto({
    required this.startTime,
    required this.endTime,
    this.dataType = HealthDataTypeDto.activityIntensity,
    this.intensityType,
  });

  /// The type of health data to aggregate.
  ///
  /// Must be always [HealthDataTypeDto.activityIntensity].
  final HealthDataTypeDto dataType;

  /// The intensity type to aggregate (nullable).
  ///
  /// - `null`: DURATION_TOTAL (total minutes in any activity)
  /// - `moderate`: MODERATE_DURATION_TOTAL
  /// - `vigorous`: VIGOROUS_DURATION_TOTAL
  final ActivityIntensityTypeDto? intensityType;

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
    required this.startTime,
    required this.endTime,
    required this.pageSize,
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

  /// Optional operation being performed.
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

@HostApi()
abstract class HealthConnectorHCAndroidApi {
  /// Initializes the Health Connector client with the provided configuration.
  ///
  /// This method must be called before any other Health Connector operations
  /// to properly configure the native platform code, including logger settings.
  @async
  void initialize(HealthConnectorConfigDto config);

  @async
  void launchHealthConnectPageInGooglePlay();

  @async
  double aggregate(AggregateRequestDto request);

  @async
  void deleteRecords(DeleteRecordsRequestDto request);

  @async
  HealthPlatformFeatureStatusDto getFeatureStatus(
    HealthPlatformFeatureDto feature,
  );

  @async
  HealthPlatformStatusDto getHealthPlatformStatus();

  @async
  List<PermissionRequestResultDto> requestPermissions(
    PermissionRequestsDto request,
  );

  @async
  List<PermissionRequestResultDto> getGrantedPermissions();

  @async
  void revokeAllPermissions();

  @async
  PermissionStatusDto getPermissionStatus(PermissionRequestDto permission);

  @async
  HealthRecordDto? readRecord(ReadRecordRequestDto request);

  @async
  ReadRecordsResponseDto readRecords(ReadRecordsRequestDto request);

  @async
  String writeRecord(HealthRecordDto record);

  @async
  List<String> writeRecords(List<HealthRecordDto> records);

  @async
  void updateRecord(HealthRecordDto record);

  @async
  void updateRecords(List<HealthRecordDto> records);

  @async
  HealthDataSyncResultDto synchronize(
    List<HealthDataTypeDto> dataTypes,
    HealthDataSyncTokenDto? syncToken,
  );
}
