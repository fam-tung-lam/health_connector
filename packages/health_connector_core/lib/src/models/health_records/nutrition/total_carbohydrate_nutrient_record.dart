part of '../health_record.dart';

/// Represents a total carbohydrate measurement from food at a specific point in
/// time.
///
/// [TotalCarbohydrateNutrientRecord] captures the total carbohydrate content
/// consumed from food.
/// This is an iOS-specific record for tracking individual total carbohydrate
/// intake.
///
/// ## Platform Mapping
///
/// - **iOS HealthKit Only**: [`HKQuantityTypeIdentifier.dietaryCarbohydrates`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietarycarbohydrates)
/// - **Android Health Connect**: Part of [`NutritionRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord)
///
/// ## Example
///
/// ```dart
/// final record = TotalCarbohydrateNutrientRecord(
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
/// - [TotalCarbohydrateNutrientDataType]
///
/// {@category Health Records}
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class TotalCarbohydrateNutrientRecord extends MacronutrientRecord {
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
  /// carbohydrate.
  /// - [mealType]: The type of meal (breakfast, lunch, dinner, snack, unknown).
  factory TotalCarbohydrateNutrientRecord({
    required Mass mass,
    required DateTime time,
    required Metadata metadata,
    HealthRecordId id = HealthRecordId.none,
    int? zoneOffsetSeconds,
    String? foodName,
    MealType mealType = MealType.unknown,
  }) {
    return TotalCarbohydrateNutrientRecord._(
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
  TotalCarbohydrateNutrientRecord copyWith({
    Mass? mass,
    DateTime? time,
    Metadata? metadata,
    HealthRecordId? id,
    int? zoneOffsetSeconds,
    String? foodName,
    MealType? mealType,
  }) {
    return TotalCarbohydrateNutrientRecord._(
      mass: mass ?? this.mass,
      time: time ?? this.time,
      metadata: metadata ?? this.metadata,
      id: id ?? this.id,
      zoneOffsetSeconds: zoneOffsetSeconds ?? this.zoneOffsetSeconds,
      foodName: foodName ?? this.foodName,
      mealType: mealType ?? this.mealType,
    );
  }

  const TotalCarbohydrateNutrientRecord._({
    required super.mass,
    required super.time,
    required super.metadata,
    super.id = HealthRecordId.none,
    super.zoneOffsetSeconds,
    super.foodName,
    super.mealType,
  });
}
