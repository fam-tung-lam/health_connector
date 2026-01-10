part of '../health_record.dart';

/// Represents a vitamin A measurement from food at a specific point in time.
///
/// [VitaminANutrientRecord] captures the vitamin A content consumed from food.
/// This is an iOS-specific record for tracking individual vitamin A intake.
///
/// ## Platform Mapping
///
/// - **iOS HealthKit Only**: [`HKQuantityTypeIdentifier.dietaryVitaminA`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryvitamina)
/// - **Android Health Connect**: Part of [`NutritionRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord)
///
/// ## Example
///
/// ```dart
/// final record = VitaminANutrientRecord(
///   time: DateTime.now(),
///   mass: Mass.micrograms(835),
///   foodName: 'Carrot',
///   mealType: MealType.snack,
///   metadata: Metadata.manualEntry(),
/// );
/// ```
///
/// ## See also
///
/// - [VitaminANutrientDataType]
///
/// {@category Health Records}
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class VitaminANutrientRecord extends VitaminNutrientRecord {
  /// Creates a vitamin A nutrient record.
  ///
  /// ## Parameters
  ///
  ///
  /// - [mass]: The vitamin A measurement.
  /// - [time]: The timestamp when the vitamin A was consumed.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [id]: The unique identifier for this record.
  /// - [zoneOffsetSeconds]: Optional timezone offset for the measurement time.
  /// - [foodName]: Optional name of the food containing this vitamin A.
  /// - [mealType]: The type of meal (breakfast, lunch, dinner, snack, unknown).
  factory VitaminANutrientRecord({
    required Mass mass,
    required DateTime time,
    required Metadata metadata,
    HealthRecordId id = HealthRecordId.none,
    int? zoneOffsetSeconds,
    String? foodName,
    MealType mealType = MealType.unknown,
  }) {
    return VitaminANutrientRecord._(
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
  VitaminANutrientRecord copyWith({
    Mass? mass,
    DateTime? time,
    Metadata? metadata,
    HealthRecordId? id,
    int? zoneOffsetSeconds,
    String? foodName,
    MealType? mealType,
  }) {
    return VitaminANutrientRecord._(
      mass: mass ?? this.mass,
      time: time ?? this.time,
      metadata: metadata ?? this.metadata,
      id: id ?? this.id,
      zoneOffsetSeconds: zoneOffsetSeconds ?? this.zoneOffsetSeconds,
      foodName: foodName ?? this.foodName,
      mealType: mealType ?? this.mealType,
    );
  }

  const VitaminANutrientRecord._({
    required super.mass,
    required super.time,
    required super.metadata,
    super.id = HealthRecordId.none,
    super.zoneOffsetSeconds,
    super.foodName,
    super.mealType,
  });
}
