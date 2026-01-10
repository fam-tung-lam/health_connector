import 'package:collection/collection.dart' show ListEquality;
import 'package:health_connector_core/src/annotations/annotations.dart';
import 'package:health_connector_core/src/models/exceptions/health_connector_exception.dart';
import 'package:health_connector_core/src/models/health_data_types/health_data_type.dart';
import 'package:health_connector_core/src/models/health_platform.dart';
import 'package:health_connector_core/src/models/health_platform_data.dart'
    show HealthPlatformData;
import 'package:health_connector_core/src/models/health_records/blood_pressure/blood_pressure_body_position.dart';
import 'package:health_connector_core/src/models/health_records/blood_pressure/blood_pressure_measurement_location.dart';
import 'package:health_connector_core/src/models/health_records/sleep/sleep_stage.dart';
import 'package:health_connector_core/src/models/measurement_units/measurement_unit.dart';
import 'package:health_connector_core/src/models/metadata/metadata.dart';
import 'package:health_connector_core/src/utils/health_record_data_type_extension.dart';
import 'package:health_connector_core/src/utils/validation_utils.dart';
import 'package:meta/meta.dart' show immutable, internal;

part 'blood_glucose/blood_glucose_record.dart';
part 'blood_glucose/blood_glucose_relation_to_meal.dart';
part 'blood_glucose/blood_glucose_specimen_source.dart';
part 'blood_pressure/blood_pressure_record.dart';
part 'blood_pressure/diastolic_blood_pressure_record.dart';
part 'blood_pressure/systolic_blood_pressure_record.dart';
part 'body_fat_percentage_record.dart';
part 'body_mass_index_record.dart';
part 'body_water_mass_record.dart';
part 'bone_mass_record.dart';
part 'cycling_pedaling_cadence/cycling_pedaling_cadence_record.dart';
part 'cycling_pedaling_cadence/cycling_pedaling_cadence_series_record.dart';
part 'distance/cross_country_skiing_distance_record.dart';
part 'distance/cycling_distance_record.dart';
part 'distance/distance_activity_record.dart';
part 'distance/distance_record.dart';
part 'distance/downhill_snow_sports_distance_record.dart';
part 'distance/paddle_sports_distance_record.dart';
part 'distance/rowing_distance_record.dart';
part 'distance/six_minute_walk_test_distance_record.dart';
part 'distance/skating_sports_distance_record.dart';
part 'distance/swimming_distance_record.dart';
part 'distance/walking_running_distance_record.dart';
part 'distance/wheelchair_distance_record.dart';
part 'energy_burned/active_energy_burned_record.dart';
part 'energy_burned/basal_energy_burned_record.dart';
part 'energy_burned/total_energy_burned_record.dart';
part 'exercise/exercise_session_record.dart';
part 'exercise/exercise_type.dart';
part 'floors_climbed_record.dart';
part 'heart_rate/heart_rate_record.dart';
part 'heart_rate/heart_rate_series_record.dart';
part 'heart_rate/heart_rate_variability_rmssd_record.dart';
part 'heart_rate/heart_rate_variability_sdnn_record.dart';
part 'heart_rate/resting_heart_rate_record.dart';
part 'height_record.dart';
part 'hydration_record.dart';
part 'instant_health_record.dart';
part 'interval_health_record.dart';
part 'lean_body_mass_record.dart';
part 'menstruation/cervical_mucus/cervical_mucus_appearance.dart';
part 'menstruation/cervical_mucus/cervical_mucus_record.dart';
part 'menstruation/cervical_mucus/cervical_mucus_sensation.dart';
part 'menstruation/intermenstrual_bleeding_record.dart';
part 'menstruation/menstrual_flow/menstrual_flow.dart';
part 'menstruation/menstrual_flow/menstrual_flow_instant_record.dart';
part 'menstruation/menstrual_flow/menstrual_flow_record.dart';
part 'menstruation/ovulation_test/ovulation_test_record.dart';
part 'menstruation/ovulation_test/ovulation_test_result.dart';
part 'mindfulness/mindfulness_session_record.dart';
// Vitamin nutrient records
part 'nutrition/biotin_nutrient_record.dart';
part 'nutrition/caffeine_nutrient_record.dart';
// Mineral nutrient records
part 'nutrition/calcium_nutrient_record.dart';
// Macronutrient records
part 'nutrition/cholesterol_nutrient_record.dart';
part 'nutrition/dietary_fiber_nutrient_record.dart';
part 'nutrition/dietary_energy_consumed_record.dart';
part 'nutrition/folate_nutrient_record.dart';
part 'nutrition/iron_nutrient_record.dart';
part 'nutrition/macronutrient_record.dart';
part 'nutrition/magnesium_nutrient_record.dart';
part 'nutrition/manganese_nutrient_record.dart';
part 'nutrition/meal_type.dart';
part 'nutrition/mineral_nutrient_records.dart';
part 'nutrition/monounsaturated_fat_nutrient_record.dart';
part 'nutrition/niacin_nutrient_record.dart';
part 'nutrition/nutrient_record.dart';
part 'nutrition/nutrition_record.dart';
part 'nutrition/pantothenic_acid_nutrient_record.dart';
part 'nutrition/phosphorus_nutrient_record.dart';
part 'nutrition/polyunsaturated_fat_nutrient_record.dart';
part 'nutrition/potassium_nutrient_record.dart';
part 'nutrition/protein_nutrient_record.dart';
part 'nutrition/riboflavin_nutrient_record.dart';
part 'nutrition/saturated_fat_nutrient_record.dart';
part 'nutrition/selenium_nutrient_record.dart';
part 'nutrition/sodium_nutrient_record.dart';
part 'nutrition/sugar_nutrient_record.dart';
part 'nutrition/thiamin_nutrient_record.dart';
part 'nutrition/total_carbohydrate_nutrient_record.dart';
part 'nutrition/total_fat_nutrient_record.dart';
part 'nutrition/vitamin_a_nutrient_record.dart';
part 'nutrition/vitamin_b12_nutrient_record.dart';
part 'nutrition/vitamin_b6_nutrient_record.dart';
part 'nutrition/vitamin_c_nutrient_record.dart';
part 'nutrition/vitamin_d_nutrient_record.dart';
part 'nutrition/vitamin_e_nutrient_record.dart';
part 'nutrition/vitamin_k_nutrient_record.dart';
part 'nutrition/vitamin_nutrient_record.dart';
part 'nutrition/zinc_nutrient_record.dart';
part 'oxygen_saturation_record.dart';
part 'power/cycling_power_record.dart';
part 'power/power_series_record.dart';
part 'respiratory_rate_record.dart';
part 'series_health_record.dart';
part 'sexual_activity/sexual_activity_protection_used.dart';
part 'sexual_activity/sexual_activity_record.dart';
part 'sleep/sleep_session_record.dart';
part 'sleep/sleep_stage_record.dart';
part 'speed/running_speed_record.dart';
part 'speed/speed_activity_record.dart';
part 'speed/speed_series_record.dart';
part 'speed/stair_ascent_speed_record.dart';
part 'speed/stair_descent_speed_record.dart';
part 'speed/walking_speed_record.dart';
part 'steps_record.dart';
part 'temperature/basal_body_temperature_record.dart';
part 'temperature/body_temperature_record.dart';
part 'vo2_max_record.dart';
part 'waist_circumference_record.dart';
part 'weight_record.dart';
part 'wheelchair_pushes_record.dart';

/// Base class for all health records.
///
/// ## Acknowledgments
///
/// **Android Health Connect SDK**
///
/// - The base health record hierarchy design is inspired by the organizational
///   structure of the Android Health Connect SDK
/// - **Source**: https://developer.android.com/jetpack/androidx/releases/health-connect
/// - **Documentation**: https://developer.android.com/health-and-fitness/guides/health-connect
///
/// **Implementation Details:**
///
/// - All code in this file is an **original Dart implementation** written
///   specifically for Flutter
/// - No source code has been copied from Health Connect SDK (written in
///   Kotlin/Java)
/// - The design follows functional organizational patterns that are
///   industry-standard for health data categorization
/// - This is a **cross-platform abstraction layer** designed for
///   interoperability between Android and iOS health platforms
///
/// {@category Health Records}
@sinceV1_0_0
@immutable
sealed class HealthRecord implements HealthPlatformData {
  /// Creates a health record with the specified [id] and [metadata].
  const HealthRecord({required this.metadata, this.id = HealthRecordId.none});

  /// The unique identifier for this health record.
  ///
  /// For new records (not yet written to the platform), this should be
  /// [HealthRecordId.none]. The platform will assign a UUID when the record
  /// is written.
  ///
  /// For records read from the platform, this will be the platform-assigned
  /// UUID string.
  final HealthRecordId id;

  /// Metadata describing the context and origin of this health record.
  final Metadata metadata;

  /// Compares this health record to another for equality.
  @override
  bool operator ==(Object other);

  /// Returns a hash code for this health record.
  @override
  int get hashCode;

  @override
  List<HealthPlatform> get supportedHealthPlatforms =>
      dataType.supportedHealthPlatforms;

  /// The category of this health record, derived from its associated data type.
  ///
  /// Categories help organize health data into logical groups for better
  /// discoverability and filtering in UIs.
  ///
  /// ## Example
  ///
  /// ```dart
  /// final record = StepsRecord(...);
  /// print(record.category); // HealthDataTypeCategory.activity
  ///
  /// // Filter records by category
  /// final records = await healthConnector.readRecords(...);
  /// final activityRecords = records.where(
  ///   (record) => record.category == HealthDataTypeCategory.activity,
  /// );
  /// ```
  HealthDataTypeCategory get category => dataType.category;
}

/// A type-safe identifier for health records.
///
/// This value object prevents string misuse and provides clear semantics for
/// record identification.
@sinceV1_0_0
@immutable
final class HealthRecordId {
  /// Creates a health record ID from a string value.
  ///
  /// The [value] must not be empty. Throws [ArgumentError] if [value] is empty.
  ///
  /// ## Example
  ///
  /// ```dart
  /// // Valid - platform-assigned UUID
  /// final id = HealthRecordId('550e8400-e29b-41d4-a716-446655440000');
  ///
  /// // Invalid - empty string
  /// final badId = HealthRecordId(''); // Throws ArgumentError
  /// ```
  factory HealthRecordId(String value) {
    require(
      value != none.value,
      'HealthRecordId value cannot be empty. '
      'Use predefined HealthRecordId.none for new records.',
    );

    return HealthRecordId._(value);
  }

  /// Private constructor for internal use.
  ///
  /// Use [HealthRecordId] factory constructor or [HealthRecordId.none]
  /// singleton instead.
  const HealthRecordId._(this.value);

  /// The singleton instance representing no ID (for new records).
  ///
  /// Use this when creating new health records that haven't been written to
  /// the platform yet. The platform will assign an actual ID when the record
  /// is written.
  ///
  /// ## Example
  ///
  /// ```dart
  /// final newRecord = StepsRecord(
  ///   id: HealthRecordId.none, // Indicates this is a new record
  ///   // ... other fields
  /// );
  /// ```
  static const HealthRecordId none = HealthRecordId._('');

  /// The underlying ID value.
  ///
  /// For new records, this will be 'none'. For records read from the platform,
  /// this will be a platform-assigned UUID string.
  final String value;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HealthRecordId &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;
}
