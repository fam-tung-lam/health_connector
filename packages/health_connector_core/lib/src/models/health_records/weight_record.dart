part of 'health_record.dart';

/// Represents a body weight measurement at a specific point in time.
///
/// [WeightRecord] captures the user's body weight as an instant measurement.
/// This is a point-in-time record with a single timestamp.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: `WeightRecord`
/// - **iOS HealthKit**: `HKQuantityType(.bodyMass)`
///
/// ## Example
///
/// ```dart
/// final record = WeightRecord(
///   time: DateTime.now(),
///   weight: Mass.kilograms(72.5),
///   metadata: Metadata.manualEntry(
///     dataOrigin: DataOrigin(packageName: 'com.example.app'),
///   ),
/// );
/// ```
@sinceV1_0_0
@immutable
final class WeightRecord extends InstantHealthRecord {
  /// Creates a body weight record.
  ///
  /// ## Parameters
  ///
  /// - [id]: The unique identifier for this record.
  /// - [time]: The timestamp when the weight was measured.
  /// - [zoneOffsetSeconds]: Optional timezone offset for the measurement time.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [weight]: The body weight measurement.
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [weight] is negative (via Mass class validation).
  const WeightRecord({
    required super.time,
    required super.metadata,
    required this.weight,
    super.id = HealthRecordId.none,
    super.zoneOffsetSeconds,
  });

  /// The body weight measurement.
  ///
  /// This uses the [Mass] unit class which supports multiple units
  /// (kilograms, grams, pounds, ounces).
  final Mass weight;

  /// Creates a copy with the given fields replaced with the new values.
  WeightRecord copyWith({
    DateTime? time,
    Mass? weight,
    Metadata? metadata,
    HealthRecordId? id,
    int? zoneOffsetSeconds,
  }) {
    return WeightRecord(
      time: time ?? this.time,
      weight: weight ?? this.weight,
      metadata: metadata ?? this.metadata,
      id: id ?? this.id,
      zoneOffsetSeconds: zoneOffsetSeconds ?? this.zoneOffsetSeconds,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeightRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          time == other.time &&
          zoneOffsetSeconds == other.zoneOffsetSeconds &&
          weight == other.weight &&
          metadata == other.metadata;

  @override
  int get hashCode =>
      id.hashCode ^
      time.hashCode ^
      (zoneOffsetSeconds?.hashCode ?? 0) ^
      weight.hashCode ^
      metadata.hashCode;

  @override
  List<HealthPlatform> get supportedHealthPlatforms => HealthPlatform.values;
}
