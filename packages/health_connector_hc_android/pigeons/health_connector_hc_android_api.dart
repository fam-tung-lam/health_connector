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
    copyrightHeader: 'pigeons/copyright_header.txt',
  ),
)
/// Error codes that native platforms can use when throwing error.
enum HealthConnectorErrorCodeDto {
  /// Health Connect installation or update is required.
  healthPlatformNotInstalledOrUpdateRequired,

  /// Health platform is unavailable on this device.
  healthPlatformUnavailable,

  /// Invalid platform configuration detected.
  invalidConfiguration,

  /// Invalid argument or input validation error.
  invalidArgument,

  /// Attempted to use platform APIs or features that are not supported
  /// on the current health platform.
  unsupportedOperation,

  /// Unknown or unspecified error.
  unknown,

  /// Security/permission error occurred.
  notAuthorized,

  /// A transient I/O or communication error occurred.
  remoteError,
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

// region Measurement Unit
/// Sealed class for all measurement unit DTOs.
sealed class MeasurementUnitDto {}

/// Blood glucose unit types supported by the plugin.
enum BloodGlucoseUnitDto { milligramsPerDeciliter, millimolesPerLiter }

/// Energy unit types supported by the plugin.
enum EnergyUnitDto { calories, joules, kilocalories, kilojoules }

/// Duration unit types supported by the plugin.
enum TimeDurationUnitDto { seconds, minutes, hours }

/// Length unit types supported by the plugin.
enum LengthUnitDto { feet, inches, kilometers, meters, miles }

/// Mass unit types supported by the plugin.
enum MassUnitDto { grams, kilograms, ounces, pounds }

/// Percentage unit types supported by the plugin.
enum PercentageUnitDto {
  /// Percentage as a decimal value (0.0 to 1.0).
  decimal,

  /// Percentage as a whole number (0 to 100).
  whole,
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

/// Pressure unit types supported by the plugin.
enum PressureUnitDto { millimetersOfMercury }

/// Power unit types supported by the plugin.
enum PowerUnitDto { kilowatts, watts }

/// Temperature unit types supported by the plugin.
enum TemperatureUnitDto { celsius, fahrenheit, kelvin }

/// Velocity unit types supported by the plugin.
enum VelocityUnitDto { kilometersPerHour, metersPerSecond, milesPerHour }

/// Volume unit types supported by the plugin.
enum VolumeUnitDto { fluidOuncesUs, liters, milliliters }

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

/// Represents a blood glucose measurement for platform transfer.
class BloodGlucoseDto extends MeasurementUnitDto {
  BloodGlucoseDto({required this.value, required this.unit});

  /// The unit in which the value is expressed.
  final BloodGlucoseUnitDto unit;

  /// The numeric value of the blood glucose.
  final double value;
}

/// Represents an energy measurement for platform transfer.
class EnergyDto extends MeasurementUnitDto {
  EnergyDto({required this.value, required this.unit});

  /// The unit in which the value is expressed.
  final EnergyUnitDto unit;

  /// The numeric value of the energy.
  final double value;
}

/// Represents an interval (time duration) measurement for platform transfer.
class TimeDurationDto extends MeasurementUnitDto {
  TimeDurationDto({required this.value, required this.unit});

  /// The unit in which the value is expressed.
  final TimeDurationUnitDto unit;

  /// The numeric value of the interval.
  final double value;
}

/// Represents a length measurement for platform transfer.
class LengthDto extends MeasurementUnitDto {
  LengthDto({required this.value, required this.unit});

  /// The unit in which the value is expressed.
  final LengthUnitDto unit;

  /// The numeric value of the length.
  final double value;
}

/// Represents a mass measurement for platform transfer.
class MassDto extends MeasurementUnitDto {
  MassDto({required this.value, required this.unit});

  /// The unit in which the value is expressed.
  final MassUnitDto unit;

  /// The numeric value of the mass.
  final double value;
}

/// Represents a number for platform transfer.
class NumberDto extends MeasurementUnitDto {
  NumberDto(this.value);

  /// The count value.
  final double value;
}

/// Represents a percentage measurement for platform transfer.
class PercentageDto extends MeasurementUnitDto {
  PercentageDto({required this.value, required this.unit});

  /// The unit in which the value is expressed.
  final PercentageUnitDto unit;

  /// The numeric value of the percentage.
  final double value;
}

/// Represents a power measurement for platform transfer.
class PowerDto extends MeasurementUnitDto {
  PowerDto({required this.value, required this.unit});

  /// The unit in which the value is expressed.
  final PowerUnitDto unit;

  /// The numeric value of the power.
  final double value;
}

/// Represents a pressure measurement for platform transfer.
class PressureDto extends MeasurementUnitDto {
  PressureDto({required this.value, required this.unit});

  /// The unit in which the value is expressed.
  final PressureUnitDto unit;

  /// The numeric value of the pressure.
  final double value;
}

/// Represents a temperature measurement for platform transfer.
class TemperatureDto extends MeasurementUnitDto {
  TemperatureDto({required this.value, required this.unit});

  /// The unit in which the value is expressed.
  final TemperatureUnitDto unit;

  /// The numeric value of the temperature.
  final double value;
}

/// Represents a velocity measurement for platform transfer.
class VelocityDto extends MeasurementUnitDto {
  VelocityDto({required this.value, required this.unit});

  /// The unit in which the value is expressed.
  final VelocityUnitDto unit;

  /// The numeric value of the velocity.
  final double value;
}

/// Represents a volume measurement for platform transfer.
class VolumeDto extends MeasurementUnitDto {
  VolumeDto({required this.value, required this.unit});

  /// The unit in which the value is expressed.
  final VolumeUnitDto unit;

  /// The numeric value of the volume.
  final double value;
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

/// Cervical mucus appearance classification.
///
/// Maps to Android Health Connect CervicalMucusRecord appearance types
/// and iOS HealthKit HKCategoryValueCervicalMucusQuality enum.
enum CervicalMucusAppearanceTypeDto {
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
enum CervicalMucusSensationTypeDto {
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
enum SexualActivityProtectionUsedTypeDto {
  /// Protection was used.
  protected,

  /// Protection was not used.
  unprotected,

  /// Unknown whether protection was used.
  unknown,
}

// endregion

// region Health Records

/// Sealed class for all health record DTOs.
sealed class HealthRecordDto {}

/// Represents a health data type.
enum HealthDataTypeDto {
  /// Active calories burned data.
  activeCaloriesBurned,

  /// Distance traveled data.
  distance,

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

  // region Nutrition

  /// Combined nutrition record with all nutrients.
  nutrition,

  // endregion

  /// Resting heart rate data.
  restingHeartRate,

  /// Composite blood pressure data (systolic + diastolic).
  bloodPressure,

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
}

/// Represents a blood glucose record for platform transfer.
class BloodGlucoseRecordDto extends HealthRecordDto {
  BloodGlucoseRecordDto({
    required this.id,
    required this.time,
    required this.metadata,
    required this.bloodGlucose,
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
  final BloodGlucoseDto bloodGlucose;

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
  final NumberDto beatsPerMinute;

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
  final PercentageDto percentage;

  /// Timezone offset in seconds for measurement time (optional).
  final int? zoneOffsetSeconds;
}

/// Represents a respiratory rate record for platform transfer.
class RespiratoryRateRecordDto extends HealthRecordDto {
  RespiratoryRateRecordDto({
    required this.id,
    required this.time,
    required this.metadata,
    required this.breathsPerMin,
    this.zoneOffsetSeconds,
  });

  /// Platform-assigned unique identifier.
  final String? id;

  /// Measurement time in milliseconds since epoch (UTC).
  final int time;

  /// Metadata about this record.
  final MetadataDto metadata;

  /// Respiratory rate in breaths per minute.
  final NumberDto breathsPerMin;

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
    required this.mLPerKgPerMin,
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
  final NumberDto mLPerKgPerMin;

  /// The method used to measure or estimate VO2 max.
  ///
  /// Maps to Health Connect's Vo2MaxMeasurementMethod.
  final Vo2MaxMeasurementMethodDto? measurementMethod;

  /// Timezone offset in seconds for measurement time (optional).
  final int? zoneOffsetSeconds;
}

class ActiveCaloriesBurnedRecordDto extends HealthRecordDto {
  ActiveCaloriesBurnedRecordDto({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.metadata,
    required this.energy,
    this.startZoneOffsetSeconds,
    this.endZoneOffsetSeconds,
  });

  /// Energy (calories) burned during the interval.
  final EnergyDto energy;

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
    required this.distance,
    this.startZoneOffsetSeconds,
    this.endZoneOffsetSeconds,
  });

  /// Distance traveled during the interval.
  final LengthDto distance;

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
  final NumberDto floors;

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
  final NumberDto pushes;

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
  final NumberDto count;

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
    required this.weight,
    this.zoneOffsetSeconds,
  });

  /// Platform-assigned unique identifier.
  final String? id;

  /// Metadata about this record.
  final MetadataDto metadata;

  /// Measurement time in milliseconds since epoch (UTC).
  final int time;

  /// Weight measurement.
  final MassDto weight;

  /// Timezone offset in seconds for measurement time (optional).
  final int? zoneOffsetSeconds;
}

/// Represents a composite blood pressure record for platform transfer.
class BloodPressureRecordDto extends HealthRecordDto {
  BloodPressureRecordDto({
    required this.id,
    required this.time,
    required this.metadata,
    required this.systolic,
    required this.diastolic,
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
  final PressureDto systolic;

  /// Diastolic blood pressure measurement.
  final PressureDto diastolic;

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
    required this.mass,
    this.zoneOffsetSeconds,
  });

  /// Platform-assigned unique identifier.
  final String? id;

  /// Metadata about this record.
  final MetadataDto metadata;

  /// Measurement time in milliseconds since epoch (UTC).
  final int time;

  /// Lean body mass measurement.
  final MassDto mass;

  /// Timezone offset in seconds for measurement time (optional).
  final int? zoneOffsetSeconds;
}

/// DTO for body height health data.
class HeightRecordDto extends HealthRecordDto {
  HeightRecordDto({
    required this.id,
    required this.time,
    required this.metadata,
    required this.height,
    this.zoneOffsetSeconds,
  });

  /// Platform-assigned unique identifier.
  final String? id;

  /// Metadata about this record.
  final MetadataDto metadata;

  /// Measurement time in milliseconds since epoch (UTC).
  final int time;

  /// Height measurement.
  final LengthDto height;

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
  final PercentageDto percentage;

  /// Timezone offset in seconds for measurement time (optional).
  final int? zoneOffsetSeconds;
}

/// DTO for body temperature health data.
class BodyTemperatureRecordDto extends HealthRecordDto {
  BodyTemperatureRecordDto({
    required this.id,
    required this.time,
    required this.metadata,
    required this.temperature,
    this.zoneOffsetSeconds,
  });

  /// Platform-assigned unique identifier.
  final String? id;

  /// Metadata about this record.
  final MetadataDto metadata;

  /// Measurement time in milliseconds since epoch (UTC).
  final int time;

  /// Body temperature measurement.
  final TemperatureDto temperature;

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
  final CervicalMucusAppearanceTypeDto appearance;

  /// Cervical mucus sensation (optional).
  final CervicalMucusSensationTypeDto sensation;
}

/// Represents a hydration (water intake) record for platform transfer.
class HydrationRecordDto extends HealthRecordDto {
  HydrationRecordDto({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.metadata,
    required this.volume,
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
  final VolumeDto volume;

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
  final NumberDto beatsPerMinute;
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
  final List<HeartRateMeasurementDto> samples;

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
class CyclingPedalingCadenceMeasurementDto {
  CyclingPedalingCadenceMeasurementDto({
    required this.time,
    required this.revolutionsPerMinute,
  });

  /// Timestamp in milliseconds since epoch (UTC).
  final int time;

  /// Cycling cadence value in revolutions per minute (RPM).
  final NumberDto revolutionsPerMinute;
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
  final List<CyclingPedalingCadenceMeasurementDto> samples;
}

/// Represents a single speed measurement within a [SpeedSeriesRecordDto].
class SpeedMeasurementDto {
  SpeedMeasurementDto({
    required this.time,
    required this.speed,
  });

  /// Timestamp in milliseconds since epoch (UTC).
  final int time;

  /// Speed measurement.
  final VelocityDto speed;
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
  final List<SpeedMeasurementDto> samples;

  /// Timezone offset in seconds for start time (optional).
  final int? startZoneOffsetSeconds;

  /// Timezone offset in seconds for end time (optional).
  final int? endZoneOffsetSeconds;
}

/// Represents a single power measurement within a [PowerSeriesRecordDto].
class PowerMeasurementDto {
  PowerMeasurementDto({
    required this.time,
    required this.power,
  });

  /// Timestamp in milliseconds since epoch (UTC).
  final int time;

  /// Power measurement.
  final PowerDto power;
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
  final List<PowerMeasurementDto> samples;

  /// Timezone offset in seconds for start time (optional).
  final int? startZoneOffsetSeconds;

  /// Timezone offset in seconds for end time (optional).
  final int? endZoneOffsetSeconds;
}

/// Sleep stage type enum.
enum SleepStageTypeDto {
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
class SleepStageDto {
  SleepStageDto({
    required this.startTime,
    required this.endTime,
    required this.stage,
  });

  /// Start time (milliseconds since epoch).
  final int startTime;

  /// End time (milliseconds since epoch).
  final int endTime;

  /// The sleep stage type.
  final SleepStageTypeDto stage;
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
  final List<SleepStageDto> stages;
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
  final SexualActivityProtectionUsedTypeDto protectionUsed;
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
    this.energy,
    this.protein,
    this.totalCarbohydrate,
    this.totalFat,
    this.saturatedFat,
    this.monounsaturatedFat,
    this.polyunsaturatedFat,
    this.cholesterol,
    this.dietaryFiber,
    this.sugar,
    this.vitaminA,
    this.vitaminB6,
    this.vitaminB12,
    this.vitaminC,
    this.vitaminD,
    this.vitaminE,
    this.vitaminK,
    this.thiamin,
    this.riboflavin,
    this.niacin,
    this.folate,
    this.biotin,
    this.pantothenicAcid,
    this.calcium,
    this.iron,
    this.magnesium,
    this.manganese,
    this.phosphorus,
    this.potassium,
    this.selenium,
    this.sodium,
    this.zinc,
    this.caffeine,
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
  final EnergyDto? energy;

  /// Protein nutrient (grams).
  final MassDto? protein;

  /// Total carbohydrate nutrient (grams).
  final MassDto? totalCarbohydrate;

  /// Total fat nutrient (grams).
  final MassDto? totalFat;

  /// Saturated fat nutrient (grams).
  final MassDto? saturatedFat;

  /// Monounsaturated fat nutrient (grams).
  final MassDto? monounsaturatedFat;

  /// Polyunsaturated fat nutrient (grams).
  final MassDto? polyunsaturatedFat;

  /// Cholesterol nutrient (grams).
  final MassDto? cholesterol;

  /// Dietary fiber nutrient (grams).
  final MassDto? dietaryFiber;

  /// Sugar nutrient (grams).
  final MassDto? sugar;

  /// Vitamin A nutrient (grams).
  final MassDto? vitaminA;

  /// Vitamin B6 nutrient (grams).
  final MassDto? vitaminB6;

  /// Vitamin B12 nutrient (grams).
  final MassDto? vitaminB12;

  /// Vitamin C nutrient (grams).
  final MassDto? vitaminC;

  /// Vitamin D nutrient (grams).
  final MassDto? vitaminD;

  /// Vitamin E nutrient (grams).
  final MassDto? vitaminE;

  /// Vitamin K nutrient (grams).
  final MassDto? vitaminK;

  /// Thiamin (vitamin B1) nutrient (grams).
  final MassDto? thiamin;

  /// Riboflavin (vitamin B2) nutrient (grams).
  final MassDto? riboflavin;

  /// Niacin (vitamin B3) nutrient (grams).
  final MassDto? niacin;

  /// Folate (vitamin B9) nutrient (grams).
  final MassDto? folate;

  /// Biotin (vitamin B7) nutrient (grams).
  final MassDto? biotin;

  /// Pantothenic acid (vitamin B5) nutrient (grams).
  final MassDto? pantothenicAcid;

  /// Calcium nutrient (grams).
  final MassDto? calcium;

  /// Iron nutrient (grams).
  final MassDto? iron;

  /// Magnesium nutrient (grams).
  final MassDto? magnesium;

  /// Manganese nutrient (grams).
  final MassDto? manganese;

  /// Phosphorus nutrient (grams).
  final MassDto? phosphorus;

  /// Potassium nutrient (grams).
  final MassDto? potassium;

  /// Selenium nutrient (grams).
  final MassDto? selenium;

  /// Sodium nutrient (grams).
  final MassDto? sodium;

  /// Zinc nutrient (grams).
  final MassDto? zinc;

  /// Caffeine nutrient (grams).
  final MassDto? caffeine;
}

// endregion

// region Requests/Responses

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

/// Represents the response from a permissions request.
class PermissionRequestsResponseDto {
  PermissionRequestsResponseDto(this.permissionResults);

  /// Results for each permission that was requested.
  final List<PermissionRequestResultDto> permissionResults;
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

enum BloodPressureHealthDataTypeDto {
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
  final BloodPressureHealthDataTypeDto bloodPressureDataType;

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

/// Configuration data transfer object for Health Connector.
///
/// Contains configuration settings that are passed from Dart to native
/// platform code during client initialization.
class HealthConnectorConfigDto {
  HealthConnectorConfigDto({required this.isLoggerEnabled});

  /// Whether logging is enabled for the Health Connector.
  final bool isLoggerEnabled;
}

/// The main API for communicating with the health platform.
@HostApi()
abstract class HealthConnectorHCAndroidApi {
  /// Initializes the Health Connector client with the provided configuration.
  ///
  /// This method must be called before any other Health Connector operations
  /// to properly configure the native platform code, including logger settings.
  @async
  void initialize(HealthConnectorConfigDto config);

  @async
  MeasurementUnitDto aggregate(AggregateRequestDto request);

  @async
  void deleteRecords(DeleteRecordsRequestDto request);

  @async
  HealthPlatformFeatureStatusDto getFeatureStatus(
    HealthPlatformFeatureDto feature,
  );

  @async
  HealthPlatformStatusDto getHealthPlatformStatus();

  @async
  PermissionRequestsResponseDto requestPermissions(
    PermissionRequestsDto request,
  );

  @async
  PermissionRequestsResponseDto getGrantedPermissions();

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
}
