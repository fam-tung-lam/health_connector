part of 'health_record.dart';

/// Represents a body weight measurement at a specific point in time.
///
/// [WeightRecord] captures the user's body weight as an instant measurement.
/// This is a point-in-time record with a single timestamp.
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: [`WeightRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/WeightRecord)
/// - **iOS HealthKit**: [`HKQuantityTypeIdentifier.bodyMass`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/bodymass)
///
/// ## Example
///
/// ```dart
/// final record = WeightRecord(
///   time: DateTime.now(),
///   weight: Mass.kilograms(72.5),
///   metadata: Metadata.manualEntry(),
/// );
/// ```
///
/// ## See also
///
/// - [WeightDataType]
///
/// {@category Health Records}
@sinceV1_0_0
@immutable
final class WeightRecord extends InstantHealthRecord {
  /// Minimum valid weight in kilograms (0.5 kg).
  ///
  /// Extremely premature infants can weigh ~500g.
  /// Minimum valid weight (0.5 kg).
  ///
  /// Extremely premature infants can weigh ~500g.
  static const Mass minWeight = Mass.kilograms(0.5);

  /// Maximum valid weight (700 kg).
  ///
  /// Exceeds the heaviest recorded person (635 kg) with margin for
  /// medical edge cases.
  static const Mass maxWeight = Mass.kilograms(700.0);

  /// Creates a body weight record.
  ///
  /// ## Parameters
  ///
  /// - [id]: The unique identifier for this record.
  /// - [time]: The timestamp when the weight was measured.
  /// - [zoneOffsetSeconds]: Optional timezone offset for the measurement time.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [weight]: The body mass measurement.
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [weight] is outside the valid range of
  /// - [ArgumentError] if [weight] is outside the valid range of
  ///   [minWeight]-[maxWeight] kg.
  ///
  /// ## Validation Rationale
  ///
  /// - **Minimum ([minWeight] kg)**: Extremely premature infants can
  ///   weigh ~500g.
  /// - **Maximum ([maxWeight] kg)**: Exceeds the heaviest recorded person
  ///   (635 kg) with margin for medical edge cases.
  WeightRecord({
    required super.time,
    required super.metadata,
    required this.weight,
    super.id,
    super.zoneOffsetSeconds,
  }) {
    require(
      condition: weight >= minWeight && weight <= maxWeight,
      value: weight,
      name: 'weight',
      message:
          'Weight must be between '
          '${minWeight.inKilograms.toStringAsFixed(1)}-'
          '${maxWeight.inKilograms.toStringAsFixed(0)} kg. '
          'Got ${weight.inKilograms.toStringAsFixed(1)} kg.',
    );
  }

  /// Internal factory for creating [WeightRecord] instances
  /// without validation.
  ///
  /// **⚠️ Warning**: Not for public use. SDK users should use the public
  /// [WeightRecord] constructor, which enforces validation.
  @internalUse
  factory WeightRecord.internal({
    required HealthRecordId id,
    required DateTime time,
    required Metadata metadata,
    required Mass weight,
    int? zoneOffsetSeconds,
  }) {
    return WeightRecord._(
      id: id,
      time: time,
      metadata: metadata,
      weight: weight,
      zoneOffsetSeconds: zoneOffsetSeconds,
    );
  }

  /// Private constructor without validation.
  const WeightRecord._({
    required super.id,
    required super.time,
    required super.metadata,
    required this.weight,
    super.zoneOffsetSeconds,
  });

  /// The body mass measurement.
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
}
