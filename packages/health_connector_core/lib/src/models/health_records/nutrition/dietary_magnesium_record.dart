part of '../health_record.dart';

/// Represents a magnesium measurement from food at a specific point in time.
///
/// [DietaryMagnesiumRecord] captures the magnesium content consumed from food.
/// This is an iOS-specific record for tracking individual magnesium intake.
///
/// ## Platform Mapping
///
/// - **iOS HealthKit Only**: [`HKQuantityTypeIdentifier.dietaryMagnesium`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietarymagnesium)
/// - **Android Health Connect**: Part of [`NutritionRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord)
///
/// ## Example
///
/// ```dart
/// final record = DietaryMagnesiumRecord(
///   time: DateTime.now(),
///   mass: Mass.milligrams(80),
///   foodName: 'Almonds',
///   mealType: MealType.snack,
///   metadata: Metadata.manualEntry(),
/// );
/// ```
///
/// ## See also
///
/// - [DietaryMagnesiumDataType]
///
/// {@category Health Records}
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class DietaryMagnesiumRecord extends DietaryMineralRecord {
  /// Creates a magnesium nutrient record.
  ///
  /// ## Parameters
  ///
  /// - [mass]: The magnesium measurement.
  /// - [time]: The timestamp when the magnesium was consumed.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [id]: The unique identifier for this record.
  /// - [zoneOffsetSeconds]: Optional timezone offset for the measurement time.
  /// - [foodName]: Optional name of the food containing this magnesium.
  /// - [mealType]: The type of meal (breakfast, lunch, dinner, snack, unknown).
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [mass] is outside the valid range of
  ///   [minMass]-[maxMass] g.
  ///
  /// ## Validation Rationale
  ///
  /// - **Minimum ([minMass] g)**: Valid mass must be non-negative.
  /// - **Maximum ([maxMass] g)**: 100g is a reasonable upper bound for
  ///   mineral intake from a single food item.
  DietaryMagnesiumRecord({
    required super.mass,
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
          'Magnesium mass must be between '
          '${minMass.inGrams.toStringAsFixed(0)}-'
          '${maxMass.inGrams.toStringAsFixed(0)} g. '
          'Got ${mass.inGrams.toStringAsFixed(3)} g.',
    );
  }

  /// Minimum valid magnesium mass (0.0 g).
  static const Mass minMass = Mass.zero;

  /// Maximum valid magnesium mass (100.0 g).
  static const Mass maxMass = Mass.grams(100.0);

  ///
  /// **⚠️ Warning**: Not for public use. SDK users should use the public
  /// [DietaryMagnesiumRecord] constructor, which enforces validation and
  /// business
  /// rules. This factory is restricted to the SDK developers and contributors.
  @internalUse
  factory DietaryMagnesiumRecord.internal({
    required Mass mass,
    required DateTime time,
    required Metadata metadata,
    HealthRecordId id = HealthRecordId.none,
    int? zoneOffsetSeconds,
    String? foodName,
    MealType mealType = MealType.unknown,
  }) {
    return DietaryMagnesiumRecord(
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
  DietaryMagnesiumRecord copyWith({
    Mass? mass,
    DateTime? time,
    Metadata? metadata,
    HealthRecordId? id,
    int? zoneOffsetSeconds,
    String? foodName,
    MealType? mealType,
  }) {
    return DietaryMagnesiumRecord(
      mass: mass ?? this.mass,
      time: time ?? this.time,
      metadata: metadata ?? this.metadata,
      id: id ?? this.id,
      zoneOffsetSeconds: zoneOffsetSeconds ?? this.zoneOffsetSeconds,
      foodName: foodName ?? this.foodName,
      mealType: mealType ?? this.mealType,
    );
  }
}
