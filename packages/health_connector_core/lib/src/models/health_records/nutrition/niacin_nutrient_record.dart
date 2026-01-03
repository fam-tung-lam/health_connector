part of '../health_record.dart';

/// Represents a niacin (vitamin B3) measurement from food at a specific point
/// in time.
///
/// [NiacinNutrientRecord] captures the niacin content consumed from food.
/// This is an iOS-specific record for tracking individual niacin intake.
///
/// ## Platform Mapping
///
/// - **iOS HealthKit Only**: [`HKQuantityTypeIdentifier.dietaryNiacin`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryniacin)
/// - **Android Health Connect**: Part of [`NutritionRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord)
///
/// ## Example
///
/// ```dart
/// final record = NiacinNutrientRecord(
///   time: DateTime.now(),
///   value: Mass.milligrams(10),
///   foodName: 'Chicken Breast',
///   mealType: MealType.lunch,
///   metadata: Metadata.manualEntry(
///     dataOrigin: DataOrigin(packageName: 'com.example.app'),
///   ),
/// );
/// ```
///
/// ## See also
///
/// - [NiacinNutrientDataType]
///
/// {@category Health Records}
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class NiacinNutrientRecord extends VitaminNutrientRecord {
  /// Creates a niacin nutrient record.
  ///
  /// ## Parameters
  ///
  /// - [value]: The niacin measurement.
  /// - [time]: The timestamp when the niacin was consumed.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [id]: The unique identifier for this record.
  /// - [zoneOffsetSeconds]: Optional timezone offset for the measurement time.
  /// - [foodName]: Optional name of the food containing this niacin.
  /// - [mealType]: The type of meal (breakfast, lunch, dinner, snack, unknown).
  factory NiacinNutrientRecord({
    required Mass value,
    required DateTime time,
    required Metadata metadata,
    HealthRecordId id = HealthRecordId.none,
    int? zoneOffsetSeconds,
    String? foodName,
    MealType mealType = MealType.unknown,
  }) {
    return NiacinNutrientRecord._(
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
  NiacinNutrientRecord copyWith({
    Mass? value,
    DateTime? time,
    Metadata? metadata,
    HealthRecordId? id,
    int? zoneOffsetSeconds,
    String? foodName,
    MealType? mealType,
  }) {
    return NiacinNutrientRecord._(
      value: value ?? this.value,
      time: time ?? this.time,
      metadata: metadata ?? this.metadata,
      id: id ?? this.id,
      zoneOffsetSeconds: zoneOffsetSeconds ?? this.zoneOffsetSeconds,
      foodName: foodName ?? this.foodName,
      mealType: mealType ?? this.mealType,
    );
  }

  const NiacinNutrientRecord._({
    required super.value,
    required super.time,
    required super.metadata,
    super.id = HealthRecordId.none,
    super.zoneOffsetSeconds,
    super.foodName,
    super.mealType,
  });
}
