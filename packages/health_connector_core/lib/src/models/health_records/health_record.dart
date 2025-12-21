import 'package:health_connector_core/health_connector_core.dart'
    show sinceV1_1_0, sinceV1_4_0;
import 'package:health_connector_core/src/annotations/annotations.dart'
    show
        PlatformSpecificBehaviors,
        sinceV1_0_0,
        sinceV1_2_0,
        sinceV1_3_0,
        supportedOnAppleHealth,
        supportedOnHealthConnect;
import 'package:health_connector_core/src/annotations/internal_use.dart';
import 'package:health_connector_core/src/models/health_platform.dart'
    show HealthPlatform;
import 'package:health_connector_core/src/models/health_platform_data.dart'
    show HealthPlatformData;
import 'package:health_connector_core/src/models/health_records/blood_pressure_records/blood_pressure_body_position.dart'
    show BloodPressureBodyPosition;
import 'package:health_connector_core/src/models/health_records/blood_pressure_records/blood_pressure_measurement_location.dart'
    show BloodPressureMeasurementLocation;
import 'package:health_connector_core/src/models/health_records/heart_rate_measurement.dart'
    show HeartRateMeasurement;
import 'package:health_connector_core/src/models/health_records/sleep_stage_type.dart'
    show SleepStageType;
import 'package:health_connector_core/src/models/measurement_units/measurement_unit.dart'
    show
        BloodGlucose,
        Number,
        Energy,
        Length,
        Mass,
        MeasurementUnit,
        Percentage,
        Pressure,
        Temperature,
        Volume;
import 'package:health_connector_core/src/models/metadata/metadata.dart'
    show Metadata;
import 'package:health_connector_core/src/utils/collection.dart';

import 'package:health_connector_core/src/utils/validation.dart' show require;
import 'package:meta/meta.dart' show immutable, internal;

part 'active_calories_burned_record.dart';
part 'blood_glucose_record.dart';
part 'blood_pressure_records/blood_pressure_record.dart';
part 'blood_pressure_records/diastolic_blood_pressure_record.dart';
part 'blood_pressure_records/systolic_blood_pressure_record.dart';
part 'body_fat_percentage_record.dart';
part 'body_temperature_record.dart';
part 'distance_record.dart';
part 'floors_climbed_record.dart';
part 'heart_rate_measurement_record.dart';
part 'heart_rate_series_record.dart';
part 'height_record.dart';
part 'hydration_record.dart';
part 'instant_health_record.dart';
part 'interval_health_record.dart';
part 'lean_body_mass_record.dart';
part 'nutrient_health_records/macronutrient_health_records.dart';
part 'nutrient_health_records/meal_type.dart';
part 'nutrient_health_records/mineral_nutrient_health_records.dart';
part 'nutrient_health_records/nutrient_health_record.dart';
part 'nutrient_health_records/nutrition_record.dart';
part 'nutrient_health_records/vitamin_nutrient_health_records.dart';
part 'oxygen_saturation_record.dart';
part 'respiratory_rate_record.dart';
part 'resting_heart_rate_record.dart';
part 'series_health_record.dart';
part 'sleep_session_record.dart';
part 'sleep_stage_record.dart';
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
/// - The health record hierarchy design (HealthRecord → Interval/Instant/Series →
///   Specific Records) is inspired by the organizational structure of
///   the Android Health Connect SDK
/// - **Source**: https://developer.android.com/jetpack/androidx/releases/health-connect
/// - **Documentation**: https://developer.android.com/health-and-fitness/guides/health-connect
///
/// **Implementation Details:**
///
/// - All code in this file is an **original Dart implementation** written
///   specifically for Flutter
/// - No source code has been copied from Health Connect SDK (written in Kotlin/Java)
/// - The design follows functional organizational patterns that are
///   industry-standard for health data categorization
/// - This is a **cross-platform abstraction layer** designed for
///   interoperability between Android and iOS health platforms
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
