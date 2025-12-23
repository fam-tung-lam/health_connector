part of '../health_record.dart';

/// Represents a polyunsaturated fat measurement from food at a specific point
/// in time.
///
/// [PolyunsaturatedFatNutrientRecord] captures the polyunsaturated fat content
/// consumed from food.
/// This is an iOS-specific record for tracking individual polyunsaturated fat
/// intake.
///
/// ## Platform Mapping
///
/// - **iOS HealthKit**: `HKQuantityTypeIdentifier.dietaryFatPolyunsaturated`
///
/// > [!NOTE]
/// > This record type is only supported on iOS/HealthKit. For Android,
/// > use the [NutritionRecord.polyunsaturatedFat] field in [NutritionRecord].
///
/// ## Example
///
/// ```dart
/// final record = PolyunsaturatedFatNutrientRecord(
///   time: DateTime.now(),
///   value: Mass.grams(8),
///   foodName: 'Salmon',
///   mealType: MealType.dinner,
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
final class PolyunsaturatedFatNutrientRecord extends MacronutrientRecord {
  /// Creates a polyunsaturated fat nutrient record.
  ///
  /// ## Parameters
  ///
  /// - [value]: The polyunsaturated fat measurement.
  /// - [time]: The timestamp when the polyunsaturated fat was consumed.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [id]: The unique identifier for this record.
  /// - [zoneOffsetSeconds]: Optional timezone offset for the measurement time.
  /// - [foodName]: Optional name of the food containing this polyunsaturated
  /// fat.
  /// - [mealType]: The type of meal (breakfast, lunch, dinner, snack, unknown).
  factory PolyunsaturatedFatNutrientRecord({
    required Mass value,
    required DateTime time,
    required Metadata metadata,
    HealthRecordId id = HealthRecordId.none,
    int? zoneOffsetSeconds,
    String? foodName,
    MealType mealType = MealType.unknown,
  }) {
    return PolyunsaturatedFatNutrientRecord._(
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
  PolyunsaturatedFatNutrientRecord copyWith({
    Mass? value,
    DateTime? time,
    Metadata? metadata,
    HealthRecordId? id,
    int? zoneOffsetSeconds,
    String? foodName,
    MealType? mealType,
  }) {
    return PolyunsaturatedFatNutrientRecord._(
      value: value ?? this.value,
      time: time ?? this.time,
      metadata: metadata ?? this.metadata,
      id: id ?? this.id,
      zoneOffsetSeconds: zoneOffsetSeconds ?? this.zoneOffsetSeconds,
      foodName: foodName ?? this.foodName,
      mealType: mealType ?? this.mealType,
    );
  }

  const PolyunsaturatedFatNutrientRecord._({
    required super.value,
    required super.time,
    required super.metadata,
    super.id = HealthRecordId.none,
    super.zoneOffsetSeconds,
    super.foodName,
    super.mealType,
  });
}
