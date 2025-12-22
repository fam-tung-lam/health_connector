import 'package:health_connector/health_connector.dart'
    show
        ActiveCaloriesBurnedHealthDataType,
        ActiveCaloriesBurnedRecord,
        BiotinNutrientDataType,
        BiotinNutrientRecord,
        BodyFatPercentageHealthDataType,
        BodyFatPercentageRecord,
        BloodPressureBodyPosition,
        BloodPressureHealthDataType,
        BloodPressureMeasurementLocation,
        BloodPressureRecord,
        BloodGlucose,
        BodyTemperatureHealthDataType,
        BodyTemperatureRecord,
        BloodGlucoseHealthDataType,
        BloodGlucoseRecord,
        BloodGlucoseRelationToMeal,
        BloodGlucoseMealType,
        BloodGlucoseSpecimenSource,
        CaffeineNutrientDataType,
        CaffeineNutrientRecord,
        CalciumNutrientDataType,
        CalciumNutrientRecord,
        CholesterolNutrientDataType,
        CholesterolNutrientRecord,
        DietaryFiberNutrientDataType,
        DietaryFiberNutrientRecord,
        DiastolicBloodPressureHealthDataType,
        DiastolicBloodPressureRecord,
        DistanceHealthDataType,
        DistanceRecord,
        Energy,
        EnergyNutrientDataType,
        EnergyNutrientRecord,
        FloorsClimbedHealthDataType,
        FloorsClimbedRecord,
        FolateNutrientDataType,
        FolateNutrientRecord,
        HealthDataType,
        HealthRecord,
        HealthRecordId,
        HeartRateMeasurement,
        HeartRateMeasurementRecord,
        HeartRateMeasurementRecordHealthDataType,
        HeartRateSeriesRecord,
        HeartRateSeriesRecordHealthDataType,
        HeightHealthDataType,
        HeightRecord,
        HydrationHealthDataType,
        HydrationRecord,
        IronNutrientDataType,
        IronNutrientRecord,
        LeanBodyMassHealthDataType,
        LeanBodyMassRecord,
        MagnesiumNutrientDataType,
        MagnesiumNutrientRecord,
        ManganeseNutrientDataType,
        ManganeseNutrientRecord,
        Mass,
        MealType,
        MeasurementUnit,
        Metadata,
        MonounsaturatedFatNutrientDataType,
        MonounsaturatedFatNutrientRecord,
        PolyunsaturatedFatNutrientDataType,
        PolyunsaturatedFatNutrientRecord,
        NiacinNutrientDataType,
        NiacinNutrientRecord,
        NutritionHealthDataType,
        NutritionRecord,
        PantothenicAcidNutrientDataType,
        PantothenicAcidNutrientRecord,
        Percentage,
        OxygenSaturationHealthDataType,
        OxygenSaturationRecord,
        Length,
        PhosphorusNutrientDataType,
        PhosphorusNutrientRecord,
        PotassiumNutrientDataType,
        PotassiumNutrientRecord,
        ProteinNutrientDataType,
        ProteinNutrientRecord,
        Pressure,
        RiboflavinNutrientDataType,
        RiboflavinNutrientRecord,
        RestingHeartRateHealthDataType,
        RestingHeartRateRecord,
        SaturatedFatNutrientDataType,
        SaturatedFatNutrientRecord,
        SeleniumNutrientDataType,
        SeleniumNutrientRecord,
        SodiumNutrientDataType,
        SodiumNutrientRecord,
        StepsHealthDataType,
        SugarNutrientDataType,
        SugarNutrientRecord,
        SystolicBloodPressureHealthDataType,
        SystolicBloodPressureRecord,
        Temperature,
        ThiaminNutrientDataType,
        ThiaminNutrientRecord,
        TotalCarbohydrateNutrientDataType,
        TotalCarbohydrateNutrientRecord,
        TotalFatNutrientDataType,
        TotalFatNutrientRecord,
        Volume,
        VitaminANutrientDataType,
        VitaminANutrientRecord,
        VitaminB12NutrientDataType,
        VitaminB12NutrientRecord,
        VitaminB6NutrientDataType,
        VitaminB6NutrientRecord,
        VitaminCNutrientDataType,
        VitaminCNutrientRecord,
        VitaminDNutrientDataType,
        VitaminDNutrientRecord,
        VitaminENutrientDataType,
        VitaminENutrientRecord,
        VitaminKNutrientDataType,
        VitaminKNutrientRecord,
        WeightHealthDataType,
        WeightRecord,
        WheelchairPushesHealthDataType,
        WheelchairPushesRecord,
        ZincNutrientDataType,
        ZincNutrientRecord,
        SleepSessionRecord,
        SleepSessionHealthDataType,
        SleepStage,
        SleepStageRecord,
        SleepStageHealthDataType,
        SleepStageType,
        RespiratoryRateRecord,
        RespiratoryRateHealthDataType,
        Number,
        Vo2MaxHealthDataType,
        Vo2MaxRecord,
        Vo2MaxTestType,
        CrossCountrySkiingDistanceDataType,
        CrossCountrySkiingDistanceRecord,
        CyclingDistanceDataType,
        CyclingDistanceRecord,
        DownhillSnowSportsDistanceDataType,
        DownhillSnowSportsDistanceRecord,
        PaddleSportsDistanceDataType,
        PaddleSportsDistanceRecord,
        RowingDistanceDataType,
        RowingDistanceRecord,
        SixMinuteWalkTestDistanceDataType,
        SixMinuteWalkTestDistanceRecord,
        SkatingSportsDistanceDataType,
        SkatingSportsDistanceRecord,
        SwimmingDistanceDataType,
        SwimmingDistanceRecord,
        WheelchairDistanceDataType,
        WheelchairDistanceRecord,
        WalkingRunningDistanceDataType,
        WalkingRunningDistanceRecord,
        StepsRecord;

/// Configuration for a health record write form.
///
/// Each health data type has its own configuration that defines:
/// - Whether the form needs duration (interval records vs instant records)
/// - How to build the HealthRecord from form values
/// - What validation rules apply
sealed class HealthRecordFormConfig {
  const HealthRecordFormConfig();

  /// Whether the form needs duration (interval records vs instant records).
  bool get needsDuration;

  /// Builds a [HealthRecord] from the provided form values.
  ///
  /// ## Parameters
  ///
  /// - [startDateTime]: The start date/time for the record
  /// - [endDateTime]: The end date/time (required if [needsDuration] is true)
  /// - [value]: The measurement value (e.g., step count, weight)
  /// - [metadata]: The metadata for the record
  ///
  /// ## Returns
  ///
  /// A [HealthRecord] instance ready to be written.
  HealthRecord buildRecord({
    required DateTime startDateTime,
    required MeasurementUnit value,
    required Metadata metadata,
    DateTime? endDateTime,
  });

  /// Factory to get config for a given [HealthDataType].
  factory HealthRecordFormConfig.fromDataType(HealthDataType type) {
    return switch (type) {
      StepsHealthDataType() => const StepsFormConfig(),
      WeightHealthDataType() => const WeightFormConfig(),
      HeightHealthDataType() => const HeightFormConfig(),
      BodyFatPercentageHealthDataType() => const BodyFatPercentageFormConfig(),
      LeanBodyMassHealthDataType() => const LeanBodyMassFormConfig(),
      OxygenSaturationHealthDataType() => const OxygenSaturationFormConfig(),
      BodyTemperatureHealthDataType() => const BodyTemperatureFormConfig(),
      BloodPressureHealthDataType() => const BloodPressureFormConfig(),
      SystolicBloodPressureHealthDataType() =>
        const SystolicBloodPressureFormConfig(),
      DiastolicBloodPressureHealthDataType() =>
        const DiastolicBloodPressureFormConfig(),
      DistanceHealthDataType() => const DistanceFormConfig(),
      CrossCountrySkiingDistanceDataType() =>
        const CrossCountrySkiingDistanceFormConfig(),
      CyclingDistanceDataType() => const CyclingDistanceFormConfig(),
      DownhillSnowSportsDistanceDataType() =>
        const DownhillSnowSportsDistanceFormConfig(),
      PaddleSportsDistanceDataType() => const PaddleSportsDistanceFormConfig(),
      RowingDistanceDataType() => const RowingDistanceFormConfig(),
      SixMinuteWalkTestDistanceDataType() =>
        const SixMinuteWalkTestDistanceFormConfig(),
      SkatingSportsDistanceDataType() =>
        const SkatingSportsDistanceFormConfig(),
      SwimmingDistanceDataType() => const SwimmingDistanceFormConfig(),
      WheelchairDistanceDataType() => const WheelchairDistanceFormConfig(),
      WalkingRunningDistanceDataType() =>
        const WalkingRunningDistanceFormConfig(),
      ActiveCaloriesBurnedHealthDataType() =>
        const ActiveCaloriesBurnedFormConfig(),
      FloorsClimbedHealthDataType() => const FloorsClimbedFormConfig(),
      WheelchairPushesHealthDataType() => const WheelchairPushesFormConfig(),
      HydrationHealthDataType() => const HydrationFormConfig(),
      HeartRateMeasurementRecordHealthDataType() =>
        const HeartRateMeasurementRecordFormConfig(),
      HeartRateSeriesRecordHealthDataType() =>
        const HeartRateSeriesRecordFormConfig(),
      SleepStageHealthDataType() => const SleepStageRecordFormConfig(),
      SleepSessionHealthDataType() => const SleepSessionRecordFormConfig(),
      EnergyNutrientDataType() => const EnergyNutrientFormConfig(),
      CaffeineNutrientDataType() => const CaffeineNutrientFormConfig(),
      ProteinNutrientDataType() => const ProteinNutrientFormConfig(),
      TotalCarbohydrateNutrientDataType() =>
        const TotalCarbohydrateNutrientFormConfig(),
      TotalFatNutrientDataType() => const TotalFatNutrientFormConfig(),
      SaturatedFatNutrientDataType() => const SaturatedFatNutrientFormConfig(),
      MonounsaturatedFatNutrientDataType() =>
        const MonounsaturatedFatNutrientFormConfig(),
      PolyunsaturatedFatNutrientDataType() =>
        const PolyunsaturatedFatNutrientFormConfig(),
      CholesterolNutrientDataType() => const CholesterolNutrientFormConfig(),
      DietaryFiberNutrientDataType() => const DietaryFiberNutrientFormConfig(),
      SugarNutrientDataType() => const SugarNutrientFormConfig(),
      CalciumNutrientDataType() => const CalciumNutrientFormConfig(),
      IronNutrientDataType() => const IronNutrientFormConfig(),
      MagnesiumNutrientDataType() => const MagnesiumNutrientFormConfig(),
      ManganeseNutrientDataType() => const ManganeseNutrientFormConfig(),
      PhosphorusNutrientDataType() => const PhosphorusNutrientFormConfig(),
      PotassiumNutrientDataType() => const PotassiumNutrientFormConfig(),
      SeleniumNutrientDataType() => const SeleniumNutrientFormConfig(),
      SodiumNutrientDataType() => const SodiumNutrientFormConfig(),
      ZincNutrientDataType() => const ZincNutrientFormConfig(),
      VitaminANutrientDataType() => const VitaminANutrientFormConfig(),
      VitaminB6NutrientDataType() => const VitaminB6NutrientFormConfig(),
      VitaminB12NutrientDataType() => const VitaminB12NutrientFormConfig(),
      VitaminCNutrientDataType() => const VitaminCNutrientFormConfig(),
      VitaminDNutrientDataType() => const VitaminDNutrientFormConfig(),
      VitaminENutrientDataType() => const VitaminENutrientFormConfig(),
      VitaminKNutrientDataType() => const VitaminKNutrientFormConfig(),
      ThiaminNutrientDataType() => const ThiaminNutrientFormConfig(),
      RiboflavinNutrientDataType() => const RiboflavinNutrientFormConfig(),
      NiacinNutrientDataType() => const NiacinNutrientFormConfig(),
      FolateNutrientDataType() => const FolateNutrientFormConfig(),
      BiotinNutrientDataType() => const BiotinNutrientFormConfig(),
      PantothenicAcidNutrientDataType() =>
        const PantothenicAcidNutrientFormConfig(),
      NutritionHealthDataType() => const NutritionFormConfig(),
      RestingHeartRateHealthDataType() => const RestingHeartRateFormConfig(),
      RespiratoryRateHealthDataType() => const RespiratoryRateFormConfig(),
      Vo2MaxHealthDataType() => const Vo2MaxFormConfig(),
      BloodGlucoseHealthDataType() => const BloodGlucoseFormConfig(),
    };
  }
}

/// Configuration for sleep stage records (iOS).
///
/// Sleep stage is an interval-based record that requires:
/// - Start time
/// - End time
/// - Single sleep stage with type
/// - Optional title and notes
final class SleepStageRecordFormConfig extends HealthRecordFormConfig {
  const SleepStageRecordFormConfig();

  @override
  bool get needsDuration => true;

  @override
  HealthRecord buildRecord({
    required DateTime startDateTime,
    required MeasurementUnit value,
    required Metadata metadata,
    DateTime? endDateTime,
  }) {
    // This method signature doesn't support sleep stage data.
    // The actual implementation will be handled in the write form page.
    throw UnsupportedError(
      'SleepStageRecordFormConfig.buildRecord() should not be called directly. '
      'Use buildRecordWithStage() instead.',
    );
  }

  /// Builds a [SleepStageRecord] from the provided form values with stage data.
  ///
  /// ## Parameters
  ///
  /// - [startDateTime]: The start date/time for the record
  /// - [endDateTime]: The end date/time (required)
  /// - [stageType]: The sleep stage
  /// - [metadata]: The metadata for the record
  /// - [title]: Optional title for the sleep stage
  /// - [notes]: Optional notes for the sleep stage
  ///
  /// ## Returns
  ///
  /// A [SleepStageRecord] instance ready to be written.
  SleepStageRecord buildRecordWithStage({
    required DateTime startDateTime,
    required DateTime endDateTime,
    required SleepStageType stageType,
    required Metadata metadata,
    String? title,
    String? notes,
  }) {
    return SleepStageRecord(
      id: HealthRecordId.none,
      startTime: startDateTime,
      endTime: endDateTime,
      stageType: stageType,
      metadata: metadata,
      title: title,
      notes: notes,
    );
  }
}

/// Configuration for sleep session records (Android).
///
/// Sleep session is an interval-based record that requires:
/// - Start time
/// - End time (derived from start time + duration)
/// - List of sleep stages with start/end times and stage types
/// - Optional title and notes
///
/// Note: This config requires special handling in the form page as it needs
/// a list of stages rather than a single value.
final class SleepSessionRecordFormConfig extends HealthRecordFormConfig {
  const SleepSessionRecordFormConfig();

  @override
  bool get needsDuration => true;

  @override
  HealthRecord buildRecord({
    required DateTime startDateTime,
    required MeasurementUnit value,
    required Metadata metadata,
    DateTime? endDateTime,
  }) {
    // This method signature doesn't support stages list.
    // The actual implementation will be handled in the write form page.
    throw UnsupportedError(
      'SleepSessionRecordFormConfig.buildRecord() should not be called '
      'directly. Use buildRecordWithStages() instead.',
    );
  }

  /// Builds a [SleepSessionRecord] from the provided form values with stages.
  ///
  /// ## Parameters
  ///
  /// - [startDateTime]: The start date/time for the record
  /// - [endDateTime]: The end date/time (required)
  /// - [stages]: The list of sleep stages
  /// - [metadata]: The metadata for the record
  /// - [title]: Optional title for the sleep session
  /// - [notes]: Optional notes for the sleep session
  ///
  /// ## Returns
  ///
  /// A [SleepSessionRecord] instance ready to be written.
  SleepSessionRecord buildRecordWithStages({
    required DateTime startDateTime,
    required DateTime endDateTime,
    required List<SleepStage> stages,
    required Metadata metadata,
    String? title,
    String? notes,
  }) {
    return SleepSessionRecord(
      id: HealthRecordId.none,
      startTime: startDateTime,
      endTime: endDateTime,
      samples: stages,
      metadata: metadata,
      title: title,
      notes: notes,
    );
  }
}

/// Configuration for step count records.
///
/// Steps are interval-based records that require:
/// - Start time
/// - End time (derived from start time + duration)
/// - Step count (integer)
final class StepsFormConfig extends HealthRecordFormConfig {
  const StepsFormConfig();

  @override
  bool get needsDuration => true;

  @override
  HealthRecord buildRecord({
    required DateTime startDateTime,
    required MeasurementUnit value,
    required Metadata metadata,
    DateTime? endDateTime,
  }) {
    if (endDateTime == null) {
      throw ArgumentError('endDateTime is required for step records');
    }
    final count = value as Number;

    return StepsRecord(
      startTime: startDateTime,
      endTime: endDateTime,
      count: count,
      metadata: metadata,
    );
  }
}

/// Configuration for weight records.
///
/// Weight is an instant-based record that requires:
/// - Time (single timestamp)
/// - Weight value (mass in kilograms)
final class WeightFormConfig extends HealthRecordFormConfig {
  const WeightFormConfig();

  @override
  bool get needsDuration => false;

  @override
  HealthRecord buildRecord({
    required DateTime startDateTime,
    required MeasurementUnit value,
    required Metadata metadata,
    DateTime? endDateTime,
  }) {
    final massValue = value as Mass;

    return WeightRecord(
      time: startDateTime,
      weight: massValue,
      metadata: metadata,
    );
  }
}

/// Configuration for height records.
///
/// Height is an instant-based record that requires:
/// - Time (single timestamp)
/// - Height value (length in meters)
final class HeightFormConfig extends HealthRecordFormConfig {
  const HeightFormConfig();

  @override
  bool get needsDuration => false;

  @override
  HealthRecord buildRecord({
    required DateTime startDateTime,
    required MeasurementUnit value,
    required Metadata metadata,
    DateTime? endDateTime,
  }) {
    final lengthValue = value as Length;

    return HeightRecord(
      time: startDateTime,
      height: lengthValue,
      metadata: metadata,
    );
  }
}

/// Configuration for body fat percentage records.
///
/// Body fat percentage is an instant-based record that requires:
/// - Time (single timestamp)
/// - Body fat percentage value (Percentage type)
final class BodyFatPercentageFormConfig extends HealthRecordFormConfig {
  const BodyFatPercentageFormConfig();

  @override
  bool get needsDuration => false;

  @override
  HealthRecord buildRecord({
    required DateTime startDateTime,
    required MeasurementUnit value,
    required Metadata metadata,
    DateTime? endDateTime,
  }) {
    final percentageValue = value as Percentage;

    return BodyFatPercentageRecord(
      time: startDateTime,
      percentage: percentageValue,
      metadata: metadata,
    );
  }
}

/// Configuration for oxygen saturation records.
///
/// Oxygen saturation is an instant-based record that requires:
/// - Time (single timestamp)
/// - Percentage value
final class OxygenSaturationFormConfig extends HealthRecordFormConfig {
  const OxygenSaturationFormConfig();

  @override
  bool get needsDuration => false;

  @override
  HealthRecord buildRecord({
    required DateTime startDateTime,
    required MeasurementUnit value,
    required Metadata metadata,
    DateTime? endDateTime,
  }) {
    final percentageValue = value as Percentage;

    return OxygenSaturationRecord(
      time: startDateTime,
      percentage: percentageValue,
      metadata: metadata,
    );
  }
}

/// Configuration for respiratory rate records.
///
/// Respiratory rate is an instant-based record that requires:
/// - Time (single timestamp)
/// - Rate value (breaths per minute)
final class RespiratoryRateFormConfig extends HealthRecordFormConfig {
  const RespiratoryRateFormConfig();

  @override
  bool get needsDuration => false;

  @override
  HealthRecord buildRecord({
    required DateTime startDateTime,
    required MeasurementUnit value,
    required Metadata metadata,
    DateTime? endDateTime,
  }) {
    final breathsPerMin = value as Number;

    return RespiratoryRateRecord(
      time: startDateTime,
      breathsPerMin: breathsPerMin,
      metadata: metadata,
    );
  }
}

/// Configuration for lean body mass records.
///
/// Lean body mass is an instant-based record that requires:
/// - Time (single timestamp)
/// - Lean body mass value (mass in kilograms)
final class LeanBodyMassFormConfig extends HealthRecordFormConfig {
  const LeanBodyMassFormConfig();

  @override
  bool get needsDuration => false;

  @override
  HealthRecord buildRecord({
    required DateTime startDateTime,
    required MeasurementUnit value,
    required Metadata metadata,
    DateTime? endDateTime,
  }) {
    final massValue = value as Mass;

    return LeanBodyMassRecord(
      time: startDateTime,
      mass: massValue,
      metadata: metadata,
    );
  }
}

/// Configuration for body temperature records.
///
/// Body temperature is an instant-based record that requires:
/// - Time (single timestamp)
/// - Body temperature value (temperature in Celsius)
final class BodyTemperatureFormConfig extends HealthRecordFormConfig {
  const BodyTemperatureFormConfig();

  @override
  bool get needsDuration => false;

  @override
  HealthRecord buildRecord({
    required DateTime startDateTime,
    required MeasurementUnit value,
    required Metadata metadata,
    DateTime? endDateTime,
  }) {
    final temperatureValue = value as Temperature;

    return BodyTemperatureRecord(
      time: startDateTime,
      temperature: temperatureValue,
      metadata: metadata,
    );
  }
}

/// Configuration for blood pressure records.
///
/// Blood pressure is a composite record that requires:
/// - Time (single timestamp)
/// - Systolic pressure
/// - Diastolic pressure
/// - Body position
/// - Measurement location
final class BloodPressureFormConfig extends HealthRecordFormConfig {
  const BloodPressureFormConfig();

  @override
  bool get needsDuration => false;

  @override
  HealthRecord buildRecord({
    required DateTime startDateTime,
    required MeasurementUnit value,
    required Metadata metadata,
    DateTime? endDateTime,
  }) {
    throw UnsupportedError(
      'BloodPressureFormConfig.buildRecord() should not be called directly. '
      'Use buildBloodPressureRecord() instead.',
    );
  }

  HealthRecord buildBloodPressureRecord({
    required DateTime time,
    required Pressure systolic,
    required Pressure diastolic,
    required BloodPressureBodyPosition bodyPosition,
    required BloodPressureMeasurementLocation measurementLocation,
    required Metadata metadata,
  }) {
    return BloodPressureRecord(
      time: time,
      systolic: systolic,
      diastolic: diastolic,
      bodyPosition: bodyPosition,
      measurementLocation: measurementLocation,
      metadata: metadata,
    );
  }
}

/// Configuration for systolic blood pressure records.
final class SystolicBloodPressureFormConfig extends HealthRecordFormConfig {
  const SystolicBloodPressureFormConfig();

  @override
  bool get needsDuration => false;

  @override
  HealthRecord buildRecord({
    required DateTime startDateTime,
    required MeasurementUnit value,
    required Metadata metadata,
    DateTime? endDateTime,
  }) {
    final pressureValue = value as Pressure;
    return SystolicBloodPressureRecord(
      time: startDateTime,
      pressure: pressureValue,
      metadata: metadata,
    );
  }
}

/// Configuration for diastolic blood pressure records.
final class DiastolicBloodPressureFormConfig extends HealthRecordFormConfig {
  const DiastolicBloodPressureFormConfig();

  @override
  bool get needsDuration => false;

  @override
  HealthRecord buildRecord({
    required DateTime startDateTime,
    required MeasurementUnit value,
    required Metadata metadata,
    DateTime? endDateTime,
  }) {
    final pressureValue = value as Pressure;
    return DiastolicBloodPressureRecord(
      time: startDateTime,
      pressure: pressureValue,
      metadata: metadata,
    );
  }
}

/// Configuration for distance records.
///
/// Distance is an interval-based record that requires:
/// - Start time
/// - End time (derived from start time + duration)
/// - Distance value (length in meters)
final class DistanceFormConfig extends HealthRecordFormConfig {
  const DistanceFormConfig();

  @override
  bool get needsDuration => true;

  @override
  HealthRecord buildRecord({
    required DateTime startDateTime,
    required MeasurementUnit value,
    required Metadata metadata,
    DateTime? endDateTime,
  }) {
    if (endDateTime == null) {
      throw ArgumentError('endDateTime is required for distance records');
    }
    final lengthValue = value as Length;

    return DistanceRecord(
      startTime: startDateTime,
      endTime: endDateTime,
      distance: lengthValue,
      metadata: metadata,
    );
  }
}

/// Configuration for CrossCountrySkiingDistance records.
final class CrossCountrySkiingDistanceFormConfig
    extends HealthRecordFormConfig {
  const CrossCountrySkiingDistanceFormConfig();

  @override
  bool get needsDuration => true;

  @override
  HealthRecord buildRecord({
    required DateTime startDateTime,
    required MeasurementUnit value,
    required Metadata metadata,
    DateTime? endDateTime,
  }) {
    if (endDateTime == null) {
      throw ArgumentError(
        'endDateTime is required for CrossCountrySkiingDistance records',
      );
    }
    final lengthValue = value as Length;

    return CrossCountrySkiingDistanceRecord(
      startTime: startDateTime,
      endTime: endDateTime,
      distance: lengthValue,
      metadata: metadata,
    );
  }
}

/// Configuration for CyclingDistance records.
final class CyclingDistanceFormConfig extends HealthRecordFormConfig {
  const CyclingDistanceFormConfig();

  @override
  bool get needsDuration => true;

  @override
  HealthRecord buildRecord({
    required DateTime startDateTime,
    required MeasurementUnit value,
    required Metadata metadata,
    DateTime? endDateTime,
  }) {
    if (endDateTime == null) {
      throw ArgumentError(
        'endDateTime is required for CyclingDistance records',
      );
    }
    final lengthValue = value as Length;

    return CyclingDistanceRecord(
      startTime: startDateTime,
      endTime: endDateTime,
      distance: lengthValue,
      metadata: metadata,
    );
  }
}

/// Configuration for DownhillSnowSportsDistance records.
final class DownhillSnowSportsDistanceFormConfig
    extends HealthRecordFormConfig {
  const DownhillSnowSportsDistanceFormConfig();

  @override
  bool get needsDuration => true;

  @override
  HealthRecord buildRecord({
    required DateTime startDateTime,
    required MeasurementUnit value,
    required Metadata metadata,
    DateTime? endDateTime,
  }) {
    if (endDateTime == null) {
      throw ArgumentError(
        'endDateTime is required for DownhillSnowSportsDistance records',
      );
    }
    final lengthValue = value as Length;

    return DownhillSnowSportsDistanceRecord(
      startTime: startDateTime,
      endTime: endDateTime,
      distance: lengthValue,
      metadata: metadata,
    );
  }
}

/// Configuration for PaddleSportsDistance records.
final class PaddleSportsDistanceFormConfig extends HealthRecordFormConfig {
  const PaddleSportsDistanceFormConfig();

  @override
  bool get needsDuration => true;

  @override
  HealthRecord buildRecord({
    required DateTime startDateTime,
    required MeasurementUnit value,
    required Metadata metadata,
    DateTime? endDateTime,
  }) {
    if (endDateTime == null) {
      throw ArgumentError(
        'endDateTime is required for PaddleSportsDistance records',
      );
    }
    final lengthValue = value as Length;

    return PaddleSportsDistanceRecord(
      startTime: startDateTime,
      endTime: endDateTime,
      distance: lengthValue,
      metadata: metadata,
    );
  }
}

/// Configuration for RowingDistance records.
final class RowingDistanceFormConfig extends HealthRecordFormConfig {
  const RowingDistanceFormConfig();

  @override
  bool get needsDuration => true;

  @override
  HealthRecord buildRecord({
    required DateTime startDateTime,
    required MeasurementUnit value,
    required Metadata metadata,
    DateTime? endDateTime,
  }) {
    if (endDateTime == null) {
      throw ArgumentError(
        'endDateTime is required for RowingDistance records',
      );
    }
    final lengthValue = value as Length;

    return RowingDistanceRecord(
      startTime: startDateTime,
      endTime: endDateTime,
      distance: lengthValue,
      metadata: metadata,
    );
  }
}

/// Configuration for SixMinuteWalkTestDistance records.
final class SixMinuteWalkTestDistanceFormConfig extends HealthRecordFormConfig {
  const SixMinuteWalkTestDistanceFormConfig();

  @override
  bool get needsDuration => true;

  @override
  HealthRecord buildRecord({
    required DateTime startDateTime,
    required MeasurementUnit value,
    required Metadata metadata,
    DateTime? endDateTime,
  }) {
    if (endDateTime == null) {
      throw ArgumentError(
        'endDateTime is required for SixMinuteWalkTestDistance records',
      );
    }
    final lengthValue = value as Length;

    return SixMinuteWalkTestDistanceRecord(
      startTime: startDateTime,
      endTime: endDateTime,
      distance: lengthValue,
      metadata: metadata,
    );
  }
}

/// Configuration for SkatingSportsDistance records.
final class SkatingSportsDistanceFormConfig extends HealthRecordFormConfig {
  const SkatingSportsDistanceFormConfig();

  @override
  bool get needsDuration => true;

  @override
  HealthRecord buildRecord({
    required DateTime startDateTime,
    required MeasurementUnit value,
    required Metadata metadata,
    DateTime? endDateTime,
  }) {
    if (endDateTime == null) {
      throw ArgumentError(
        'endDateTime is required for SkatingSportsDistance records',
      );
    }
    final lengthValue = value as Length;

    return SkatingSportsDistanceRecord(
      startTime: startDateTime,
      endTime: endDateTime,
      distance: lengthValue,
      metadata: metadata,
    );
  }
}

/// Configuration for SwimmingDistance records.
final class SwimmingDistanceFormConfig extends HealthRecordFormConfig {
  const SwimmingDistanceFormConfig();

  @override
  bool get needsDuration => true;

  @override
  HealthRecord buildRecord({
    required DateTime startDateTime,
    required MeasurementUnit value,
    required Metadata metadata,
    DateTime? endDateTime,
  }) {
    if (endDateTime == null) {
      throw ArgumentError(
        'endDateTime is required for SwimmingDistance records',
      );
    }
    final lengthValue = value as Length;

    return SwimmingDistanceRecord(
      startTime: startDateTime,
      endTime: endDateTime,
      distance: lengthValue,
      metadata: metadata,
    );
  }
}

/// Configuration for WheelchairDistance records.
final class WheelchairDistanceFormConfig extends HealthRecordFormConfig {
  const WheelchairDistanceFormConfig();

  @override
  bool get needsDuration => true;

  @override
  HealthRecord buildRecord({
    required DateTime startDateTime,
    required MeasurementUnit value,
    required Metadata metadata,
    DateTime? endDateTime,
  }) {
    if (endDateTime == null) {
      throw ArgumentError(
        'endDateTime is required for WheelchairDistance records',
      );
    }
    final lengthValue = value as Length;

    return WheelchairDistanceRecord(
      startTime: startDateTime,
      endTime: endDateTime,
      distance: lengthValue,
      metadata: metadata,
    );
  }
}

/// Configuration for WalkingRunningDistance records.
final class WalkingRunningDistanceFormConfig extends HealthRecordFormConfig {
  const WalkingRunningDistanceFormConfig();

  @override
  bool get needsDuration => true;

  @override
  HealthRecord buildRecord({
    required DateTime startDateTime,
    required MeasurementUnit value,
    required Metadata metadata,
    DateTime? endDateTime,
  }) {
    if (endDateTime == null) {
      throw ArgumentError(
        'endDateTime is required for WalkingRunningDistance records',
      );
    }
    final lengthValue = value as Length;

    return WalkingRunningDistanceRecord(
      startTime: startDateTime,
      endTime: endDateTime,
      distance: lengthValue,
      metadata: metadata,
    );
  }
}

/// Configuration for active calories burned records.
///
/// Active calories burned is an interval-based record that requires:
/// - Start time
/// - End time (derived from start time + duration)
/// - Energy value (energy in kilocalories)
final class ActiveCaloriesBurnedFormConfig extends HealthRecordFormConfig {
  const ActiveCaloriesBurnedFormConfig();

  @override
  bool get needsDuration => true;

  @override
  HealthRecord buildRecord({
    required DateTime startDateTime,
    required MeasurementUnit value,
    required Metadata metadata,
    DateTime? endDateTime,
  }) {
    if (endDateTime == null) {
      throw ArgumentError(
        'endDateTime is required for active calories burned records',
      );
    }
    final energyValue = value as Energy;

    return ActiveCaloriesBurnedRecord(
      startTime: startDateTime,
      endTime: endDateTime,
      energy: energyValue,
      metadata: metadata,
    );
  }
}

/// Configuration for floors climbed records.
///
/// Floors climbed is an interval-based record that requires:
/// - Start time
/// - End time (derived from start time + duration)
/// - Floors count (numeric/integer)
final class FloorsClimbedFormConfig extends HealthRecordFormConfig {
  const FloorsClimbedFormConfig();

  @override
  bool get needsDuration => true;

  @override
  HealthRecord buildRecord({
    required DateTime startDateTime,
    required MeasurementUnit value,
    required Metadata metadata,
    DateTime? endDateTime,
  }) {
    if (endDateTime == null) {
      throw ArgumentError(
        'endDateTime is required for floors climbed records',
      );
    }
    final count = value as Number;

    return FloorsClimbedRecord(
      startTime: startDateTime,
      endTime: endDateTime,
      floors: count,
      metadata: metadata,
    );
  }
}

/// Configuration for wheelchair pushes records.
///
/// Wheelchair pushes is an interval-based record that requires:
/// - Start time
/// - End time (derived from start time + duration)
/// - Pushes count (numeric/integer)
final class WheelchairPushesFormConfig extends HealthRecordFormConfig {
  const WheelchairPushesFormConfig();

  @override
  bool get needsDuration => true;

  @override
  HealthRecord buildRecord({
    required DateTime startDateTime,
    required MeasurementUnit value,
    required Metadata metadata,
    DateTime? endDateTime,
  }) {
    if (endDateTime == null) {
      throw ArgumentError(
        'endDateTime is required for wheelchair pushes records',
      );
    }
    final count = value as Number;

    return WheelchairPushesRecord(
      startTime: startDateTime,
      endTime: endDateTime,
      pushes: count,
      metadata: metadata,
    );
  }
}

/// Configuration for hydration records.
///
/// Hydration is an interval-based record that requires:
/// - Start time
/// - End time (derived from start time + duration)
/// - Volume value (volume in liters)
final class HydrationFormConfig extends HealthRecordFormConfig {
  const HydrationFormConfig();

  @override
  bool get needsDuration => true;

  @override
  HealthRecord buildRecord({
    required DateTime startDateTime,
    required MeasurementUnit value,
    required Metadata metadata,
    DateTime? endDateTime,
  }) {
    if (endDateTime == null) {
      throw ArgumentError('endDateTime is required for hydration records');
    }
    final volumeValue = value as Volume;

    return HydrationRecord(
      startTime: startDateTime,
      endTime: endDateTime,
      volume: volumeValue,
      metadata: metadata,
    );
  }
}

/// Base configuration for nutrient records.
///
/// Nutrient records are instant-based records that require:
/// - Time (single timestamp)
/// - Value (Energy or Mass depending on nutrient type)
/// - Optional food name
/// - Optional meal type
abstract class NutrientFormConfig extends HealthRecordFormConfig {
  const NutrientFormConfig();

  @override
  bool get needsDuration => false;

  @override
  HealthRecord buildRecord({
    required DateTime startDateTime,
    required MeasurementUnit value,
    required Metadata metadata,
    DateTime? endDateTime,
  }) {
    // This method signature doesn't support foodName and mealType.
    // The actual implementation will be handled in the write form page.
    throw UnsupportedError(
      'NutrientFormConfig.buildRecord() should not be called directly. '
      'Use buildRecordWithNutrientData() instead.',
    );
  }

  /// Builds a nutrient record from the provided form values with nutrient data.
  ///
  /// ## Parameters
  ///
  /// - [time]: The date/time for the record
  /// - [value]: The measurement value (Energy or Mass)
  /// - [metadata]: The metadata for the record
  /// - [foodName]: Optional food name
  /// - [mealType]: Optional meal type
  ///
  /// ## Returns
  ///
  /// A nutrient record instance ready to be written.
  HealthRecord buildRecordWithNutrientData({
    required DateTime time,
    required MeasurementUnit value,
    required Metadata metadata,
    String? foodName,
    MealType mealType = MealType.unknown,
  });
}

/// Configuration for energy nutrient records.
final class EnergyNutrientFormConfig extends NutrientFormConfig {
  const EnergyNutrientFormConfig();

  @override
  EnergyNutrientRecord buildRecordWithNutrientData({
    required DateTime time,
    required MeasurementUnit value,
    required Metadata metadata,
    String? foodName,
    MealType mealType = MealType.unknown,
  }) {
    final energyValue = value as Energy;
    return EnergyNutrientRecord(
      value: energyValue,
      time: time,
      metadata: metadata,
      foodName: foodName,
      mealType: mealType,
    );
  }
}

/// Configuration for caffeine nutrient records.
final class CaffeineNutrientFormConfig extends NutrientFormConfig {
  const CaffeineNutrientFormConfig();

  @override
  CaffeineNutrientRecord buildRecordWithNutrientData({
    required DateTime time,
    required MeasurementUnit value,
    required Metadata metadata,
    String? foodName,
    MealType mealType = MealType.unknown,
  }) {
    final massValue = value as Mass;
    return CaffeineNutrientRecord(
      value: massValue,
      time: time,
      metadata: metadata,
      foodName: foodName,
      mealType: mealType,
    );
  }
}

/// Configuration for protein nutrient records.
final class ProteinNutrientFormConfig extends NutrientFormConfig {
  const ProteinNutrientFormConfig();

  @override
  ProteinNutrientRecord buildRecordWithNutrientData({
    required DateTime time,
    required MeasurementUnit value,
    required Metadata metadata,
    String? foodName,
    MealType mealType = MealType.unknown,
  }) {
    final massValue = value as Mass;
    return ProteinNutrientRecord(
      value: massValue,
      time: time,
      metadata: metadata,
      foodName: foodName,
      mealType: mealType,
    );
  }
}

/// Configuration for total carbohydrate nutrient records.
final class TotalCarbohydrateNutrientFormConfig extends NutrientFormConfig {
  const TotalCarbohydrateNutrientFormConfig();

  @override
  TotalCarbohydrateNutrientRecord buildRecordWithNutrientData({
    required DateTime time,
    required MeasurementUnit value,
    required Metadata metadata,
    String? foodName,
    MealType mealType = MealType.unknown,
  }) {
    final massValue = value as Mass;
    return TotalCarbohydrateNutrientRecord(
      value: massValue,
      time: time,
      metadata: metadata,
      foodName: foodName,
      mealType: mealType,
    );
  }
}

/// Configuration for total fat nutrient records.
final class TotalFatNutrientFormConfig extends NutrientFormConfig {
  const TotalFatNutrientFormConfig();

  @override
  TotalFatNutrientRecord buildRecordWithNutrientData({
    required DateTime time,
    required MeasurementUnit value,
    required Metadata metadata,
    String? foodName,
    MealType mealType = MealType.unknown,
  }) {
    final massValue = value as Mass;
    return TotalFatNutrientRecord(
      value: massValue,
      time: time,
      metadata: metadata,
      foodName: foodName,
      mealType: mealType,
    );
  }
}

/// Configuration for saturated fat nutrient records.
final class SaturatedFatNutrientFormConfig extends NutrientFormConfig {
  const SaturatedFatNutrientFormConfig();

  @override
  SaturatedFatNutrientRecord buildRecordWithNutrientData({
    required DateTime time,
    required MeasurementUnit value,
    required Metadata metadata,
    String? foodName,
    MealType mealType = MealType.unknown,
  }) {
    final massValue = value as Mass;
    return SaturatedFatNutrientRecord(
      value: massValue,
      time: time,
      metadata: metadata,
      foodName: foodName,
      mealType: mealType,
    );
  }
}

/// Configuration for monounsaturated fat nutrient records.
final class MonounsaturatedFatNutrientFormConfig extends NutrientFormConfig {
  const MonounsaturatedFatNutrientFormConfig();

  @override
  MonounsaturatedFatNutrientRecord buildRecordWithNutrientData({
    required DateTime time,
    required MeasurementUnit value,
    required Metadata metadata,
    String? foodName,
    MealType mealType = MealType.unknown,
  }) {
    final massValue = value as Mass;
    return MonounsaturatedFatNutrientRecord(
      value: massValue,
      time: time,
      metadata: metadata,
      foodName: foodName,
      mealType: mealType,
    );
  }
}

/// Configuration for polyunsaturated fat nutrient records.
final class PolyunsaturatedFatNutrientFormConfig extends NutrientFormConfig {
  const PolyunsaturatedFatNutrientFormConfig();

  @override
  PolyunsaturatedFatNutrientRecord buildRecordWithNutrientData({
    required DateTime time,
    required MeasurementUnit value,
    required Metadata metadata,
    String? foodName,
    MealType mealType = MealType.unknown,
  }) {
    final massValue = value as Mass;
    return PolyunsaturatedFatNutrientRecord(
      value: massValue,
      time: time,
      metadata: metadata,
      foodName: foodName,
      mealType: mealType,
    );
  }
}

/// Configuration for cholesterol nutrient records.
final class CholesterolNutrientFormConfig extends NutrientFormConfig {
  const CholesterolNutrientFormConfig();

  @override
  CholesterolNutrientRecord buildRecordWithNutrientData({
    required DateTime time,
    required MeasurementUnit value,
    required Metadata metadata,
    String? foodName,
    MealType mealType = MealType.unknown,
  }) {
    final massValue = value as Mass;
    return CholesterolNutrientRecord(
      value: massValue,
      time: time,
      metadata: metadata,
      foodName: foodName,
      mealType: mealType,
    );
  }
}

/// Configuration for dietary fiber nutrient records.
final class DietaryFiberNutrientFormConfig extends NutrientFormConfig {
  const DietaryFiberNutrientFormConfig();

  @override
  DietaryFiberNutrientRecord buildRecordWithNutrientData({
    required DateTime time,
    required MeasurementUnit value,
    required Metadata metadata,
    String? foodName,
    MealType mealType = MealType.unknown,
  }) {
    final massValue = value as Mass;
    return DietaryFiberNutrientRecord(
      value: massValue,
      time: time,
      metadata: metadata,
      foodName: foodName,
      mealType: mealType,
    );
  }
}

/// Configuration for sugar nutrient records.
final class SugarNutrientFormConfig extends NutrientFormConfig {
  const SugarNutrientFormConfig();

  @override
  SugarNutrientRecord buildRecordWithNutrientData({
    required DateTime time,
    required MeasurementUnit value,
    required Metadata metadata,
    String? foodName,
    MealType mealType = MealType.unknown,
  }) {
    final massValue = value as Mass;
    return SugarNutrientRecord(
      value: massValue,
      time: time,
      metadata: metadata,
      foodName: foodName,
      mealType: mealType,
    );
  }
}

/// Configuration for calcium nutrient records.
final class CalciumNutrientFormConfig extends NutrientFormConfig {
  const CalciumNutrientFormConfig();

  @override
  CalciumNutrientRecord buildRecordWithNutrientData({
    required DateTime time,
    required MeasurementUnit value,
    required Metadata metadata,
    String? foodName,
    MealType mealType = MealType.unknown,
  }) {
    final massValue = value as Mass;
    return CalciumNutrientRecord(
      value: massValue,
      time: time,
      metadata: metadata,
      foodName: foodName,
      mealType: mealType,
    );
  }
}

/// Configuration for iron nutrient records.
final class IronNutrientFormConfig extends NutrientFormConfig {
  const IronNutrientFormConfig();

  @override
  IronNutrientRecord buildRecordWithNutrientData({
    required DateTime time,
    required MeasurementUnit value,
    required Metadata metadata,
    String? foodName,
    MealType mealType = MealType.unknown,
  }) {
    final massValue = value as Mass;
    return IronNutrientRecord(
      value: massValue,
      time: time,
      metadata: metadata,
      foodName: foodName,
      mealType: mealType,
    );
  }
}

/// Configuration for magnesium nutrient records.
final class MagnesiumNutrientFormConfig extends NutrientFormConfig {
  const MagnesiumNutrientFormConfig();

  @override
  MagnesiumNutrientRecord buildRecordWithNutrientData({
    required DateTime time,
    required MeasurementUnit value,
    required Metadata metadata,
    String? foodName,
    MealType mealType = MealType.unknown,
  }) {
    final massValue = value as Mass;
    return MagnesiumNutrientRecord(
      value: massValue,
      time: time,
      metadata: metadata,
      foodName: foodName,
      mealType: mealType,
    );
  }
}

/// Configuration for manganese nutrient records.
final class ManganeseNutrientFormConfig extends NutrientFormConfig {
  const ManganeseNutrientFormConfig();

  @override
  ManganeseNutrientRecord buildRecordWithNutrientData({
    required DateTime time,
    required MeasurementUnit value,
    required Metadata metadata,
    String? foodName,
    MealType mealType = MealType.unknown,
  }) {
    final massValue = value as Mass;
    return ManganeseNutrientRecord(
      value: massValue,
      time: time,
      metadata: metadata,
      foodName: foodName,
      mealType: mealType,
    );
  }
}

/// Configuration for phosphorus nutrient records.
final class PhosphorusNutrientFormConfig extends NutrientFormConfig {
  const PhosphorusNutrientFormConfig();

  @override
  PhosphorusNutrientRecord buildRecordWithNutrientData({
    required DateTime time,
    required MeasurementUnit value,
    required Metadata metadata,
    String? foodName,
    MealType mealType = MealType.unknown,
  }) {
    final massValue = value as Mass;
    return PhosphorusNutrientRecord(
      value: massValue,
      time: time,
      metadata: metadata,
      foodName: foodName,
      mealType: mealType,
    );
  }
}

/// Configuration for potassium nutrient records.
final class PotassiumNutrientFormConfig extends NutrientFormConfig {
  const PotassiumNutrientFormConfig();

  @override
  PotassiumNutrientRecord buildRecordWithNutrientData({
    required DateTime time,
    required MeasurementUnit value,
    required Metadata metadata,
    String? foodName,
    MealType mealType = MealType.unknown,
  }) {
    final massValue = value as Mass;
    return PotassiumNutrientRecord(
      value: massValue,
      time: time,
      metadata: metadata,
      foodName: foodName,
      mealType: mealType,
    );
  }
}

/// Configuration for selenium nutrient records.
final class SeleniumNutrientFormConfig extends NutrientFormConfig {
  const SeleniumNutrientFormConfig();

  @override
  SeleniumNutrientRecord buildRecordWithNutrientData({
    required DateTime time,
    required MeasurementUnit value,
    required Metadata metadata,
    String? foodName,
    MealType mealType = MealType.unknown,
  }) {
    final massValue = value as Mass;
    return SeleniumNutrientRecord(
      value: massValue,
      time: time,
      metadata: metadata,
      foodName: foodName,
      mealType: mealType,
    );
  }
}

/// Configuration for sodium nutrient records.
final class SodiumNutrientFormConfig extends NutrientFormConfig {
  const SodiumNutrientFormConfig();

  @override
  SodiumNutrientRecord buildRecordWithNutrientData({
    required DateTime time,
    required MeasurementUnit value,
    required Metadata metadata,
    String? foodName,
    MealType mealType = MealType.unknown,
  }) {
    final massValue = value as Mass;
    return SodiumNutrientRecord(
      value: massValue,
      time: time,
      metadata: metadata,
      foodName: foodName,
      mealType: mealType,
    );
  }
}

/// Configuration for zinc nutrient records.
final class ZincNutrientFormConfig extends NutrientFormConfig {
  const ZincNutrientFormConfig();

  @override
  ZincNutrientRecord buildRecordWithNutrientData({
    required DateTime time,
    required MeasurementUnit value,
    required Metadata metadata,
    String? foodName,
    MealType mealType = MealType.unknown,
  }) {
    final massValue = value as Mass;
    return ZincNutrientRecord(
      value: massValue,
      time: time,
      metadata: metadata,
      foodName: foodName,
      mealType: mealType,
    );
  }
}

/// Configuration for vitamin A nutrient records.
final class VitaminANutrientFormConfig extends NutrientFormConfig {
  const VitaminANutrientFormConfig();

  @override
  VitaminANutrientRecord buildRecordWithNutrientData({
    required DateTime time,
    required MeasurementUnit value,
    required Metadata metadata,
    String? foodName,
    MealType mealType = MealType.unknown,
  }) {
    final massValue = value as Mass;
    return VitaminANutrientRecord(
      value: massValue,
      time: time,
      metadata: metadata,
      foodName: foodName,
      mealType: mealType,
    );
  }
}

/// Configuration for vitamin B6 nutrient records.
final class VitaminB6NutrientFormConfig extends NutrientFormConfig {
  const VitaminB6NutrientFormConfig();

  @override
  VitaminB6NutrientRecord buildRecordWithNutrientData({
    required DateTime time,
    required MeasurementUnit value,
    required Metadata metadata,
    String? foodName,
    MealType mealType = MealType.unknown,
  }) {
    final massValue = value as Mass;
    return VitaminB6NutrientRecord(
      value: massValue,
      time: time,
      metadata: metadata,
      foodName: foodName,
      mealType: mealType,
    );
  }
}

/// Configuration for vitamin B12 nutrient records.
final class VitaminB12NutrientFormConfig extends NutrientFormConfig {
  const VitaminB12NutrientFormConfig();

  @override
  VitaminB12NutrientRecord buildRecordWithNutrientData({
    required DateTime time,
    required MeasurementUnit value,
    required Metadata metadata,
    String? foodName,
    MealType mealType = MealType.unknown,
  }) {
    final massValue = value as Mass;
    return VitaminB12NutrientRecord(
      value: massValue,
      time: time,
      metadata: metadata,
      foodName: foodName,
      mealType: mealType,
    );
  }
}

/// Configuration for vitamin C nutrient records.
final class VitaminCNutrientFormConfig extends NutrientFormConfig {
  const VitaminCNutrientFormConfig();

  @override
  VitaminCNutrientRecord buildRecordWithNutrientData({
    required DateTime time,
    required MeasurementUnit value,
    required Metadata metadata,
    String? foodName,
    MealType mealType = MealType.unknown,
  }) {
    final massValue = value as Mass;
    return VitaminCNutrientRecord(
      value: massValue,
      time: time,
      metadata: metadata,
      foodName: foodName,
      mealType: mealType,
    );
  }
}

/// Configuration for vitamin D nutrient records.
final class VitaminDNutrientFormConfig extends NutrientFormConfig {
  const VitaminDNutrientFormConfig();

  @override
  VitaminDNutrientRecord buildRecordWithNutrientData({
    required DateTime time,
    required MeasurementUnit value,
    required Metadata metadata,
    String? foodName,
    MealType mealType = MealType.unknown,
  }) {
    final massValue = value as Mass;
    return VitaminDNutrientRecord(
      value: massValue,
      time: time,
      metadata: metadata,
      foodName: foodName,
      mealType: mealType,
    );
  }
}

/// Configuration for vitamin E nutrient records.
final class VitaminENutrientFormConfig extends NutrientFormConfig {
  const VitaminENutrientFormConfig();

  @override
  VitaminENutrientRecord buildRecordWithNutrientData({
    required DateTime time,
    required MeasurementUnit value,
    required Metadata metadata,
    String? foodName,
    MealType mealType = MealType.unknown,
  }) {
    final massValue = value as Mass;
    return VitaminENutrientRecord(
      value: massValue,
      time: time,
      metadata: metadata,
      foodName: foodName,
      mealType: mealType,
    );
  }
}

/// Configuration for vitamin K nutrient records.
final class VitaminKNutrientFormConfig extends NutrientFormConfig {
  const VitaminKNutrientFormConfig();

  @override
  VitaminKNutrientRecord buildRecordWithNutrientData({
    required DateTime time,
    required MeasurementUnit value,
    required Metadata metadata,
    String? foodName,
    MealType mealType = MealType.unknown,
  }) {
    final massValue = value as Mass;
    return VitaminKNutrientRecord(
      value: massValue,
      time: time,
      metadata: metadata,
      foodName: foodName,
      mealType: mealType,
    );
  }
}

/// Configuration for thiamin nutrient records.
final class ThiaminNutrientFormConfig extends NutrientFormConfig {
  const ThiaminNutrientFormConfig();

  @override
  ThiaminNutrientRecord buildRecordWithNutrientData({
    required DateTime time,
    required MeasurementUnit value,
    required Metadata metadata,
    String? foodName,
    MealType mealType = MealType.unknown,
  }) {
    final massValue = value as Mass;
    return ThiaminNutrientRecord(
      value: massValue,
      time: time,
      metadata: metadata,
      foodName: foodName,
      mealType: mealType,
    );
  }
}

/// Configuration for riboflavin nutrient records.
final class RiboflavinNutrientFormConfig extends NutrientFormConfig {
  const RiboflavinNutrientFormConfig();

  @override
  RiboflavinNutrientRecord buildRecordWithNutrientData({
    required DateTime time,
    required MeasurementUnit value,
    required Metadata metadata,
    String? foodName,
    MealType mealType = MealType.unknown,
  }) {
    final massValue = value as Mass;
    return RiboflavinNutrientRecord(
      value: massValue,
      time: time,
      metadata: metadata,
      foodName: foodName,
      mealType: mealType,
    );
  }
}

/// Configuration for niacin nutrient records.
final class NiacinNutrientFormConfig extends NutrientFormConfig {
  const NiacinNutrientFormConfig();

  @override
  NiacinNutrientRecord buildRecordWithNutrientData({
    required DateTime time,
    required MeasurementUnit value,
    required Metadata metadata,
    String? foodName,
    MealType mealType = MealType.unknown,
  }) {
    final massValue = value as Mass;
    return NiacinNutrientRecord(
      value: massValue,
      time: time,
      metadata: metadata,
      foodName: foodName,
      mealType: mealType,
    );
  }
}

/// Configuration for folate nutrient records.
final class FolateNutrientFormConfig extends NutrientFormConfig {
  const FolateNutrientFormConfig();

  @override
  FolateNutrientRecord buildRecordWithNutrientData({
    required DateTime time,
    required MeasurementUnit value,
    required Metadata metadata,
    String? foodName,
    MealType mealType = MealType.unknown,
  }) {
    final massValue = value as Mass;
    return FolateNutrientRecord(
      value: massValue,
      time: time,
      metadata: metadata,
      foodName: foodName,
      mealType: mealType,
    );
  }
}

/// Configuration for biotin nutrient records.
final class BiotinNutrientFormConfig extends NutrientFormConfig {
  const BiotinNutrientFormConfig();

  @override
  BiotinNutrientRecord buildRecordWithNutrientData({
    required DateTime time,
    required MeasurementUnit value,
    required Metadata metadata,
    String? foodName,
    MealType mealType = MealType.unknown,
  }) {
    final massValue = value as Mass;
    return BiotinNutrientRecord(
      value: massValue,
      time: time,
      metadata: metadata,
      foodName: foodName,
      mealType: mealType,
    );
  }
}

/// Configuration for pantothenic acid nutrient records.
final class PantothenicAcidNutrientFormConfig extends NutrientFormConfig {
  const PantothenicAcidNutrientFormConfig();

  @override
  PantothenicAcidNutrientRecord buildRecordWithNutrientData({
    required DateTime time,
    required MeasurementUnit value,
    required Metadata metadata,
    String? foodName,
    MealType mealType = MealType.unknown,
  }) {
    final massValue = value as Mass;
    return PantothenicAcidNutrientRecord(
      value: massValue,
      time: time,
      metadata: metadata,
      foodName: foodName,
      mealType: mealType,
    );
  }
}

/// Configuration for nutrition records.
///
/// Nutrition is an interval-based record that requires:
/// - Start time
/// - End time (derived from start time + duration)
/// - Many optional nutrient fields
///
/// Note: This config requires special handling in the form page as it needs
/// many optional nutrient values rather than a single value.
final class NutritionFormConfig extends HealthRecordFormConfig {
  const NutritionFormConfig();

  @override
  bool get needsDuration => true;

  @override
  HealthRecord buildRecord({
    required DateTime startDateTime,
    required MeasurementUnit value,
    required Metadata metadata,
    DateTime? endDateTime,
  }) {
    // This method signature doesn't support nutrition data.
    // The actual implementation will be handled in the write form page.
    throw UnsupportedError(
      'NutritionFormConfig.buildRecord() should not be called directly. '
      'Use buildRecordWithNutritionData() instead.',
    );
  }

  /// Builds a [NutritionRecord] from the provided form values with
  /// nutrition data.
  ///
  /// ## Parameters
  ///
  /// - [startDateTime]: The start date/time for the record
  /// - [endDateTime]: The end date/time (required)
  /// - [metadata]: The metadata for the record
  /// - [foodName]: Optional food name
  /// - [mealType]: Optional meal type
  /// - All other parameters are optional nutrient values
  ///
  /// ## Returns
  ///
  /// A [NutritionRecord] instance ready to be written.
  NutritionRecord buildRecordWithNutritionData({
    required DateTime startDateTime,
    required DateTime endDateTime,
    required Metadata metadata,
    String? foodName,
    MealType mealType = MealType.unknown,
    Energy? energy,
    Mass? protein,
    Mass? totalCarbohydrate,
    Mass? totalFat,
    Mass? saturatedFat,
    Mass? monounsaturatedFat,
    Mass? polyunsaturatedFat,
    Mass? cholesterol,
    Mass? dietaryFiber,
    Mass? sugar,
    Mass? vitaminA,
    Mass? vitaminB6,
    Mass? vitaminB12,
    Mass? vitaminC,
    Mass? vitaminD,
    Mass? vitaminE,
    Mass? vitaminK,
    Mass? thiamin,
    Mass? riboflavin,
    Mass? niacin,
    Mass? folate,
    Mass? biotin,
    Mass? pantothenicAcid,
    Mass? calcium,
    Mass? iron,
    Mass? magnesium,
    Mass? manganese,
    Mass? phosphorus,
    Mass? potassium,
    Mass? selenium,
    Mass? sodium,
    Mass? zinc,
    Mass? caffeine,
  }) {
    return NutritionRecord(
      startTime: startDateTime,
      endTime: endDateTime,
      metadata: metadata,
      foodName: foodName,
      mealType: mealType,
      energy: energy,
      protein: protein,
      totalCarbohydrate: totalCarbohydrate,
      totalFat: totalFat,
      saturatedFat: saturatedFat,
      monounsaturatedFat: monounsaturatedFat,
      polyunsaturatedFat: polyunsaturatedFat,
      cholesterol: cholesterol,
      dietaryFiber: dietaryFiber,
      sugar: sugar,
      vitaminA: vitaminA,
      vitaminB6: vitaminB6,
      vitaminB12: vitaminB12,
      vitaminC: vitaminC,
      vitaminD: vitaminD,
      vitaminE: vitaminE,
      vitaminK: vitaminK,
      thiamin: thiamin,
      riboflavin: riboflavin,
      niacin: niacin,
      folate: folate,
      biotin: biotin,
      pantothenicAcid: pantothenicAcid,
      calcium: calcium,
      iron: iron,
      magnesium: magnesium,
      manganese: manganese,
      phosphorus: phosphorus,
      potassium: potassium,
      selenium: selenium,
      sodium: sodium,
      zinc: zinc,
      caffeine: caffeine,
    );
  }
}

/// Configuration for heart rate measurement records (iOS).
///
/// Heart rate measurement is an instant-based record that requires:
/// - Time (single timestamp)
/// - Heart rate value (BPM as Numeric)
final class HeartRateMeasurementRecordFormConfig
    extends HealthRecordFormConfig {
  const HeartRateMeasurementRecordFormConfig();

  @override
  bool get needsDuration => false;

  @override
  HealthRecord buildRecord({
    required DateTime startDateTime,
    required MeasurementUnit value,
    required Metadata metadata,
    DateTime? endDateTime,
  }) {
    final beatsPerMinute = value as Number;

    return HeartRateMeasurementRecord(
      id: HealthRecordId.none,
      metadata: metadata,
      measurement: HeartRateMeasurement(
        time: startDateTime,
        beatsPerMinute: beatsPerMinute,
      ),
    );
  }
}

/// Configuration for heart rate series records (Android).
///
/// Heart rate series is an interval-based record that requires:
/// - Start time
/// - End time (derived from start time + duration)
/// - List of heart rate measurements (samples with time and BPM)
///
/// Note: This config requires special handling in the form page as it needs
/// a list of samples rather than a single value.
final class HeartRateSeriesRecordFormConfig extends HealthRecordFormConfig {
  const HeartRateSeriesRecordFormConfig();

  @override
  bool get needsDuration => true;

  @override
  HealthRecord buildRecord({
    required DateTime startDateTime,
    required MeasurementUnit value,
    required Metadata metadata,
    DateTime? endDateTime,
  }) {
    // This method signature doesn't support samples list.
    // The actual implementation will be handled in the write form page.
    throw UnsupportedError(
      'HeartRateSeriesRecordFormConfig.buildRecord() should not be '
      'called directly. Use buildRecordWithSamples() instead.',
    );
  }

  /// Builds a [HeartRateSeriesRecord] from the provided form values with
  /// samples.
  ///
  /// ## Parameters
  ///
  /// - [startDateTime]: The start date/time for the record
  /// - [endDateTime]: The end date/time (required)
  /// - [samples]: The list of heart rate measurements
  /// - [metadata]: The metadata for the record
  ///
  /// ## Returns
  ///
  /// A [HeartRateSeriesRecord] instance ready to be written.
  HeartRateSeriesRecord buildRecordWithSamples({
    required DateTime startDateTime,
    required DateTime endDateTime,
    required List<HeartRateMeasurement> samples,
    required Metadata metadata,
  }) {
    return HeartRateSeriesRecord(
      id: HealthRecordId.none,
      startTime: startDateTime,
      endTime: endDateTime,
      samples: samples,
      metadata: metadata,
    );
  }
}

/// Configuration for resting heart rate records.
final class RestingHeartRateFormConfig extends HealthRecordFormConfig {
  const RestingHeartRateFormConfig();

  @override
  bool get needsDuration => false;

  @override
  HealthRecord buildRecord({
    required DateTime startDateTime,
    required MeasurementUnit value,
    required Metadata metadata,
    DateTime? endDateTime,
  }) {
    final beatsPerMinute = value as Number;

    return RestingHeartRateRecord(
      time: startDateTime,
      beatsPerMinute: beatsPerMinute,
      metadata: metadata,
    );
  }
}

/// Configuration for VO2 max records.
final class Vo2MaxFormConfig extends HealthRecordFormConfig {
  const Vo2MaxFormConfig();

  @override
  bool get needsDuration => false;

  @override
  HealthRecord buildRecord({
    required DateTime startDateTime,
    required MeasurementUnit value,
    required Metadata metadata,
    DateTime? endDateTime,
  }) {
    throw UnsupportedError(
      'Vo2MaxFormConfig.buildRecord() should not be called directly. '
      'Use buildVo2MaxRecord() instead.',
    );
  }

  HealthRecord buildVo2MaxRecord({
    required DateTime time,
    required Number vo2Max,
    required Vo2MaxTestType testType,
    required Metadata metadata,
  }) {
    return Vo2MaxRecord(
      time: time,
      mLPerKgPerMin: vo2Max,
      testType: testType,
      metadata: metadata,
    );
  }
}

/// Configuration for blood glucose records.
final class BloodGlucoseFormConfig extends HealthRecordFormConfig {
  const BloodGlucoseFormConfig();

  @override
  bool get needsDuration => false;

  @override
  HealthRecord buildRecord({
    required DateTime startDateTime,
    required MeasurementUnit value,
    required Metadata metadata,
    DateTime? endDateTime,
  }) {
    throw UnsupportedError(
      'BloodGlucoseFormConfig.buildRecord() should not be called directly. '
      'Use buildBloodGlucoseRecord() instead.',
    );
  }

  HealthRecord buildBloodGlucoseRecord({
    required DateTime time,
    required BloodGlucose bloodGlucose,
    required BloodGlucoseRelationToMeal relationToMeal,
    required BloodGlucoseSpecimenSource specimenSource,
    required BloodGlucoseMealType mealType,
    required Metadata metadata,
  }) {
    return BloodGlucoseRecord(
      time: time,
      bloodGlucose: bloodGlucose,
      relationToMeal: relationToMeal,
      specimenSource: specimenSource,
      mealType: mealType,
      metadata: metadata,
    );
  }
}
