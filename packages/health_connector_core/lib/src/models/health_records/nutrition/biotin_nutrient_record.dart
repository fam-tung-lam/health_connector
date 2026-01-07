part of '../health_record.dart';

/// Represents a biotin (vitamin B7) measurement from food at a specific point
/// in time.
///
/// [BiotinNutrientRecord] captures the biotin content consumed from food.
/// This is an iOS-specific record for tracking individual biotin intake.
///
/// ## Platform Mapping
///
/// - **iOS HealthKit Only**: [`HKQuantityTypeIdentifier.dietaryBiotin`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietarybiotin)
/// - **Android Health Connect**: Part of [`NutritionRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord)
///
/// ## Example
///
/// ```dart
/// final record = BiotinNutrientRecord(
///   time: DateTime.now(),
///   value: Mass.micrograms(10),
///   foodName: 'Egg',
///   mealType: MealType.breakfast,
///   metadata: Metadata.manualEntry(),
/// );
/// ```
///
/// ## See also
///
/// - [BiotinNutrientDataType]
///
/// {@category Health Records}
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class BiotinNutrientRecord extends VitaminNutrientRecord {
  /// Creates a biotin nutrient record.
  ///
  /// ## Parameters
  ///
  /// - [value]: The biotin measurement.
  /// - [time]: The timestamp when the biotin was consumed.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [id]: The unique identifier for this record.
  /// - [zoneOffsetSeconds]: Optional timezone offset for the measurement time.
  /// - [foodName]: Optional name of the food containing this biotin.
  /// - [mealType]: The type of meal (breakfast, lunch, dinner, snack, unknown).
  factory BiotinNutrientRecord({
    required Mass value,
    required DateTime time,
    required Metadata metadata,
    HealthRecordId id = HealthRecordId.none,
    int? zoneOffsetSeconds,
    String? foodName,
    MealType mealType = MealType.unknown,
  }) {
    return BiotinNutrientRecord._(
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
  BiotinNutrientRecord copyWith({
    Mass? value,
    DateTime? time,
    Metadata? metadata,
    HealthRecordId? id,
    int? zoneOffsetSeconds,
    String? foodName,
    MealType? mealType,
  }) {
    return BiotinNutrientRecord._(
      value: value ?? this.value,
      time: time ?? this.time,
      metadata: metadata ?? this.metadata,
      id: id ?? this.id,
      zoneOffsetSeconds: zoneOffsetSeconds ?? this.zoneOffsetSeconds,
      foodName: foodName ?? this.foodName,
      mealType: mealType ?? this.mealType,
    );
  }

  const BiotinNutrientRecord._({
    required super.value,
    required super.time,
    required super.metadata,
    super.id = HealthRecordId.none,
    super.zoneOffsetSeconds,
    super.foodName,
    super.mealType,
  });
}
