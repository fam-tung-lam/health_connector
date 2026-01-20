part of '../health_record.dart';

/// Base class for individual nutrient measurement records.
///
/// [NutrientRecord] serves as the foundation for specific nutrient records
/// (vitamins, minerals, macronutrients) that track individual nutritional
/// components consumed at a specific point in time. Each nutrient record is
/// iOS-specific and maps to a corresponding HealthKit nutrient quantity type.
///
/// ## Platform Mapping
///
/// - **iOS HealthKit**: Various `HKQuantityTypeIdentifier` nutrient types
///
/// [!NOTE]
/// Individual nutrient records are iOS-only. Android Health Connect uses the
/// combined [NutritionRecord] instead.
///
/// {@category Health Records}
@sinceV1_1_0
@supportedOnAppleHealth
@internalUse
@immutable
sealed class NutrientRecord<U extends MeasurementUnit>
    extends InstantHealthRecord {
  /// Creates a nutrient record.
  ///
  /// ## Parameters
  ///
  /// - [time]: The timestamp when the nutrient was consumed.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [id]: The unique identifier for this record.
  /// - [zoneOffsetSeconds]: Optional timezone offset for the measurement time.
  /// - [foodName]: Optional name of the food containing this nutrient.
  /// - [mealType]: The type of meal (breakfast, lunch, dinner, snack, unknown).
  /// - [foodName]: Optional name of the food containing this nutrient.
  /// - [mealType]: The type of meal (breakfast, lunch, dinner, snack, unknown).
  const NutrientRecord({
    required super.time,
    required super.metadata,
    super.id = HealthRecordId.none,
    super.zoneOffsetSeconds,
    this.foodName,
    this.mealType = MealType.unknown,
  });

  /// Optional name of the food containing this nutrient.
  final String? foodName;

  /// The type of meal during which this nutrient was consumed.
  final MealType mealType;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NutrientRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          metadata == other.metadata &&
          time == other.time &&
          zoneOffsetSeconds == other.zoneOffsetSeconds &&
          foodName == other.foodName &&
          mealType == other.mealType;

  @override
  int get hashCode =>
      id.hashCode ^
      metadata.hashCode ^
      time.hashCode ^
      zoneOffsetSeconds.hashCode ^
      foodName.hashCode ^
      mealType.hashCode;
}
