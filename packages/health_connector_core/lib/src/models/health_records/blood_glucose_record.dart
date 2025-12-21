part of 'health_record.dart';

/// Represents a single blood glucose measurement.
///
/// [BloodGlucoseRecord] captures the blood glucose level at a specific point in
/// time, along with context about the measurement (relationship to meal,
/// meal type, and specimen source).
///
/// ## Platform Mapping
///
/// - **Android**: Maps to Health Connect's `BloodGlucoseRecord`
/// - **iOS**: Maps to HealthKit's `HKQuantityType(.bloodGlucose)`
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
  /// - [bloodGlucose]: The blood glucose level.
  /// - [relationToMeal]: The relationship to a meal (e.g., fasting, after
  ///   meal).
  /// - [mealType]: The type of meal (e.g., breakfast, lunch).
  /// - [specimenSource]: The source of the specimen (e.g., capillary blood).
  const BloodGlucoseRecord({
    required super.time,
    required super.metadata,
    required this.bloodGlucose,
    super.id = HealthRecordId.none,
    super.zoneOffsetSeconds,
    this.relationToMeal = BloodGlucoseRelationToMeal.unknown,
    this.mealType = BloodGlucoseMealType.unknown,
    this.specimenSource = BloodGlucoseSpecimenSource.unknown,
  });

  /// The blood glucose level.
  final BloodGlucose bloodGlucose;

  /// The relationship of this measurement to a meal.
  final BloodGlucoseRelationToMeal relationToMeal;

  /// The type of meal associated with this measurement.
  final BloodGlucoseMealType mealType;

  /// The source of the biological specimen.
  final BloodGlucoseSpecimenSource specimenSource;

  @override
  List<HealthPlatform> get supportedHealthPlatforms => [
    HealthPlatform.healthConnect,
    HealthPlatform.appleHealth,
  ];

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BloodGlucoseRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          time == other.time &&
          zoneOffsetSeconds == other.zoneOffsetSeconds &&
          bloodGlucose == other.bloodGlucose &&
          relationToMeal == other.relationToMeal &&
          mealType == other.mealType &&
          specimenSource == other.specimenSource &&
          metadata == other.metadata;

  @override
  int get hashCode =>
      id.hashCode ^
      time.hashCode ^
      (zoneOffsetSeconds?.hashCode ?? 0) ^
      bloodGlucose.hashCode ^
      relationToMeal.hashCode ^
      mealType.hashCode ^
      specimenSource.hashCode ^
      metadata.hashCode;

  @override
  String get name => 'blood_glucose_record';
}

/// Represents the type of meal associated with the measurement.
@sinceV1_4_0
enum BloodGlucoseMealType {
  /// Meal type unknown or unspecified.
  unknown,

  /// First meal of the day, typically morning.
  breakfast,

  /// Noon meal.
  lunch,

  /// Last meal of the day, typically evening.
  dinner,

  /// Any meal outside the usual three daily meals.
  snack,
}

/// Represents the relationship of a blood glucose measurement to a meal.
@sinceV1_4_0
enum BloodGlucoseRelationToMeal {
  /// Relationship is unknown or not specified.
  unknown,

  /// General meal context without specific timing information.
  general,

  /// Measurement taken while fasting (typically 8+ hours without food).
  fasting,

  /// Measurement taken before consuming a meal (preprandial).
  beforeMeal,

  /// Measurement taken after consuming a meal (postprandial).
  afterMeal,
}

/// Represents the source of the biological specimen used for the measurement.
@sinceV1_4_0
enum BloodGlucoseSpecimenSource {
  /// Source unknown or unspecified.
  unknown,

  /// Interstitial fluid, typically from continuous glucose monitors (CGMs).
  interstitialFluid,

  /// Capillary blood from fingerstick testing.
  capillaryBlood,

  /// Blood plasma (laboratory reference standard).
  plasma,

  /// Blood serum.
  serum,

  /// Tears (experimental measurement source).
  tears,

  /// Whole blood.
  wholeBlood,
}
