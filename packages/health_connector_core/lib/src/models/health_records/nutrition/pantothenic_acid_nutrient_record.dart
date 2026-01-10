part of '../health_record.dart';

/// Represents a pantothenic acid (vitamin B5) measurement from food at a
/// specific point in time.
///
/// [PantothenicAcidNutrientRecord] captures the pantothenic acid content
/// consumed from food.
/// This is an iOS-specific record for tracking individual pantothenic acid
/// intake.
///
/// ## Platform Mapping
///
/// - **iOS HealthKit Only**: [`HKQuantityTypeIdentifier.dietaryPantothenicAcid`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/dietarypantothenicacid)
/// - **Android Health Connect**: Part of [`NutritionRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/NutritionRecord)
///
/// ## Example
///
/// ```dart
/// final record = PantothenicAcidNutrientRecord(
///   time: DateTime.now(),
///   mass: Mass.milligrams(1),
///   foodName: 'Avocado',
///   mealType: MealType.snack,
///   metadata: Metadata.manualEntry(),
/// );
/// ```
///
/// ## See also
///
/// - [PantothenicAcidNutrientDataType]
///
/// {@category Health Records}
@sinceV1_1_0
@supportedOnAppleHealth
@immutable
final class PantothenicAcidNutrientRecord extends VitaminNutrientRecord {
  /// Creates a pantothenic acid nutrient record.
  ///
  /// ## Parameters
  ///
  ///
  /// - [mass]: The pantothenic acid measurement.
  /// - [time]: The timestamp when the pantothenic acid was consumed.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [id]: The unique identifier for this record.
  /// - [zoneOffsetSeconds]: Optional timezone offset for the measurement time.
  /// - [foodName]: Optional name of the food containing this pantothenic acid.
  /// - [mealType]: The type of meal (breakfast, lunch, dinner, snack, unknown).
  factory PantothenicAcidNutrientRecord({
    required Mass mass,
    required DateTime time,
    required Metadata metadata,
    HealthRecordId id = HealthRecordId.none,
    int? zoneOffsetSeconds,
    String? foodName,
    MealType mealType = MealType.unknown,
  }) {
    return PantothenicAcidNutrientRecord._(
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
  PantothenicAcidNutrientRecord copyWith({
    Mass? mass,
    DateTime? time,
    Metadata? metadata,
    HealthRecordId? id,
    int? zoneOffsetSeconds,
    String? foodName,
    MealType? mealType,
  }) {
    return PantothenicAcidNutrientRecord._(
      mass: mass ?? this.mass,
      time: time ?? this.time,
      metadata: metadata ?? this.metadata,
      id: id ?? this.id,
      zoneOffsetSeconds: zoneOffsetSeconds ?? this.zoneOffsetSeconds,
      foodName: foodName ?? this.foodName,
      mealType: mealType ?? this.mealType,
    );
  }

  const PantothenicAcidNutrientRecord._({
    required super.mass,
    required super.time,
    required super.metadata,
    super.id = HealthRecordId.none,
    super.zoneOffsetSeconds,
    super.foodName,
    super.mealType,
  });
}
