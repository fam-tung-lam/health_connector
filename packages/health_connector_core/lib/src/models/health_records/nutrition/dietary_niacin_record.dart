part of '../health_record.dart';

/// Represents a niacin (vitamin B3) measurement from food at a specific point
/// in time.
///
/// [DietaryNiacinRecord] captures the niacin content consumed from food.
/// This is an iOS-specific record for tracking individual niacin intake.
///
/// ## Platform Mapping
///
/// - **iOS HealthKit Only**: [`HKQuantityTypeIdentifier.dietaryNiacin`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryniacin)
/// - **Android Health Connect**: Part of [`NutritionRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord)
///
/// ## Example
///
/// ```dart
/// final record = DietaryNiacinRecord(
///   time: DateTime.now(),
///   mass: Mass.milligrams(10),
///   foodName: 'Chicken Breast',
///   mealType: MealType.lunch,
///   metadata: Metadata.manualEntry(),
/// );
/// ```
///
/// ## See also
///
/// - [DietaryNiacinDataType]
///
/// {@category Health Records}
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class DietaryNiacinRecord extends DietaryVitaminRecord {
  /// Creates a niacin nutrient record.
  ///
  /// ## Parameters
  ///
  ///
  /// - [mass]: The niacin measurement.
  /// - [time]: The timestamp when the niacin was consumed.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [id]: The unique identifier for this record.
  /// - [zoneOffsetSeconds]: Optional timezone offset for the measurement time.
  /// - [foodName]: Optional name of the food containing this niacin.
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
  /// - **Maximum ([maxMass] g)**: 10g is a reasonable upper bound for
  ///   vitamin intake from a single food item.
  DietaryNiacinRecord({
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
          'Niacin mass must be between '
          '${minMass.inGrams.toStringAsFixed(0)}-'
          '${maxMass.inGrams.toStringAsFixed(0)} g. '
          'Got ${mass.inGrams.toStringAsFixed(4)} g.',
    );
  }

  /// Minimum valid niacin mass (0.0 g).
  static const Mass minMass = Mass.zero;

  /// Maximum valid niacin mass (10.0 g).
  static const Mass maxMass = Mass.grams(10.0);

  ///
  /// **⚠️ Warning**: Not for public use. SDK users should use the public
  /// [DietaryNiacinRecord] constructor, which enforces validation and business
  /// rules. This factory is restricted to the SDK developers and contributors.
  @internalUse
  factory DietaryNiacinRecord.internal({
    required Mass mass,
    required DateTime time,
    required Metadata metadata,
    HealthRecordId id = HealthRecordId.none,
    int? zoneOffsetSeconds,
    String? foodName,
    MealType mealType = MealType.unknown,
  }) {
    return DietaryNiacinRecord(
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
  DietaryNiacinRecord copyWith({
    Mass? mass,
    DateTime? time,
    Metadata? metadata,
    HealthRecordId? id,
    int? zoneOffsetSeconds,
    String? foodName,
    MealType? mealType,
  }) {
    return DietaryNiacinRecord(
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
