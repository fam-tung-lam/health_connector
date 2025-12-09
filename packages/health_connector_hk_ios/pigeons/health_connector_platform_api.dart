import 'package:pigeon/pigeon.dart';

/// Pigeon API definition for HealthKit Flutter plugin.
///
/// This file defines the complete API contract between Dart and iOS
/// for health data operations. Pigeon generates platform-specific
/// code from these definitions.
@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/src/pigeon/health_connector_platform_api.g.dart',
    dartOptions: DartOptions(),
    swiftOut:
        'ios/health_connector_hk_ios/Sources/health_connector_hk_ios/pigeon/HealthConnectorPlatformApi.g.swift',
    swiftOptions: SwiftOptions(errorClassName: 'HealthConnectorError'),
    copyrightHeader: 'pigeons/copyright_header.txt',
  ),
)
/// Error codes that native platforms can use when throwing error.
enum HealthConnectorErrorCodeDto {
  /// Health platform is unavailable on this device.
  healthPlatformUnavailable,

  /// Invalid platform configuration detected.
  invalidPlatformConfiguration,

  /// Invalid argument or input validation error.
  invalidArgument,

  /// Attempted to use platform APIs that are not supported on
  /// the current health platform.
  unsupportedHealthPlatformApi,

  /// Unknown or unspecified error.
  unknown,

  /// Security/permission error occurred.
  securityError,
}

/// Represents the status of the health platform on the device.
enum HealthPlatformStatusDto {
  /// The health platform is available and ready to use.
  available,

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

/// Length unit types supported by the plugin.
enum LengthUnitDto { feet, inches, kilometers, meters, miles }

/// Mass unit types supported by the plugin.
enum MassUnitDto { grams, kilograms, ounces, pounds }

/// Numeric unit types supported by the plugin.
///
/// Numeric values don't have unit conversions, but this enum is provided
/// for consistency with other unit types.
enum NumericUnitDto { numeric }

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

/// Represents a numeric measurement for platform transfer.
class NumericDto extends MeasurementUnitDto {
  NumericDto({required this.value, required this.unit});

  /// The unit in which the value is expressed.
  final NumericUnitDto unit;

  /// The numeric value.
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

// endregion

// region Metadata

/// Represents metadata for a health record.
class MetadataDto {
  MetadataDto({
    required this.dataOrigin,
    required this.isManualEntry,
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

  /// Whether this data was manually entered by the user.
  ///
  /// `true` indicates manual entry, `false` indicates unknown/not manual entry.
  final bool isManualEntry;
}

// endregion

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

// region Health Records

/// Represents the type of sleep stage.
///
/// Maps to iOS HKCategoryValueSleepAnalysis values.
enum SleepStageTypeDto {
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

  /// Lean body mass data.
  leanBodyMass,

  /// Wheelchair pushes data.
  wheelchairPushes,

  /// Hydration (water intake) data.
  hydration,

  /// Heart rate measurement record data (iOS).
  heartRateMeasurementRecord,

  /// Sleep stage record data (iOS).
  sleepStageRecord,

  // NUTRIENT TYPES - Energy & Other (2)
  /// Energy nutrient data (calories consumed).
  energyNutrient,

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

  /// Composite blood pressure (HKCorrelationType.bloodPressure).
  bloodPressure,

  /// Systolic blood pressure (HKQuantityType.bloodPressureSystolic).
  systolicBloodPressure,

  /// Diastolic blood pressure (HKQuantityType.bloodPressureDiastolic).
  diastolicBloodPressure,
}

/// Represents an active calories burned record for platform transfer.
class ActiveCaloriesBurnedRecordDto extends HealthRecordDto {
  ActiveCaloriesBurnedRecordDto({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.metadata,
    required this.energy,
    this.zoneOffsetSeconds,
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

  /// Timezone offset in seconds (optional).
  final int? zoneOffsetSeconds;
}

/// Represents a distance record for platform transfer.
class DistanceRecordDto extends HealthRecordDto {
  DistanceRecordDto({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.metadata,
    required this.distance,
    this.zoneOffsetSeconds,
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
    this.zoneOffsetSeconds,
  });

  /// Number of floors (flights of stairs) climbed during the interval.
  final NumericDto floors;

  /// End time in milliseconds since epoch (UTC).
  final int endTime;

  /// Platform-assigned unique identifier.
  final String? id;

  /// Metadata about this record.
  final MetadataDto metadata;

  /// Start time in milliseconds since epoch (UTC).
  final int startTime;

  /// Timezone offset in seconds (optional).
  final int? zoneOffsetSeconds;
}

/// Represents a wheelchair pushes record for platform transfer.
class WheelchairPushesRecordDto extends HealthRecordDto {
  WheelchairPushesRecordDto({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.metadata,
    required this.pushes,
    this.zoneOffsetSeconds,
  });

  /// Number of wheelchair pushes performed during the interval.
  final NumericDto pushes;

  /// End time in milliseconds since epoch (UTC).
  final int endTime;

  /// Platform-assigned unique identifier.
  final String? id;

  /// Metadata about this record.
  final MetadataDto metadata;

  /// Start time in milliseconds since epoch (UTC).
  final int startTime;

  /// Timezone offset in seconds (optional).
  final int? zoneOffsetSeconds;
}

/// Represents a step count record for platform transfer.
class StepRecordDto extends HealthRecordDto {
  StepRecordDto({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.metadata,
    required this.count,
    this.zoneOffsetSeconds,
  });

  /// Number of steps taken during the interval (must be >= 0).
  final NumericDto count;

  /// End time in milliseconds since epoch (UTC).
  final int endTime;

  /// Platform-assigned unique identifier.
  final String? id;

  /// Metadata about this record.
  final MetadataDto metadata;

  /// Start time in milliseconds since epoch (UTC).
  final int startTime;

  /// Timezone offset in seconds (optional).
  final int? zoneOffsetSeconds;
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
/// Maps to HKCorrelationType.bloodPressure.
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

  /// Body position during measurement (Android only, always unknown on iOS).
  final BodyPositionDto bodyPosition;

  /// Location where measurement was taken (Android only, always unknown on
  /// iOS).
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
    required this.pressure,
    this.zoneOffsetSeconds,
  });

  /// Platform-assigned unique identifier.
  final String? id;

  /// Metadata about this record.
  final MetadataDto metadata;

  /// Measurement time in milliseconds since epoch (UTC).
  final int time;

  /// Systolic blood pressure measurement.
  final PressureDto pressure;

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
    required this.pressure,
    this.zoneOffsetSeconds,
  });

  /// Platform-assigned unique identifier.
  final String? id;

  /// Metadata about this record.
  final MetadataDto metadata;

  /// Measurement time in milliseconds since epoch (UTC).
  final int time;

  /// Diastolic blood pressure measurement.
  final PressureDto pressure;

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

/// Represents a hydration (water intake) record for platform transfer.
class HydrationRecordDto extends HealthRecordDto {
  HydrationRecordDto({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.metadata,
    required this.volume,
    this.zoneOffsetSeconds,
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

  /// Timezone offset in seconds (optional).
  final int? zoneOffsetSeconds;
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
  final NumericDto beatsPerMinute;
}

/// Represents a heart rate measurement record for platform transfer (iOS).
class HeartRateMeasurementRecordDto extends HealthRecordDto {
  HeartRateMeasurementRecordDto({
    required this.id,
    required this.time,
    required this.metadata,
    required this.measurement,
    this.zoneOffsetSeconds,
  });

  /// Platform-assigned unique identifier.
  final String? id;

  /// Measurement time in milliseconds since epoch (UTC).
  final int time;

  /// Metadata about this record.
  final MetadataDto metadata;

  /// The heart rate measurement.
  final HeartRateMeasurementDto measurement;

  /// Timezone offset in seconds for measurement time (optional).
  final int? zoneOffsetSeconds;
}

/// Represents a sleep stage record for platform transfer (iOS).
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
  final SleepStageTypeDto stageType;

  /// Timezone offset in seconds for start time (optional).
  final int? startZoneOffsetSeconds;

  /// Timezone offset in seconds for end time (optional).
  final int? endZoneOffsetSeconds;
}

/// Represents energy nutrient data for platform transfer.
///
/// Maps to:
/// - HealthKit: `HKQuantityTypeIdentifier.dietaryEnergyConsumed`
/// - Domain: `EnergyNutrientRecord`
class EnergyNutrientRecordDto extends HealthRecordDto {
  EnergyNutrientRecordDto({
    required this.id,
    required this.metadata,
    required this.time,
    required this.value,
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
  final EnergyDto value;

  /// Name of the food (optional).
  final String? foodName;

  /// Meal type classification.
  final MealTypeDto? mealType;
}

/// Represents caffeine nutrient data for platform transfer.
class CaffeineNutrientRecordDto extends HealthRecordDto {
  CaffeineNutrientRecordDto({
    required this.id,
    required this.metadata,
    required this.time,
    required this.value,
    this.zoneOffsetSeconds,
    this.foodName,
    this.mealType,
  });

  final String? id;
  final MetadataDto metadata;
  final int time;
  final int? zoneOffsetSeconds;
  final MassDto value;
  final String? foodName;
  final MealTypeDto? mealType;
}

/// Represents protein nutrient data for platform transfer.
class ProteinNutrientRecordDto extends HealthRecordDto {
  ProteinNutrientRecordDto({
    required this.id,
    required this.metadata,
    required this.time,
    required this.value,
    this.zoneOffsetSeconds,
    this.foodName,
    this.mealType,
  });

  final String? id;
  final MetadataDto metadata;
  final int time;
  final int? zoneOffsetSeconds;
  final MassDto value;
  final String? foodName;
  final MealTypeDto? mealType;
}

/// Represents total carbohydrate nutrient data for platform transfer.
class TotalCarbohydrateNutrientRecordDto extends HealthRecordDto {
  TotalCarbohydrateNutrientRecordDto({
    required this.id,
    required this.metadata,
    required this.time,
    required this.value,
    this.zoneOffsetSeconds,
    this.foodName,
    this.mealType,
  });

  final String? id;
  final MetadataDto metadata;
  final int time;
  final int? zoneOffsetSeconds;
  final MassDto value;
  final String? foodName;
  final MealTypeDto? mealType;
}

/// Represents total fat nutrient data for platform transfer.
class TotalFatNutrientRecordDto extends HealthRecordDto {
  TotalFatNutrientRecordDto({
    required this.id,
    required this.metadata,
    required this.time,
    required this.value,
    this.zoneOffsetSeconds,
    this.foodName,
    this.mealType,
  });

  final String? id;
  final MetadataDto metadata;
  final int time;
  final int? zoneOffsetSeconds;
  final MassDto value;
  final String? foodName;
  final MealTypeDto? mealType;
}

/// Represents saturated fat nutrient data for platform transfer.
class SaturatedFatNutrientRecordDto extends HealthRecordDto {
  SaturatedFatNutrientRecordDto({
    required this.id,
    required this.metadata,
    required this.time,
    required this.value,
    this.zoneOffsetSeconds,
    this.foodName,
    this.mealType,
  });

  final String? id;
  final MetadataDto metadata;
  final int time;
  final int? zoneOffsetSeconds;
  final MassDto value;
  final String? foodName;
  final MealTypeDto? mealType;
}

/// Represents monounsaturated fat nutrient data for platform transfer.
class MonounsaturatedFatNutrientRecordDto extends HealthRecordDto {
  MonounsaturatedFatNutrientRecordDto({
    required this.id,
    required this.metadata,
    required this.time,
    required this.value,
    this.zoneOffsetSeconds,
    this.foodName,
    this.mealType,
  });

  final String? id;
  final MetadataDto metadata;
  final int time;
  final int? zoneOffsetSeconds;
  final MassDto value;
  final String? foodName;
  final MealTypeDto? mealType;
}

/// Represents polyunsaturated fat nutrient data for platform transfer.
class PolyunsaturatedFatNutrientRecordDto extends HealthRecordDto {
  PolyunsaturatedFatNutrientRecordDto({
    required this.id,
    required this.metadata,
    required this.time,
    required this.value,
    this.zoneOffsetSeconds,
    this.foodName,
    this.mealType,
  });

  final String? id;
  final MetadataDto metadata;
  final int time;
  final int? zoneOffsetSeconds;
  final MassDto value;
  final String? foodName;
  final MealTypeDto? mealType;
}

/// Represents cholesterol nutrient data for platform transfer.
class CholesterolNutrientRecordDto extends HealthRecordDto {
  CholesterolNutrientRecordDto({
    required this.id,
    required this.metadata,
    required this.time,
    required this.value,
    this.zoneOffsetSeconds,
    this.foodName,
    this.mealType,
  });

  final String? id;
  final MetadataDto metadata;
  final int time;
  final int? zoneOffsetSeconds;
  final MassDto value;
  final String? foodName;
  final MealTypeDto? mealType;
}

/// Represents dietary fiber nutrient data for platform transfer.
class DietaryFiberNutrientRecordDto extends HealthRecordDto {
  DietaryFiberNutrientRecordDto({
    required this.id,
    required this.metadata,
    required this.time,
    required this.value,
    this.zoneOffsetSeconds,
    this.foodName,
    this.mealType,
  });

  final String? id;
  final MetadataDto metadata;
  final int time;
  final int? zoneOffsetSeconds;
  final MassDto value;
  final String? foodName;
  final MealTypeDto? mealType;
}

/// Represents sugar nutrient data for platform transfer.
class SugarNutrientRecordDto extends HealthRecordDto {
  SugarNutrientRecordDto({
    required this.id,
    required this.metadata,
    required this.time,
    required this.value,
    this.zoneOffsetSeconds,
    this.foodName,
    this.mealType,
  });

  final String? id;
  final MetadataDto metadata;
  final int time;
  final int? zoneOffsetSeconds;
  final MassDto value;
  final String? foodName;
  final MealTypeDto? mealType;
}

/// Represents vitamin A nutrient data for platform transfer.
class VitaminANutrientRecordDto extends HealthRecordDto {
  VitaminANutrientRecordDto({
    required this.id,
    required this.metadata,
    required this.time,
    required this.value,
    this.zoneOffsetSeconds,
    this.foodName,
    this.mealType,
  });

  final String? id;
  final MetadataDto metadata;
  final int time;
  final int? zoneOffsetSeconds;
  final MassDto value;
  final String? foodName;
  final MealTypeDto? mealType;
}

/// Represents vitamin B6 nutrient data for platform transfer.
class VitaminB6NutrientRecordDto extends HealthRecordDto {
  VitaminB6NutrientRecordDto({
    required this.id,
    required this.metadata,
    required this.time,
    required this.value,
    this.zoneOffsetSeconds,
    this.foodName,
    this.mealType,
  });

  final String? id;
  final MetadataDto metadata;
  final int time;
  final int? zoneOffsetSeconds;
  final MassDto value;
  final String? foodName;
  final MealTypeDto? mealType;
}

/// Represents vitamin B12 nutrient data for platform transfer.
class VitaminB12NutrientRecordDto extends HealthRecordDto {
  VitaminB12NutrientRecordDto({
    required this.id,
    required this.metadata,
    required this.time,
    required this.value,
    this.zoneOffsetSeconds,
    this.foodName,
    this.mealType,
  });

  final String? id;
  final MetadataDto metadata;
  final int time;
  final int? zoneOffsetSeconds;
  final MassDto value;
  final String? foodName;
  final MealTypeDto? mealType;
}

/// Represents vitamin C nutrient data for platform transfer.
class VitaminCNutrientRecordDto extends HealthRecordDto {
  VitaminCNutrientRecordDto({
    required this.id,
    required this.metadata,
    required this.time,
    required this.value,
    this.zoneOffsetSeconds,
    this.foodName,
    this.mealType,
  });

  final String? id;
  final MetadataDto metadata;
  final int time;
  final int? zoneOffsetSeconds;
  final MassDto value;
  final String? foodName;
  final MealTypeDto? mealType;
}

/// Represents vitamin D nutrient data for platform transfer.
class VitaminDNutrientRecordDto extends HealthRecordDto {
  VitaminDNutrientRecordDto({
    required this.id,
    required this.metadata,
    required this.time,
    required this.value,
    this.zoneOffsetSeconds,
    this.foodName,
    this.mealType,
  });

  final String? id;
  final MetadataDto metadata;
  final int time;
  final int? zoneOffsetSeconds;
  final MassDto value;
  final String? foodName;
  final MealTypeDto? mealType;
}

/// Represents vitamin E nutrient data for platform transfer.
class VitaminENutrientRecordDto extends HealthRecordDto {
  VitaminENutrientRecordDto({
    required this.id,
    required this.metadata,
    required this.time,
    required this.value,
    this.zoneOffsetSeconds,
    this.foodName,
    this.mealType,
  });

  final String? id;
  final MetadataDto metadata;
  final int time;
  final int? zoneOffsetSeconds;
  final MassDto value;
  final String? foodName;
  final MealTypeDto? mealType;
}

/// Represents vitamin K nutrient data for platform transfer.
class VitaminKNutrientRecordDto extends HealthRecordDto {
  VitaminKNutrientRecordDto({
    required this.id,
    required this.metadata,
    required this.time,
    required this.value,
    this.zoneOffsetSeconds,
    this.foodName,
    this.mealType,
  });

  final String? id;
  final MetadataDto metadata;
  final int time;
  final int? zoneOffsetSeconds;
  final MassDto value;
  final String? foodName;
  final MealTypeDto? mealType;
}

/// Represents thiamin (vitamin B1) nutrient data for platform transfer.
class ThiaminNutrientRecordDto extends HealthRecordDto {
  ThiaminNutrientRecordDto({
    required this.id,
    required this.metadata,
    required this.time,
    required this.value,
    this.zoneOffsetSeconds,
    this.foodName,
    this.mealType,
  });

  final String? id;
  final MetadataDto metadata;
  final int time;
  final int? zoneOffsetSeconds;
  final MassDto value;
  final String? foodName;
  final MealTypeDto? mealType;
}

/// Represents riboflavin (vitamin B2) nutrient data for platform transfer.
class RiboflavinNutrientRecordDto extends HealthRecordDto {
  RiboflavinNutrientRecordDto({
    required this.id,
    required this.metadata,
    required this.time,
    required this.value,
    this.zoneOffsetSeconds,
    this.foodName,
    this.mealType,
  });

  final String? id;
  final MetadataDto metadata;
  final int time;
  final int? zoneOffsetSeconds;
  final MassDto value;
  final String? foodName;
  final MealTypeDto? mealType;
}

/// Represents niacin (vitamin B3) nutrient data for platform transfer.
class NiacinNutrientRecordDto extends HealthRecordDto {
  NiacinNutrientRecordDto({
    required this.id,
    required this.metadata,
    required this.time,
    required this.value,
    this.zoneOffsetSeconds,
    this.foodName,
    this.mealType,
  });

  final String? id;
  final MetadataDto metadata;
  final int time;
  final int? zoneOffsetSeconds;
  final MassDto value;
  final String? foodName;
  final MealTypeDto? mealType;
}

/// Represents folate (vitamin B9) nutrient data for platform transfer.
class FolateNutrientRecordDto extends HealthRecordDto {
  FolateNutrientRecordDto({
    required this.id,
    required this.metadata,
    required this.time,
    required this.value,
    this.zoneOffsetSeconds,
    this.foodName,
    this.mealType,
  });

  final String? id;
  final MetadataDto metadata;
  final int time;
  final int? zoneOffsetSeconds;
  final MassDto value;
  final String? foodName;
  final MealTypeDto? mealType;
}

/// Represents biotin (vitamin B7) nutrient data for platform transfer.
class BiotinNutrientRecordDto extends HealthRecordDto {
  BiotinNutrientRecordDto({
    required this.id,
    required this.metadata,
    required this.time,
    required this.value,
    this.zoneOffsetSeconds,
    this.foodName,
    this.mealType,
  });

  final String? id;
  final MetadataDto metadata;
  final int time;
  final int? zoneOffsetSeconds;
  final MassDto value;
  final String? foodName;
  final MealTypeDto? mealType;
}

/// Represents pantothenic acid (vitamin B5) nutrient data.
class PantothenicAcidNutrientRecordDto extends HealthRecordDto {
  PantothenicAcidNutrientRecordDto({
    required this.id,
    required this.metadata,
    required this.time,
    required this.value,
    this.zoneOffsetSeconds,
    this.foodName,
    this.mealType,
  });

  final String? id;
  final MetadataDto metadata;
  final int time;
  final int? zoneOffsetSeconds;
  final MassDto value;
  final String? foodName;
  final MealTypeDto? mealType;
}

/// Represents calcium nutrient data for platform transfer.
class CalciumNutrientRecordDto extends HealthRecordDto {
  CalciumNutrientRecordDto({
    required this.id,
    required this.metadata,
    required this.time,
    required this.value,
    this.zoneOffsetSeconds,
    this.foodName,
    this.mealType,
  });

  final String? id;
  final MetadataDto metadata;
  final int time;
  final int? zoneOffsetSeconds;
  final MassDto value;
  final String? foodName;
  final MealTypeDto? mealType;
}

/// Represents iron nutrient data for platform transfer.
class IronNutrientRecordDto extends HealthRecordDto {
  IronNutrientRecordDto({
    required this.id,
    required this.metadata,
    required this.time,
    required this.value,
    this.zoneOffsetSeconds,
    this.foodName,
    this.mealType,
  });

  final String? id;
  final MetadataDto metadata;
  final int time;
  final int? zoneOffsetSeconds;
  final MassDto value;
  final String? foodName;
  final MealTypeDto? mealType;
}

/// Represents magnesium nutrient data for platform transfer.
class MagnesiumNutrientRecordDto extends HealthRecordDto {
  MagnesiumNutrientRecordDto({
    required this.id,
    required this.metadata,
    required this.time,
    required this.value,
    this.zoneOffsetSeconds,
    this.foodName,
    this.mealType,
  });

  final String? id;
  final MetadataDto metadata;
  final int time;
  final int? zoneOffsetSeconds;
  final MassDto value;
  final String? foodName;
  final MealTypeDto? mealType;
}

/// Represents manganese nutrient data for platform transfer.
class ManganeseNutrientRecordDto extends HealthRecordDto {
  ManganeseNutrientRecordDto({
    required this.id,
    required this.metadata,
    required this.time,
    required this.value,
    this.zoneOffsetSeconds,
    this.foodName,
    this.mealType,
  });

  final String? id;
  final MetadataDto metadata;
  final int time;
  final int? zoneOffsetSeconds;
  final MassDto value;
  final String? foodName;
  final MealTypeDto? mealType;
}

/// Represents phosphorus nutrient data for platform transfer.
class PhosphorusNutrientRecordDto extends HealthRecordDto {
  PhosphorusNutrientRecordDto({
    required this.id,
    required this.metadata,
    required this.time,
    required this.value,
    this.zoneOffsetSeconds,
    this.foodName,
    this.mealType,
  });

  final String? id;
  final MetadataDto metadata;
  final int time;
  final int? zoneOffsetSeconds;
  final MassDto value;
  final String? foodName;
  final MealTypeDto? mealType;
}

/// Represents potassium nutrient data for platform transfer.
class PotassiumNutrientRecordDto extends HealthRecordDto {
  PotassiumNutrientRecordDto({
    required this.id,
    required this.metadata,
    required this.time,
    required this.value,
    this.zoneOffsetSeconds,
    this.foodName,
    this.mealType,
  });

  final String? id;
  final MetadataDto metadata;
  final int time;
  final int? zoneOffsetSeconds;
  final MassDto value;
  final String? foodName;
  final MealTypeDto? mealType;
}

/// Represents selenium nutrient data for platform transfer.
class SeleniumNutrientRecordDto extends HealthRecordDto {
  SeleniumNutrientRecordDto({
    required this.id,
    required this.metadata,
    required this.time,
    required this.value,
    this.zoneOffsetSeconds,
    this.foodName,
    this.mealType,
  });

  final String? id;
  final MetadataDto metadata;
  final int time;
  final int? zoneOffsetSeconds;
  final MassDto value;
  final String? foodName;
  final MealTypeDto? mealType;
}

/// Represents sodium nutrient data for platform transfer.
class SodiumNutrientRecordDto extends HealthRecordDto {
  SodiumNutrientRecordDto({
    required this.id,
    required this.metadata,
    required this.time,
    required this.value,
    this.zoneOffsetSeconds,
    this.foodName,
    this.mealType,
  });

  final String? id;
  final MetadataDto metadata;
  final int time;
  final int? zoneOffsetSeconds;
  final MassDto value;
  final String? foodName;
  final MealTypeDto? mealType;
}

/// Represents zinc nutrient data for platform transfer.
class ZincNutrientRecordDto extends HealthRecordDto {
  ZincNutrientRecordDto({
    required this.id,
    required this.metadata,
    required this.time,
    required this.value,
    this.zoneOffsetSeconds,
    this.foodName,
    this.mealType,
  });

  final String? id;
  final MetadataDto metadata;
  final int time;
  final int? zoneOffsetSeconds;
  final MassDto value;
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
    this.energy,
    // Macronutrients
    this.protein,
    this.totalCarbohydrate,
    this.totalFat,
    this.saturatedFat,
    this.monounsaturatedFat,
    this.polyunsaturatedFat,
    this.cholesterol,
    this.dietaryFiber,
    this.sugar,
    // Vitamins
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
    // Minerals
    this.calcium,
    this.iron,
    this.magnesium,
    this.manganese,
    this.phosphorus,
    this.potassium,
    this.selenium,
    this.sodium,
    this.zinc,
    // Other
    this.caffeine,
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
  final EnergyDto? energy;

  // Macronutrients (all Mass)
  /// Protein amount.
  final MassDto? protein;

  /// Total carbohydrate amount.
  final MassDto? totalCarbohydrate;

  /// Total fat amount.
  final MassDto? totalFat;

  /// Saturated fat amount.
  final MassDto? saturatedFat;

  /// Monounsaturated fat amount.
  final MassDto? monounsaturatedFat;

  /// Polyunsaturated fat amount.
  final MassDto? polyunsaturatedFat;

  /// Cholesterol amount.
  final MassDto? cholesterol;

  /// Dietary fiber amount.
  final MassDto? dietaryFiber;

  /// Sugar amount.
  final MassDto? sugar;

  // Vitamins (all Mass)
  /// Vitamin A amount.
  final MassDto? vitaminA;

  /// Vitamin B6 amount.
  final MassDto? vitaminB6;

  /// Vitamin B12 amount.
  final MassDto? vitaminB12;

  /// Vitamin C amount.
  final MassDto? vitaminC;

  /// Vitamin D amount.
  final MassDto? vitaminD;

  /// Vitamin E amount.
  final MassDto? vitaminE;

  /// Vitamin K amount.
  final MassDto? vitaminK;

  /// Thiamin amount.
  final MassDto? thiamin;

  /// Riboflavin amount.
  final MassDto? riboflavin;

  /// Niacin amount.
  final MassDto? niacin;

  /// Folate amount.
  final MassDto? folate;

  /// Biotin amount.
  final MassDto? biotin;

  /// Pantothenic acid amount.
  final MassDto? pantothenicAcid;

  // Minerals (all Mass)
  /// Calcium amount.
  final MassDto? calcium;

  /// Iron amount.
  final MassDto? iron;

  /// Magnesium amount.
  final MassDto? magnesium;

  /// Manganese amount.
  final MassDto? manganese;

  /// Phosphorus amount.
  final MassDto? phosphorus;

  /// Potassium amount.
  final MassDto? potassium;

  /// Selenium amount.
  final MassDto? selenium;

  /// Sodium amount.
  final MassDto? sodium;

  /// Zinc amount.
  final MassDto? zinc;

  // Other
  /// Caffeine amount.
  final MassDto? caffeine;
}

// endregion

// region Requests/Responses

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

/// Represents the response from a permissions request.
class PermissionsRequestResponseDto {
  PermissionsRequestResponseDto(this.healthDataPermissionResults);

  /// Results for each health data permission that was requested.
  final List<HealthDataPermissionRequestResultDto> healthDataPermissionResults;
}

/// Aggregation metric types for health data queries.
enum AggregationMetricDto {
  /// Average (mean) value across all data points.
  avg,

  /// Count of data points (records) in the dataset.
  count,

  /// Maximum value in the dataset.
  max,

  /// Minimum value in the dataset.
  min,

  /// Sum of all values in the time range.
  sum,
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

/// Response containing aggregated value.
class AggregateResponseDto {
  AggregateResponseDto(this.value);

  /// Aggregated value.
  final MeasurementUnitDto value;
}

/// Request to delete specific records by their IDs.
class DeleteRecordsByIdsRequestDto {
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
class DeleteRecordsByTimeRangeRequestDto {
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

/// Response containing a single health record.
class ReadRecordResponseDto {
  ReadRecordResponseDto(this.record);

  /// The health record that was read.
  final HealthRecordDto? record;
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

/// Request to write a single health record.
class WriteRecordRequestDto {
  WriteRecordRequestDto(this.record);

  /// Health record.
  final HealthRecordDto record;
}

/// Response after writing a single record.
class WriteRecordResponseDto {
  WriteRecordResponseDto(this.recordId);

  /// Platform-assigned unique identifier for the written record.
  final String recordId;
}

/// Request to write multiple health records atomically.
class WriteRecordsRequestDto {
  WriteRecordsRequestDto(this.records);

  /// Records being written.
  final List<HealthRecordDto> records;
}

/// Response after writing multiple records.
class WriteRecordsResponseDto {
  WriteRecordsResponseDto(this.recordIds);

  /// Platform-assigned unique identifiers for written records.
  final List<String> recordIds;
}

/// Request to update a single health record.
class UpdateRecordRequestDto {
  UpdateRecordRequestDto(this.record);

  /// The health record to update.
  final HealthRecordDto record;
}

/// Response after updating a single record.
class UpdateRecordResponseDto {
  UpdateRecordResponseDto(this.recordId);

  /// Platform-assigned unique identifier for the updated record.
  final String recordId;
}

// endregion

/// The main API for communicating with the health platform.
@HostApi()
abstract class HealthConnectorPlatformApi {
  @async
  AggregateResponseDto aggregate(AggregateRequestDto request);

  @async
  void deleteRecordsByIds(DeleteRecordsByIdsRequestDto request);

  @async
  void deleteRecordsByTimeRange(DeleteRecordsByTimeRangeRequestDto request);

  @async
  HealthPlatformStatusDto getHealthPlatformStatus();

  @async
  PermissionsRequestResponseDto requestPermissions(
    PermissionsRequestDto request,
  );

  @async
  ReadRecordResponseDto? readRecord(ReadRecordRequestDto request);

  @async
  ReadRecordsResponseDto readRecords(ReadRecordsRequestDto request);

  @async
  WriteRecordResponseDto writeRecord(WriteRecordRequestDto request);

  @async
  WriteRecordsResponseDto writeRecords(WriteRecordsRequestDto request);

  @async
  UpdateRecordResponseDto updateRecord(UpdateRecordRequestDto request);
}
