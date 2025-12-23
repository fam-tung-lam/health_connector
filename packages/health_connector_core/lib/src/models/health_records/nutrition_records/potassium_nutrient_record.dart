part of '../health_record.dart';

/// Represents a potassium measurement from food at a specific point in time.
///
/// [PotassiumNutrientRecord] captures the potassium content consumed from food.
/// This is an iOS-specific record for tracking individual potassium intake.
///
/// ## Platform Mapping
///
/// - **iOS HealthKit**: `HKQuantityTypeIdentifier.dietaryPotassium`
///
/// > [!NOTE]
/// > This record type is only supported on iOS/HealthKit. For Android,
/// > use the [NutritionRecord.potassium] field in [NutritionRecord].
///
/// ## Example
///
/// ```dart
/// final record = PotassiumNutrientRecord(
///   time: DateTime.now(),
///   value: Mass.milligrams(422),
///   foodName: 'Banana',
///   mealType: MealType.snack,
///   metadata: Metadata.manualEntry(
///     dataOrigin: DataOrigin(packageName: 'com.example.app'),
///   ),
/// );
/// ```
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class PotassiumNutrientRecord extends MineralNutrientRecord {
  /// Creates a potassium nutrient record.
  ///
  /// ## Parameters
  ///
  /// - [value]: The potassium measurement.
  /// - [time]: The timestamp when the potassium was consumed.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [id]: The unique identifier for this record.
  /// - [zoneOffsetSeconds]: Optional timezone offset for the measurement time.
  /// - [foodName]: Optional name of the food containing this potassium.
  /// - [mealType]: The type of meal (breakfast, lunch, dinner, snack, unknown).
  factory PotassiumNutrientRecord({
    required Mass value,
    required DateTime time,
    required Metadata metadata,
    HealthRecordId id = HealthRecordId.none,
    int? zoneOffsetSeconds,
    String? foodName,
    MealType mealType = MealType.unknown,
  }) {
    return PotassiumNutrientRecord._(
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
  PotassiumNutrientRecord copyWith({
    Mass? value,
    DateTime? time,
    Metadata? metadata,
    HealthRecordId? id,
    int? zoneOffsetSeconds,
    String? foodName,
    MealType? mealType,
  }) {
    return PotassiumNutrientRecord._(
      value: value ?? this.value,
      time: time ?? this.time,
      metadata: metadata ?? this.metadata,
      id: id ?? this.id,
      zoneOffsetSeconds: zoneOffsetSeconds ?? this.zoneOffsetSeconds,
      foodName: foodName ?? this.foodName,
      mealType: mealType ?? this.mealType,
    );
  }

  const PotassiumNutrientRecord._({
    required super.value,
    required super.time,
    required super.metadata,
    super.id = HealthRecordId.none,
    super.zoneOffsetSeconds,
    super.foodName,
    super.mealType,
  });
}
