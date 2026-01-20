part of '../health_record.dart';

/// Represents a total carbohydrate measurement from food at a specific point in
/// time.
///
/// [DietaryTotalCarbohydrateRecord] captures the total carbohydrate content
/// consumed from food.
/// This is an iOS-specific record for tracking individual total carbohydrate
/// intake.
///
/// ## Platform Mapping
///
/// - **iOS HealthKit Only**: [`HKQuantityTypeIdentifier.dietaryCarbohydrates`](
/// https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier
/// /dietarycarbohydrates)
/// - **Android Health Connect**: Part of [`NutritionRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord)
///
/// ## Example
///
/// ```dart
/// final record = DietaryTotalCarbohydrateRecord(
///   time: DateTime.now(),
///   mass: Mass.grams(45),
///   foodName: 'Brown Rice',
///   mealType: MealType.dinner,
///   metadata: Metadata.manualEntry(),
/// );
/// ```
///
/// ## See also
///
/// - [DietaryTotalCarbohydrateDataType]
///
/// {@category Health Records}
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class DietaryTotalCarbohydrateRecord extends DietaryMacronutrientRecord {
  /// Creates a total carbohydrate nutrient record.
  ///
  /// ## Parameters
  ///
  /// - [mass]: The total carbohydrate measurement.
  /// - [time]: The timestamp when the total carbohydrate was consumed.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [id]: The unique identifier for this record.
  /// - [zoneOffsetSeconds]: Optional timezone offset for the measurement time.
  /// - [foodName]: Optional name of the food containing this total
  ///   carbohydrate.
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
  /// - **Maximum ([maxMass] g)**: 1,000g is a reasonable upper bound for
  ///   macronutrient intake from a single food item.
  DietaryTotalCarbohydrateRecord({
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
          'Total carbohydrate mass must be between '
          '${minMass.inGrams.toStringAsFixed(0)}-'
          '${maxMass.inGrams.toStringAsFixed(0)} g. '
          'Got ${mass.inGrams.toStringAsFixed(1)} g.',
    );
  }

  /// Minimum valid total carbohydrate mass (0.0 g).
  static const Mass minMass = Mass.zero;

  /// Maximum valid total carbohydrate mass (1,000.0 g).
  static const Mass maxMass = Mass.grams(1000.0);

  ///
  /// **⚠️ Warning**: Not for public use. SDK users should use the public
  /// [DietaryTotalCarbohydrateRecord] constructor, which enforces validation
  /// and business
  /// rules.
  @internalUse
  factory DietaryTotalCarbohydrateRecord.internal({
    required Mass mass,
    required DateTime time,
    required Metadata metadata,
    HealthRecordId id = HealthRecordId.none,
    int? zoneOffsetSeconds,
    String? foodName,
    MealType mealType = MealType.unknown,
  }) {
    return DietaryTotalCarbohydrateRecord(
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
  DietaryTotalCarbohydrateRecord copyWith({
    Mass? mass,
    DateTime? time,
    Metadata? metadata,
    HealthRecordId? id,
    int? zoneOffsetSeconds,
    String? foodName,
    MealType? mealType,
  }) {
    return DietaryTotalCarbohydrateRecord(
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
