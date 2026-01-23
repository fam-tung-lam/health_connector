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
/// - **Android Health Connect**: [`Vo2MaxRecord`](https://developer.android.com/reference/kotlin/androidx/health/connect/client/records/Vo2MaxRecord)
/// - **iOS HealthKit**: [`HKQuantityTypeIdentifier.vo2Max`](https://developer.apple.com/documentation/healthkit/hkquantitytypeidentifier/vo2max)
///
/// ## Example
///
/// ```dart
/// final record = Vo2MaxRecord(
///   time: DateTime.now(),
///   vo2MlPerMinPerKg: Number(45.2),
///   testType: Vo2MaxTestType.cooperTest,
///   metadata: Metadata.manualEntry(),
/// );
/// ```
///
/// ## See also
///
/// - [Vo2MaxDataType]
///
/// {@category Health Records}
@sinceV1_3_0
@immutable
final class Vo2MaxRecord extends InstantHealthRecord {
  /// Minimum valid VO₂ max (5.0 mL/kg/min).
  ///
  /// Very sedentary/severely ill lower limit.
  static const Number minVo2MlPerMinPerKg = Number(5.0);

  /// Maximum valid VO₂ max (100.0 mL/kg/min).
  ///
  /// Exceeds world record (97.5 mL/kg/min, Oskar Svendsen) with margin for
  /// measurement variance.
  static const Number maxVo2MlPerMinPerKg = Number(100.0);

  /// Creates a VO₂ max record.
  ///
  /// ## Parameters
  ///
  /// The unique identifier for this record.
  /// - [time]: The timestamp when the VO₂ max was measured.
  /// - [zoneOffsetSeconds]: Optional timezone offset for the measurement time.
  /// - [metadata]: Metadata about the origin and recording method.
  /// - [vo2MlPerMinPerKg]: The VO₂ max measurement in mL/kg/min.
  /// - [testType]: Optional test type or measurement method used.
  ///
  /// ## Throws
  ///
  /// - [ArgumentError] if [vo2MlPerMinPerKg] is outside the valid range of
  ///   [minVo2MlPerMinPerKg]-[maxVo2MlPerMinPerKg] mL/kg/min.
  ///
  /// ## Validation Rationale
  ///
  /// - **Minimum ([minVo2MlPerMinPerKg] mL/kg/min)**: Very sedentary/severely ill lower limit.
  /// - **Maximum ([maxVo2MlPerMinPerKg] mL/kg/min)**: Exceeds world record (97.5 mL/kg/min,
  ///   Oskar Svendsen) with margin for measurement variance.
  Vo2MaxRecord({
    required super.time,
    required super.metadata,
    required this.vo2MlPerMinPerKg,
    this.testType,
    super.id,
    super.zoneOffsetSeconds,
  }) {
    require(
      condition:
          vo2MlPerMinPerKg >= minVo2MlPerMinPerKg &&
          vo2MlPerMinPerKg <= maxVo2MlPerMinPerKg,
      value: vo2MlPerMinPerKg,
      name: 'vo2MlPerMinPerKg',
      message:
          'VO₂ max must be between '
          '${minVo2MlPerMinPerKg.value}-'
          '${maxVo2MlPerMinPerKg.value} mL/kg/min. '
          'Got ${vo2MlPerMinPerKg.value.toStringAsFixed(1)} mL/kg/min.',
    );
  }

  /// Internal factory for creating [Vo2MaxRecord] instances
  /// without validation.
  ///
  /// **⚠️ Warning**: Not for public use.
  @internalUse
  factory Vo2MaxRecord.internal({
    required HealthRecordId id,
    required DateTime time,
    required Metadata metadata,
    required Number vo2MlPerMinPerKg,
    Vo2MaxTestType? testType,
    int? zoneOffsetSeconds,
  }) {
    return Vo2MaxRecord._(
      id: id,
      time: time,
      metadata: metadata,
      vo2MlPerMinPerKg: vo2MlPerMinPerKg,
      testType: testType,
      zoneOffsetSeconds: zoneOffsetSeconds,
    );
  }

  Vo2MaxRecord._({
    required super.id,
    required super.time,
    required super.metadata,
    required this.vo2MlPerMinPerKg,
    this.testType,
    super.zoneOffsetSeconds,
  });

  /// The VO₂ max measurement in mL/kg/min.
  final Number vo2MlPerMinPerKg;

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
    Number? vo2MlPerMinPerKg,
    Vo2MaxTestType? testType,
    Metadata? metadata,
    HealthRecordId? id,
    int? zoneOffsetSeconds,
  }) {
    return Vo2MaxRecord(
      time: time ?? this.time,
      vo2MlPerMinPerKg: vo2MlPerMinPerKg ?? this.vo2MlPerMinPerKg,
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
          vo2MlPerMinPerKg == other.vo2MlPerMinPerKg &&
          testType == other.testType &&
          metadata == other.metadata;

  @override
  int get hashCode =>
      id.hashCode ^
      time.hashCode ^
      (zoneOffsetSeconds?.hashCode ?? 0) ^
      vo2MlPerMinPerKg.hashCode ^
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
