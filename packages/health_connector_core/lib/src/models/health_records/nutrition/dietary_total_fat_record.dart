part of '../health_record.dart';

/// Represents a total fat measurement from food at a specific point in time.
///
/// [DietaryTotalFatRecord] captures the total fat content consumed from food.
/// This is an iOS-specific record for tracking individual total fat intake.
///
/// ## Platform Mapping
///
/// - **iOS HealthKit Only**: [`HKQuantityTypeIdentifier.dietaryFatTotal`](https
/// ://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/diet
/// aryfattotal)
/// - **Android Health Connect**: Part of [`NutritionRecord`](https://developer.
/// android.com/reference/kotlin/androidx/health/connect/client/records/Nutritio
/// nRecord)
///
/// ## Example
///
/// ```dart
/// final record = DietaryTotalFatRecord(
///   time: DateTime.now(),
///   mass: Mass.grams(15),
///   foodName: 'Avocado',
///   mealType: MealType.snack,
///   metadata: Metadata.manualEntry(),
/// );
/// ```
///
/// ## See also
///
/// - [DietaryTotalFatDataType]
///
/// {@category Health Records}
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class DietaryTotalFatRecord extends DietaryMacronutrientRecord {
  /// Creates a total fat nutrient record.
  ///
  /// ## Parameters
  ///
  /// - [mass]: The total fat measurement.
  /// - [time]: The timestamp when the total fat was consumed.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [id]: The unique identifier for this record.
  /// - [zoneOffsetSeconds]: Optional timezone offset for the measurement time.
  /// - [foodName]: Optional name of the food containing this total fat.
  /// - [mealType]: The type of meal (breakfast, lunch, dinner, snack, unknown).
  factory DietaryTotalFatRecord({
    required Mass mass,
    required DateTime time,
    required Metadata metadata,
    HealthRecordId id = HealthRecordId.none,
    int? zoneOffsetSeconds,
    String? foodName,
    MealType mealType = MealType.unknown,
  }) {
    return DietaryTotalFatRecord._(
      mass: mass,
      time: time,
      metadata: metadata,
      id: id,
      zoneOffsetSeconds: zoneOffsetSeconds,
      foodName: foodName,
      mealType: mealType,
    );
  }

  /// Internal factory for creating [DietaryTotalFatRecord] instances without
  /// validation.
  ///
  /// Creates a [DietaryTotalFatRecord] by directly mapping platform data to
  /// fields, bypassing the normal validation and business rules applied by the
  /// public constructor.
  ///
  /// **⚠️ Warning**: Not for public use. SDK users should use the public
  /// [DietaryTotalFatRecord] constructor, which enforces validation and
  /// business
  /// rules. This factory is restricted to the SDK developers and contributors.
  @internalUse
  factory DietaryTotalFatRecord.internal({
    required Mass mass,
    required DateTime time,
    required Metadata metadata,
    HealthRecordId id = HealthRecordId.none,
    int? zoneOffsetSeconds,
    String? foodName,
    MealType mealType = MealType.unknown,
  }) {
    return DietaryTotalFatRecord._(
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
  DietaryTotalFatRecord copyWith({
    Mass? mass,
    DateTime? time,
    Metadata? metadata,
    HealthRecordId? id,
    int? zoneOffsetSeconds,
    String? foodName,
    MealType? mealType,
  }) {
    return DietaryTotalFatRecord(
      mass: mass ?? this.mass,
      time: time ?? this.time,
      metadata: metadata ?? this.metadata,
      id: id ?? this.id,
      zoneOffsetSeconds: zoneOffsetSeconds ?? this.zoneOffsetSeconds,
      foodName: foodName ?? this.foodName,
      mealType: mealType ?? this.mealType,
    );
  }

  const DietaryTotalFatRecord._({
    required super.mass,
    required super.time,
    required super.metadata,
    super.id = HealthRecordId.none,
    super.zoneOffsetSeconds,
    super.foodName,
    super.mealType,
  });
}
