part of '../health_record.dart';

/// Represents a sodium measurement from food at a specific point in time.
///
/// [SodiumNutrientRecord] captures the sodium content consumed from food.
/// This is an iOS-specific record for tracking individual sodium intake.
///
/// ## Platform Mapping
///
/// - **iOS HealthKit Only**: [`HKQuantityTypeIdentifier.dietarySodium`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietarysodium)
/// - **Android Health Connect**: Part of [`NutritionRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord)
///
/// ## Example
///
/// ```dart
/// final record = SodiumNutrientRecord(
///   time: DateTime.now(),
///   mass: Mass.milligrams(700),
///   foodName: 'Soup',
///   mealType: MealType.lunch,
///   metadata: Metadata.manualEntry(),
/// );
/// ```
///
/// ## See also
///
/// - [SodiumNutrientDataType]
///
/// {@category Health Records}
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class SodiumNutrientRecord extends MineralNutrientRecord {
  /// Creates a sodium nutrient record.
  ///
  /// ## Parameters
  ///
  /// - [mass]: The sodium measurement.
  /// - [time]: The timestamp when the sodium was consumed.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [id]: The unique identifier for this record.
  /// - [zoneOffsetSeconds]: Optional timezone offset for the measurement time.
  /// - [foodName]: Optional name of the food containing this sodium.
  /// - [mealType]: The type of meal (breakfast, lunch, dinner, snack, unknown).
  factory SodiumNutrientRecord({
    required Mass mass,
    required DateTime time,
    required Metadata metadata,
    HealthRecordId id = HealthRecordId.none,
    int? zoneOffsetSeconds,
    String? foodName,
    MealType mealType = MealType.unknown,
  }) {
    return SodiumNutrientRecord._(
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
  SodiumNutrientRecord copyWith({
    Mass? mass,
    DateTime? time,
    Metadata? metadata,
    HealthRecordId? id,
    int? zoneOffsetSeconds,
    String? foodName,
    MealType? mealType,
  }) {
    return SodiumNutrientRecord._(
      mass: mass ?? this.mass,
      time: time ?? this.time,
      metadata: metadata ?? this.metadata,
      id: id ?? this.id,
      zoneOffsetSeconds: zoneOffsetSeconds ?? this.zoneOffsetSeconds,
      foodName: foodName ?? this.foodName,
      mealType: mealType ?? this.mealType,
    );
  }

  const SodiumNutrientRecord._({
    required this.mass,
    required super.time,
    required super.metadata,
    super.id = HealthRecordId.none,
    super.zoneOffsetSeconds,
    super.foodName,
    super.mealType,
  });

  /// The sodium measurement.
  final Mass mass;
}
