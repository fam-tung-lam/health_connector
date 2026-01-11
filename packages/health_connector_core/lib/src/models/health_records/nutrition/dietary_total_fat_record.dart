part of '../health_record.dart';

/// Represents a total fat measurement from food at a specific point in time.
///
/// [DietaryTotalFatRecord] captures the total fat content consumed from food.
/// This is an iOS-specific record for tracking individual total fat intake.
///
/// ## Platform Mapping
///
/// - **iOS HealthKit Only**: [`HKQuantityTypeIdentifier.dietaryFatTotal`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryfattotal)
/// - **Android Health Connect**: Part of [`NutritionRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord)
///
/// ## Example
///
/// ```dart
/// final record = DietaryTotalFatRecord(
///   time: DateTime.now(),
///   mass: Mass.grams(15),
///   foodName: 'Avocado',
///   mealType: MealType.snack,
///   metadata: Metadata.manualEntry(),
/// );
/// ```
///
/// ## See also
///
/// - [DietaryTotalFatDataType]
///
/// {@category Health Records}
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class DietaryTotalFatRecord extends DietaryMacronutrientRecord {
  /// Creates a total fat nutrient record.
  ///
  /// ## Parameters
  ///
  /// - [mass]: The total fat measurement.
  /// - [time]: The timestamp when the total fat was consumed.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [id]: The unique identifier for this record.
  /// - [zoneOffsetSeconds]: Optional timezone offset for the measurement time.
  /// - [foodName]: Optional name of the food containing this total fat.
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
  DietaryTotalFatRecord({
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
          'Total fat mass must be between '
          '${minMass.inGrams.toStringAsFixed(0)}-'
          '${maxMass.inGrams.toStringAsFixed(0)} g. '
          'Got ${mass.inGrams.toStringAsFixed(1)} g.',
    );
  }

  /// Minimum valid total fat mass (0.0 g).
  static const Mass minMass = Mass.zero;

  /// Maximum valid total fat mass (1,000.0 g).
  static const Mass maxMass = Mass.grams(1000.0);

  ///
  /// **⚠️ Warning**: Not for public use. SDK users should use the public
  /// [DietaryTotalFatRecord] constructor, which enforces validation and
  /// business
  /// rules. This factory is restricted to the SDK developers and contributors.
  @internalUse
  factory DietaryTotalFatRecord.internal({
    required Mass mass,
    required DateTime time,
    required Metadata metadata,
    HealthRecordId id = HealthRecordId.none,
    int? zoneOffsetSeconds,
    String? foodName,
    MealType mealType = MealType.unknown,
  }) {
    return DietaryTotalFatRecord(
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
  DietaryTotalFatRecord copyWith({
    Mass? mass,
    DateTime? time,
    Metadata? metadata,
    HealthRecordId? id,
    int? zoneOffsetSeconds,
    String? foodName,
    MealType? mealType,
  }) {
    return DietaryTotalFatRecord(
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
