part of '../health_record.dart';

/// Represents a saturated fat measurement from food at a specific point in
/// time.
///
/// [SaturatedFatNutrientRecord] captures the saturated fat content consumed
/// from food.
/// This is an iOS-specific record for tracking individual saturated fat intake.
///
/// ## Platform Mapping
///
/// - **iOS HealthKit Only**: [`HKQuantityTypeIdentifier.dietaryFatSaturated`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryfatsaturated)
/// - **Android Health Connect**: Part of [`NutritionRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord)
///
/// ## Example
///
/// ```dart
/// final record = SaturatedFatNutrientRecord(
///   time: DateTime.now(),
///   mass: Mass.grams(5),
///   foodName: 'Cheese',
///   mealType: MealType.snack,
///   metadata: Metadata.manualEntry(),
/// );
/// ```
///
/// ## See also
///
/// - [SaturatedFatNutrientDataType]
///
/// {@category Health Records}
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class SaturatedFatNutrientRecord extends MacronutrientRecord {
  /// Creates a saturated fat nutrient record.
  ///
  /// ## Parameters
  ///
  /// - [mass]: The saturated fat measurement.
  /// - [time]: The timestamp when the saturated fat was consumed.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [id]: The unique identifier for this record.
  /// - [zoneOffsetSeconds]: Optional timezone offset for the measurement time.
  /// - [foodName]: Optional name of the food containing this saturated fat.
  /// - [mealType]: The type of meal (breakfast, lunch, dinner, snack, unknown).
  factory SaturatedFatNutrientRecord({
    required Mass mass,
    required DateTime time,
    required Metadata metadata,
    HealthRecordId id = HealthRecordId.none,
    int? zoneOffsetSeconds,
    String? foodName,
    MealType mealType = MealType.unknown,
  }) {
    return SaturatedFatNutrientRecord._(
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
  SaturatedFatNutrientRecord copyWith({
    Mass? mass,
    DateTime? time,
    Metadata? metadata,
    HealthRecordId? id,
    int? zoneOffsetSeconds,
    String? foodName,
    MealType? mealType,
  }) {
    return SaturatedFatNutrientRecord._(
      mass: mass ?? this.mass,
      time: time ?? this.time,
      metadata: metadata ?? this.metadata,
      id: id ?? this.id,
      zoneOffsetSeconds: zoneOffsetSeconds ?? this.zoneOffsetSeconds,
      foodName: foodName ?? this.foodName,
      mealType: mealType ?? this.mealType,
    );
  }

  const SaturatedFatNutrientRecord._({
    required super.mass,
    required super.time,
    required super.metadata,
    super.id = HealthRecordId.none,
    super.zoneOffsetSeconds,
    super.foodName,
    super.mealType,
  });
}
