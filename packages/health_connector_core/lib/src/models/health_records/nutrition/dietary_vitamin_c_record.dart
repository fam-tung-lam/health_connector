part of '../health_record.dart';

/// Represents a vitamin C measurement from food at a specific point in time.
///
/// [DietaryVitaminCRecord] captures the vitamin C content consumed from food.
/// This is an iOS-specific record for tracking individual vitamin C intake.
///
/// ## Platform Mapping
///
/// - **iOS HealthKit Only**: [`HKQuantityTypeIdentifier.dietaryVitaminC`](https
/// ://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/diet
/// aryvitaminc)
/// - **Android Health Connect**: Part of [`NutritionRecord`](https://developer.
/// android.com/reference/kotlin/androidx/health/connect/client/records/Nutritio
/// nRecord)
///
/// ## Example
///
/// ```dart
/// final record = DietaryVitaminCRecord(
///   time: DateTime.now(),
///   mass: Mass.milligrams(70),
///   foodName: 'Orange',
///   mealType: MealType.snack,
///   metadata: Metadata.manualEntry(),
/// );
/// ```
///
/// ## See also
///
/// - [DietaryVitaminCDataType]
///
/// {@category Health Records}
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class DietaryVitaminCRecord extends DietaryVitaminRecord {
  /// Creates a vitamin C nutrient record.
  ///
  /// ## Parameters
  ///
  ///
  /// - [mass]: The vitamin C measurement.
  /// - [time]: The timestamp when the vitamin C was consumed.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [id]: The unique identifier for this record.
  /// - [zoneOffsetSeconds]: Optional timezone offset for the measurement time.
  /// - [foodName]: Optional name of the food containing this vitamin C.
  /// - [mealType]: The type of meal (breakfast, lunch, dinner, snack, unknown).
  factory DietaryVitaminCRecord({
    required Mass mass,
    required DateTime time,
    required Metadata metadata,
    HealthRecordId id = HealthRecordId.none,
    int? zoneOffsetSeconds,
    String? foodName,
    MealType mealType = MealType.unknown,
  }) {
    return DietaryVitaminCRecord._(
      mass: mass,
      time: time,
      metadata: metadata,
      id: id,
      zoneOffsetSeconds: zoneOffsetSeconds,
      foodName: foodName,
      mealType: mealType,
    );
  }

  /// Internal factory for creating [DietaryVitaminCRecord] instances without
  /// validation.
  ///
  /// Creates a [DietaryVitaminCRecord] by directly mapping platform data to
  /// fields, bypassing the normal validation and business rules applied by the
  /// public constructor.
  ///
  /// **⚠️ Warning**: Not for public use. SDK users should use the public
  /// [DietaryVitaminCRecord] constructor, which enforces validation and
  /// business
  /// rules. This factory is restricted to the SDK developers and contributors.
  @internalUse
  factory DietaryVitaminCRecord.internal({
    required Mass mass,
    required DateTime time,
    required Metadata metadata,
    HealthRecordId id = HealthRecordId.none,
    int? zoneOffsetSeconds,
    String? foodName,
    MealType mealType = MealType.unknown,
  }) {
    return DietaryVitaminCRecord._(
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
  DietaryVitaminCRecord copyWith({
    Mass? mass,
    DateTime? time,
    Metadata? metadata,
    HealthRecordId? id,
    int? zoneOffsetSeconds,
    String? foodName,
    MealType? mealType,
  }) {
    return DietaryVitaminCRecord(
      mass: mass ?? this.mass,
      time: time ?? this.time,
      metadata: metadata ?? this.metadata,
      id: id ?? this.id,
      zoneOffsetSeconds: zoneOffsetSeconds ?? this.zoneOffsetSeconds,
      foodName: foodName ?? this.foodName,
      mealType: mealType ?? this.mealType,
    );
  }

  const DietaryVitaminCRecord._({
    required super.mass,
    required super.time,
    required super.metadata,
    super.id = HealthRecordId.none,
    super.zoneOffsetSeconds,
    super.foodName,
    super.mealType,
  });
}
