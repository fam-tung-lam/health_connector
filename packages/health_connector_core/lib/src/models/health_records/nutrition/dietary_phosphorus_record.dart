part of '../health_record.dart';

/// Represents a phosphorus measurement from food at a specific point in time.
///
/// [DietaryPhosphorusRecord] captures the phosphorus content consumed from
/// food.
/// This is an iOS-specific record for tracking individual phosphorus intake.
///
/// ## Platform Mapping
///
/// - **iOS HealthKit Only**: [`HKQuantityTypeIdentifier.dietaryPhosphorus`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryphosphorus)
/// - **Android Health Connect**: Part of [`NutritionRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord)
///
/// ## Example
///
/// ```dart
/// final record = DietaryPhosphorusRecord(
///   time: DateTime.now(),
///   mass: Mass.milligrams(200),
///   foodName: 'Chicken',
///   mealType: MealType.dinner,
///   metadata: Metadata.manualEntry(),
/// );
/// ```
///
/// ## See also
///
/// - [DietaryPhosphorusDataType]
///
/// {@category Health Records}
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class DietaryPhosphorusRecord extends DietaryMineralRecord {
  /// Creates a phosphorus nutrient record.
  ///
  /// ## Parameters
  ///
  /// - [mass]: The phosphorus measurement.
  /// - [time]: The timestamp when the phosphorus was consumed.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [id]: The unique identifier for this record.
  /// - [zoneOffsetSeconds]: Optional timezone offset for the measurement time.
  /// - [foodName]: Optional name of the food containing this phosphorus.
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
  /// - **Maximum ([maxMass])**: 100g is a reasonable upper bound for
  ///   mineral intake from a single food item.
  DietaryPhosphorusRecord({
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
          'Phosphorus mass must be between '
          '${minMass.inGrams.toStringAsFixed(0)}-'
          '${maxMass.inGrams.toStringAsFixed(0)} g. '
          'Got ${mass.inGrams.toStringAsFixed(3)} g.',
    );
  }

  /// Minimum valid phosphorus mass (0.0 g).
  static const Mass minMass = Mass.zero;

  /// Maximum valid phosphorus mass (100.0 g).
  static const Mass maxMass = Mass.grams(100.0);

  ///
  /// **⚠️ Warning**: Not for public use. SDK users should use the public
  /// [DietaryPhosphorusRecord] constructor, which enforces validation and
  /// business
  /// rules.
  @internalUse
  factory DietaryPhosphorusRecord.internal({
    required Mass mass,
    required DateTime time,
    required Metadata metadata,
    HealthRecordId id = HealthRecordId.none,
    int? zoneOffsetSeconds,
    String? foodName,
    MealType mealType = MealType.unknown,
  }) {
    return DietaryPhosphorusRecord(
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
  DietaryPhosphorusRecord copyWith({
    Mass? mass,
    DateTime? time,
    Metadata? metadata,
    HealthRecordId? id,
    int? zoneOffsetSeconds,
    String? foodName,
    MealType? mealType,
  }) {
    return DietaryPhosphorusRecord(
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
