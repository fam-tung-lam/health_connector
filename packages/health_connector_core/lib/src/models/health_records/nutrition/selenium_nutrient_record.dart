part of '../health_record.dart';

/// Represents a selenium measurement from food at a specific point in time.
///
/// [SeleniumNutrientRecord] captures the selenium content consumed from food.
/// This is an iOS-specific record for tracking individual selenium intake.
///
/// ## Platform Mapping
///
/// - **iOS HealthKit Only**: [`HKQuantityTypeIdentifier.dietarySelenium`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryselenium)
/// - **Android Health Connect**: Part of [`NutritionRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord)
///
/// ## Example
///
/// ```dart
/// final record = SeleniumNutrientRecord(
///   time: DateTime.now(),
///   mass: Mass.micrograms(68),
///   foodName: 'Brazil Nuts',
///   mealType: MealType.snack,
///   metadata: Metadata.manualEntry(),
/// );
/// ```
///
/// ## See also
///
/// - [SeleniumNutrientDataType]
///
/// {@category Health Records}
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class SeleniumNutrientRecord extends MineralNutrientRecord {
  /// Creates a selenium nutrient record.
  ///
  /// ## Parameters
  ///
  /// - [mass]: The selenium measurement.
  /// - [time]: The timestamp when the selenium was consumed.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [id]: The unique identifier for this record.
  /// - [zoneOffsetSeconds]: Optional timezone offset for the measurement time.
  /// - [foodName]: Optional name of the food containing this selenium.
  /// - [mealType]: The type of meal (breakfast, lunch, dinner, snack, unknown).
  factory SeleniumNutrientRecord({
    required Mass mass,
    required DateTime time,
    required Metadata metadata,
    HealthRecordId id = HealthRecordId.none,
    int? zoneOffsetSeconds,
    String? foodName,
    MealType mealType = MealType.unknown,
  }) {
    return SeleniumNutrientRecord._(
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
  SeleniumNutrientRecord copyWith({
    Mass? mass,
    DateTime? time,
    Metadata? metadata,
    HealthRecordId? id,
    int? zoneOffsetSeconds,
    String? foodName,
    MealType? mealType,
  }) {
    return SeleniumNutrientRecord._(
      mass: mass ?? this.mass,
      time: time ?? this.time,
      metadata: metadata ?? this.metadata,
      id: id ?? this.id,
      zoneOffsetSeconds: zoneOffsetSeconds ?? this.zoneOffsetSeconds,
      foodName: foodName ?? this.foodName,
      mealType: mealType ?? this.mealType,
    );
  }

  const SeleniumNutrientRecord._({
    required super.mass,
    required super.time,
    required super.metadata,
    super.id = HealthRecordId.none,
    super.zoneOffsetSeconds,
    super.foodName,
    super.mealType,
  });
}
