part of '../health_record.dart';

/// Represents a riboflavin (vitamin B2) measurement from food at a specific
/// point in time.
///
/// [RiboflavinNutrientRecord] captures the riboflavin content consumed from
/// food.
/// This is an iOS-specific record for tracking individual riboflavin intake.
///
/// ## Platform Mapping
///
/// - **iOS HealthKit**: `HKQuantityTypeIdentifier.dietaryRiboflavin`
///
/// > [!NOTE]
/// > This record type is only supported on iOS/HealthKit. For Android,
/// > use the [NutritionRecord.riboflavin] field in [NutritionRecord].
///
/// ## Example
///
/// ```dart
/// final record = RiboflavinNutrientRecord(
///   time: DateTime.now(),
///   value: Mass.milligrams(0.3),
///   foodName: 'Yogurt',
///   mealType: MealType.breakfast,
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
final class RiboflavinNutrientRecord extends VitaminNutrientRecord {
  /// Creates a riboflavin nutrient record.
  ///
  /// ## Parameters
  ///
  /// - [value]: The riboflavin measurement.
  /// - [time]: The timestamp when the riboflavin was consumed.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [id]: The unique identifier for this record.
  /// - [zoneOffsetSeconds]: Optional timezone offset for the measurement time.
  /// - [foodName]: Optional name of the food containing this riboflavin.
  /// - [mealType]: The type of meal (breakfast, lunch, dinner, snack, unknown).
  factory RiboflavinNutrientRecord({
    required Mass value,
    required DateTime time,
    required Metadata metadata,
    HealthRecordId id = HealthRecordId.none,
    int? zoneOffsetSeconds,
    String? foodName,
    MealType mealType = MealType.unknown,
  }) {
    return RiboflavinNutrientRecord._(
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
  RiboflavinNutrientRecord copyWith({
    Mass? value,
    DateTime? time,
    Metadata? metadata,
    HealthRecordId? id,
    int? zoneOffsetSeconds,
    String? foodName,
    MealType? mealType,
  }) {
    return RiboflavinNutrientRecord._(
      value: value ?? this.value,
      time: time ?? this.time,
      metadata: metadata ?? this.metadata,
      id: id ?? this.id,
      zoneOffsetSeconds: zoneOffsetSeconds ?? this.zoneOffsetSeconds,
      foodName: foodName ?? this.foodName,
      mealType: mealType ?? this.mealType,
    );
  }

  const RiboflavinNutrientRecord._({
    required super.value,
    required super.time,
    required super.metadata,
    super.id = HealthRecordId.none,
    super.zoneOffsetSeconds,
    super.foodName,
    super.mealType,
  });
}
