part of '../health_record.dart';

/// Represents a caffeine measurement from food at a specific point in time.
///
/// [DietaryCaffeineRecord] captures the caffeine content consumed from food.
/// This is an iOS-specific record for tracking individual caffeine intake.
///
/// ## Platform Mapping
///
/// - **iOS HealthKit Only**: [`HKQuantityTypeIdentifier.dietaryCaffeine`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietarycaffeine)
/// - **Android Health Connect**: Part of [`NutritionRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord)
///
/// ## Example
///
/// ```dart
/// final record = DietaryCaffeineRecord(
///   time: DateTime.now(),
///   mass: Mass.milligrams(95),
///   foodName: 'Coffee',
///   mealType: MealType.breakfast,
///   metadata: Metadata.manualEntry(),
/// );
/// ```
///
/// ## See also
///
/// - [DietaryCaffeineDataType]
///
/// {@category Health Records}
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class DietaryCaffeineRecord extends NutrientRecord<Mass> {
  /// Creates a caffeine nutrient record.
  ///
  /// ## Parameters
  ///
  ///
  /// - [mass]: The caffeine measurement.
  /// - [time]: The timestamp when the caffeine was consumed.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [id]: The unique identifier for this record.
  /// - [zoneOffsetSeconds]: Optional timezone offset for the measurement time.
  /// - [foodName]: Optional name of the food containing this caffeine.
  /// - [mealType]: The type of meal (breakfast, lunch, dinner, snack, unknown).
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [mass] is outside the valid range of
  ///   [minMass]-[maxMass].
  ///
  /// ## Validation Rationale
  ///
  /// - **Minimum ([minMass])**: Valid mass must be non-negative.
  /// - **Maximum ([maxMass])**: 10g is a reasonable upper bound for
  ///   caffeine intake from a single food item.
  DietaryCaffeineRecord({
    required this.mass,
    required super.time,
    required super.metadata,
    super.id = HealthRecordId.none,
    super.zoneOffsetSeconds,
    super.foodName,
    super.mealType,
  }) {
    require(
      condition: mass >= minMass && mass <= maxMass,
      value: mass,
      name: 'mass',
      message:
          'Caffeine mass must be between '
          '${minMass.inGrams.toStringAsFixed(0)}-'
          '${maxMass.inGrams.toStringAsFixed(0)} g. '
          'Got ${mass.inGrams.toStringAsFixed(4)} g.',
    );
  }

  /// Internal factory for creating [DietaryCaffeineRecord] instances without
  /// validation.
  ///
  /// **⚠️ Warning**: Not for public use. SDK users should use the public
  /// [DietaryCaffeineRecord] constructor, which enforces validation and
  /// business
  /// rules.
  @internalUse
  factory DietaryCaffeineRecord.internal({
    required Mass mass,
    required DateTime time,
    required Metadata metadata,
    HealthRecordId id = HealthRecordId.none,
    int? zoneOffsetSeconds,
    String? foodName,
    MealType mealType = MealType.unknown,
  }) {
    return DietaryCaffeineRecord(
      mass: mass,
      time: time,
      metadata: metadata,
      id: id,
      zoneOffsetSeconds: zoneOffsetSeconds,
      foodName: foodName,
      mealType: mealType,
    );
  }

  /// Creates a copy with the given fields replaced with the new values.
  DietaryCaffeineRecord copyWith({
    Mass? mass,
    DateTime? time,
    Metadata? metadata,
    HealthRecordId? id,
    int? zoneOffsetSeconds,
    String? foodName,
    MealType? mealType,
  }) {
    return DietaryCaffeineRecord(
      mass: mass ?? this.mass,
      time: time ?? this.time,
      metadata: metadata ?? this.metadata,
      id: id ?? this.id,
      zoneOffsetSeconds: zoneOffsetSeconds ?? this.zoneOffsetSeconds,
      foodName: foodName ?? this.foodName,
      mealType: mealType ?? this.mealType,
    );
  }

  /// The caffeine measurement.
  final Mass mass;

  /// Minimum valid caffeine mass (0.0 g).
  static const Mass minMass = Mass.zero;

  /// Maximum valid caffeine mass (10.0 g).
  static const Mass maxMass = Mass.grams(10.0);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is DietaryCaffeineRecord &&
          (mass.inGrams - other.mass.inGrams).abs() < 1e-6;

  @override
  int get hashCode => super.hashCode ^ mass.hashCode;
}
