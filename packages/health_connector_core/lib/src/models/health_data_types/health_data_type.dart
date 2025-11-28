import 'package:health_connector_annotation/health_connector_annotation.dart'
    show
        sinceV1_0_0,
        supportedOnHealthConnect,
        supportedOnAppleHealth,
        availableOnAppleHealth;
import 'package:health_connector_core/health_connector_core.dart'
    show Permission;
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
        BodyFatPercentageRecord,
        BodyTemperatureRecord,
        DistanceRecord,
        FloorsClimbedRecord,
        HealthRecord,
        HealthRecordId,
        HeartRateMeasurementRecord,
        HeartRateSeriesRecord,
        HeightRecord,
        HydrationRecord,
        LeanBodyMassRecord,
        SleepSessionRecord,
        SleepStageRecord,
        StepRecord,
        WeightRecord,
        WheelchairPushesRecord;
import 'package:health_connector_core/src/models/measurement_units/measurement_unit.dart'
    show
        Energy,
        Length,
        Mass,
        MeasurementUnit,
        Numeric,
        Percentage,
        Temperature,
        Volume;
import 'package:health_connector_core/src/models/permissions/permission.dart'
    show HealthDataPermission, HealthDataPermissionAccessType;
import 'package:health_connector_core/src/models/requests/aggregate_request.dart'
    show AggregateRequest;
import 'package:health_connector_core/src/models/requests/aggregation_metric.dart'
    show AggregationMetric;
import 'package:health_connector_core/src/models/requests/read_record_request.dart'
    show ReadRecordRequest;
import 'package:health_connector_core/src/models/requests/read_records_request.dart'
    show ReadRecordsRequest;
import 'package:meta/meta.dart' show immutable, internal;

part 'active_calories_burned_health_data_type.dart';
part 'body_fat_percentage_health_data_type.dart';
part 'body_temperature_health_data_type.dart';
part 'distance_health_data_type.dart';
part 'floors_climbed_health_data_type.dart';
part 'heart_rate_measurement_record_health_data_type.dart';
part 'heart_rate_series_record_health_data_type.dart';
part 'height_health_data_type.dart';
part 'hydration_health_data_type.dart';
part 'lean_body_mass_health_data_type.dart';
part 'sleep_session_health_data_type.dart';
part 'sleep_stage_record_health_data_type.dart';
part 'steps_health_data_type.dart';
part 'weight_health_data_type.dart';
part 'wheelchair_pushes_health_data_type.dart';

/// [HealthDataType] represents different kinds of health and fitness data
/// that can be read from or written to health platforms.
///
/// ## Type Parameters
///
/// - `R`: The [HealthRecord] type associated with this data type
/// - `U`: The unit type for aggregations (e.g., [Numeric], [Mass], [Energy])
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
  List<AggregationMetric> get supportedAggregationMetrics;

  /// The list of permissions for this health record.
  List<Permission> get permissions;

  /// Distance data type.
  ///
  /// Represents the distance traveled during activities such as walking,
  /// running, or cycling. Supports both reading existing distance data
  /// and writing new distance measurements.
  static const distance = DistanceHealthDataType();

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

  /// Returns a list of all available health data types.
  ///
  /// This list contains all data types currently supported by the plugin.
  /// As new data types are added, they will automatically appear in this list.
  static const List<HealthDataType<HealthRecord, MeasurementUnit>> values = [
    activeCaloriesBurned,
    bodyFatPercentage,
    bodyTemperature,
    distance,
    floorsClimbed,
    heartRateMeasurementRecord,
    heartRateSeriesRecord,
    height,
    hydration,
    leanBodyMass,
    sleepSession,
    sleepStageRecord,
    steps,
    weight,
    wheelchairPushes,
  ];
}
