part of 'health_record.dart';

/// Represents a body temperature measurement at a specific point in time.
///
/// [BodyTemperatureRecord] captures the user's body temperature.
/// This is a point-in-time record with a single timestamp.
///
/// ## Platform Mapping
///
/// - **Android**: Maps to Health Connect's `BodyTemperatureRecord`
/// - **iOS**: Maps to HealthKit's `HKQuantityTypeIdentifier.bodyTemperature`
@sinceV1_0_0
@immutable
final class BodyTemperatureRecord extends InstantHealthRecord {
  /// Creates a body temperature record.
  ///
  /// ## Parameters
  ///
  /// - [id]: The unique identifier for this record.
  /// - [time]: The timestamp when the temperature was measured.
  /// - [zoneOffsetSeconds]: Optional timezone offset for the measurement time.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [temperature]: The body temperature measurement.
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [temperature] is invalid via [Temperature]
  ///   class validation.
  const BodyTemperatureRecord({
    required super.time,
    required super.metadata,
    required this.temperature,
    super.id = HealthRecordId.none,
    super.zoneOffsetSeconds,
  });

  /// The body temperature measurement.
  ///
  /// This uses the [Temperature] unit class which supports multiple units
  /// (Celsius, Fahrenheit, Kelvin).
  final Temperature temperature;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BodyTemperatureRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          time == other.time &&
          zoneOffsetSeconds == other.zoneOffsetSeconds &&
          temperature == other.temperature &&
          metadata == other.metadata;

  @override
  int get hashCode =>
      id.hashCode ^
      time.hashCode ^
      (zoneOffsetSeconds?.hashCode ?? 0) ^
      temperature.hashCode ^
      metadata.hashCode;

  @override
  String get name => 'body_temperature_record';

  @override
  List<HealthPlatform> get supportedHealthPlatforms => HealthPlatform.values;
}
