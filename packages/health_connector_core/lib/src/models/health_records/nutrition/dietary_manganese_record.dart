part of '../health_record.dart';

/// Represents a manganese measurement from food at a specific point in time.
///
/// [DietaryManganeseRecord] captures the manganese content consumed from food.
/// This is an iOS-specific record for tracking individual manganese intake.
///
/// ## Platform Mapping
///
/// - **iOS HealthKit Only**: [`HKQuantityTypeIdentifier.dietaryManganese`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietarymanganese)
/// - **Android Health Connect**: Part of [`NutritionRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord)
///
/// ## Example
///
/// ```dart
/// final record = DietaryManganeseRecord(
///   time: DateTime.now(),
///   mass: Mass.milligrams(1.5),
///   foodName: 'Oats',
///   mealType: MealType.breakfast,
///   metadata: Metadata.manualEntry(),
/// );
/// ```
///
/// ## See also
///
/// - [DietaryManganeseDataType]
///
/// {@category Health Records}
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class DietaryManganeseRecord extends DietaryMineralRecord {
  /// Creates a manganese nutrient record.
  ///
  /// ## Parameters
  ///
  /// - [mass]: The manganese measurement.
  /// - [time]: The timestamp when the manganese was consumed.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [id]: The unique identifier for this record.
  /// - [zoneOffsetSeconds]: Optional timezone offset for the measurement time.
  /// - [foodName]: Optional name of the food containing this manganese.
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
  DietaryManganeseRecord({
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
          'Manganese mass must be between '
          '${minMass.inGrams.toStringAsFixed(0)}-'
          '${maxMass.inGrams.toStringAsFixed(0)} g. '
          'Got ${mass.inGrams.toStringAsFixed(3)} g.',
    );
  }

  /// Minimum valid manganese mass (0.0 g).
  static const Mass minMass = Mass.zero;

  /// Maximum valid manganese mass (100.0 g).
  static const Mass maxMass = Mass.grams(100.0);

  ///
  /// **⚠️ Warning**: Not for public use. SDK users should use the public
  /// [DietaryManganeseRecord] constructor, which enforces validation and
  /// business
  /// rules. This factory is restricted to the SDK developers and contributors.
  @internalUse
  factory DietaryManganeseRecord.internal({
    required Mass mass,
    required DateTime time,
    required Metadata metadata,
    HealthRecordId id = HealthRecordId.none,
    int? zoneOffsetSeconds,
    String? foodName,
    MealType mealType = MealType.unknown,
  }) {
    return DietaryManganeseRecord(
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
  DietaryManganeseRecord copyWith({
    Mass? mass,
    DateTime? time,
    Metadata? metadata,
    HealthRecordId? id,
    int? zoneOffsetSeconds,
    String? foodName,
    MealType? mealType,
  }) {
    return DietaryManganeseRecord(
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
