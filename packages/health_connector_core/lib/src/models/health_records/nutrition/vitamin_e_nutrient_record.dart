part of '../health_record.dart';

/// Represents a vitamin E measurement from food at a specific point in time.
///
/// [VitaminENutrientRecord] captures the vitamin E content consumed from food.
/// This is an iOS-specific record for tracking individual vitamin E intake.
///
/// ## Platform Mapping
///
/// - **iOS HealthKit Only**: [`HKQuantityTypeIdentifier.dietaryVitaminE`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryvitamine)
/// - **Android Health Connect**: Part of [`NutritionRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord)
///
/// ## Example
///
/// ```dart
/// final record = VitaminENutrientRecord(
///   time: DateTime.now(),
///   mass: Mass.milligrams(7.3),
///   foodName: 'Almonds',
///   mealType: MealType.snack,
///   metadata: Metadata.manualEntry(),
/// );
/// ```
///
/// ## See also
///
/// - [VitaminENutrientDataType]
///
/// {@category Health Records}
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class VitaminENutrientRecord extends VitaminNutrientRecord {
  /// Creates a vitamin E nutrient record.
  ///
  /// ## Parameters
  ///
  ///
  /// - [mass]: The vitamin E measurement.
  /// - [time]: The timestamp when the vitamin E was consumed.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [id]: The unique identifier for this record.
  /// - [zoneOffsetSeconds]: Optional timezone offset for the measurement time.
  /// - [foodName]: Optional name of the food containing this vitamin E.
  /// - [mealType]: The type of meal (breakfast, lunch, dinner, snack, unknown).
  factory VitaminENutrientRecord({
    required Mass mass,
    required DateTime time,
    required Metadata metadata,
    HealthRecordId id = HealthRecordId.none,
    int? zoneOffsetSeconds,
    String? foodName,
    MealType mealType = MealType.unknown,
  }) {
    return VitaminENutrientRecord._(
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
  VitaminENutrientRecord copyWith({
    Mass? mass,
    DateTime? time,
    Metadata? metadata,
    HealthRecordId? id,
    int? zoneOffsetSeconds,
    String? foodName,
    MealType? mealType,
  }) {
    return VitaminENutrientRecord._(
      mass: mass ?? this.mass,
      time: time ?? this.time,
      metadata: metadata ?? this.metadata,
      id: id ?? this.id,
      zoneOffsetSeconds: zoneOffsetSeconds ?? this.zoneOffsetSeconds,
      foodName: foodName ?? this.foodName,
      mealType: mealType ?? this.mealType,
    );
  }

  const VitaminENutrientRecord._({
    required this.mass,
    required super.time,
    required super.metadata,
    super.id = HealthRecordId.none,
    super.zoneOffsetSeconds,
    super.foodName,
    super.mealType,
  });

  /// The vitamin E measurement.
  final Mass mass;
}
