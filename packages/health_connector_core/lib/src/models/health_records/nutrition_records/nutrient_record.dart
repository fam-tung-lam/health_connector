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
/// > [!NOTE]
/// > Individual nutrient records are iOS-only. Android Health Connect uses the
/// > combined [NutritionRecord] instead.
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
  /// - [value]: The measurement value of this nutrient.
  /// - [time]: The timestamp when the nutrient was consumed.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [id]: The unique identifier for this record.
  /// - [zoneOffsetSeconds]: Optional timezone offset for the measurement time.
  /// - [foodName]: Optional name of the food containing this nutrient.
  /// - [mealType]: The type of meal (breakfast, lunch, dinner, snack, unknown).
  const NutrientRecord({
    required this.value,
    required super.time,
    required super.metadata,
    super.id = HealthRecordId.none,
    super.zoneOffsetSeconds,
    this.foodName,
    this.mealType = MealType.unknown,
  });

  /// Optional name of the food containing this nutrient.
  final String? foodName;

  /// The measurement value of this specific nutrient.
  final U value;

  /// The type of meal during which this nutrient was consumed.
  final MealType mealType;

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.appleHealth,
  ];
}
