import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_core/src/models/health_data_types/health_data_type.dart';
import 'package:health_connector_core/src/models/health_platform_data.dart'
    show HealthPlatformData;
import 'package:health_connector_core/src/utils/collection.dart';
import 'package:health_connector_core/src/utils/health_record_data_type_extension.dart';
import 'package:meta/meta.dart' show immutable, internal;

part 'active_calories_burned_record.dart';
part 'blood_glucose_record.dart';
part 'blood_pressure_records/blood_pressure_record.dart';
part 'blood_pressure_records/diastolic_blood_pressure_record.dart';
part 'blood_pressure_records/systolic_blood_pressure_record.dart';
part 'body_fat_percentage_record.dart';
part 'body_temperature_record.dart';
part 'cervical_mucus/cervical_mucus_appearance_type.dart';
part 'cervical_mucus/cervical_mucus_record.dart';
part 'cervical_mucus/cervical_mucus_sensation_type.dart';
part 'distance_records/cross_country_skiing_distance_record.dart';
part 'distance_records/cycling_distance_record.dart';
part 'distance_records/distance_activity_record.dart';
part 'distance_records/distance_record.dart';
part 'distance_records/downhill_snow_sports_distance_record.dart';
part 'distance_records/paddle_sports_distance_record.dart';
part 'distance_records/rowing_distance_record.dart';
part 'distance_records/six_minute_walk_test_distance_record.dart';
part 'distance_records/skating_sports_distance_record.dart';
part 'distance_records/swimming_distance_record.dart';
part 'distance_records/walking_running_distance_record.dart';
part 'distance_records/wheelchair_distance_record.dart';
part 'exercise_records/exercise_session_record.dart';
part 'exercise_records/exercise_type.dart';
part 'floors_climbed_record.dart';
part 'heart_rate_measurement_record.dart';
part 'heart_rate_series_record.dart';
part 'height_record.dart';
part 'hydration_record.dart';
part 'instant_health_record.dart';
part 'interval_health_record.dart';
part 'lean_body_mass_record.dart';
// Vitamin nutrient records
part 'nutrition_records/biotin_nutrient_record.dart';
part 'nutrition_records/caffeine_nutrient_record.dart';
// Mineral nutrient records
part 'nutrition_records/calcium_nutrient_record.dart';
// Macronutrient records
part 'nutrition_records/cholesterol_nutrient_record.dart';
part 'nutrition_records/dietary_fiber_nutrient_record.dart';
part 'nutrition_records/energy_nutrient_record.dart';
part 'nutrition_records/folate_nutrient_record.dart';
part 'nutrition_records/iron_nutrient_record.dart';
part 'nutrition_records/macronutrient_record.dart';
part 'nutrition_records/magnesium_nutrient_record.dart';
part 'nutrition_records/manganese_nutrient_record.dart';
part 'nutrition_records/meal_type.dart';
part 'nutrition_records/mineral_nutrient_records.dart';
part 'nutrition_records/monounsaturated_fat_nutrient_record.dart';
part 'nutrition_records/niacin_nutrient_record.dart';
part 'nutrition_records/nutrient_record.dart';
part 'nutrition_records/nutrition_record.dart';
part 'nutrition_records/pantothenic_acid_nutrient_record.dart';
part 'nutrition_records/phosphorus_nutrient_record.dart';
part 'nutrition_records/polyunsaturated_fat_nutrient_record.dart';
part 'nutrition_records/potassium_nutrient_record.dart';
part 'nutrition_records/protein_nutrient_record.dart';
part 'nutrition_records/riboflavin_nutrient_record.dart';
part 'nutrition_records/saturated_fat_nutrient_record.dart';
part 'nutrition_records/selenium_nutrient_record.dart';
part 'nutrition_records/sodium_nutrient_record.dart';
part 'nutrition_records/sugar_nutrient_record.dart';
part 'nutrition_records/thiamin_nutrient_record.dart';
part 'nutrition_records/total_carbohydrate_nutrient_record.dart';
part 'nutrition_records/total_fat_nutrient_record.dart';
part 'nutrition_records/vitamin_a_nutrient_record.dart';
part 'nutrition_records/vitamin_b12_nutrient_record.dart';
part 'nutrition_records/vitamin_b6_nutrient_record.dart';
part 'nutrition_records/vitamin_c_nutrient_record.dart';
part 'nutrition_records/vitamin_d_nutrient_record.dart';
part 'nutrition_records/vitamin_e_nutrient_record.dart';
part 'nutrition_records/vitamin_k_nutrient_record.dart';
part 'nutrition_records/vitamin_nutrient_record.dart';
part 'nutrition_records/zinc_nutrient_record.dart';
part 'oxygen_saturation_record.dart';
part 'power_records/cycling_power_record.dart';
part 'power_records/power_series_record.dart';
part 'respiratory_rate_record.dart';
part 'resting_heart_rate_record.dart';
part 'series_health_record.dart';
part 'sexual_activity/sexual_activity_protection_used_type.dart';
part 'sexual_activity/sexual_activity_record.dart';
part 'sleep_records/sleep_session_record.dart';
part 'sleep_records/sleep_stage_record.dart';
part 'mindfulness_records/mindfulness_session_record.dart';
part 'mindfulness_records/mindfulness_session_type.dart';
part 'speed_records/running_speed_record.dart';
part 'speed_records/speed_activity_record.dart';
part 'speed_records/speed_series_record.dart';
part 'speed_records/stair_ascent_speed_record.dart';
part 'speed_records/stair_descent_speed_record.dart';
part 'speed_records/walking_speed_record.dart';
part 'steps_record.dart';
part 'vo2_max_record.dart';
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
  /// Example:
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
  /// Example:
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
