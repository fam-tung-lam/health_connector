part of '../health_record.dart';

/// Represents a vitamin D measurement from food at a specific point in time.
///
/// [DietaryVitaminDRecord] captures the vitamin D content consumed from food.
/// This is an iOS-specific record for tracking individual vitamin D intake.
///
/// ## Platform Mapping
///
/// - **iOS HealthKit Only**: [`HKQuantityTypeIdentifier.dietaryVitaminD`](https
/// ://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/diet
/// aryvitamind)
/// - **Android Health Connect**: Part of [`NutritionRecord`](https://developer.
/// android.com/reference/kotlin/androidx/health/connect/client/records/Nutritio
/// nRecord)
///
/// ## Example
///
/// ```dart
/// final record = DietaryVitaminDRecord(
///   time: DateTime.now(),
///   mass: Mass.micrograms(2.5),
///   foodName: 'Fortified Milk',
///   mealType: MealType.breakfast,
///   metadata: Metadata.manualEntry(),
/// );
/// ```
///
/// ## See also
///
/// - [DietaryVitaminDDataType]
///
/// {@category Health Records}
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class DietaryVitaminDRecord extends DietaryVitaminRecord {
  /// Creates a vitamin D nutrient record.
  ///
  /// ## Parameters
  ///
  ///
  /// - [mass]: The vitamin D measurement.
  /// - [time]: The timestamp when the vitamin D was consumed.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [id]: The unique identifier for this record.
  /// - [zoneOffsetSeconds]: Optional timezone offset for the measurement time.
  /// - [foodName]: Optional name of the food containing this vitamin D.
  /// - [mealType]: The type of meal (breakfast, lunch, dinner, snack, unknown).
  factory DietaryVitaminDRecord({
    required Mass mass,
    required DateTime time,
    required Metadata metadata,
    HealthRecordId id = HealthRecordId.none,
    int? zoneOffsetSeconds,
    String? foodName,
    MealType mealType = MealType.unknown,
  }) {
    return DietaryVitaminDRecord._(
      mass: mass,
      time: time,
      metadata: metadata,
      id: id,
      zoneOffsetSeconds: zoneOffsetSeconds,
      foodName: foodName,
      mealType: mealType,
    );
  }

  /// Internal factory for creating [DietaryVitaminDRecord] instances without
  /// validation.
  ///
  /// Creates a [DietaryVitaminDRecord] by directly mapping platform data to
  /// fields, bypassing the normal validation and business rules applied by the
  /// public constructor.
  ///
  /// **⚠️ Warning**: Not for public use. SDK users should use the public
  /// [DietaryVitaminDRecord] constructor, which enforces validation and
  /// business
  /// rules. This factory is restricted to the SDK developers and contributors.
  @internalUse
  factory DietaryVitaminDRecord.internal({
    required Mass mass,
    required DateTime time,
    required Metadata metadata,
    HealthRecordId id = HealthRecordId.none,
    int? zoneOffsetSeconds,
    String? foodName,
    MealType mealType = MealType.unknown,
  }) {
    return DietaryVitaminDRecord._(
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
  DietaryVitaminDRecord copyWith({
    Mass? mass,
    DateTime? time,
    Metadata? metadata,
    HealthRecordId? id,
    int? zoneOffsetSeconds,
    String? foodName,
    MealType? mealType,
  }) {
    return DietaryVitaminDRecord(
      mass: mass ?? this.mass,
      time: time ?? this.time,
      metadata: metadata ?? this.metadata,
      id: id ?? this.id,
      zoneOffsetSeconds: zoneOffsetSeconds ?? this.zoneOffsetSeconds,
      foodName: foodName ?? this.foodName,
      mealType: mealType ?? this.mealType,
    );
  }

  const DietaryVitaminDRecord._({
    required super.mass,
    required super.time,
    required super.metadata,
    super.id = HealthRecordId.none,
    super.zoneOffsetSeconds,
    super.foodName,
    super.mealType,
  });
}
