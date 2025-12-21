part of 'health_record.dart';

/// Represents a lean body mass measurement at a specific point in time.
///
/// [LeanBodyMassRecord] captures the user's lean body mass as an instant
/// measurement. Lean body mass is the total weight of the body minus the
/// weight of body fat. This is a point-in-time record with a single timestamp.
///
/// ## Platform Mapping
///
/// - **Android**: Maps to Health Connect's `LeanBodyMassRecord`
/// - **iOS**: Maps to HealthKit's `HKQuantityType(.leanBodyMass)`
@sinceV1_0_0
@immutable
final class LeanBodyMassRecord extends InstantHealthRecord {
  /// Creates a lean body mass record.
  ///
  /// ## Parameters
  ///
  /// - [id]: The unique identifier for this record.
  /// - [time]: The timestamp when the lean body mass was measured.
  /// - [zoneOffsetSeconds]: Optional timezone offset for the measurement time.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [mass]: The lean body mass measurement.
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [mass] is negative (via Mass class validation).
  const LeanBodyMassRecord({
    required super.time,
    required super.metadata,
    required this.mass,
    super.id = HealthRecordId.none,
    super.zoneOffsetSeconds,
  });

  /// The lean body mass measurement.
  ///
  /// This uses the [Mass] unit class which supports multiple units
  /// (kilograms, grams, pounds, ounces).
  final Mass mass;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LeanBodyMassRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          time == other.time &&
          zoneOffsetSeconds == other.zoneOffsetSeconds &&
          mass == other.mass &&
          metadata == other.metadata;

  @override
  int get hashCode =>
      id.hashCode ^
      time.hashCode ^
      (zoneOffsetSeconds?.hashCode ?? 0) ^
      mass.hashCode ^
      metadata.hashCode;

  @override
  String get name => 'lean_body_mass_record';

  @override
  List<HealthPlatform> get supportedHealthPlatforms => HealthPlatform.values;
}
