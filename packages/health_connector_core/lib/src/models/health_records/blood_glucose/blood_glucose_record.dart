part of '../health_record.dart';

/// Represents a single blood glucose measurement.
///
/// [BloodGlucoseRecord] captures the blood glucose level at a specific point in
/// time, along with context about the measurement (relationship to meal,
/// meal type, and specimen source).
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: [`BloodGlucoseRecord`](https://developer.andro
/// id.com/reference/kotlin/androidx/health/connect/client/records/BloodGlucoseR
/// ecord)
/// - **iOS HealthKit**: [`HKQuantityTypeIdentifier.bloodGlucose`](https://devel
/// oper.apple.com/documentation/healthkit/hkquantitytypeidentifier/bloodglucose
/// )
///
/// ## Example
///
/// ```dart
/// final record = BloodGlucoseRecord(
///   time: DateTime.now(),
///   glucoseLevel: BloodGlucose.millimolesPerLiter(5.5),
///   relationToMeal: BloodGlucoseRelationToMeal.fasting,
///   mealType: MealType.breakfast,
///   specimenSource: BloodGlucoseSpecimenSource.capillaryBlood,
///   metadata: Metadata.manualEntry(),
/// );
/// ```
///
/// ## See also
///
/// - [BloodGlucoseDataType]
///
/// {@category Health Records}
@sinceV1_4_0
@immutable
final class BloodGlucoseRecord extends InstantHealthRecord {
  /// Creates a blood glucose record.
  ///
  /// ## Parameters
  ///
  /// - [id]: The unique identifier for this record.
  /// - [time]: The timestamp when the measurement was taken.
  /// - [zoneOffsetSeconds]: Optional timezone offset for the measurement time.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [glucoseLevel]: The blood glucose level.
  /// - [relationToMeal]: The relationship to a meal (e.g., fasting, after
  ///   meal).
  /// - [mealType]: The type of meal (e.g., breakfast, lunch).
  /// - [specimenSource]: The source of the specimen (e.g., capillary blood).
  const BloodGlucoseRecord({
    required super.time,
    required super.metadata,
    required this.glucoseLevel,
    super.id = HealthRecordId.none,
    super.zoneOffsetSeconds,
    this.relationToMeal = BloodGlucoseRelationToMeal.unknown,
    this.mealType = MealType.unknown,
    this.specimenSource = BloodGlucoseSpecimenSource.unknown,
  });

  /// Internal factory for creating [BloodGlucoseRecord] instances without
  /// validation.
  ///
  /// Creates a [BloodGlucoseRecord] by directly mapping platform data to
  /// fields, bypassing the normal validation and business rules applied by the
  /// public constructor.
  ///
  /// **⚠️ Warning**: Not for public use. SDK users should use the public
  /// [BloodGlucoseRecord] constructor, which enforces validation and business
  /// rules. This factory is restricted to the SDK developers and contributors.
  @internalUse
  factory BloodGlucoseRecord.internal({
    required HealthRecordId id,
    required DateTime time,
    required Metadata metadata,
    required BloodGlucose glucoseLevel,
    int? zoneOffsetSeconds,
    BloodGlucoseRelationToMeal relationToMeal =
        BloodGlucoseRelationToMeal.unknown,
    MealType mealType = MealType.unknown,
    BloodGlucoseSpecimenSource specimenSource =
        BloodGlucoseSpecimenSource.unknown,
  }) {
    return BloodGlucoseRecord._(
      id: id,
      time: time,
      metadata: metadata,
      glucoseLevel: glucoseLevel,
      zoneOffsetSeconds: zoneOffsetSeconds,
      relationToMeal: relationToMeal,
      mealType: mealType,
      specimenSource: specimenSource,
    );
  }

  /// Private constructor without validation.
  const BloodGlucoseRecord._({
    required super.time,
    required super.metadata,
    required this.glucoseLevel,
    required super.id,
    required this.relationToMeal,
    required this.mealType,
    required this.specimenSource,
    super.zoneOffsetSeconds,
  });

  /// The blood glucose level.
  final BloodGlucose glucoseLevel;

  /// The relationship of this measurement to a meal.
  final BloodGlucoseRelationToMeal relationToMeal;

  /// The type of meal associated with this measurement.
  final MealType mealType;

  /// The source of the biological specimen.
  final BloodGlucoseSpecimenSource specimenSource;

  /// Creates a copy with the given fields replaced with the new values.
  BloodGlucoseRecord copyWith({
    DateTime? time,
    BloodGlucose? glucoseLevel,
    Metadata? metadata,
    HealthRecordId? id,
    int? zoneOffsetSeconds,
    BloodGlucoseRelationToMeal? relationToMeal,
    MealType? mealType,
    BloodGlucoseSpecimenSource? specimenSource,
  }) {
    return BloodGlucoseRecord(
      time: time ?? this.time,
      glucoseLevel: glucoseLevel ?? this.glucoseLevel,
      metadata: metadata ?? this.metadata,
      id: id ?? this.id,
      zoneOffsetSeconds: zoneOffsetSeconds ?? this.zoneOffsetSeconds,
      relationToMeal: relationToMeal ?? this.relationToMeal,
      mealType: mealType ?? this.mealType,
      specimenSource: specimenSource ?? this.specimenSource,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BloodGlucoseRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          time == other.time &&
          zoneOffsetSeconds == other.zoneOffsetSeconds &&
          glucoseLevel == other.glucoseLevel &&
          relationToMeal == other.relationToMeal &&
          mealType == other.mealType &&
          specimenSource == other.specimenSource &&
          metadata == other.metadata;

  @override
  int get hashCode =>
      id.hashCode ^
      time.hashCode ^
      (zoneOffsetSeconds?.hashCode ?? 0) ^
      glucoseLevel.hashCode ^
      relationToMeal.hashCode ^
      mealType.hashCode ^
      specimenSource.hashCode ^
      metadata.hashCode;
}
