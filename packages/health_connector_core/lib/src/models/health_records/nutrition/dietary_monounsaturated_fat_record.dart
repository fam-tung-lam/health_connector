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
/// - **iOS HealthKit Only**: [`HKQuantityTypeIdentifier.dietaryFatMonounsaturat
/// ed`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietaryFatMonounsaturated)
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
  DietaryMonounsaturatedFatRecord({
    required super.mass,
    required super.time,
    required super.metadata,
    super.id = HealthRecordId.none,
    super.zoneOffsetSeconds,
    super.foodName,
    super.mealType,
  });

  /// Internal factory for creating [DietaryMonounsaturatedFatRecord] instances
  /// without
  /// validation.
  ///
  /// Creates a [DietaryMonounsaturatedFatRecord] by directly mapping platform
  /// data to
  /// fields, bypassing the normal validation and business rules applied by the
  /// public constructor.
  ///
  /// **⚠️ Warning**: Not for public use. SDK users should use the public
  /// [DietaryMonounsaturatedFatRecord] constructor, which enforces validation
  /// and business
  /// rules. This factory is restricted to the SDK developers and contributors.
  @internalUse
  factory DietaryMonounsaturatedFatRecord.internal({
    required Mass mass,
    required DateTime time,
    required Metadata metadata,
    HealthRecordId id = HealthRecordId.none,
    int? zoneOffsetSeconds,
    String? foodName,
    MealType mealType = MealType.unknown,
  }) {
    return DietaryMonounsaturatedFatRecord(
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
    return DietaryMonounsaturatedFatRecord(
      mass: mass ?? this.mass,
      time: time ?? this.time,
      metadata: metadata ?? this.metadata,
      id: id ?? this.id,
      zoneOffsetSeconds: zoneOffsetSeconds ?? this.zoneOffsetSeconds,
      foodName: foodName ?? this.foodName,
      mealType: mealType ?? this.mealType,
    );
  }
}
