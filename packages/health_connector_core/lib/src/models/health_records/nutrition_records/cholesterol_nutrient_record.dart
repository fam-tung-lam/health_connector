part of '../health_record.dart';

/// Represents a cholesterol measurement from food at a specific point in time.
///
/// [CholesterolNutrientRecord] captures the cholesterol content consumed from
/// food.
/// This is an iOS-specific record for tracking individual cholesterol intake.
///
/// ## Platform Mapping
///
/// - **iOS (HealthKit)**: `HKQuantityTypeIdentifier.dietaryCholesterol`
///
/// > [!NOTE]
/// > This record type is only supported on iOS/HealthKit. For Android,
/// > use the [NutritionRecord.cholesterol] field in [NutritionRecord].
///
/// ## Example
///
/// ```dart
/// final record = CholesterolNutrientRecord(
///   time: DateTime.now(),
///   value: Mass.milligrams(186),
///   foodName: 'Egg',
///   mealType: MealType.breakfast,
///   metadata: Metadata.manualEntry(
///     dataOrigin: DataOrigin(packageName: 'com.example.app'),
///   ),
/// );
/// ```
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class CholesterolNutrientRecord extends MacronutrientRecord {
  /// Creates a cholesterol nutrient record.
  ///
  /// ## Parameters
  ///
  /// - [value]: The cholesterol measurement.
  /// - [time]: The timestamp when the cholesterol was consumed.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [id]: The unique identifier for this record.
  /// - [zoneOffsetSeconds]: Optional timezone offset for the measurement time.
  /// - [foodName]: Optional name of the food containing this cholesterol.
  /// - [mealType]: The type of meal (breakfast, lunch, dinner, snack, unknown).
  factory CholesterolNutrientRecord({
    required Mass value,
    required DateTime time,
    required Metadata metadata,
    HealthRecordId id = HealthRecordId.none,
    int? zoneOffsetSeconds,
    String? foodName,
    MealType mealType = MealType.unknown,
  }) {
    return CholesterolNutrientRecord._(
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
  CholesterolNutrientRecord copyWith({
    Mass? value,
    DateTime? time,
    Metadata? metadata,
    HealthRecordId? id,
    int? zoneOffsetSeconds,
    String? foodName,
    MealType? mealType,
  }) {
    return CholesterolNutrientRecord._(
      value: value ?? this.value,
      time: time ?? this.time,
      metadata: metadata ?? this.metadata,
      id: id ?? this.id,
      zoneOffsetSeconds: zoneOffsetSeconds ?? this.zoneOffsetSeconds,
      foodName: foodName ?? this.foodName,
      mealType: mealType ?? this.mealType,
    );
  }

  const CholesterolNutrientRecord._({
    required super.value,
    required super.time,
    required super.metadata,
    super.id = HealthRecordId.none,
    super.zoneOffsetSeconds,
    super.foodName,
    super.mealType,
  });
}
