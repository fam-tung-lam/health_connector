import 'package:flutter/material.dart' hide Velocity;
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/common/utils/extensions/cervical_mucus_appearance_extension.dart';
import 'package:health_connector_toolbox/src/common/utils/extensions/cervical_mucus_sensation_extension.dart';
import 'package:health_connector_toolbox/src/common/utils/extensions/exercise_type_extension.dart';
import 'package:health_connector_toolbox/src/common/utils/extensions/meal_type_extension.dart';
import 'package:health_connector_toolbox/src/common/utils/extensions/mindfulness_session_type_extension.dart';
import 'package:health_connector_toolbox/src/common/utils/extensions/sexual_activity_protection_used_extension.dart';
import 'package:health_connector_toolbox/src/common/utils/extensions/sleep_stage_type_extension.dart';
import 'package:health_connector_toolbox/src/common/utils/mixins/process_operation_with_error_handler_page_state_mixin.dart';
import 'package:health_connector_toolbox/src/common/utils/show_app_snack_bar.dart';
import 'package:health_connector_toolbox/src/common/widgets/buttons/elevated_gradient_button.dart';
import 'package:health_connector_toolbox/src/common/widgets/loading_overlay.dart';
import 'package:health_connector_toolbox/src/common/widgets/pickers/date_time_picker_row.dart';
import 'package:health_connector_toolbox/src/common/widgets/pickers/duration_picker_field.dart'
    show DurationPickerField;
import 'package:health_connector_toolbox/src/features/write_health_record/models/nutrition_form_data.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/form_fields/blood_pressure_form_field.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/form_fields/enum_dropdown_form_field.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/form_fields/health_record_value_form_field.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/form_fields/heart_rate_series_record_heart_rate_measurements_form_field.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/form_fields/metadata_form_field_group.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/form_fields/nutrition_record_nutrient_form_fields.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/form_fields/power_series_record_power_samples_form_field.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/form_fields/sleep_session_record_sleep_stages_form_field.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/form_fields/speed_series_record_speed_samples_form_field.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/write_health_record_change_notifier.dart';
import 'package:provider/provider.dart' show Provider;

// region Utilities

/// Extension on [HealthDataType] to provide form-related properties.
///
/// This provides form configuration directly on the data type,
/// eliminating the need for a separate registry.
extension HealthDataTypeFormExtension on HealthDataType {
  /// Whether this data type requires duration (interval vs instant records).
  ///
  /// Interval-based records (like steps, distance) need both start and end
  /// times. Instant-based records (like weight, height) only need a single
  /// timestamp.
  bool get needsDuration => switch (this) {
    // Activity types (interval)
    StepsHealthDataType() ||
    DistanceHealthDataType() ||
    CrossCountrySkiingDistanceDataType() ||
    CyclingDistanceDataType() ||
    DownhillSnowSportsDistanceDataType() ||
    PaddleSportsDistanceDataType() ||
    RowingDistanceDataType() ||
    SixMinuteWalkTestDistanceDataType() ||
    SkatingSportsDistanceDataType() ||
    SwimmingDistanceDataType() ||
    WheelchairDistanceDataType() ||
    WalkingRunningDistanceDataType() ||
    ActiveCaloriesBurnedHealthDataType() ||
    FloorsClimbedHealthDataType() ||
    WheelchairPushesHealthDataType() ||
    // Nutrition types (interval)
    HydrationHealthDataType() ||
    NutritionHealthDataType() ||
    // Sleep types (interval)
    SleepStageHealthDataType() ||
    SleepSessionHealthDataType() ||
    // Exercise types (interval)
    ExerciseSessionHealthDataType() ||
    // Mindfulness types (interval)
    MindfulnessSessionDataType() ||
    // Speed types (interval - series records)
    SpeedSeriesDataType() ||
    // Power types (interval - series records)
    PowerSeriesDataType() ||
    // Vitals types (interval - series records)
    HeartRateSeriesRecordHealthDataType() => true,

    // Body measurement types (instant)
    WeightHealthDataType() ||
    HeightHealthDataType() ||
    BodyFatPercentageHealthDataType() ||
    LeanBodyMassHealthDataType() ||
    // Vitals types (instant)
    OxygenSaturationHealthDataType() ||
    RespiratoryRateHealthDataType() ||
    BodyTemperatureHealthDataType() ||
    BloodPressureHealthDataType() ||
    SystolicBloodPressureHealthDataType() ||
    DiastolicBloodPressureHealthDataType() ||
    HeartRateMeasurementRecordHealthDataType() ||
    RestingHeartRateHealthDataType() ||
    Vo2MaxHealthDataType() ||
    BloodGlucoseHealthDataType() ||
    // Sexual activity (instant)
    SexualActivityDataType() ||
    // Cervical mucus (instant)
    CervicalMucusDataType() ||
    // Speed types (instant)
    WalkingSpeedDataType() ||
    RunningSpeedDataType() ||
    StairAscentSpeedDataType() ||
    StairDescentSpeedDataType() ||
    // Power types (instant)
    CyclingPowerDataType() ||
    // Nutrient types (instant)
    EnergyNutrientDataType() ||
    CaffeineNutrientDataType() ||
    ProteinNutrientDataType() ||
    TotalCarbohydrateNutrientDataType() ||
    TotalFatNutrientDataType() ||
    SaturatedFatNutrientDataType() ||
    MonounsaturatedFatNutrientDataType() ||
    PolyunsaturatedFatNutrientDataType() ||
    CholesterolNutrientDataType() ||
    DietaryFiberNutrientDataType() ||
    SugarNutrientDataType() ||
    CalciumNutrientDataType() ||
    IronNutrientDataType() ||
    MagnesiumNutrientDataType() ||
    ManganeseNutrientDataType() ||
    PhosphorusNutrientDataType() ||
    PotassiumNutrientDataType() ||
    SeleniumNutrientDataType() ||
    SodiumNutrientDataType() ||
    ZincNutrientDataType() ||
    VitaminANutrientDataType() ||
    VitaminB6NutrientDataType() ||
    VitaminB12NutrientDataType() ||
    VitaminCNutrientDataType() ||
    VitaminDNutrientDataType() ||
    VitaminENutrientDataType() ||
    VitaminKNutrientDataType() ||
    ThiaminNutrientDataType() ||
    RiboflavinNutrientDataType() ||
    NiacinNutrientDataType() ||
    FolateNutrientDataType() ||
    BiotinNutrientDataType() ||
    PantothenicAcidNutrientDataType() => false,
  };
}

// endregion
/// Utility class for building [HealthRecord] instances from form data.
///
/// This replaces the registry-based form config pattern with direct
/// record building logic using switch expressions.
final class HealthRecordBuilder {
  HealthRecordBuilder._();

  /// Builds a [HealthRecord] for standard types that use a single value.
  ///
  /// For complex types like [HeartRateSeriesRecord], [SleepSessionRecord],
  /// [NutritionRecord], [BloodPressureRecord], etc., use the specialized
  /// builder methods instead.
  ///
  /// Throws [UnsupportedError] for types that require specialized builders.
  static HealthRecord buildRecord({
    required HealthDataType dataType,
    required DateTime startDateTime,
    required MeasurementUnit value,
    required Metadata metadata,
    DateTime? endDateTime,
  }) {
    return switch (dataType) {
      // region Activity Types (Interval)
      StepsHealthDataType() => StepsRecord(
        startTime: startDateTime,
        endTime: endDateTime!,
        count: value as Number,
        metadata: metadata,
      ),
      DistanceHealthDataType() => DistanceRecord(
        startTime: startDateTime,
        endTime: endDateTime!,
        distance: value as Length,
        metadata: metadata,
      ),
      CrossCountrySkiingDistanceDataType() => CrossCountrySkiingDistanceRecord(
        startTime: startDateTime,
        endTime: endDateTime!,
        distance: value as Length,
        metadata: metadata,
      ),
      CyclingDistanceDataType() => CyclingDistanceRecord(
        startTime: startDateTime,
        endTime: endDateTime!,
        distance: value as Length,
        metadata: metadata,
      ),
      DownhillSnowSportsDistanceDataType() => DownhillSnowSportsDistanceRecord(
        startTime: startDateTime,
        endTime: endDateTime!,
        distance: value as Length,
        metadata: metadata,
      ),
      PaddleSportsDistanceDataType() => PaddleSportsDistanceRecord(
        startTime: startDateTime,
        endTime: endDateTime!,
        distance: value as Length,
        metadata: metadata,
      ),
      RowingDistanceDataType() => RowingDistanceRecord(
        startTime: startDateTime,
        endTime: endDateTime!,
        distance: value as Length,
        metadata: metadata,
      ),
      SixMinuteWalkTestDistanceDataType() => SixMinuteWalkTestDistanceRecord(
        startTime: startDateTime,
        endTime: endDateTime!,
        distance: value as Length,
        metadata: metadata,
      ),
      SkatingSportsDistanceDataType() => SkatingSportsDistanceRecord(
        startTime: startDateTime,
        endTime: endDateTime!,
        distance: value as Length,
        metadata: metadata,
      ),
      SwimmingDistanceDataType() => SwimmingDistanceRecord(
        startTime: startDateTime,
        endTime: endDateTime!,
        distance: value as Length,
        metadata: metadata,
      ),
      WheelchairDistanceDataType() => WheelchairDistanceRecord(
        startTime: startDateTime,
        endTime: endDateTime!,
        distance: value as Length,
        metadata: metadata,
      ),
      WalkingRunningDistanceDataType() => WalkingRunningDistanceRecord(
        startTime: startDateTime,
        endTime: endDateTime!,
        distance: value as Length,
        metadata: metadata,
      ),
      ActiveCaloriesBurnedHealthDataType() => ActiveCaloriesBurnedRecord(
        startTime: startDateTime,
        endTime: endDateTime!,
        energy: value as Energy,
        metadata: metadata,
      ),
      FloorsClimbedHealthDataType() => FloorsClimbedRecord(
        startTime: startDateTime,
        endTime: endDateTime!,
        floors: value as Number,
        metadata: metadata,
      ),
      WheelchairPushesHealthDataType() => WheelchairPushesRecord(
        startTime: startDateTime,
        endTime: endDateTime!,
        pushes: value as Number,
        metadata: metadata,
      ),
      // endregion

      // region Nutrition Types
      HydrationHealthDataType() => HydrationRecord(
        startTime: startDateTime,
        endTime: endDateTime!,
        volume: value as Volume,
        metadata: metadata,
      ),
      // endregion

      // region Body Measurement Types (Instant)
      WeightHealthDataType() => WeightRecord(
        time: startDateTime,
        weight: value as Mass,
        metadata: metadata,
      ),
      HeightHealthDataType() => HeightRecord(
        time: startDateTime,
        height: value as Length,
        metadata: metadata,
      ),
      BodyFatPercentageHealthDataType() => BodyFatPercentageRecord(
        time: startDateTime,
        percentage: value as Percentage,
        metadata: metadata,
      ),
      LeanBodyMassHealthDataType() => LeanBodyMassRecord(
        time: startDateTime,
        mass: value as Mass,
        metadata: metadata,
      ),
      // endregion

      // region Vitals Types (Instant)
      OxygenSaturationHealthDataType() => OxygenSaturationRecord(
        time: startDateTime,
        percentage: value as Percentage,
        metadata: metadata,
      ),
      RespiratoryRateHealthDataType() => RespiratoryRateRecord(
        time: startDateTime,
        breathsPerMin: value as Number,
        metadata: metadata,
      ),
      SexualActivityDataType() => SexualActivityRecord(
        time: startDateTime,
        metadata: metadata,
        // protectionUsed defaults to null - needs specialized form
      ),
      CervicalMucusDataType() => CervicalMucusRecord(
        time: startDateTime,
        metadata: metadata,
        // appearance and sensation default to null - needs specialized form
      ),
      BodyTemperatureHealthDataType() => BodyTemperatureRecord(
        time: startDateTime,
        temperature: value as Temperature,
        metadata: metadata,
      ),
      SystolicBloodPressureHealthDataType() => SystolicBloodPressureRecord(
        time: startDateTime,
        pressure: value as Pressure,
        metadata: metadata,
      ),
      DiastolicBloodPressureHealthDataType() => DiastolicBloodPressureRecord(
        time: startDateTime,
        pressure: value as Pressure,
        metadata: metadata,
      ),
      HeartRateMeasurementRecordHealthDataType() => HeartRateMeasurementRecord(
        id: HealthRecordId.none,
        metadata: metadata,
        measurement: HeartRateMeasurement(
          time: startDateTime,
          beatsPerMinute: value as Number,
        ),
      ),
      RestingHeartRateHealthDataType() => RestingHeartRateRecord(
        time: startDateTime,
        beatsPerMinute: value as Number,
        metadata: metadata,
      ),
      // endregion

      // region Speed Types (Instant)
      WalkingSpeedDataType() => WalkingSpeedRecord(
        time: startDateTime,
        speed: value as Velocity,
        metadata: metadata,
      ),
      RunningSpeedDataType() => RunningSpeedRecord(
        time: startDateTime,
        speed: value as Velocity,
        metadata: metadata,
      ),
      StairAscentSpeedDataType() => StairAscentSpeedRecord(
        time: startDateTime,
        speed: value as Velocity,
        metadata: metadata,
      ),
      StairDescentSpeedDataType() => StairDescentSpeedRecord(
        time: startDateTime,
        speed: value as Velocity,
        metadata: metadata,
      ),
      // endregion

      // region Power Types (Instant)
      CyclingPowerDataType() => CyclingPowerRecord(
        time: startDateTime,
        power: value as Power,
        metadata: metadata,
      ),
      // endregion

      // region Nutrient Types (Instant)
      EnergyNutrientDataType() => _buildNutrientRecord(
        time: startDateTime,
        value: value,
        metadata: metadata,
        builder: (v) => EnergyNutrientRecord(
          value: v as Energy,
          time: startDateTime,
          metadata: metadata,
        ),
      ),
      CaffeineNutrientDataType() => _buildNutrientRecord(
        time: startDateTime,
        value: value,
        metadata: metadata,
        builder: (v) => CaffeineNutrientRecord(
          value: v as Mass,
          time: startDateTime,
          metadata: metadata,
        ),
      ),
      ProteinNutrientDataType() => _buildNutrientRecord(
        time: startDateTime,
        value: value,
        metadata: metadata,
        builder: (v) => ProteinNutrientRecord(
          value: v as Mass,
          time: startDateTime,
          metadata: metadata,
        ),
      ),
      TotalCarbohydrateNutrientDataType() => TotalCarbohydrateNutrientRecord(
        value: value as Mass,
        time: startDateTime,
        metadata: metadata,
      ),
      TotalFatNutrientDataType() => TotalFatNutrientRecord(
        value: value as Mass,
        time: startDateTime,
        metadata: metadata,
      ),
      SaturatedFatNutrientDataType() => SaturatedFatNutrientRecord(
        value: value as Mass,
        time: startDateTime,
        metadata: metadata,
      ),
      MonounsaturatedFatNutrientDataType() => MonounsaturatedFatNutrientRecord(
        value: value as Mass,
        time: startDateTime,
        metadata: metadata,
      ),
      PolyunsaturatedFatNutrientDataType() => PolyunsaturatedFatNutrientRecord(
        value: value as Mass,
        time: startDateTime,
        metadata: metadata,
      ),
      CholesterolNutrientDataType() => CholesterolNutrientRecord(
        value: value as Mass,
        time: startDateTime,
        metadata: metadata,
      ),
      DietaryFiberNutrientDataType() => DietaryFiberNutrientRecord(
        value: value as Mass,
        time: startDateTime,
        metadata: metadata,
      ),
      SugarNutrientDataType() => SugarNutrientRecord(
        value: value as Mass,
        time: startDateTime,
        metadata: metadata,
      ),
      CalciumNutrientDataType() => CalciumNutrientRecord(
        value: value as Mass,
        time: startDateTime,
        metadata: metadata,
      ),
      IronNutrientDataType() => IronNutrientRecord(
        value: value as Mass,
        time: startDateTime,
        metadata: metadata,
      ),
      MagnesiumNutrientDataType() => MagnesiumNutrientRecord(
        value: value as Mass,
        time: startDateTime,
        metadata: metadata,
      ),
      ManganeseNutrientDataType() => ManganeseNutrientRecord(
        value: value as Mass,
        time: startDateTime,
        metadata: metadata,
      ),
      PhosphorusNutrientDataType() => PhosphorusNutrientRecord(
        value: value as Mass,
        time: startDateTime,
        metadata: metadata,
      ),
      PotassiumNutrientDataType() => PotassiumNutrientRecord(
        value: value as Mass,
        time: startDateTime,
        metadata: metadata,
      ),
      SeleniumNutrientDataType() => SeleniumNutrientRecord(
        value: value as Mass,
        time: startDateTime,
        metadata: metadata,
      ),
      SodiumNutrientDataType() => SodiumNutrientRecord(
        value: value as Mass,
        time: startDateTime,
        metadata: metadata,
      ),
      ZincNutrientDataType() => ZincNutrientRecord(
        value: value as Mass,
        time: startDateTime,
        metadata: metadata,
      ),
      VitaminANutrientDataType() => VitaminANutrientRecord(
        value: value as Mass,
        time: startDateTime,
        metadata: metadata,
      ),
      VitaminB6NutrientDataType() => VitaminB6NutrientRecord(
        value: value as Mass,
        time: startDateTime,
        metadata: metadata,
      ),
      VitaminB12NutrientDataType() => VitaminB12NutrientRecord(
        value: value as Mass,
        time: startDateTime,
        metadata: metadata,
      ),
      VitaminCNutrientDataType() => VitaminCNutrientRecord(
        value: value as Mass,
        time: startDateTime,
        metadata: metadata,
      ),
      VitaminDNutrientDataType() => VitaminDNutrientRecord(
        value: value as Mass,
        time: startDateTime,
        metadata: metadata,
      ),
      VitaminENutrientDataType() => VitaminENutrientRecord(
        value: value as Mass,
        time: startDateTime,
        metadata: metadata,
      ),
      VitaminKNutrientDataType() => VitaminKNutrientRecord(
        value: value as Mass,
        time: startDateTime,
        metadata: metadata,
      ),
      ThiaminNutrientDataType() => ThiaminNutrientRecord(
        value: value as Mass,
        time: startDateTime,
        metadata: metadata,
      ),
      RiboflavinNutrientDataType() => RiboflavinNutrientRecord(
        value: value as Mass,
        time: startDateTime,
        metadata: metadata,
      ),
      NiacinNutrientDataType() => NiacinNutrientRecord(
        value: value as Mass,
        time: startDateTime,
        metadata: metadata,
      ),
      FolateNutrientDataType() => FolateNutrientRecord(
        value: value as Mass,
        time: startDateTime,
        metadata: metadata,
      ),
      BiotinNutrientDataType() => BiotinNutrientRecord(
        value: value as Mass,
        time: startDateTime,
        metadata: metadata,
      ),
      PantothenicAcidNutrientDataType() => PantothenicAcidNutrientRecord(
        value: value as Mass,
        time: startDateTime,
        metadata: metadata,
      ),
      // endregion

      // Types that require specialized builders
      HeartRateSeriesRecordHealthDataType() ||
      SpeedSeriesDataType() ||
      PowerSeriesDataType() ||
      SleepStageHealthDataType() ||
      SleepSessionHealthDataType() ||
      ExerciseSessionHealthDataType() ||
      MindfulnessSessionDataType() ||
      NutritionHealthDataType() ||
      BloodPressureHealthDataType() ||
      Vo2MaxHealthDataType() ||
      BloodGlucoseHealthDataType() => throw UnsupportedError(
        'Use specialized builder method for ${dataType.runtimeType}',
      ),
    };
  }

  // Helper for nutrient records with optional food info
  static HealthRecord _buildNutrientRecord({
    required DateTime time,
    required MeasurementUnit value,
    required Metadata metadata,
    required HealthRecord Function(MeasurementUnit) builder,
  }) {
    return builder(value);
  }

  // region Specialized Builders

  /// Builds a [HeartRateSeriesRecord] from form data.
  static HeartRateSeriesRecord buildHeartRateSeries({
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

  /// Builds a [SpeedSeriesRecord] from form data.
  static SpeedSeriesRecord buildSpeedSeries({
    required DateTime startDateTime,
    required DateTime endDateTime,
    required List<SpeedMeasurement> samples,
    required Metadata metadata,
  }) {
    return SpeedSeriesRecord(
      startTime: startDateTime,
      endTime: endDateTime,
      samples: samples,
      metadata: metadata,
    );
  }

  /// Builds a [PowerSeriesRecord] from form data (Android).
  static PowerSeriesRecord buildPowerSeries({
    required DateTime startDateTime,
    required DateTime endDateTime,
    required List<PowerMeasurement> samples,
    required Metadata metadata,
  }) {
    return PowerSeriesRecord(
      startTime: startDateTime,
      endTime: endDateTime,
      samples: samples,
      metadata: metadata,
    );
  }

  /// Builds a [SleepStageRecord] from form data (iOS).
  static SleepStageRecord buildSleepStage({
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

  /// Builds a [SleepSessionRecord] from form data (Android).
  static SleepSessionRecord buildSleepSession({
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

  /// Builds a [NutritionRecord] from form data.
  static NutritionRecord buildNutrition({
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

  /// Builds a [BloodPressureRecord] from form data.
  static BloodPressureRecord buildBloodPressure({
    required DateTime time,
    required Pressure systolic,
    required Pressure diastolic,
    required Metadata metadata,
    BloodPressureBodyPosition bodyPosition = BloodPressureBodyPosition.unknown,
    BloodPressureMeasurementLocation measurementLocation =
        BloodPressureMeasurementLocation.unknown,
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

  /// Builds a [Vo2MaxRecord] from form data.
  static Vo2MaxRecord buildVo2Max({
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

  /// Builds a [BloodGlucoseRecord] from form data.
  static BloodGlucoseRecord buildBloodGlucose({
    required DateTime time,
    required BloodGlucose bloodGlucose,
    required Metadata metadata,
    BloodGlucoseRelationToMeal relationToMeal =
        BloodGlucoseRelationToMeal.unknown,
    BloodGlucoseMealType mealType = BloodGlucoseMealType.unknown,
    BloodGlucoseSpecimenSource specimenSource =
        BloodGlucoseSpecimenSource.unknown,
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

  /// Builds a nutrient record with optional food name and meal type.
  static HealthRecord buildNutrientWithFoodInfo({
    required HealthDataType dataType,
    required DateTime time,
    required MeasurementUnit value,
    required Metadata metadata,
    String? foodName,
    MealType mealType = MealType.unknown,
  }) {
    return switch (dataType) {
      EnergyNutrientDataType() => EnergyNutrientRecord(
        value: value as Energy,
        time: time,
        metadata: metadata,
        foodName: foodName,
        mealType: mealType,
      ),
      CaffeineNutrientDataType() => CaffeineNutrientRecord(
        value: value as Mass,
        time: time,
        metadata: metadata,
        foodName: foodName,
        mealType: mealType,
      ),
      ProteinNutrientDataType() => ProteinNutrientRecord(
        value: value as Mass,
        time: time,
        metadata: metadata,
        foodName: foodName,
        mealType: mealType,
      ),
      TotalCarbohydrateNutrientDataType() => TotalCarbohydrateNutrientRecord(
        value: value as Mass,
        time: time,
        metadata: metadata,
        foodName: foodName,
        mealType: mealType,
      ),
      TotalFatNutrientDataType() => TotalFatNutrientRecord(
        value: value as Mass,
        time: time,
        metadata: metadata,
        foodName: foodName,
        mealType: mealType,
      ),
      SaturatedFatNutrientDataType() => SaturatedFatNutrientRecord(
        value: value as Mass,
        time: time,
        metadata: metadata,
        foodName: foodName,
        mealType: mealType,
      ),
      MonounsaturatedFatNutrientDataType() => MonounsaturatedFatNutrientRecord(
        value: value as Mass,
        time: time,
        metadata: metadata,
        foodName: foodName,
        mealType: mealType,
      ),
      PolyunsaturatedFatNutrientDataType() => PolyunsaturatedFatNutrientRecord(
        value: value as Mass,
        time: time,
        metadata: metadata,
        foodName: foodName,
        mealType: mealType,
      ),
      CholesterolNutrientDataType() => CholesterolNutrientRecord(
        value: value as Mass,
        time: time,
        metadata: metadata,
        foodName: foodName,
        mealType: mealType,
      ),
      DietaryFiberNutrientDataType() => DietaryFiberNutrientRecord(
        value: value as Mass,
        time: time,
        metadata: metadata,
        foodName: foodName,
        mealType: mealType,
      ),
      SugarNutrientDataType() => SugarNutrientRecord(
        value: value as Mass,
        time: time,
        metadata: metadata,
        foodName: foodName,
        mealType: mealType,
      ),
      CalciumNutrientDataType() => CalciumNutrientRecord(
        value: value as Mass,
        time: time,
        metadata: metadata,
        foodName: foodName,
        mealType: mealType,
      ),
      IronNutrientDataType() => IronNutrientRecord(
        value: value as Mass,
        time: time,
        metadata: metadata,
        foodName: foodName,
        mealType: mealType,
      ),
      MagnesiumNutrientDataType() => MagnesiumNutrientRecord(
        value: value as Mass,
        time: time,
        metadata: metadata,
        foodName: foodName,
        mealType: mealType,
      ),
      ManganeseNutrientDataType() => ManganeseNutrientRecord(
        value: value as Mass,
        time: time,
        metadata: metadata,
        foodName: foodName,
        mealType: mealType,
      ),
      PhosphorusNutrientDataType() => PhosphorusNutrientRecord(
        value: value as Mass,
        time: time,
        metadata: metadata,
        foodName: foodName,
        mealType: mealType,
      ),
      PotassiumNutrientDataType() => PotassiumNutrientRecord(
        value: value as Mass,
        time: time,
        metadata: metadata,
        foodName: foodName,
        mealType: mealType,
      ),
      SeleniumNutrientDataType() => SeleniumNutrientRecord(
        value: value as Mass,
        time: time,
        metadata: metadata,
        foodName: foodName,
        mealType: mealType,
      ),
      SodiumNutrientDataType() => SodiumNutrientRecord(
        value: value as Mass,
        time: time,
        metadata: metadata,
        foodName: foodName,
        mealType: mealType,
      ),
      ZincNutrientDataType() => ZincNutrientRecord(
        value: value as Mass,
        time: time,
        metadata: metadata,
        foodName: foodName,
        mealType: mealType,
      ),
      VitaminANutrientDataType() => VitaminANutrientRecord(
        value: value as Mass,
        time: time,
        metadata: metadata,
        foodName: foodName,
        mealType: mealType,
      ),
      VitaminB6NutrientDataType() => VitaminB6NutrientRecord(
        value: value as Mass,
        time: time,
        metadata: metadata,
        foodName: foodName,
        mealType: mealType,
      ),
      VitaminB12NutrientDataType() => VitaminB12NutrientRecord(
        value: value as Mass,
        time: time,
        metadata: metadata,
        foodName: foodName,
        mealType: mealType,
      ),
      VitaminCNutrientDataType() => VitaminCNutrientRecord(
        value: value as Mass,
        time: time,
        metadata: metadata,
        foodName: foodName,
        mealType: mealType,
      ),
      VitaminDNutrientDataType() => VitaminDNutrientRecord(
        value: value as Mass,
        time: time,
        metadata: metadata,
        foodName: foodName,
        mealType: mealType,
      ),
      VitaminENutrientDataType() => VitaminENutrientRecord(
        value: value as Mass,
        time: time,
        metadata: metadata,
        foodName: foodName,
        mealType: mealType,
      ),
      VitaminKNutrientDataType() => VitaminKNutrientRecord(
        value: value as Mass,
        time: time,
        metadata: metadata,
        foodName: foodName,
        mealType: mealType,
      ),
      ThiaminNutrientDataType() => ThiaminNutrientRecord(
        value: value as Mass,
        time: time,
        metadata: metadata,
        foodName: foodName,
        mealType: mealType,
      ),
      RiboflavinNutrientDataType() => RiboflavinNutrientRecord(
        value: value as Mass,
        time: time,
        metadata: metadata,
        foodName: foodName,
        mealType: mealType,
      ),
      NiacinNutrientDataType() => NiacinNutrientRecord(
        value: value as Mass,
        time: time,
        metadata: metadata,
        foodName: foodName,
        mealType: mealType,
      ),
      FolateNutrientDataType() => FolateNutrientRecord(
        value: value as Mass,
        time: time,
        metadata: metadata,
        foodName: foodName,
        mealType: mealType,
      ),
      BiotinNutrientDataType() => BiotinNutrientRecord(
        value: value as Mass,
        time: time,
        metadata: metadata,
        foodName: foodName,
        mealType: mealType,
      ),
      PantothenicAcidNutrientDataType() => PantothenicAcidNutrientRecord(
        value: value as Mass,
        time: time,
        metadata: metadata,
        foodName: foodName,
        mealType: mealType,
      ),
      _ => throw UnsupportedError(
        'Not a nutrient type: ${dataType.runtimeType}',
      ),
    };
  }

  /// Checks if a data type is a nutrient type (requires food info fields).
  static bool isNutrientType(HealthDataType dataType) => switch (dataType) {
    EnergyNutrientDataType() ||
    CaffeineNutrientDataType() ||
    ProteinNutrientDataType() ||
    TotalCarbohydrateNutrientDataType() ||
    TotalFatNutrientDataType() ||
    SaturatedFatNutrientDataType() ||
    MonounsaturatedFatNutrientDataType() ||
    PolyunsaturatedFatNutrientDataType() ||
    CholesterolNutrientDataType() ||
    DietaryFiberNutrientDataType() ||
    SugarNutrientDataType() ||
    CalciumNutrientDataType() ||
    IronNutrientDataType() ||
    MagnesiumNutrientDataType() ||
    ManganeseNutrientDataType() ||
    PhosphorusNutrientDataType() ||
    PotassiumNutrientDataType() ||
    SeleniumNutrientDataType() ||
    SodiumNutrientDataType() ||
    ZincNutrientDataType() ||
    VitaminANutrientDataType() ||
    VitaminB6NutrientDataType() ||
    VitaminB12NutrientDataType() ||
    VitaminCNutrientDataType() ||
    VitaminDNutrientDataType() ||
    VitaminENutrientDataType() ||
    VitaminKNutrientDataType() ||
    ThiaminNutrientDataType() ||
    RiboflavinNutrientDataType() ||
    NiacinNutrientDataType() ||
    FolateNutrientDataType() ||
    BiotinNutrientDataType() ||
    PantothenicAcidNutrientDataType() => true,
    _ => false,
  };

  /// Builds an [ExerciseSessionRecord] from form data.
  static ExerciseSessionRecord buildExerciseSession({
    required DateTime startDateTime,
    required DateTime endDateTime,
    required ExerciseType exerciseType,
    required Metadata metadata,
    String? title,
    String? notes,
  }) {
    return ExerciseSessionRecord(
      startTime: startDateTime,
      endTime: endDateTime,
      exerciseType: exerciseType,
      metadata: metadata,
      title: title,
      notes: notes,
    );
  }

  /// Builds a [MindfulnessSessionRecord] from form data.
  static MindfulnessSessionRecord buildMindfulnessSession({
    required DateTime startDateTime,
    required DateTime endDateTime,
    required MindfulnessSessionType sessionType,
    required Metadata metadata,
    String? title,
    String? notes,
  }) {
    return MindfulnessSessionRecord(
      startTime: startDateTime,
      endTime: endDateTime,
      sessionType: sessionType,
      metadata: metadata,
      title: title,
      notes: notes,
    );
  }

  // endregion
}

/// Unified page for writing health records.
///
/// This page dynamically renders the appropriate form fields based on the
/// provided [HealthDataType].
/// It handles both interval-based records (e.g., steps) and
/// instant-based records (e.g., weight).
@immutable
final class WriteHealthRecordFormPage extends StatefulWidget {
  const WriteHealthRecordFormPage({
    required this.dataType,
    super.key,
  });

  /// The health data type that determines which form fields to render.
  final HealthDataType dataType;

  @override
  State<WriteHealthRecordFormPage> createState() =>
      _WriteHealthRecordFormPageState();
}

class _WriteHealthRecordFormPageState extends State<WriteHealthRecordFormPage>
    with
        ProcessOperationWithErrorHandlerPageStateMixin<
          WriteHealthRecordFormPage
        > {
  late final WriteHealthRecordChangeNotifier _notifier =
      Provider.of<WriteHealthRecordChangeNotifier>(
        context,
        listen: false,
      );

  bool get _needsDuration => widget.dataType.needsDuration;

  final _formKey = GlobalKey<FormState>();
  RecordingMethod _recordingMethod = RecordingMethod.unknown;
  Device? _device;
  MeasurementUnit? _value;
  bool _isWriting = false;

  // State for heart rate series samples (Android)
  List<HeartRateMeasurement>? _heartRateSamples;

  // State for speed series samples (Android)
  List<SpeedMeasurement>? _speedSamples;

  // State for power series samples (Android)
  List<PowerMeasurement>? _powerSamples;

  // State for sleep stages (Android SleepSessionRecord)
  List<SleepStage>? _sleepStages;

  // State for single sleep stage (iOS SleepStageRecord)
  SleepStage? _sleepStage;
  SleepStageType? _sleepStageType;

  // Optional title and notes for sleep records
  String? _sleepTitle;
  String? _sleepNotes;

  // State for nutrient records
  String? _foodName;
  MealType _mealType = MealType.unknown;

  // State for nutrition record (using NutritionData model)
  NutritionData _nutritionData = const NutritionData();

  // State for blood pressure record
  Pressure? _systolic;
  Pressure? _diastolic;

  // State for blood glucose record
  BloodGlucoseRelationToMeal _bgRelationToMeal =
      BloodGlucoseRelationToMeal.unknown;
  BloodGlucoseMealType _bgMealType = BloodGlucoseMealType.unknown;
  BloodGlucoseSpecimenSource _bgSpecimenSource =
      BloodGlucoseSpecimenSource.unknown;

  // State for Number
  Vo2MaxTestType? _vo2MaxTestType;

  // State for exercise session
  ExerciseType? _exerciseType;
  String? _exerciseTitle;
  String? _exerciseNotes;

  // State for sexual activity
  SexualActivityProtectionUsedType _protectionUsed =
      SexualActivityProtectionUsedType.unknown;

  // State for cervical mucus
  CervicalMucusAppearanceType _appearance = CervicalMucusAppearanceType.unknown;
  CervicalMucusSensationType _sensation = CervicalMucusSensationType.unknown;

  // State for mindfulness session
  MindfulnessSessionType? _mindfulnessSessionType;
  String? _mindfulnessTitle;
  String? _mindfulnessNotes;

  // Use different state mixins based on whether duration is needed
  DateTime? _startDate;
  TimeOfDay? _startTime;
  TimeOfDay? _duration;

  DateTime? get startDateTime {
    if (_startDate == null || _startTime == null) {
      return null;
    }
    return DateTime(
      _startDate!.year,
      _startDate!.month,
      _startDate!.day,
      _startTime!.hour,
      _startTime!.minute,
    );
  }

  DateTime? get endDateTime {
    if (!_needsDuration) {
      return null;
    }
    final start = startDateTime;
    if (start == null || _duration == null) {
      return null;
    }
    final durationMinutes = _duration!.hour * 60 + _duration!.minute;
    if (durationMinutes == 0) {
      return null;
    }
    return start.add(Duration(minutes: durationMinutes));
  }

  @override
  void initState() {
    super.initState();
    if (_needsDuration) {
      // For interval records, set start time to 30 minutes ago
      final nowMinus30Min = DateTime.now().subtract(
        const Duration(minutes: 30),
      );
      _startDate = DateTime(
        nowMinus30Min.year,
        nowMinus30Min.month,
        nowMinus30Min.day,
      );
      _startTime = TimeOfDay(
        hour: nowMinus30Min.hour,
        minute: nowMinus30Min.minute,
      );
      _duration = const TimeOfDay(hour: 0, minute: 30);
    } else {
      // For instant records, set to current time
      final now = DateTime.now();
      _startDate = DateTime(now.year, now.month, now.day);
      _startTime = TimeOfDay.fromDateTime(now);
    }
  }

  void setDate(DateTime? date) {
    setState(() {
      _startDate = date;
    });
    _updateSleepStage();
  }

  void setTime(TimeOfDay? time) {
    setState(() {
      _startTime = time;
    });
    _updateSleepStage();
  }

  void setDuration(TimeOfDay? duration) {
    setState(() {
      _duration = duration;
      // Update sleep stage if we're creating a SleepStageRecord
      if (widget.dataType is SleepStageHealthDataType &&
          _sleepStageType != null &&
          startDateTime != null &&
          endDateTime != null) {
        _sleepStage = SleepStage(
          startTime: startDateTime!,
          endTime: endDateTime!,
          stageType: _sleepStageType!,
        );
      }
    });
  }

  void _updateSleepStage() {
    if (widget.dataType is SleepStageHealthDataType &&
        _sleepStageType != null &&
        startDateTime != null &&
        endDateTime != null) {
      setState(() {
        _sleepStage = SleepStage(
          startTime: startDateTime!,
          endTime: endDateTime!,
          stageType: _sleepStageType!,
        );
      });
    } else {
      setState(() {
        _sleepStage = null;
      });
    }
  }

  String? _durationValidator(TimeOfDay? value) {
    if (value == null) {
      return '${AppTexts.pleaseSelect} Duration';
    }
    final durationMinutes = value.hour * 60 + value.minute;
    if (durationMinutes == 0) {
      return AppTexts.durationMustBeGreaterThanZero;
    }
    if (startDateTime == null) {
      return AppTexts.pleaseSelectDateTime;
    }
    final end = endDateTime;
    if (end == null) {
      return AppTexts.failedToCalculateEndTime;
    }
    return null;
  }

  Future<void> _submitRecord() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    // Validate device is present when required
    if ((_recordingMethod == RecordingMethod.automaticallyRecorded ||
            _recordingMethod == RecordingMethod.activelyRecorded) &&
        _device == null) {
      return;
    }

    // Validate required fields
    if (startDateTime == null) {
      return;
    }
    if (_needsDuration && endDateTime == null) {
      return;
    }

    // Special validation for heart rate series record
    if (widget.dataType is HeartRateSeriesRecordHealthDataType) {
      if (_heartRateSamples == null || _heartRateSamples!.isEmpty) {
        return;
      }
    } else if (widget.dataType is SpeedSeriesDataType) {
      if (_speedSamples == null || _speedSamples!.isEmpty) {
        return;
      }
    } else if (widget.dataType is PowerSeriesDataType) {
      if (_powerSamples == null || _powerSamples!.isEmpty) {
        return;
      }
    } else if (widget.dataType is SleepSessionHealthDataType) {
      if (_sleepStages == null || _sleepStages!.isEmpty) {
        return;
      }
    } else if (widget.dataType is SleepStageHealthDataType) {
      if (_sleepStage == null) {
        return;
      }
    } else if (widget.dataType is NutritionHealthDataType) {
      // NutritionRecord doesn't require any fields - all are optional
      // Validation will be handled in the form widget
    } else if (widget.dataType is BloodPressureHealthDataType) {
      // Blood pressure records need both systolic and diastolic values
      if (_systolic == null || _diastolic == null) {
        return;
      }
    } else if (widget.dataType is Vo2MaxHealthDataType) {
      if (_value == null || _vo2MaxTestType == null) {
        return;
      }
    } else if (widget.dataType is BloodGlucoseHealthDataType) {
      if (_value == null) {
        return;
      }
    } else if (widget.dataType is ExerciseSessionHealthDataType) {
      if (_exerciseType == null) {
        return;
      }
    } else if (widget.dataType is MindfulnessSessionDataType) {
      if (_mindfulnessSessionType == null) {
        return;
      }
    } else if (HealthRecordBuilder.isNutrientType(widget.dataType)) {
      // Nutrient records need a value
      if (_value == null) {
        return;
      }
    } else if (widget.dataType is SexualActivityDataType) {
      // Sexual activity records are always valid (all fields are optional)
      // No required validation needed
    } else if (widget.dataType is CervicalMucusDataType) {
      // Cervical mucus records are always valid (all fields are optional)
      // No required validation needed
    } else {
      if (_value == null) {
        return;
      }
    }

    setState(() {
      _isWriting = true;
    });

    await process(() async {
      // Use a fake package name 'com.example.health_connector_toolbox'.
      // In production this should come from app config.
      const dataOrigin = DataOrigin('com.example.health_connector_toolbox');
      final metadata = switch (_recordingMethod) {
        RecordingMethod.manualEntry => Metadata.manualEntry(
          dataOrigin: dataOrigin,
        ),
        RecordingMethod.automaticallyRecorded => Metadata.automaticallyRecorded(
          dataOrigin: dataOrigin,
          device: _device!,
        ),
        RecordingMethod.activelyRecorded => Metadata.activelyRecorded(
          dataOrigin: dataOrigin,
          device: _device!,
        ),
        RecordingMethod.unknown => Metadata.unknownRecordingMethod(
          dataOrigin: dataOrigin,
          device: _device,
        ),
      };

      final record = switch (widget.dataType) {
        HeartRateSeriesRecordHealthDataType() =>
          HealthRecordBuilder.buildHeartRateSeries(
            startDateTime: startDateTime!,
            endDateTime: endDateTime!,
            samples: _heartRateSamples!,
            metadata: metadata,
          ),
        SpeedSeriesDataType() => HealthRecordBuilder.buildSpeedSeries(
          startDateTime: startDateTime!,
          endDateTime: endDateTime!,
          samples: _speedSamples!,
          metadata: metadata,
        ),
        PowerSeriesDataType() => HealthRecordBuilder.buildPowerSeries(
          startDateTime: startDateTime!,
          endDateTime: endDateTime!,
          samples: _powerSamples!,
          metadata: metadata,
        ),
        SleepSessionHealthDataType() => HealthRecordBuilder.buildSleepSession(
          startDateTime: startDateTime!,
          endDateTime: endDateTime!,
          stages: _sleepStages!,
          metadata: metadata,
          title: _sleepTitle?.isEmpty ?? true ? null : _sleepTitle,
          notes: _sleepNotes?.isEmpty ?? true ? null : _sleepNotes,
        ),
        SleepStageHealthDataType() => HealthRecordBuilder.buildSleepStage(
          startDateTime: startDateTime!,
          endDateTime: endDateTime!,
          stageType: _sleepStage!.stageType,
          metadata: metadata,
          title: _sleepTitle?.isEmpty ?? true ? null : _sleepTitle,
          notes: _sleepNotes?.isEmpty ?? true ? null : _sleepNotes,
        ),
        NutritionHealthDataType() => HealthRecordBuilder.buildNutrition(
          startDateTime: startDateTime!,
          endDateTime: endDateTime!,
          metadata: metadata,
          foodName: _nutritionData.foodName,
          mealType: _nutritionData.mealType,
          energy: _nutritionData.energy,
          protein: _nutritionData.protein,
          totalCarbohydrate: _nutritionData.totalCarbohydrate,
          totalFat: _nutritionData.totalFat,
          saturatedFat: _nutritionData.saturatedFat,
          monounsaturatedFat: _nutritionData.monounsaturatedFat,
          polyunsaturatedFat: _nutritionData.polyunsaturatedFat,
          cholesterol: _nutritionData.cholesterol,
          dietaryFiber: _nutritionData.dietaryFiber,
          sugar: _nutritionData.sugar,
          vitaminA: _nutritionData.vitaminA,
          vitaminB6: _nutritionData.vitaminB6,
          vitaminB12: _nutritionData.vitaminB12,
          vitaminC: _nutritionData.vitaminC,
          vitaminD: _nutritionData.vitaminD,
          vitaminE: _nutritionData.vitaminE,
          vitaminK: _nutritionData.vitaminK,
          thiamin: _nutritionData.thiamin,
          riboflavin: _nutritionData.riboflavin,
          niacin: _nutritionData.niacin,
          folate: _nutritionData.folate,
          biotin: _nutritionData.biotin,
          pantothenicAcid: _nutritionData.pantothenicAcid,
          calcium: _nutritionData.calcium,
          iron: _nutritionData.iron,
          magnesium: _nutritionData.magnesium,
          manganese: _nutritionData.manganese,
          phosphorus: _nutritionData.phosphorus,
          potassium: _nutritionData.potassium,
          selenium: _nutritionData.selenium,
          sodium: _nutritionData.sodium,
          zinc: _nutritionData.zinc,
          caffeine: _nutritionData.caffeine,
        ),
        BloodPressureHealthDataType() => HealthRecordBuilder.buildBloodPressure(
          time: startDateTime!,
          systolic: _systolic!,
          diastolic: _diastolic!,
          metadata: metadata,
        ),
        Vo2MaxHealthDataType() => HealthRecordBuilder.buildVo2Max(
          time: startDateTime!,
          vo2Max: _value! as Number,
          testType: _vo2MaxTestType!,
          metadata: metadata,
        ),
        BloodGlucoseHealthDataType() => HealthRecordBuilder.buildBloodGlucose(
          time: startDateTime!,
          bloodGlucose: _value! as BloodGlucose,
          metadata: metadata,
          relationToMeal: _bgRelationToMeal,
          mealType: _bgMealType,
          specimenSource: _bgSpecimenSource,
        ),
        ExerciseSessionHealthDataType() =>
          HealthRecordBuilder.buildExerciseSession(
            startDateTime: startDateTime!,
            endDateTime: endDateTime!,
            exerciseType: _exerciseType!,
            metadata: metadata,
            title: _exerciseTitle?.isEmpty ?? true ? null : _exerciseTitle,
            notes: _exerciseNotes?.isEmpty ?? true ? null : _exerciseNotes,
          ),
        SexualActivityDataType() => SexualActivityRecord(
          time: startDateTime!,
          metadata: metadata,
          protectionUsed: _protectionUsed,
        ),
        CervicalMucusDataType() => CervicalMucusRecord(
          time: startDateTime!,
          metadata: metadata,
          appearance: _appearance,
          sensation: _sensation,
        ),
        MindfulnessSessionDataType() =>
          HealthRecordBuilder.buildMindfulnessSession(
            startDateTime: startDateTime!,
            endDateTime: endDateTime!,
            sessionType: _mindfulnessSessionType!,
            metadata: metadata,
            title: _mindfulnessTitle?.isEmpty ?? true
                ? null
                : _mindfulnessTitle,
            notes: _mindfulnessNotes?.isEmpty ?? true
                ? null
                : _mindfulnessNotes,
          ),
        _ =>
          HealthRecordBuilder.isNutrientType(widget.dataType)
              ? HealthRecordBuilder.buildNutrientWithFoodInfo(
                  dataType: widget.dataType,
                  time: startDateTime!,
                  value: _value!,
                  metadata: metadata,
                  foodName: _foodName?.isEmpty ?? true ? null : _foodName,
                  mealType: _mealType,
                )
              : HealthRecordBuilder.buildRecord(
                  dataType: widget.dataType,
                  startDateTime: startDateTime!,
                  endDateTime: endDateTime,
                  value: _value!,
                  metadata: metadata,
                ),
      };

      await _notifier.writeHealthRecord(record);

      if (!mounted) {
        return;
      }

      showAppSnackBar(
        context,
        SnackBarType.success,
        '${AppTexts.successfullyWroteRecord} '
        '${_notifier.newRecordId?.value ?? 'unknown'}',
      );

      Navigator.of(context).pop();
    });

    if (mounted) {
      setState(() {
        _isWriting = false;
      });
    }
  }

  void _onHeartRateSamplesChanged(List<HeartRateMeasurement>? samples) {
    if (samples == null) {
      return;
    }
    setState(() {
      _heartRateSamples = samples;
    });
  }

  void _onSleepStagesChanged(List<SleepStage>? stages) {
    if (stages == null) {
      return;
    }
    setState(() {
      _sleepStages = stages;
    });
  }

  void _onSpeedSamplesChanged(List<SpeedMeasurement>? samples) {
    if (samples == null) {
      return;
    }
    setState(() {
      _speedSamples = samples;
    });
  }

  void _onPowerSamplesChanged(List<PowerMeasurement>? samples) {
    if (samples == null) {
      return;
    }
    setState(() {
      _powerSamples = samples;
    });
  }

  void _onSleepStageTypeChanged(SleepStageType? type) {
    setState(() {
      _sleepStageType = type;
    });
    _updateSleepStage();
  }

  String? _validateSleepStageType(SleepStageType? value) {
    if (value == null) {
      return AppTexts.pleaseSelectSleepStageType;
    }
    return null;
  }

  void _onBloodGlucoseValueChanged(MeasurementUnit? value) {
    setState(() {
      _value = value;
    });
  }

  void _onBgRelationToMealChanged(BloodGlucoseRelationToMeal? value) {
    setState(() {
      _bgRelationToMeal = value!;
    });
  }

  void _onBgMealTypeChanged(BloodGlucoseMealType? value) {
    setState(() {
      _bgMealType = value!;
    });
  }

  void _onBgSpecimenSourceChanged(BloodGlucoseSpecimenSource? value) {
    setState(() {
      _bgSpecimenSource = value!;
    });
  }

  void _onNutritionDataChanged(NutritionData data) {
    setState(() {
      _nutritionData = data;
    });
  }

  void _onBloodPressureChanged({
    required Pressure? systolic,
    required Pressure? diastolic,
  }) {
    if (systolic == null || diastolic == null) {
      return;
    }
    setState(() {
      _systolic = systolic;
      _diastolic = diastolic;
    });
  }

  void _onVo2MaxValueChanged(MeasurementUnit? value) {
    setState(() => _value = value);
  }

  void _onVo2MaxTestTypeChanged(Vo2MaxTestType? val) {
    setState(() => _vo2MaxTestType = val);
  }

  String? _validateVo2MaxTestType(Vo2MaxTestType? val) {
    return val == null ? AppTexts.pleaseSelect : null;
  }

  void _onRecordValueChanged(MeasurementUnit? value) {
    setState(() {
      _value = value;
    });
  }

  void _onFoodNameChanged(String value) {
    setState(() {
      _foodName = value.isEmpty ? null : value;
    });
  }

  void _onMealTypeChanged(MealType? type) {
    setState(() {
      _mealType = type ?? MealType.unknown;
    });
  }

  void _onSleepTitleChanged(String value) {
    setState(() {
      _sleepTitle = value.isEmpty ? null : value;
    });
  }

  void _onSleepNotesChanged(String value) {
    setState(() {
      _sleepNotes = value.isEmpty ? null : value;
    });
  }

  void _onExerciseTypeChanged(ExerciseType? type) {
    setState(() {
      _exerciseType = type;
    });
  }

  String? _validateExerciseType(ExerciseType? value) {
    if (value == null) {
      return AppTexts.getPleaseSelectText(AppTexts.exerciseType);
    }
    return null;
  }

  void _onExerciseTitleChanged(String value) {
    setState(() {
      _exerciseTitle = value.isEmpty ? null : value;
    });
  }

  void _onExerciseNotesChanged(String value) {
    setState(() {
      _exerciseNotes = value.isEmpty ? null : value;
    });
  }

  void _onProtectionUsedChanged(SexualActivityProtectionUsedType? value) {
    setState(() {
      _protectionUsed = value ?? SexualActivityProtectionUsedType.unknown;
    });
  }

  void _onAppearanceChanged(CervicalMucusAppearanceType? value) {
    setState(() {
      _appearance = value ?? CervicalMucusAppearanceType.unknown;
    });
  }

  void _onSensationChanged(CervicalMucusSensationType? value) {
    setState(() {
      _sensation = value ?? CervicalMucusSensationType.unknown;
    });
  }

  void _onMindfulnessSessionTypeChanged(MindfulnessSessionType? type) {
    setState(() {
      _mindfulnessSessionType = type;
    });
  }

  String? _validateMindfulnessSessionType(MindfulnessSessionType? value) {
    if (value == null) {
      return AppTexts.getPleaseSelectText(AppTexts.mindfulnessSession);
    }
    return null;
  }

  void _onMindfulnessTitleChanged(String value) {
    setState(() {
      _mindfulnessTitle = value.isEmpty ? null : value;
    });
  }

  void _onMindfulnessNotesChanged(String value) {
    setState(() {
      _mindfulnessNotes = value.isEmpty ? null : value;
    });
  }

  void _onRecordingMethodChanged(RecordingMethod? method) {
    setState(() {
      _recordingMethod = method ?? RecordingMethod.unknown;
    });
  }

  void _onDeviceChanged(Device? device) {
    setState(() {
      _device = device;
    });
  }

  String? _validateRecordingMethod(RecordingMethod? value) {
    if (value == null) {
      return AppTexts.pleaseSelectRecordingMethod;
    }
    return null;
  }

  String? _validateDeviceType(DeviceType? value) {
    if (value == null) {
      return AppTexts.pleaseSelectDeviceType;
    }
    return null;
  }

  /// Returns all exercise types supported on the current platform.
  ///
  /// This method filters the exercise types based on the current health
  /// platform to show only types that are valid for that platform.
  List<ExerciseType> _getExerciseTypesForPlatform() {
    return switch (_notifier.healthPlatform) {
      HealthPlatform.appleHealth => ExerciseTypeExtension.appleHealthTypes,
      HealthPlatform.healthConnect => ExerciseTypeExtension.healthConnectTypes,
    };
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: _isWriting,
      child: Scaffold(
        appBar: AppBar(
          title: Text(_getTitle(widget.dataType)),
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      DateTimePickerRow(
                        startDate: _startDate,
                        startTime: _startTime,
                        onDateChanged: setDate,
                        onTimeChanged: setTime,
                      ),
                      if (_needsDuration) ...[
                        const SizedBox(height: 16),
                        DurationPickerField(
                          initialValue: _duration,
                          onChanged: setDuration,
                          validator: _durationValidator,
                        ),
                      ],
                      const SizedBox(height: 16),
                      if (widget.dataType
                          is HeartRateSeriesRecordHealthDataType)
                        HeartRateSeriesRecordHeartRateMeasurementsFormField(
                          startDateTime: startDateTime,
                          endDateTime: endDateTime,
                          onChanged: _onHeartRateSamplesChanged,
                        )
                      else if (widget.dataType is SleepSessionHealthDataType)
                        SleepSessionRecordSleepStagesFormField(
                          startDateTime: startDateTime,
                          endDateTime: endDateTime,
                          onChanged: _onSleepStagesChanged,
                        )
                      else if (widget.dataType is SpeedSeriesDataType)
                        SpeedSeriesRecordSpeedSamplesFormField(
                          startDateTime: startDateTime,
                          endDateTime: endDateTime,
                          onChanged: _onSpeedSamplesChanged,
                        )
                      else if (widget.dataType is PowerSeriesDataType)
                        PowerSeriesRecordPowerSamplesFormField(
                          startDateTime: startDateTime,
                          endDateTime: endDateTime,
                          onChanged: _onPowerSamplesChanged,
                        )
                      else if (widget.dataType is SleepStageHealthDataType) ...[
                        EnumDropdownFormField<SleepStageType>(
                          labelText: AppTexts.sleepStageType,
                          values: SleepStageType.values,
                          value: _sleepStageType,
                          onChanged: _onSleepStageTypeChanged,
                          validator: _validateSleepStageType,
                          displayNameBuilder: (type) => type.displayName,
                          prefixIcon: AppIcons.bedtime,
                          hint: AppTexts.pleaseSelect,
                        ),
                      ] else if (widget.dataType
                          is BloodGlucoseHealthDataType) ...[
                        HealthRecordValueFormField(
                          dataType: widget.dataType,
                          onChanged: _onBloodGlucoseValueChanged,
                        ),
                        const SizedBox(height: 16),
                        EnumDropdownFormField<BloodGlucoseRelationToMeal>(
                          labelText: AppTexts.relationToMeal,
                          values: BloodGlucoseRelationToMeal.values,
                          value: _bgRelationToMeal,
                          onChanged: _onBgRelationToMealChanged,
                        ),
                        const SizedBox(height: 16),
                        EnumDropdownFormField<BloodGlucoseMealType>(
                          labelText: AppTexts.mealType,
                          values: BloodGlucoseMealType.values,
                          value: _bgMealType,
                          onChanged: _onBgMealTypeChanged,
                        ),
                        const SizedBox(height: 16),
                        EnumDropdownFormField<BloodGlucoseSpecimenSource>(
                          labelText: AppTexts.specimenSource,
                          values: BloodGlucoseSpecimenSource.values,
                          value: _bgSpecimenSource,
                          onChanged: _onBgSpecimenSourceChanged,
                        ),
                      ] else if (widget.dataType is NutritionHealthDataType)
                        NutritionRecordNutrientFormFields(
                          onChanged: _onNutritionDataChanged,
                        )
                      else if (widget.dataType is BloodPressureHealthDataType)
                        BloodPressureFormField(
                          onChanged: _onBloodPressureChanged,
                        )
                      else if (widget.dataType is Vo2MaxHealthDataType) ...[
                        HealthRecordValueFormField(
                          dataType: widget.dataType,
                          onChanged: _onVo2MaxValueChanged,
                        ),
                        const SizedBox(height: 16),
                        DropdownButtonFormField<Vo2MaxTestType>(
                          initialValue: _vo2MaxTestType,
                          decoration: const InputDecoration(
                            labelText: AppTexts.vo2MaxTestTypeLabel,
                            border: OutlineInputBorder(),
                          ),
                          items: Vo2MaxTestType.values
                              .map(
                                (type) => DropdownMenuItem(
                                  value: type,
                                  child: Text(type.name),
                                ),
                              )
                              .toList(),
                          onChanged: _onVo2MaxTestTypeChanged,
                          validator: _validateVo2MaxTestType,
                        ),
                      ] else if (widget.dataType
                          is ExerciseSessionHealthDataType) ...[
                        EnumDropdownFormField<ExerciseType>(
                          labelText: AppTexts.exerciseType,
                          values: _getExerciseTypesForPlatform(),
                          value: _exerciseType,
                          onChanged: _onExerciseTypeChanged,
                          validator: _validateExerciseType,
                          displayNameBuilder: (type) => type.displayName,
                          prefixIcon: AppIcons.fitnessCenter,
                          hint: AppTexts.pleaseSelect,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          initialValue: _exerciseTitle,
                          decoration: const InputDecoration(
                            labelText: AppTexts.exerciseTitleOptional,
                            border: OutlineInputBorder(),
                            helperText: AppTexts.exerciseTitleHelper,
                          ),
                          onChanged: _onExerciseTitleChanged,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          initialValue: _exerciseNotes,
                          decoration: const InputDecoration(
                            labelText: AppTexts.exerciseNotesOptional,
                            border: OutlineInputBorder(),
                            helperText: AppTexts.exerciseNotesHelper,
                          ),
                          onChanged: _onExerciseNotesChanged,
                          maxLines: 3,
                        ),
                      ] else if (widget.dataType
                          is MindfulnessSessionDataType) ...[
                        EnumDropdownFormField<MindfulnessSessionType>(
                          labelText: AppTexts.mindfulnessSession,
                          values: MindfulnessSessionType.values,
                          value: _mindfulnessSessionType,
                          onChanged: _onMindfulnessSessionTypeChanged,
                          validator: _validateMindfulnessSessionType,
                          displayNameBuilder: (type) => type.displayName,
                          prefixIcon: AppIcons.selfImprovement,
                          hint: AppTexts.pleaseSelect,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          initialValue: _mindfulnessTitle,
                          decoration: const InputDecoration(
                            labelText: AppTexts.titleOptional,
                            border: OutlineInputBorder(),
                            helperText: AppTexts.titleOptional,
                          ),
                          onChanged: _onMindfulnessTitleChanged,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          initialValue: _mindfulnessNotes,
                          decoration: const InputDecoration(
                            labelText: AppTexts.notesOptional,
                            border: OutlineInputBorder(),
                            helperText: AppTexts.notesOptional,
                          ),
                          onChanged: _onMindfulnessNotesChanged,
                          maxLines: 3,
                        ),
                      ] else if (widget.dataType is SexualActivityDataType) ...[
                        EnumDropdownFormField<SexualActivityProtectionUsedType>(
                          labelText: AppTexts.protectionUsed,
                          values: SexualActivityProtectionUsedType.values,
                          value: _protectionUsed,
                          onChanged: _onProtectionUsedChanged,
                          displayNameBuilder: (type) => type.displayName,
                          prefixIcon: AppIcons.favorite,
                          hint: AppTexts.optional,
                        ),
                      ] else if (widget.dataType is CervicalMucusDataType) ...[
                        EnumDropdownFormField<CervicalMucusAppearanceType>(
                          labelText: AppTexts.appearance,
                          values: CervicalMucusAppearanceType.values,
                          value: _appearance,
                          onChanged: _onAppearanceChanged,
                          displayNameBuilder: (type) => type.displayName,
                          prefixIcon: AppIcons.waterDrop,
                          hint: AppTexts.optional,
                        ),
                        const SizedBox(height: 16),
                        EnumDropdownFormField<CervicalMucusSensationType>(
                          labelText: AppTexts.sensation,
                          values: CervicalMucusSensationType.values,
                          value: _sensation,
                          onChanged: _onSensationChanged,
                          displayNameBuilder: (type) => type.displayName,
                          prefixIcon: AppIcons.waterDrop,
                          hint: AppTexts.optional,
                        ),
                      ] else ...[
                        HealthRecordValueFormField(
                          dataType: widget.dataType,
                          onChanged: _onRecordValueChanged,
                        ),
                        // Food name and meal type fields for nutrient records
                        if (HealthRecordBuilder.isNutrientType(
                          widget.dataType,
                        )) ...[
                          const SizedBox(height: 16),
                          TextFormField(
                            initialValue: _foodName,
                            decoration: const InputDecoration(
                              labelText: AppTexts.foodNameOptional,
                              border: OutlineInputBorder(),
                              helperText: AppTexts.foodNameOptionalHelper,
                            ),
                            onChanged: _onFoodNameChanged,
                          ),
                          const SizedBox(height: 16),
                          EnumDropdownFormField<MealType>(
                            labelText: AppTexts.mealType,
                            values: MealType.values,
                            value: _mealType,
                            onChanged: _onMealTypeChanged,
                            displayNameBuilder: (type) => type.displayName,
                            prefixIcon: AppIcons.fastfood,
                            hint: AppTexts.pleaseSelect,
                          ),
                        ],
                      ],
                      // Optional title and notes fields for sleep records
                      if (widget.dataType is SleepSessionHealthDataType ||
                          widget.dataType is SleepStageHealthDataType) ...[
                        const SizedBox(height: 16),
                        TextFormField(
                          initialValue: _sleepTitle,
                          decoration: const InputDecoration(
                            labelText: AppTexts.titleOptional,
                            border: OutlineInputBorder(),
                            helperText: AppTexts.optionalTitleSleepRecord,
                          ),
                          onChanged: _onSleepTitleChanged,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          initialValue: _sleepNotes,
                          decoration: const InputDecoration(
                            labelText: AppTexts.notesOptional,
                            border: OutlineInputBorder(),
                            helperText: AppTexts.optionalNotesSleepRecord,
                          ),
                          maxLines: 3,
                          onChanged: _onSleepNotesChanged,
                        ),
                      ],
                      const SizedBox(height: 16),
                      MetadataFormFieldGroup(
                        healthPlatform: _notifier.healthPlatform,
                        initialRecordingMethod: _recordingMethod,
                        initialDevice: _device,
                        onRecordingMethodChanged: _onRecordingMethodChanged,
                        onDeviceChanged: _onDeviceChanged,
                        recordingMethodValidator: _validateRecordingMethod,
                        deviceTypeValidator: _validateDeviceType,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            ElevatedGradientButton(
              onPressed: _isWriting ? null : _submitRecord,
              label: AppTexts.write.toUpperCase(),
            ),
          ],
        ),
      ),
    );
  }

  /// Returns the appropriate title for a health record form based on the
  /// data type.
  static String _getTitle(HealthDataType dataType) {
    return AppTexts.getInsertTextFor(dataType);
  }
}
