part of '../health_record.dart';

/// Represents a total fat measurement from food at a specific point in time.
///
/// [TotalFatNutrientRecord] captures the total fat content consumed from food.
/// This is an iOS-specific record for tracking individual total fat intake.
///
/// ## Platform Mapping
///
/// - **iOS HealthKit**: `HKQuantityTypeIdentifier.dietaryFatTotal`
///
/// > [!NOTE]
/// > This record type is only supported on iOS/HealthKit. For Android,
/// > use the [NutritionRecord.totalFat] field in [NutritionRecord].
///
/// ## Example
///
/// ```dart
/// final record = TotalFatNutrientRecord(
///   time: DateTime.now(),
///   value: Mass.grams(15),
///   foodName: 'Avocado',
///   mealType: MealType.snack,
///   metadata: Metadata.manualEntry(
///     dataOrigin: DataOrigin(packageName: 'com.example.app'),
///   ),
/// );
/// ```
///
/// {@category Health Records}
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class TotalFatNutrientRecord extends MacronutrientRecord {
  /// Creates a total fat nutrient record.
  ///
  /// ## Parameters
  ///
  /// - [value]: The total fat measurement.
  /// - [time]: The timestamp when the total fat was consumed.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [id]: The unique identifier for this record.
  /// - [zoneOffsetSeconds]: Optional timezone offset for the measurement time.
  /// - [foodName]: Optional name of the food containing this total fat.
  /// - [mealType]: The type of meal (breakfast, lunch, dinner, snack, unknown).
  factory TotalFatNutrientRecord({
    required Mass value,
    required DateTime time,
    required Metadata metadata,
    HealthRecordId id = HealthRecordId.none,
    int? zoneOffsetSeconds,
    String? foodName,
    MealType mealType = MealType.unknown,
  }) {
    return TotalFatNutrientRecord._(
      value: value,
      time: time,
      metadata: metadata,
      id: id,
      zoneOffsetSeconds: zoneOffsetSeconds,
      foodName: foodName,
      mealType: mealType,
    );
  }

  /// Creates a copy with the given fields replaced with the new values.
  TotalFatNutrientRecord copyWith({
    Mass? value,
    DateTime? time,
    Metadata? metadata,
    HealthRecordId? id,
    int? zoneOffsetSeconds,
    String? foodName,
    MealType? mealType,
  }) {
    return TotalFatNutrientRecord._(
      value: value ?? this.value,
      time: time ?? this.time,
      metadata: metadata ?? this.metadata,
      id: id ?? this.id,
      zoneOffsetSeconds: zoneOffsetSeconds ?? this.zoneOffsetSeconds,
      foodName: foodName ?? this.foodName,
      mealType: mealType ?? this.mealType,
    );
  }

  const TotalFatNutrientRecord._({
    required super.value,
    required super.time,
    required super.metadata,
    super.id = HealthRecordId.none,
    super.zoneOffsetSeconds,
    super.foodName,
    super.mealType,
  });
}
