part of '../health_record.dart';

/// Represents a calcium measurement from food at a specific point in time.
///
/// [DietaryCalciumRecord] captures the calcium content consumed from food.
/// This is an iOS-specific record for tracking individual calcium intake.
///
/// ## Platform Mapping
///
/// - **iOS HealthKit Only**: [`HKQuantityTypeIdentifier.dietaryCalcium`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietarycalcium)
/// - **Android Health Connect**: Part of [`NutritionRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord)
///
/// ## Example
///
/// ```dart
/// final record = DietaryCalciumRecord(
///   time: DateTime.now(),
///   mass: Mass.milligrams(300),
///   foodName: 'Milk',
///   mealType: MealType.breakfast,
///   metadata: Metadata.manualEntry(),
/// );
/// ```
///
/// ## See also
///
/// - [DietaryCalciumDataType]
///
/// {@category Health Records}
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class DietaryCalciumRecord extends DietaryMineralRecord {
  /// Minimum valid calcium mass (0.0 g).
  static const Mass minMass = Mass.zero;

  /// Maximum valid calcium mass (100.0 g).
  static const Mass maxMass = Mass.grams(100.0);

  /// Creates a calcium nutrient record.
  ///
  /// ## Parameters
  ///
  ///
  /// - [mass]: The calcium measurement.
  /// - [time]: The timestamp when the calcium was consumed.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [id]: The unique identifier for this record.
  /// - [zoneOffsetSeconds]: Optional timezone offset for the measurement time.
  /// - [foodName]: Optional name of the food containing this calcium.
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
  DietaryCalciumRecord({
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
          'Calcium mass must be between '
          '${minMass.inGrams.toStringAsFixed(0)}-'
          '${maxMass.inGrams.toStringAsFixed(0)} g. '
          'Got ${mass.inGrams.toStringAsFixed(3)} g.',
    );
  }

  ///
  /// **⚠️ Warning**: Not for public use. SDK users should use the public
  /// [DietaryCalciumRecord] constructor, which enforces validation and business
  /// rules.
  @internalUse
  factory DietaryCalciumRecord.internal({
    required Mass mass,
    required DateTime time,
    required Metadata metadata,
    HealthRecordId id = HealthRecordId.none,
    int? zoneOffsetSeconds,
    String? foodName,
    MealType mealType = MealType.unknown,
  }) {
    return DietaryCalciumRecord(
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
  DietaryCalciumRecord copyWith({
    Mass? mass,
    DateTime? time,
    Metadata? metadata,
    HealthRecordId? id,
    int? zoneOffsetSeconds,
    String? foodName,
    MealType? mealType,
  }) {
    return DietaryCalciumRecord(
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
