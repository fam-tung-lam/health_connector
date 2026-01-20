part of '../health_record.dart';

/// Represents a polyunsaturated fat measurement from food at a specific point
/// in time.
///
/// [DietaryPolyunsaturatedFatRecord] captures the polyunsaturated fat content
/// consumed from food.
/// This is an iOS-specific record for tracking individual polyunsaturated fat
/// intake.
///
/// ## Platform Mapping
///
/// - **iOS HealthKit Only**: [`HKQuantityTypeIdentifier.dietaryFatPolyunsaturat
/// ed`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryfatpolyunsaturated)
/// - **Android Health Connect**: Part of [`NutritionRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord)
///
/// ## Example
///
/// ```dart
/// final record = DietaryPolyunsaturatedFatRecord(
///   time: DateTime.now(),
///   mass: Mass.grams(8),
///   foodName: 'Salmon',
///   mealType: MealType.dinner,
///   metadata: Metadata.manualEntry(),
/// );
/// ```
///
/// ## See also
///
/// - [DietaryPolyunsaturatedFatDataType]
///
/// {@category Health Records}
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class DietaryPolyunsaturatedFatRecord extends DietaryMacronutrientRecord {
  /// Creates a polyunsaturated fat nutrient record.
  ///
  /// ## Parameters
  ///
  /// - [mass]: The polyunsaturated fat measurement.
  /// - [time]: The timestamp when the polyunsaturated fat was consumed.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [id]: The unique identifier for this record.
  /// - [zoneOffsetSeconds]: Optional timezone offset for the measurement time.
  /// - [foodName]: Optional name of the food containing this polyunsaturated
  ///   fat.
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
  /// - **Maximum ([maxMass])**: 1,000g is a reasonable upper bound for
  ///   macronutrient intake from a single food item.
  DietaryPolyunsaturatedFatRecord({
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
          'Polyunsaturated fat mass must be between '
          '${minMass.inGrams.toStringAsFixed(0)}-'
          '${maxMass.inGrams.toStringAsFixed(0)} g. '
          'Got ${mass.inGrams.toStringAsFixed(1)} g.',
    );
  }

  /// Minimum valid polyunsaturated fat mass (0.0 g).
  static const Mass minMass = Mass.zero;

  /// Maximum valid polyunsaturated fat mass (1,000.0 g).
  static const Mass maxMass = Mass.grams(1000.0);

  ///
  /// **⚠️ Warning**: Not for public use. SDK users should use the public
  /// [DietaryPolyunsaturatedFatRecord] constructor, which enforces validation
  /// and business
  /// rules.
  @internalUse
  factory DietaryPolyunsaturatedFatRecord.internal({
    required Mass mass,
    required DateTime time,
    required Metadata metadata,
    HealthRecordId id = HealthRecordId.none,
    int? zoneOffsetSeconds,
    String? foodName,
    MealType mealType = MealType.unknown,
  }) {
    return DietaryPolyunsaturatedFatRecord(
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
  DietaryPolyunsaturatedFatRecord copyWith({
    Mass? mass,
    DateTime? time,
    Metadata? metadata,
    HealthRecordId? id,
    int? zoneOffsetSeconds,
    String? foodName,
    MealType? mealType,
  }) {
    return DietaryPolyunsaturatedFatRecord(
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
