part of '../health_record.dart';

/// Represents a caffeine measurement from food at a specific point in time.
///
/// [CaffeineNutrientRecord] captures the caffeine content consumed from food.
/// This is an iOS-specific record for tracking individual caffeine intake.
///
/// ## Platform Mapping
///
/// - **iOS (HealthKit)**: `HKQuantityTypeIdentifier.dietaryCaffeine`
///
/// > [!NOTE]
/// > This record type is only supported on iOS/HealthKit. For Android,
/// > use the [NutritionRecord.caffeine] field in [NutritionRecord].
///
/// ## Example
///
/// ```dart
/// final record = CaffeineNutrientRecord(
///   time: DateTime.now(),
///   value: Mass.milligrams(95),
///   foodName: 'Coffee',
///   mealType: MealType.breakfast,
///   metadata: Metadata.manualEntry(
///     dataOrigin: DataOrigin(packageName: 'com.example.app'),
///   ),
/// );
/// ```
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class CaffeineNutrientRecord extends NutrientRecord<Mass> {
  /// Creates a caffeine nutrient record.
  ///
  /// ## Parameters
  ///
  /// - [value]: The caffeine measurement.
  /// - [time]: The timestamp when the caffeine was consumed.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [id]: The unique identifier for this record.
  /// - [zoneOffsetSeconds]: Optional timezone offset for the measurement time.
  /// - [foodName]: Optional name of the food containing this caffeine.
  /// - [mealType]: The type of meal (breakfast, lunch, dinner, snack, unknown).
  factory CaffeineNutrientRecord({
    required Mass value,
    required DateTime time,
    required Metadata metadata,
    HealthRecordId id = HealthRecordId.none,
    int? zoneOffsetSeconds,
    String? foodName,
    MealType mealType = MealType.unknown,
  }) {
    return CaffeineNutrientRecord._(
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
  CaffeineNutrientRecord copyWith({
    Mass? value,
    DateTime? time,
    Metadata? metadata,
    HealthRecordId? id,
    int? zoneOffsetSeconds,
    String? foodName,
    MealType? mealType,
  }) {
    return CaffeineNutrientRecord._(
      value: value ?? this.value,
      time: time ?? this.time,
      metadata: metadata ?? this.metadata,
      id: id ?? this.id,
      zoneOffsetSeconds: zoneOffsetSeconds ?? this.zoneOffsetSeconds,
      foodName: foodName ?? this.foodName,
      mealType: mealType ?? this.mealType,
    );
  }

  const CaffeineNutrientRecord._({
    required super.value,
    required super.time,
    required super.metadata,
    super.id = HealthRecordId.none,
    super.zoneOffsetSeconds,
    super.foodName,
    super.mealType,
  });
}
