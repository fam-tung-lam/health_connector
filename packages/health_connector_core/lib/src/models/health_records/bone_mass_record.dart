part of 'health_record.dart';

/// Represents a bone mass record.
///
/// This record captures the user's bone mass, which is the total weight of bone
/// in the body. It is a point-in-time measurement.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: [`BoneMassRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/BoneMassRecord)
///
/// ## Example
///
/// ```dart
/// final record = BoneMassRecord(
///   time: DateTime.now(),
///   mass: Mass.kilograms(12.5),
///   metadata: Metadata.manualEntry(),
/// );
/// ```
///
/// ## See also
///
/// - [BoneMassDataType]
///
/// {@category Health Records}
@sinceV2_2_0
@supportedOnHealthConnect
@immutable
final class BoneMassRecord extends InstantHealthRecord {
  /// Minimum valid bone mass in kilograms (0.1 kg).
  ///
  /// Very young infants; typical newborn skeleton ~300-400g.
  /// Minimum valid bone mass (0.1 kg).
  ///
  /// Very young infants; typical newborn skeleton ~300-400g.
  static const Mass minMass = Mass.kilograms(0.1);

  /// Maximum valid bone mass (15.0 kg).
  ///
  /// Extreme upper limit; typical adult bone mass 2-6 kg depending on body
  /// size.
  static const Mass maxMass = Mass.kilograms(15.0);

  /// Creates a bone mass record.
  ///
  /// ## Parameters
  ///
  /// - [time]: The timestamp when the measurement was taken.
  /// - [mass]: The bone mass measurement.
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
  /// - **Minimum ([minMass] kg)**: Very young infants; typical newborn
  ///   skeleton ~300-400g.
  /// - **Maximum ([maxMass] kg)**: Extreme upper limit; typical adult bone
  ///   mass 2-6 kg depending on body size.
  BoneMassRecord({
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
          'Bone mass must be between '
          '${minMass.inKilograms.toStringAsFixed(1)}-'
          '${maxMass.inKilograms.toStringAsFixed(0)} kg. '
          'Got ${mass.inKilograms.toStringAsFixed(1)} kg.',
    );
  }

  /// Internal factory for creating [BoneMassRecord] instances
  /// without validation.
  ///
  /// Creates a [BoneMassRecord] by directly mapping platform data
  /// to fields,
  /// bypassing the normal validation and business rules applied by the
  /// public constructor.
  ///
  /// **⚠️ Warning**: Not for public use. SDK users should use the public
  /// [BoneMassRecord] constructor, which enforces validation and
  /// business rules.
  /// This factory is restricted to the SDK developers and contributors.
  @internalUse
  factory BoneMassRecord.internal({
    required HealthRecordId id,
    required DateTime time,
    required Metadata metadata,
    required Mass mass,
    int? zoneOffsetSeconds,
  }) {
    return BoneMassRecord._(
      id: id,
      time: time,
      metadata: metadata,
      mass: mass,
      zoneOffsetSeconds: zoneOffsetSeconds,
    );
  }

  /// Private constructor without validation.
  const BoneMassRecord._({
    required super.id,
    required super.time,
    required super.metadata,
    required this.mass,
    super.zoneOffsetSeconds,
  });

  /// The bone mass measurement.
  final Mass mass;

  /// Creates a copy with the given fields replaced with the new values.
  BoneMassRecord copyWith({
    DateTime? time,
    Metadata? metadata,
    Mass? mass,
    HealthRecordId? id,
    int? zoneOffsetSeconds,
  }) {
    return BoneMassRecord(
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
      other is BoneMassRecord &&
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
