part of '../health_record.dart';

/// Represents a magnesium measurement from food at a specific point in time.
///
/// [MagnesiumNutrientRecord] captures the magnesium content consumed from food.
/// This is an iOS-specific record for tracking individual magnesium intake.
///
/// ## Platform Mapping
///
/// - **iOS (HealthKit)**: `HKQuantityTypeIdentifier.dietaryMagnesium`
///
/// > [!NOTE]
/// > This record type is only supported on iOS/HealthKit. For Android,
/// > use the [NutritionRecord.magnesium] field in [NutritionRecord].
///
/// ## Example
///
/// ```dart
/// final record = MagnesiumNutrientRecord(
///   time: DateTime.now(),
///   value: Mass.milligrams(80),
///   foodName: 'Almonds',
///   mealType: MealType.snack,
///   metadata: Metadata.manualEntry(
///     dataOrigin: DataOrigin(packageName: 'com.example.app'),
///   ),
/// );
/// ```
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class MagnesiumNutrientRecord extends MineralNutrientRecord {
  /// Creates a magnesium nutrient record.
  ///
  /// ## Parameters
  ///
  /// - [value]: The magnesium measurement.
  /// - [time]: The timestamp when the magnesium was consumed.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [id]: The unique identifier for this record.
  /// - [zoneOffsetSeconds]: Optional timezone offset for the measurement time.
  /// - [foodName]: Optional name of the food containing this magnesium.
  /// - [mealType]: The type of meal (breakfast, lunch, dinner, snack, unknown).
  factory MagnesiumNutrientRecord({
    required Mass value,
    required DateTime time,
    required Metadata metadata,
    HealthRecordId id = HealthRecordId.none,
    int? zoneOffsetSeconds,
    String? foodName,
    MealType mealType = MealType.unknown,
  }) {
    return MagnesiumNutrientRecord._(
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
  MagnesiumNutrientRecord copyWith({
    Mass? value,
    DateTime? time,
    Metadata? metadata,
    HealthRecordId? id,
    int? zoneOffsetSeconds,
    String? foodName,
    MealType? mealType,
  }) {
    return MagnesiumNutrientRecord._(
      value: value ?? this.value,
      time: time ?? this.time,
      metadata: metadata ?? this.metadata,
      id: id ?? this.id,
      zoneOffsetSeconds: zoneOffsetSeconds ?? this.zoneOffsetSeconds,
      foodName: foodName ?? this.foodName,
      mealType: mealType ?? this.mealType,
    );
  }

  const MagnesiumNutrientRecord._({
    required super.value,
    required super.time,
    required super.metadata,
    super.id = HealthRecordId.none,
    super.zoneOffsetSeconds,
    super.foodName,
    super.mealType,
  });
}
