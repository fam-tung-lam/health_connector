part of '../health_record.dart';

/// Represents a body temperature measurement at a specific point in time.
///
/// [BodyTemperatureRecord] captures the user's body temperature.
/// This is a point-in-time record with a single timestamp.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: [`BodyTemperatureRecord`](https://developer.an
/// droid.com/reference/kotlin/androidx/health/connect/client/records/BodyTemper
/// atureRecord)
/// - **iOS HealthKit**: [`HKQuantityTypeIdentifier.bodyTemperature`](https://de
/// veloper.apple.com/documentation/healthkit/hkquantitytypeidentifier/bodytempe
/// rature)
///
/// ## Example
///
/// ```dart
/// final record = BodyTemperatureRecord(
///   time: DateTime.now(),
///   temperature: Temperature.celsius(36.5),
///   metadata: Metadata.manualEntry(),
/// );
/// ```
///
/// ## See also
///
/// - [BodyTemperatureDataType]
///
/// {@category Health Records}
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
  const BodyTemperatureRecord({
    required super.time,
    required super.metadata,
    required this.temperature,
    super.id,
    super.zoneOffsetSeconds,
  });

  /// Internal factory for creating [BodyTemperatureRecord] instances
  /// without validation.
  ///
  /// Creates a [BodyTemperatureRecord] by directly mapping platform data
  /// to fields,
  /// bypassing the normal validation and business rules applied by the
  /// public constructor.
  ///
  /// **⚠️ Warning**: Not for public use. SDK users should use the public
  /// [BodyTemperatureRecord] constructor, which enforces validation and
  /// business rules.
  /// This factory is restricted to the SDK developers and contributors.
  @internalUse
  factory BodyTemperatureRecord.internal({
    required HealthRecordId id,
    required DateTime time,
    required Metadata metadata,
    required Temperature temperature,
    int? zoneOffsetSeconds,
  }) {
    return BodyTemperatureRecord._(
      id: id,
      time: time,
      metadata: metadata,
      temperature: temperature,
      zoneOffsetSeconds: zoneOffsetSeconds,
    );
  }

  const BodyTemperatureRecord._({
    required super.id,
    required super.time,
    required super.metadata,
    required this.temperature,
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
}
