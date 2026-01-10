part of '../health_record.dart';

/// Represents a monounsaturated fat measurement from food at a specific point
/// in time.
///
/// [DietaryMonounsaturatedFatRecord] captures the monounsaturated fat content
/// consumed from food.
/// This is an iOS-specific record for tracking individual monounsaturated fat
/// intake.
///
/// ## Platform Mapping
///
/// - **iOS HealthKit Only**: [`HKQuantityTypeIdentifier.dietaryFatMonounsaturated`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryFatMonounsaturated)
/// - **Android Health Connect**: Part of [`NutritionRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord)
///
/// ## Example
///
/// ```dart
/// final record = DietaryMonounsaturatedFatRecord(
///   time: DateTime.now(),
///   mass: Mass.grams(10),
///   foodName: 'Olive Oil',
///   mealType: MealType.lunch,
///   metadata: Metadata.manualEntry(),
/// );
/// ```
///
/// ## See also
///
/// - [DietaryMonounsaturatedFatDataType]
///
/// {@category Health Records}
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class DietaryMonounsaturatedFatRecord extends DietaryMacronutrientRecord {
  /// Creates a monounsaturated fat nutrient record.
  ///
  /// ## Parameters
  ///
  /// - [mass]: The monounsaturated fat measurement.
  /// - [time]: The timestamp when the monounsaturated fat was consumed.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [id]: The unique identifier for this record.
  /// - [zoneOffsetSeconds]: Optional timezone offset for the measurement time.
  /// - [foodName]: Optional name of the food containing this monounsaturated
  /// fat.
  /// - [mealType]: The type of meal (breakfast, lunch, dinner, snack, unknown).
  factory DietaryMonounsaturatedFatRecord({
    required Mass mass,
    required DateTime time,
    required Metadata metadata,
    HealthRecordId id = HealthRecordId.none,
    int? zoneOffsetSeconds,
    String? foodName,
    MealType mealType = MealType.unknown,
  }) {
    return DietaryMonounsaturatedFatRecord._(
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
  DietaryMonounsaturatedFatRecord copyWith({
    Mass? mass,
    DateTime? time,
    Metadata? metadata,
    HealthRecordId? id,
    int? zoneOffsetSeconds,
    String? foodName,
    MealType? mealType,
  }) {
    return DietaryMonounsaturatedFatRecord._(
      mass: mass ?? this.mass,
      time: time ?? this.time,
      metadata: metadata ?? this.metadata,
      id: id ?? this.id,
      zoneOffsetSeconds: zoneOffsetSeconds ?? this.zoneOffsetSeconds,
      foodName: foodName ?? this.foodName,
      mealType: mealType ?? this.mealType,
    );
  }

  const DietaryMonounsaturatedFatRecord._({
    required super.mass,
    required super.time,
    required super.metadata,
    super.id = HealthRecordId.none,
    super.zoneOffsetSeconds,
    super.foodName,
    super.mealType,
  });
}
