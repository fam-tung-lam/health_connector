part of '../health_record.dart';

/// Represents a riboflavin (vitamin B2) measurement from food at a specific
/// point in time.
///
/// [DietaryRiboflavinRecord] captures the riboflavin content consumed from
/// food.
/// This is an iOS-specific record for tracking individual riboflavin intake.
///
/// ## Platform Mapping
///
/// - **iOS HealthKit Only**: [`HKQuantityTypeIdentifier.dietaryRiboflavin`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryriboflavin)
/// - **Android Health Connect**: Part of [`NutritionRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord)
///
/// ## Example
///
/// ```dart
/// final record = DietaryRiboflavinRecord(
///   time: DateTime.now(),
///   mass: Mass.milligrams(0.3),
///   foodName: 'Yogurt',
///   mealType: MealType.breakfast,
///   metadata: Metadata.manualEntry(),
/// );
/// ```
///
/// ## See also
///
/// - [DietaryRiboflavinDataType]
///
/// {@category Health Records}
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class DietaryRiboflavinRecord extends DietaryVitaminRecord {
  /// Creates a riboflavin nutrient record.
  ///
  /// ## Parameters
  ///
  ///
  /// - [mass]: The riboflavin measurement.
  /// - [time]: The timestamp when the riboflavin was consumed.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [id]: The unique identifier for this record.
  /// - [zoneOffsetSeconds]: Optional timezone offset for the measurement time.
  /// - [foodName]: Optional name of the food containing this riboflavin.
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
  DietaryRiboflavinRecord({
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
          'Riboflavin mass must be between '
          '${minMass.inGrams.toStringAsFixed(0)}-'
          '${maxMass.inGrams.toStringAsFixed(0)} g. '
          'Got ${mass.inGrams.toStringAsFixed(4)} g.',
    );
  }

  /// Minimum valid riboflavin mass (0.0 g).
  static const Mass minMass = Mass.zero;

  /// Maximum valid riboflavin mass (10.0 g).
  static const Mass maxMass = Mass.grams(10.0);

  ///
  /// **⚠️ Warning**: Not for public use. SDK users should use the public
  /// [DietaryRiboflavinRecord] constructor, which enforces validation and
  /// business
  /// rules. This factory is restricted to the SDK developers and contributors.
  @internalUse
  factory DietaryRiboflavinRecord.internal({
    required Mass mass,
    required DateTime time,
    required Metadata metadata,
    HealthRecordId id = HealthRecordId.none,
    int? zoneOffsetSeconds,
    String? foodName,
    MealType mealType = MealType.unknown,
  }) {
    return DietaryRiboflavinRecord(
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
  DietaryRiboflavinRecord copyWith({
    Mass? mass,
    DateTime? time,
    Metadata? metadata,
    HealthRecordId? id,
    int? zoneOffsetSeconds,
    String? foodName,
    MealType? mealType,
  }) {
    return DietaryRiboflavinRecord(
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
