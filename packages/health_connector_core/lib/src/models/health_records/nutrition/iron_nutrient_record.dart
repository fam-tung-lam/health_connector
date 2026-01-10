part of '../health_record.dart';

/// Represents an iron measurement from food at a specific point in time.
///
/// [IronNutrientRecord] captures the iron content consumed from food.
/// This is an iOS-specific record for tracking individual iron intake.
///
/// ## Platform Mapping
///
/// - **iOS HealthKit Only**: [`HKQuantityTypeIdentifier.dietaryIron`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryiron)
/// - **Android Health Connect**: Part of [`NutritionRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord)
///
/// ## Example
///
/// ```dart
/// final record = IronNutrientRecord(
///   time: DateTime.now(),
///   mass: Mass.milligrams(2.7),
///   foodName: 'Spinach',
///   mealType: MealType.lunch,
///   metadata: Metadata.manualEntry(),
/// );
/// ```
///
/// ## See also
///
/// - [IronNutrientDataType]
///
/// {@category Health Records}
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class IronNutrientRecord extends MineralNutrientRecord {
  /// Creates an iron nutrient record.
  ///
  /// ## Parameters
  ///
  /// - [mass]: The iron measurement.
  /// - [time]: The timestamp when the iron was consumed.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [id]: The unique identifier for this record.
  /// - [zoneOffsetSeconds]: Optional timezone offset for the measurement time.
  /// - [foodName]: Optional name of the food containing this iron.
  /// - [mealType]: The type of meal (breakfast, lunch, dinner, snack, unknown).
  factory IronNutrientRecord({
    required Mass mass,
    required DateTime time,
    required Metadata metadata,
    HealthRecordId id = HealthRecordId.none,
    int? zoneOffsetSeconds,
    String? foodName,
    MealType mealType = MealType.unknown,
  }) {
    return IronNutrientRecord._(
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
  IronNutrientRecord copyWith({
    Mass? mass,
    DateTime? time,
    Metadata? metadata,
    HealthRecordId? id,
    int? zoneOffsetSeconds,
    String? foodName,
    MealType? mealType,
  }) {
    return IronNutrientRecord._(
      mass: mass ?? this.mass,
      time: time ?? this.time,
      metadata: metadata ?? this.metadata,
      id: id ?? this.id,
      zoneOffsetSeconds: zoneOffsetSeconds ?? this.zoneOffsetSeconds,
      foodName: foodName ?? this.foodName,
      mealType: mealType ?? this.mealType,
    );
  }

  const IronNutrientRecord._({
    required super.mass,
    required super.time,
    required super.metadata,
    super.id = HealthRecordId.none,
    super.zoneOffsetSeconds,
    super.foodName,
    super.mealType,
  });
}
