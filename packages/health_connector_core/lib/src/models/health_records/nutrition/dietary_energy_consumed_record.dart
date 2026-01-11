part of '../health_record.dart';

/// Represents an energy (calorie) measurement from food at a specific point in
/// time.
///
/// [DietaryEnergyConsumedRecord] captures the energy content consumed from
/// food. This is an iOS-specific record for tracking individual energy intake.
///
/// ## Platform Mapping
///
/// - **iOS HealthKit Only**: [`HKQuantityTypeIdentifier.dietaryEnergyConsumed`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifie
/// r/dietaryenergyconsumed)
/// - **Android Health Connect**: Part of [`NutritionRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord)
///
/// ## Example
///
/// ```dart
/// final record = DietaryEnergyConsumedRecord(
///   time: DateTime.now(),
///   energy: Energy.kilocalories(250),
///   foodName: 'Apple',
///   mealType: MealType.snack,
///   metadata: Metadata.manualEntry(),
/// );
/// ```
///
/// ## See also
///
/// - [DietaryEnergyConsumedDataType]
///
/// {@category Health Records}
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class DietaryEnergyConsumedRecord extends NutrientRecord<Energy> {
  /// Creates an energy nutrient record.
  ///
  /// ## Parameters
  ///
  ///
  /// - [energy]: The energy (calorie) measurement.
  /// - [time]: The timestamp when the energy was consumed.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [id]: The unique identifier for this record.
  /// - [zoneOffsetSeconds]: Optional timezone offset for the measurement time.
  /// - [foodName]: Optional name of the food containing this energy.
  /// - [mealType]: The type of meal (breakfast, lunch, dinner, snack, unknown).
  factory DietaryEnergyConsumedRecord({
    required Energy energy,
    required DateTime time,
    required Metadata metadata,
    HealthRecordId id = HealthRecordId.none,
    int? zoneOffsetSeconds,
    String? foodName,
    MealType mealType = MealType.unknown,
  }) {
    return DietaryEnergyConsumedRecord._(
      energy: energy,
      time: time,
      metadata: metadata,
      id: id,
      zoneOffsetSeconds: zoneOffsetSeconds,
      foodName: foodName,
      mealType: mealType,
    );
  }

  /// Internal factory for creating [DietaryEnergyConsumedRecord] instances
  /// without
  /// validation.
  ///
  /// Creates a [DietaryEnergyConsumedRecord] by directly mapping platform data
  /// to
  /// fields, bypassing the normal validation and business rules applied by the
  /// public constructor.
  ///
  /// **⚠️ Warning**: Not for public use. SDK users should use the public
  /// [DietaryEnergyConsumedRecord] constructor, which enforces validation and
  /// business
  /// rules. This factory is restricted to the SDK developers and contributors.
  @internalUse
  factory DietaryEnergyConsumedRecord.internal({
    required Energy energy,
    required DateTime time,
    required Metadata metadata,
    HealthRecordId id = HealthRecordId.none,
    int? zoneOffsetSeconds,
    String? foodName,
    MealType mealType = MealType.unknown,
  }) {
    return DietaryEnergyConsumedRecord._(
      energy: energy,
      time: time,
      metadata: metadata,
      id: id,
      zoneOffsetSeconds: zoneOffsetSeconds,
      foodName: foodName,
      mealType: mealType,
    );
  }

  /// The energy (calorie) measurement.
  final Energy energy;

  /// Creates a copy with the given fields replaced with the new values.
  DietaryEnergyConsumedRecord copyWith({
    Energy? energy,
    DateTime? time,
    Metadata? metadata,
    HealthRecordId? id,
    int? zoneOffsetSeconds,
    String? foodName,
    MealType? mealType,
  }) {
    return DietaryEnergyConsumedRecord(
      energy: energy ?? this.energy,
      time: time ?? this.time,
      metadata: metadata ?? this.metadata,
      id: id ?? this.id,
      zoneOffsetSeconds: zoneOffsetSeconds ?? this.zoneOffsetSeconds,
      foodName: foodName ?? this.foodName,
      mealType: mealType ?? this.mealType,
    );
  }

  const DietaryEnergyConsumedRecord._({
    required this.energy,
    required super.time,
    required super.metadata,
    super.id = HealthRecordId.none,
    super.zoneOffsetSeconds,
    super.foodName,
    super.mealType,
  });
}
