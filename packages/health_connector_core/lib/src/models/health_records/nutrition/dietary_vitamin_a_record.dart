part of '../health_record.dart';

/// Represents a vitamin A measurement from food at a specific point in time.
///
/// [DietaryVitaminARecord] captures the vitamin A content consumed from food.
/// This is an iOS-specific record for tracking individual vitamin A intake.
///
/// ## Platform Mapping
///
/// - **iOS HealthKit Only**: [`HKQuantityTypeIdentifier.dietaryVitaminA`](https
/// ://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/diet
/// aryvitamina)
/// - **Android Health Connect**: Part of [`NutritionRecord`](https://developer.
/// android.com/reference/kotlin/androidx/health/connect/client/records/Nutritio
/// nRecord)
///
/// ## Example
///
/// ```dart
/// final record = DietaryVitaminARecord(
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
/// - [DietaryVitaminADataType]
///
/// {@category Health Records}
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class DietaryVitaminARecord extends DietaryVitaminRecord {
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
  factory DietaryVitaminARecord({
    required Mass mass,
    required DateTime time,
    required Metadata metadata,
    HealthRecordId id = HealthRecordId.none,
    int? zoneOffsetSeconds,
    String? foodName,
    MealType mealType = MealType.unknown,
  }) {
    return DietaryVitaminARecord._(
      mass: mass,
      time: time,
      metadata: metadata,
      id: id,
      zoneOffsetSeconds: zoneOffsetSeconds,
      foodName: foodName,
      mealType: mealType,
    );
  }

  /// Internal factory for creating [DietaryVitaminARecord] instances without
  /// validation.
  ///
  /// Creates a [DietaryVitaminARecord] by directly mapping platform data to
  /// fields, bypassing the normal validation and business rules applied by the
  /// public constructor.
  ///
  /// **⚠️ Warning**: Not for public use. SDK users should use the public
  /// [DietaryVitaminARecord] constructor, which enforces validation and
  /// business
  /// rules. This factory is restricted to the SDK developers and contributors.
  @internalUse
  factory DietaryVitaminARecord.internal({
    required Mass mass,
    required DateTime time,
    required Metadata metadata,
    HealthRecordId id = HealthRecordId.none,
    int? zoneOffsetSeconds,
    String? foodName,
    MealType mealType = MealType.unknown,
  }) {
    return DietaryVitaminARecord._(
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
  DietaryVitaminARecord copyWith({
    Mass? mass,
    DateTime? time,
    Metadata? metadata,
    HealthRecordId? id,
    int? zoneOffsetSeconds,
    String? foodName,
    MealType? mealType,
  }) {
    return DietaryVitaminARecord(
      mass: mass ?? this.mass,
      time: time ?? this.time,
      metadata: metadata ?? this.metadata,
      id: id ?? this.id,
      zoneOffsetSeconds: zoneOffsetSeconds ?? this.zoneOffsetSeconds,
      foodName: foodName ?? this.foodName,
      mealType: mealType ?? this.mealType,
    );
  }

  const DietaryVitaminARecord._({
    required super.mass,
    required super.time,
    required super.metadata,
    super.id = HealthRecordId.none,
    super.zoneOffsetSeconds,
    super.foodName,
    super.mealType,
  });
}
