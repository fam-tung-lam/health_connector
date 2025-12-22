part of 'health_record.dart';

/// Represents a body temperature measurement at a specific point in time.
///
/// [BodyTemperatureRecord] captures the user's body temperature.
/// This is a point-in-time record with a single timestamp.
///
/// ## Platform Mapping
///
/// - **Android (Health Connect)**: `BodyTemperatureRecord`
/// - **iOS (HealthKit)**: `HKQuantityTypeIdentifier.bodyTemperature`
///
/// ## Example
///
/// ```dart
/// final record = BodyTemperatureRecord(
///   time: DateTime.now(),
///   temperature: Temperature.celsius(36.5),
///   metadata: Metadata.manualEntry(
///     dataOrigin: DataOrigin(packageName: 'com.example.app'),
///   ),
/// );
/// ```
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

  /// Creates a copy with the given fields replaced with the new values.
  BodyTemperatureRecord copyWith({
    DateTime? time,
    Temperature? temperature,
    Metadata? metadata,
    HealthRecordId? id,
    int? zoneOffsetSeconds,
  }) {
    return BodyTemperatureRecord(
      time: time ?? this.time,
      temperature: temperature ?? this.temperature,
      metadata: metadata ?? this.metadata,
      id: id ?? this.id,
      zoneOffsetSeconds: zoneOffsetSeconds ?? this.zoneOffsetSeconds,
    );
  }

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
  List<HealthPlatform> get supportedHealthPlatforms => HealthPlatform.values;
}
