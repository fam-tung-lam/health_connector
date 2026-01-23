part of 'health_record.dart';

/// Represents a body water mass record.
///
/// This record captures the user's body water mass, which is the total weight
/// of water in the body. It is a point-in-time measurement.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: [`BodyWaterMassRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/BodyWaterMassRecord)
/// - **iOS HealthKit**: Not supported.
///
/// ## Example
///
/// ```dart
/// final record = BodyWaterMassRecord(
///   time: DateTime.now(),
///   mass: Mass.kilograms(45.0),
///   metadata: Metadata.manualEntry(),
/// );
/// ```
///
/// ## See also
///
/// - [BodyWaterMassDataType]
///
/// {@category Health Records}
@sinceV2_2_0
@supportedOnHealthConnect
@immutable
final class BodyWaterMassRecord extends InstantHealthRecord {
  /// Minimum valid body water mass in kilograms (0.3 kg).
  ///
  /// Premature infant (~0.5 kg total weight × 60% water).
  /// Minimum valid body water mass (0.3 kg).
  ///
  /// Premature infant (~0.5 kg total weight × 60% water).
  static const Mass minMass = Mass.kilograms(0.3);

  /// Maximum valid body water mass (500.0 kg).
  ///
  /// Water typically 45-75% of body weight; max for very large individuals
  /// (700 kg × 70%).
  static const Mass maxMass = Mass.kilograms(500.0);

  /// Creates a body water mass record.
  ///
  /// ## Parameters
  ///
  /// - [time]: The timestamp when the measurement was taken.
  /// - [mass]: The body water mass measurement.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [id]: The unique identifier for this record.
  /// - [zoneOffsetSeconds]: Optional timezone offset for the measurement time.
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [mass] is outside the valid range of
  /// - [ArgumentError] if [mass] is outside the valid range of
  ///   [minMass]-[maxMass] kg.
  ///
  /// ## Validation Rationale
  ///
  /// - **Minimum ([minMass] kg)**: Premature infant (~0.5 kg total
  ///   weight × 60% water).
  /// - **Maximum ([maxMass] kg)**: Water typically 45-75% of body weight;
  ///   max for very large individuals (700 kg × 70%).
  BodyWaterMassRecord({
    required super.time,
    required super.metadata,
    required this.mass,
    super.id,
    super.zoneOffsetSeconds,
  }) {
    require(
      condition: mass >= minMass && mass <= maxMass,
      value: mass,
      name: 'mass',
      message:
          'Body water mass must be between '
          '${minMass.inKilograms.toStringAsFixed(1)}-'
          '${maxMass.inKilograms.toStringAsFixed(0)} kg. '
          'Got ${mass.inKilograms.toStringAsFixed(1)} kg.',
    );
  }

  /// Internal factory for creating [BodyWaterMassRecord] instances
  /// without validation.
  ///
  /// **⚠️ Warning**: Not for public use. SDK users should use the public
  /// [BodyWaterMassRecord] constructor, which enforces validation.
  @internalUse
  factory BodyWaterMassRecord.internal({
    required HealthRecordId id,
    required DateTime time,
    required Metadata metadata,
    required Mass mass,
    int? zoneOffsetSeconds,
  }) {
    return BodyWaterMassRecord._(
      id: id,
      time: time,
      metadata: metadata,
      mass: mass,
      zoneOffsetSeconds: zoneOffsetSeconds,
    );
  }

  /// Private constructor without validation.
  BodyWaterMassRecord._({
    required super.id,
    required super.time,
    required super.metadata,
    required this.mass,
    super.zoneOffsetSeconds,
  });

  /// The body water mass measurement.
  final Mass mass;

  /// Creates a copy with the given fields replaced with the new values.
  BodyWaterMassRecord copyWith({
    DateTime? time,
    Metadata? metadata,
    Mass? mass,
    HealthRecordId? id,
    int? zoneOffsetSeconds,
  }) {
    return BodyWaterMassRecord(
      time: time ?? this.time,
      metadata: metadata ?? this.metadata,
      mass: mass ?? this.mass,
      id: id ?? this.id,
      zoneOffsetSeconds: zoneOffsetSeconds ?? this.zoneOffsetSeconds,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BodyWaterMassRecord &&
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
}
