part of 'health_record.dart';

/// Represents a VO₂ max (maximal oxygen uptake) measurement at a specific
/// point in time.
///
/// VO₂ max is the maximum rate of oxygen consumption measured during
/// incremental exercise. It is a key indicator of cardiorespiratory fitness
/// and endurance capacity.
///
/// This is a point-in-time (instant) record with a single timestamp.
///
/// ## Platform Mapping
///
/// ## Platform Mapping
///
/// - **Android Health Connect**: [`Vo2MaxRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/Vo2MaxRecord)
/// - **iOS HealthKit**: [`HKQuantityTypeIdentifier.vo2Max`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/vo2max)
///
/// ## Measurement Unit
///
/// VO₂ max is expressed in milliliters of oxygen per kilogram of body weight
/// per minute (mL/kg/min).
///
/// ## Example
///
/// ```dart
/// final record = Vo2MaxRecord(
///   time: DateTime.now(),
///   mLPerKgPerMin: Number(45.2),
///   testType: Vo2MaxTestType.cooperTest,
///   metadata: Metadata.manualEntry(),
/// );
/// ```
///
/// ## See also
///
/// - [Vo2MaxHealthDataType]
///
/// {@category Health Records}
@sinceV1_3_0
@immutable
final class Vo2MaxRecord extends InstantHealthRecord {
  /// Creates a VO₂ max record.
  ///
  /// ## Parameters
  ///
  /// - [id]: The unique identifier for this record.
  /// - [time]: The timestamp when the VO₂ max was measured.
  /// - [zoneOffsetSeconds]: Optional timezone offset for the measurement time.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [mLPerKgPerMin]: The VO₂ max measurement in mL/kg/min.
  /// - [testType]: Optional test type or measurement method used.
  const Vo2MaxRecord({
    required super.time,
    required super.metadata,
    required this.mLPerKgPerMin,
    this.testType,
    super.id = HealthRecordId.none,
    super.zoneOffsetSeconds,
  });

  /// The VO₂ max measurement in mL/kg/min.
  final Number mLPerKgPerMin;

  /// The test type or measurement method used to determine this VO₂ max value.
  ///
  /// This provides context about how the measurement was obtained:
  /// - Direct measurement (metabolic cart)
  /// - Field tests (Cooper, Rockport, beep test)
  /// - Prediction algorithms (heart rate ratio, step test)
  ///
  /// May be `null` if the measurement method is unknown.
  final Vo2MaxTestType? testType;

  /// Creates a copy with the given fields replaced with the new values.
  Vo2MaxRecord copyWith({
    DateTime? time,
    Number? mLPerKgPerMin,
    Vo2MaxTestType? testType,
    Metadata? metadata,
    HealthRecordId? id,
    int? zoneOffsetSeconds,
  }) {
    return Vo2MaxRecord(
      time: time ?? this.time,
      mLPerKgPerMin: mLPerKgPerMin ?? this.mLPerKgPerMin,
      testType: testType ?? this.testType,
      metadata: metadata ?? this.metadata,
      id: id ?? this.id,
      zoneOffsetSeconds: zoneOffsetSeconds ?? this.zoneOffsetSeconds,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Vo2MaxRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          time == other.time &&
          zoneOffsetSeconds == other.zoneOffsetSeconds &&
          mLPerKgPerMin == other.mLPerKgPerMin &&
          testType == other.testType &&
          metadata == other.metadata;

  @override
  int get hashCode =>
      id.hashCode ^
      time.hashCode ^
      (zoneOffsetSeconds?.hashCode ?? 0) ^
      mLPerKgPerMin.hashCode ^
      (testType?.hashCode ?? 0) ^
      metadata.hashCode;
}

/// Represents the test type or measurement method used to determine VO₂ max.
///
/// This enum provides a cross-platform abstraction for:
/// - **Android Health Connect**: `Vo2MaxMeasurementMethod` constants
/// - **iOS HealthKit**: `HKMetadataKeyVO2MaxTestType` enum
///
/// ## Platform Mapping
///
/// - **[metabolicCart]**: Android `METABOLIC_CART` (1), iOS `.maxExercise`
/// - **[heartRateRatio]**: Android `HEART_RATE_RATIO` (2),
///   iOS `.predictionNonExercise`
/// - **[cooperTest]**: Android `COOPER_TEST` (3),
///   iOS `.predictionSubMaxExercise`
/// - **[multistageFitnessTest]**: Android `MULTISTAGE_FITNESS_TEST` (4),
///   iOS `.predictionSubMaxExercise`
/// - **[rockportFitnessTest]**: Android `ROCKPORT_FITNESS_TEST` (5),
///   iOS `.predictionSubMaxExercise`
/// - **[predictionStepTest]**: Android `OTHER` (0), iOS `.predictionStepTest`
/// - **[other]**: Android `OTHER` (0), iOS `.predictionSubMaxExercise`
///
/// {@category Health Records}
@sinceV1_3_0
enum Vo2MaxTestType {
  /// Direct measurement using gas exchange analysis (metabolic cart).
  ///
  /// This is the gold standard for VO₂ max measurement, typically performed
  /// in a laboratory setting with specialized equipment.
  metabolicCart,

  /// Calculated using heart rate ratio (maxHR / restingHR).
  ///
  /// A non-exercise prediction method that estimates VO₂ max based on
  /// resting heart rate and demographic data.
  heartRateRatio,

  /// Based on the Cooper 12-minute run test.
  ///
  /// A field test where the distance covered in 12 minutes is used to
  /// estimate VO₂ max using validated formulas.
  cooperTest,

  /// Based on the multistage fitness test (beep test / bleep test).
  ///
  /// A progressive shuttle run test with increasing intensity levels.
  multistageFitnessTest,

  /// Based on the Rockport 1-mile walk test.
  ///
  /// A submaximal walking test that uses heart rate and walking speed
  /// to estimate VO₂ max.
  rockportFitnessTest,

  /// Step-based protocol (e.g., 3-minute step test).
  ///
  /// A prediction based on heart rate response to stepping exercises.
  predictionStepTest,

  /// Other or proprietary measurement method.
  ///
  /// Used when the specific method is unknown or not covered by
  /// the standard options (e.g., device-specific algorithms).
  other,
}
