import 'package:health_connector_annotation/health_connector_annotation.dart'
    show sinceV1_0_0;
import 'package:health_connector_core/src/models/health_platform.dart'
    show HealthPlatform;
import 'package:health_connector_core/src/models/health_platform_data.dart'
    show HealthPlatformData;
import 'package:health_connector_core/src/models/measurement_units/measurement_unit.dart'
    show Energy, Length, Mass, Numeric, Percentage, Temperature, Volume;
import 'package:health_connector_core/src/models/metadata/metadata.dart'
    show Metadata;
import 'package:health_connector_core/src/utils/datetime.dart'
    show formatTimeRange;
import 'package:health_connector_core/src/utils/validation.dart' show require;
import 'package:meta/meta.dart' show immutable;

part 'active_calories_burned_record.dart';
part 'body_fat_percentage_record.dart';
part 'body_temperature_record.dart';
part 'distance_record.dart';
part 'floors_climbed_record.dart';
part 'height_record.dart';
part 'hydration_record.dart';
part 'instant_health_record.dart';
part 'interval_health_record.dart';
part 'lean_body_mass_record.dart';
part 'series_health_record.dart';
part 'step_record.dart';
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

  /// Returns a string representation of this health record.
  @override
  String toString();
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
      value.isNotEmpty,
      'HealthRecordId value cannot be empty. '
      'Use HealthRecordId.none for new records.',
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
  /// final newRecord = StepRecord(
  ///   id: HealthRecordId.none, // Indicates this is a new record
  ///   // ... other fields
  /// );
  /// ```
  static const HealthRecordId none = HealthRecordId._('none');

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

  @override
  String toString() => value;
}
