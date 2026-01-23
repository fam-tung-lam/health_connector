part of 'health_record.dart';

/// Represents a body mass index (BMI) measurement at a specific point in time.
///
/// Body Mass Index is a value derived from the mass and height of a person.
/// The BMI is defined as the body mass divided by the square of the body
/// height.
///
/// ## Platform Mapping
///
/// - Android (Health Connect): Not supported
/// - iOS (HealthKit): [`HKQuantityTypeIdentifier.bodyMassIndex`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/bodymassindex)
///
/// ## Example
///
/// ```dart
/// final record = BodyMassIndexRecord(
///   time: DateTime.now(),
///   bmi: Number(22.5),
///   metadata: Metadata.manualEntry(),
/// );
/// ```
///
/// ## See also
///
/// - [BodyMassIndexDataType]
///
/// {@category Health Records}
@sinceV2_2_0
@supportedOnAppleHealth
@immutable
final class BodyMassIndexRecord extends InstantHealthRecord {
  /// Minimum valid BMI (5.0 kg/m²).
  ///
  /// Severe malnutrition threshold (life-threatening below ~10 kg/m²).
  static const Number minBmi = Number(5.0);

  /// Maximum valid BMI (100.0 kg/m²).
  ///
  /// Extreme obesity (typical max ~85 kg/m² in medical literature).
  static const Number maxBmi = Number(100.0);

  /// Creates a body mass index record.
  ///
  /// ## Parameters
  ///
  /// - [id]: The unique identifier for this record.
  /// - [time]: The timestamp when the BMI was measured.
  /// - [zoneOffsetSeconds]: Optional timezone offset for the measurement time.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [bmi]: The BMI value (kg/m^2).
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [bmi] is outside the valid range of
  ///   [minBmi]-[maxBmi] kg/m².
  ///
  /// ## Validation Rationale
  ///
  /// - **Minimum ([minBmi] kg/m²)**: Severe malnutrition threshold (life-threatening
  ///   below ~10 kg/m²).
  /// - **Maximum ([maxBmi] kg/m²)**: Extreme obesity (typical max ~85 kg/m²
  ///   in medical literature).
  BodyMassIndexRecord({
    required super.time,
    required super.metadata,
    required this.bmi,
    super.id = HealthRecordId.none,
    super.zoneOffsetSeconds,
  }) {
    require(
      condition: bmi >= minBmi && bmi <= maxBmi,
      value: bmi,
      name: 'bmi',
      message:
          'BMI must be between ${minBmi.value}-${maxBmi.value} kg/m². Got '
          '${bmi.value.toStringAsFixed(1)} kg/m².',
    );
  }

  /// Internal factory for creating [BodyMassIndexRecord] instances
  /// without validation.
  ///
  /// **⚠️ Warning**: Not for public use.
  @internalUse
  factory BodyMassIndexRecord.internal({
    required HealthRecordId id,
    required DateTime time,
    required Metadata metadata,
    required Number bmi,
    int? zoneOffsetSeconds,
  }) {
    return BodyMassIndexRecord._(
      id: id,
      time: time,
      metadata: metadata,
      bmi: bmi,
      zoneOffsetSeconds: zoneOffsetSeconds,
    );
  }

  /// Private constructor without validation.
  BodyMassIndexRecord._({
    required super.time,
    required super.metadata,
    required this.bmi,
    super.id = HealthRecordId.none,
    super.zoneOffsetSeconds,
  });

  /// The body mass index value (kg/m^2).
  final Number bmi;

  /// Creates a copy with the given fields replaced with the new values.
  BodyMassIndexRecord copyWith({
    DateTime? time,
    Number? bmi,
    Metadata? metadata,
    HealthRecordId? id,
    int? zoneOffsetSeconds,
  }) {
    return BodyMassIndexRecord(
      time: time ?? this.time,
      bmi: bmi ?? this.bmi,
      metadata: metadata ?? this.metadata,
      id: id ?? this.id,
      zoneOffsetSeconds: zoneOffsetSeconds ?? this.zoneOffsetSeconds,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BodyMassIndexRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          time == other.time &&
          zoneOffsetSeconds == other.zoneOffsetSeconds &&
          bmi == other.bmi &&
          metadata == other.metadata;

  @override
  int get hashCode =>
      id.hashCode ^
      time.hashCode ^
      (zoneOffsetSeconds?.hashCode ?? 0) ^
      bmi.hashCode ^
      metadata.hashCode;
}
