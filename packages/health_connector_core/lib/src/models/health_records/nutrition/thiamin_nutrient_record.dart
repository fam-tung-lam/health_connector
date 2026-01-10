part of '../health_record.dart';

/// Represents a thiamin (vitamin B1) measurement from food at a specific point
/// in time.
///
/// [ThiaminNutrientRecord] captures the thiamin content consumed from food.
/// This is an iOS-specific record for tracking individual thiamin intake.
///
/// ## Platform Mapping
///
/// - **iOS HealthKit Only**: [`HKQuantityTypeIdentifier.dietaryThiamin`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietarythiamin)
/// - **Android Health Connect**: Part of [`NutritionRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord)
///
/// ## Example
///
/// ```dart
/// final record = ThiaminNutrientRecord(
///   time: DateTime.now(),
///   mass: Mass.milligrams(0.1),
///   foodName: 'Whole Wheat Bread',
///   mealType: MealType.breakfast,
///   metadata: Metadata.manualEntry(),
/// );
/// ```
///
/// ## See also
///
/// - [ThiaminNutrientDataType]
///
/// {@category Health Records}
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class ThiaminNutrientRecord extends VitaminNutrientRecord {
  /// Creates a thiamin nutrient record.
  ///
  /// ## Parameters
  ///
  ///
  /// - [mass]: The thiamin measurement.
  /// - [time]: The timestamp when the thiamin was consumed.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [id]: The unique identifier for this record.
  /// - [zoneOffsetSeconds]: Optional timezone offset for the measurement time.
  /// - [foodName]: Optional name of the food containing this thiamin.
  /// - [mealType]: The type of meal (breakfast, lunch, dinner, snack, unknown).
  factory ThiaminNutrientRecord({
    required Mass mass,
    required DateTime time,
    required Metadata metadata,
    HealthRecordId id = HealthRecordId.none,
    int? zoneOffsetSeconds,
    String? foodName,
    MealType mealType = MealType.unknown,
  }) {
    return ThiaminNutrientRecord._(
      mass: mass,
      time: time,
      metadata: metadata,
      id: id,
      zoneOffsetSeconds: zoneOffsetSeconds,
      foodName: foodName,
      mealType: mealType,
    );
  }

  /// Creates a copy with the given fields replaced with the new values.
  ThiaminNutrientRecord copyWith({
    Mass? mass,
    DateTime? time,
    Metadata? metadata,
    HealthRecordId? id,
    int? zoneOffsetSeconds,
    String? foodName,
    MealType? mealType,
  }) {
    return ThiaminNutrientRecord._(
      mass: mass ?? this.mass,
      time: time ?? this.time,
      metadata: metadata ?? this.metadata,
      id: id ?? this.id,
      zoneOffsetSeconds: zoneOffsetSeconds ?? this.zoneOffsetSeconds,
      foodName: foodName ?? this.foodName,
      mealType: mealType ?? this.mealType,
    );
  }

  const ThiaminNutrientRecord._({
    required this.mass,
    required super.time,
    required super.metadata,
    super.id = HealthRecordId.none,
    super.zoneOffsetSeconds,
    super.foodName,
    super.mealType,
  });

  /// The thiamin measurement.
  final Mass mass;
}
