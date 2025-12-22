part of '../health_record.dart';

/// Represents a manganese measurement from food at a specific point in time.
///
/// [ManganeseNutrientRecord] captures the manganese content consumed from food.
/// This is an iOS-specific record for tracking individual manganese intake.
///
/// ## Platform Mapping
///
/// - **iOS (HealthKit)**: `HKQuantityTypeIdentifier.dietaryManganese`
///
/// > [!NOTE]
/// > This record type is only supported on iOS/HealthKit. For Android,
/// > use the [NutritionRecord.manganese] field in [NutritionRecord].
///
/// ## Example
///
/// ```dart
/// final record = ManganeseNutrientRecord(
///   time: DateTime.now(),
///   value: Mass.milligrams(1.5),
///   foodName: 'Oats',
///   mealType: MealType.breakfast,
///   metadata: Metadata.manualEntry(
///     dataOrigin: DataOrigin(packageName: 'com.example.app'),
///   ),
/// );
/// ```
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class ManganeseNutrientRecord extends MineralNutrientRecord {
  /// Creates a manganese nutrient record.
  ///
  /// ## Parameters
  ///
  /// - [value]: The manganese measurement.
  /// - [time]: The timestamp when the manganese was consumed.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [id]: The unique identifier for this record.
  /// - [zoneOffsetSeconds]: Optional timezone offset for the measurement time.
  /// - [foodName]: Optional name of the food containing this manganese.
  /// - [mealType]: The type of meal (breakfast, lunch, dinner, snack, unknown).
  factory ManganeseNutrientRecord({
    required Mass value,
    required DateTime time,
    required Metadata metadata,
    HealthRecordId id = HealthRecordId.none,
    int? zoneOffsetSeconds,
    String? foodName,
    MealType mealType = MealType.unknown,
  }) {
    return ManganeseNutrientRecord._(
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
  ManganeseNutrientRecord copyWith({
    Mass? value,
    DateTime? time,
    Metadata? metadata,
    HealthRecordId? id,
    int? zoneOffsetSeconds,
    String? foodName,
    MealType? mealType,
  }) {
    return ManganeseNutrientRecord._(
      value: value ?? this.value,
      time: time ?? this.time,
      metadata: metadata ?? this.metadata,
      id: id ?? this.id,
      zoneOffsetSeconds: zoneOffsetSeconds ?? this.zoneOffsetSeconds,
      foodName: foodName ?? this.foodName,
      mealType: mealType ?? this.mealType,
    );
  }

  const ManganeseNutrientRecord._({
    required super.value,
    required super.time,
    required super.metadata,
    super.id = HealthRecordId.none,
    super.zoneOffsetSeconds,
    super.foodName,
    super.mealType,
  });
}
