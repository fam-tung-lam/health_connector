import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/activity_intensity/activity_intensity_record_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/blood_glucose/blood_glucose_record_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/blood_pressure/blood_pressure_record_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/body_fat_percentage_record_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/body_water_mass_record_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/bone_mass_record_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/cycling_pedaling_cadence/cycling_pedaling_cadence_series_record_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/distance_record_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/elevation_gained_record_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/energy_burned/active_energy_burned_record_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/energy_burned/total_energy_burned_record_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/exercise/exercise_session_record_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/floors_climbed_record_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/heart_rate/heart_rate_series_record_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/heart_rate/heart_rate_variability_rmssd_record_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/heart_rate/resting_heart_rate_record_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/height_record_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/hydration_record_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/lean_body_mass_record_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/menstruation/cervical_mucus/cervical_mucus_record_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/menstruation/intermenstrual_bleeding_record_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/menstruation/menstrual_flow/menstrual_flow_instant_record_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/menstruation/ovulation_test_result/ovulation_test_record_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/mindfulness/mindfulness_session_record_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/nutrition/nutrition_record_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/oxygen_saturation_record_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/power/power_series_record_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/respiratory_rate_record_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/sexual_activity/sexual_activity_record_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/sleep/sleep_session_record_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/speed/speed_record_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/steps_cadence_series_record_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/steps_record_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/temperature/basal_body_temperature_record_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/temperature/body_temperature_record_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/vo2_max_record_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/weight_record_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/wheelchair_pushes_record_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show
        ActiveEnergyBurnedRecordDto,
        ActivityIntensityRecordDto,
        BloodPressureRecordDto,
        BodyFatPercentageRecordDto,
        BodyTemperatureRecordDto,
        BasalBodyTemperatureRecordDto,
        BoneMassRecordDto,
        BodyWaterMassRecordDto,
        CervicalMucusRecordDto,
        DistanceRecordDto,
        FloorsClimbedRecordDto,
        HealthRecordDto,
        HeartRateSeriesRecordDto,
        CyclingPedalingCadenceSeriesRecordDto,
        HeartRateVariabilityRMSSDRecordDto,
        HeightRecordDto,
        HydrationRecordDto,
        LeanBodyMassRecordDto,
        NutritionRecordDto,
        IntermenstrualBleedingRecordDto,
        MenstrualFlowInstantRecordDto,
        OvulationTestRecordDto,
        OxygenSaturationRecordDto,
        PowerSeriesRecordDto,
        RestingHeartRateRecordDto,
        SexualActivityRecordDto,
        SleepSessionRecordDto,
        MindfulnessSessionRecordDto,
        StepsRecordDto,
        WeightRecordDto,
        WheelchairPushesRecordDto,
        Vo2MaxRecordDto,
        BloodGlucoseRecordDto,
        ExerciseSessionRecordDto,
        RespiratoryRateRecordDto,
        TotalEnergyBurnedRecordDto,
        SpeedSeriesRecordDto,
        StepsCadenceSeriesRecordDto,
        ElevationGainedRecordDto;
import 'package:meta/meta.dart' show internal;

/// ## ⚠️ CRITICAL: Infinite Recursion Prevention
///
/// This extension uses **explicit extension invocation** to prevent infinite
/// recursion bugs caused by missing extension imports.
///
/// ### The Problem
///
/// Each [HealthRecord] subclass has its own `toDto()` extension method defined
/// in a separate file (e.g., `BodyTemperatureRecordToDto` in
/// `body_temperature_record_mapper.dart`). If you forget to import one of
/// these files, Dart's extension resolution will fall back to this base
/// extension, causing infinite recursion:
///
/// ```dart
/// // ❌ DANGEROUS: Implicit extension invocation
/// case final BodyTemperatureRecord record:
///   return record.toDto();  // If import missing, calls THIS method again!
/// ```
///
/// ### The Solution
///
/// We use explicit extension invocation to force compile-time errors when
/// imports are missing:
///
/// ```dart
/// // SAFE: Explicit extension invocation
/// case final BodyTemperatureRecord record:
///   return BodyTemperatureRecordToDto(record).toDto();  // Compile error if import missing
/// ```
///
/// ### For Developers
///
/// When adding a new [HealthRecord] subclass:
///
/// 1. Create a new mapper file with the extension (e.g., `FooRecordToDto`)
/// 2. Import the mapper file at the top of this file
/// 3. Add a case using **explicit extension invocation**:  ```dart
///    case final FooRecord record:
///      return FooRecordToDto(record).toDto();
///    ```
/// 4. **Never** use implicit invocation (`record.toDto()`) - it will compile
///    but cause infinite recursion if the import is missing
///
/// The same approach must be applied to [HealthRecordDtoToDomain].

/// Converts [HealthRecord] to [HealthRecordDto].
@sinceV1_0_0
@internal
extension HealthRecordToDto on HealthRecord {
  HealthRecordDto toDto() {
    switch (this) {
      case final ActiveEnergyBurnedRecord record:
        return ActiveEnergyBurnedRecordToDto(record).toDto();
      case final ActivityIntensityRecord record:
        return ActivityIntensityRecordToDto(record).toDto();
      case final DistanceRecord record:
        return DistanceRecordToDto(record).toDto();
      case final ElevationGainedRecord record:
        return ElevationGainedRecordToDto(record).toDto();
      case final FloorsClimbedRecord record:
        return FloorsClimbedRecordToDto(record).toDto();
      case final HeightRecord record:
        return HeightRecordToDto(record).toDto();
      case final HydrationRecord record:
        return HydrationRecordToDto(record).toDto();
      case final LeanBodyMassRecord record:
        return LeanBodyMassRecordToDto(record).toDto();
      case final BodyFatPercentageRecord record:
        return BodyFatPercentageRecordToDto(record).toDto();
      case final BodyTemperatureRecord record:
        return BodyTemperatureRecordToDto(record).toDto();
      case final BasalBodyTemperatureRecord record:
        return BasalBodyTemperatureRecordToDto(record).toDto();
      case SleepingWristTemperatureRecord():
        throw UnsupportedError(
          '$SleepingWristTemperatureRecord is not supported on Android Health '
          'Connect. This data type is iOS-only.',
        );
      case final CervicalMucusRecord record:
        return CervicalMucusRecordToDto(record).toDto();
      case final StepsRecord record:
        return StepsRecordToDto(record).toDto();
      case final StepsCadenceSeriesRecord record:
        return StepsCadenceSeriesRecordToDto(record).toDto();
      case final WeightRecord record:
        return WeightRecordToDto(record).toDto();
      case final WheelchairPushesRecord record:
        return WheelchairPushesRecordToDto(record).toDto();
      case final HeartRateSeriesRecord record:
        return HeartRateSeriesRecordToDto(record).toDto();
      case final CyclingPedalingCadenceSeriesRecord record:
        return CyclingPedalingCadenceSeriesRecordToDto(record).toDto();
      case final SexualActivityRecord record:
        return SexualActivityRecordToDto(record).toDto();
      case final SleepSessionRecord record:
        return SleepSessionRecordToDto(record).toDto();
      case final ExerciseSessionRecord record:
        return ExerciseSessionRecordToDto(record).toDto();
      case final MindfulnessSessionRecord record:
        return MindfulnessSessionRecordToDtoExtension(record).toDto();
      case final NutritionRecord record:
        return NutritionRecordToDto(record).toDto();
      case final RestingHeartRateRecord record:
        return RestingHeartRateRecordToDto(record).toDto();
      case final OvulationTestRecord record:
        return OvulationTestRecordToDto(record).toDto();
      case final IntermenstrualBleedingRecord record:
        return IntermenstrualBleedingRecordToDto(record).toDto();
      case final MenstrualFlowInstantRecord record:
        return MenstrualFlowInstantRecordToDto(record).toDto();
      case final OxygenSaturationRecord record:
        return OxygenSaturationRecordToDto(record).toDto();
      case final BloodPressureRecord record:
        return BloodPressureRecordToDto(record).toDto();
      case final RespiratoryRateRecord record:
        return RespiratoryRateRecordToDto(record).toDto();
      case final Vo2MaxRecord record:
        return Vo2MaxRecordToDto(record).toDto();
      case final BloodGlucoseRecord record:
        return BloodGlucoseRecordToDto(record).toDto();
      case final TotalEnergyBurnedRecord record:
        return TotalEnergyBurnedRecordToDto(record).toDto();
      case final BoneMassRecord record:
        return BoneMassRecordToDto(record).toDto();
      case final BodyWaterMassRecord record:
        return BodyWaterMassRecordToDto(record).toDto();
      case final HeartRateVariabilityRMSSDRecord record:
        return HeartRateVariabilityRMSSDRecordToDto(record).toDto();
      case AlcoholicBeveragesRecord():
        throw UnsupportedError(
          'AlcoholicBeveragesRecord is not supported on Android Health '
          'Connect.',
        );
      case ExerciseTimeRecord():
        throw UnsupportedError(
          '$ExerciseTimeRecord is not supported on Android Health '
          'Connect. This data type is iOS-only.',
        );
      case MoveTimeRecord():
        throw UnsupportedError(
          '$MoveTimeRecord is not supported on Android Health '
          'Connect. This data type is iOS-only.',
        );
      case StandTimeRecord():
        throw UnsupportedError(
          '$StandTimeRecord is not supported on Android Health '
          'Connect. This data type is iOS-only.',
        );
      case WalkingSteadinessRecord():
        throw UnsupportedError(
          '$WalkingSteadinessRecord is not supported on Android Health '
          'Connect. This data type is iOS-only.',
        );
      case final BasalEnergyBurnedRecord _:
        throw UnsupportedError(
          '$BasalEnergyBurnedRecord is not supported on Android '
          'Health Connect. Use $TotalEnergyBurnedRecord and '
          '$ActiveEnergyBurnedRecord instead',
        );
      case PeripheralPerfusionIndexRecord():
        throw UnsupportedError(
          '$PeripheralPerfusionIndexRecord is not supported on Android Health '
          'Connect. This data type is iOS-only.',
        );
      case PregnancyTestRecord():
        throw UnsupportedError(
          'PregnancyTestRecord is not supported on Android Health Connect. '
          'This data type is iOS-only (requires iOS 15.0+).',
        );
      case ProgesteroneTestRecord():
        throw UnsupportedError(
          'ProgesteroneTestRecord is not supported on Android Health Connect. '
          'This data type is iOS-only (requires iOS 15.0+).',
        );
      case ContraceptiveRecord():
        throw UnsupportedError(
          'ContraceptiveRecord is not supported on Android Health Connect. '
          'This data type is iOS-only (requires iOS 14.3+).',
        );
      case LactationRecord():
        throw UnsupportedError(
          'LactationRecord is not supported on Android Health Connect. '
          'This data type is iOS-only (requires iOS 15.0+).',
        );
      case PregnancyRecord():
        throw UnsupportedError(
          'PregnancyRecord is not supported on Android Health Connect. '
          'This data type is iOS-only (requires iOS 15.0+).',
        );
      case final DietaryEnergyConsumedRecord _:
        throw UnsupportedError(
          '$DietaryEnergyConsumedRecord is not supported on Health Connect. '
          'Use $NutritionRecord instead.',
        );
      case final DietaryCaffeineRecord _:
        throw UnsupportedError(
          '$DietaryCaffeineRecord is not supported on Health Connect. '
          'Use $NutritionRecord instead.',
        );
      case final DietaryProteinRecord _:
        throw UnsupportedError(
          '$DietaryProteinRecord is not supported on Health Connect. '
          'Use $NutritionRecord instead.',
        );
      case final DietaryTotalCarbohydrateRecord _:
        throw UnsupportedError(
          '$DietaryTotalCarbohydrateRecord is not supported on '
          'Health Connect. Use $NutritionRecord instead.',
        );
      case final DietaryTotalFatRecord _:
        throw UnsupportedError(
          '$DietaryTotalFatRecord is not supported on Health Connect. '
          'Use $NutritionRecord instead.',
        );
      case final DietarySaturatedFatRecord _:
        throw UnsupportedError(
          '$DietarySaturatedFatRecord is not supported on Health Connect. '
          'Use $NutritionRecord instead.',
        );
      case final DietaryMonounsaturatedFatRecord _:
        throw UnsupportedError(
          '$DietaryMonounsaturatedFatRecord is not supported on '
          'Health Connect. Use $NutritionRecord instead.',
        );
      case final DietaryPolyunsaturatedFatRecord _:
        throw UnsupportedError(
          '$DietaryPolyunsaturatedFatRecord is not supported on '
          'Health Connect. Use $NutritionRecord instead.',
        );
      case final DietaryCholesterolRecord _:
        throw UnsupportedError(
          '$DietaryCholesterolRecord is not supported on Health Connect. '
          'Use $NutritionRecord instead.',
        );
      case final DietaryFiberRecord _:
        throw UnsupportedError(
          '$DietaryFiberRecord is not supported on Health Connect. '
          'Use $NutritionRecord instead.',
        );
      case final DietarySugarRecord _:
        throw UnsupportedError(
          '$DietarySugarRecord is not supported on Health Connect. '
          'Use $NutritionRecord instead.',
        );
      case final DietaryVitaminARecord _:
        throw UnsupportedError(
          '$DietaryVitaminARecord is not supported on Health Connect. '
          'Use $NutritionRecord instead.',
        );
      case final DietaryVitaminB6Record _:
        throw UnsupportedError(
          '$DietaryVitaminB6Record is not supported on Health Connect. '
          'Use $NutritionRecord instead.',
        );
      case final DietaryVitaminB12Record _:
        throw UnsupportedError(
          '$DietaryVitaminB12Record is not supported on Health Connect. '
          'Use $NutritionRecord instead.',
        );
      case final DietaryVitaminCRecord _:
        throw UnsupportedError(
          '$DietaryVitaminCRecord is not supported on Health Connect. '
          'Use $NutritionRecord instead.',
        );
      case final DietaryVitaminDRecord _:
        throw UnsupportedError(
          '$DietaryVitaminDRecord is not supported on Health Connect. '
          'Use $NutritionRecord instead.',
        );
      case final DietaryVitaminERecord _:
        throw UnsupportedError(
          '$DietaryVitaminERecord is not supported on Health Connect. '
          'Use $NutritionRecord instead.',
        );
      case final DietaryVitaminKRecord _:
        throw UnsupportedError(
          '$DietaryVitaminKRecord is not supported on Health Connect. '
          'Use $NutritionRecord instead.',
        );
      case final DietaryThiaminRecord _:
        throw UnsupportedError(
          '$DietaryThiaminRecord is not supported on Health Connect. '
          'Use $NutritionRecord instead.',
        );
      case final DietaryRiboflavinRecord _:
        throw UnsupportedError(
          '$DietaryRiboflavinRecord is not supported on Health Connect. '
          'Use $NutritionRecord instead.',
        );
      case final DietaryNiacinRecord _:
        throw UnsupportedError(
          '$DietaryNiacinRecord is not supported on Health Connect. '
          'Use $NutritionRecord instead.',
        );
      case final DietaryFolateRecord _:
        throw UnsupportedError(
          '$DietaryFolateRecord is not supported on Health Connect. '
          'Use $NutritionRecord instead.',
        );
      case final DietaryBiotinRecord _:
        throw UnsupportedError(
          '$DietaryBiotinRecord is not supported on Health Connect. '
          'Use $NutritionRecord instead.',
        );
      case final DietaryPantothenicAcidRecord _:
        throw UnsupportedError(
          '$DietaryPantothenicAcidRecord is not supported on Health Connect. '
          'Use $NutritionRecord instead.',
        );
      case final DietaryCalciumRecord _:
        throw UnsupportedError(
          '$DietaryCalciumRecord is not supported on Health Connect. '
          'Use $NutritionRecord instead.',
        );
      case final DietaryIronRecord _:
        throw UnsupportedError(
          '$DietaryIronRecord is not supported on Health Connect. '
          'Use $NutritionRecord instead.',
        );
      case final DietaryMagnesiumRecord _:
        throw UnsupportedError(
          '$DietaryMagnesiumRecord is not supported on Health Connect. '
          'Use $NutritionRecord instead.',
        );
      case final DietaryManganeseRecord _:
        throw UnsupportedError(
          '$DietaryManganeseRecord is not supported on Health Connect. '
          'Use $NutritionRecord instead.',
        );
      case final DietaryPhosphorusRecord _:
        throw UnsupportedError(
          '$DietaryPhosphorusRecord is not supported on Health Connect. '
          'Use $NutritionRecord instead.',
        );
      case final DietaryPotassiumRecord _:
        throw UnsupportedError(
          '$DietaryPotassiumRecord is not supported on Health Connect. '
          'Use $NutritionRecord instead.',
        );
      case final DietarySeleniumRecord _:
        throw UnsupportedError(
          '$DietarySeleniumRecord is not supported on Health Connect. '
          'Use $NutritionRecord instead.',
        );
      case final DietarySodiumRecord _:
        throw UnsupportedError(
          '$DietarySodiumRecord is not supported on Health Connect. '
          'Use $NutritionRecord instead.',
        );
      case final DietaryZincRecord _:
        throw UnsupportedError(
          '$DietaryZincRecord is not supported on Health Connect. '
          'Use $NutritionRecord instead.',
        );
      case final SleepStageRecord _:
        throw UnsupportedError(
          '$SleepStageRecord is not supported on Android. '
          'Use $SleepSessionRecord instead.',
        );
      case final HeartRateRecord _:
        throw UnsupportedError(
          '$HeartRateRecord is not supported on Android. '
          'Use $HeartRateSeriesRecord instead.',
        );
      case final SystolicBloodPressureRecord _:
        throw UnsupportedError(
          '$SystolicBloodPressureRecord is not supported on '
          'Health Connect. Use $BloodPressureRecord instead.',
        );
      case final DiastolicBloodPressureRecord _:
        throw UnsupportedError(
          '$DiastolicBloodPressureRecord is not supported on '
          'Health Connect. Use $BloodPressureRecord instead.',
        );
      case final DistanceActivityRecord _:
        throw UnsupportedError(
          '$DistanceActivityRecord and its subclasses are iOS-only '
          'and not supported on Android Health Connect.',
        );
      case final CyclingPowerRecord _:
        throw UnsupportedError(
          '$CyclingPowerRecord is iOS-only and not supported on '
          'Android Health Connect. Use $PowerSeriesRecord instead.',
        );
      case final RunningPowerRecord _:
        throw UnsupportedError(
          '$RunningPowerRecord is iOS-only and not supported on '
          'Android Health Connect. Use $PowerSeriesRecord instead.',
        );
      case final CyclingPedalingCadenceRecord _:
        throw UnsupportedError(
          '$CyclingPedalingCadenceRecord is not supported on '
          'Android Health Connect. '
          'Use $CyclingPedalingCadenceSeriesRecord instead.',
        );
      case final PowerSeriesRecord record:
        return PowerSeriesRecordToDto(record).toDto();
      case final SpeedSeriesRecord record:
        return SpeedSeriesRecordToDto(record).toDto();
      case final SpeedActivityRecord _:
        throw UnsupportedError(
          '$SpeedActivityRecord and its subclasses are iOS-only '
          'and not supported on Android Health Connect.',
        );
      case final BodyMassIndexRecord _:
        throw UnsupportedError(
          '$BodyMassIndexRecord is not supported on Android Health Connect.',
        );
      case final WaistCircumferenceRecord _:
        throw UnsupportedError(
          '$WaistCircumferenceRecord is not supported on Android '
          'Health Connect.',
        );
      case final HeartRateVariabilitySDNNRecord _:
        throw UnsupportedError(
          '$HeartRateVariabilitySDNNRecord is not supported on Android '
          'Health Connect.',
        );
      case final MenstrualFlowRecord _:
        throw UnsupportedError(
          '$MenstrualFlowRecord is not supported on Android Health Connect. '
          'Use $MenstrualFlowInstantRecord instead.',
        );
      case final SwimmingStrokesRecord _:
        throw UnsupportedError(
          '$SwimmingStrokesRecord is not supported on Android Health Connect.',
        );
      case BloodAlcoholContentRecord():
        throw UnsupportedError(
          '$BloodAlcoholContentRecord is not supported on Android Health '
          'Connect.',
        );
      case ForcedVitalCapacityRecord():
        throw UnsupportedError(
          '$ForcedVitalCapacityRecord is not supported on Android Health '
          'Connect. This data type is iOS-only.',
        );
      case WalkingDoubleSupportPercentageRecord():
        throw UnsupportedError(
          '$WalkingDoubleSupportPercentageRecord is not supported on Android '
          'Health Connect. These data types are iOS-only.',
        );
      case WalkingStepLengthRecord():
        throw UnsupportedError(
          '$WalkingStepLengthRecord is not supported on Android '
          'Health Connect. These data types are iOS-only.',
        );
      case WalkingAsymmetryPercentageRecord():
        throw UnsupportedError(
          '$WalkingAsymmetryPercentageRecord is not supported on Android '
          'Health Connect. This data type is iOS-only.',
        );
      case final LowHeartRateEventRecord _:
        throw UnsupportedError(
          '$LowHeartRateEventRecord is not supported on Android '
          'Health Connect. This data type is iOS-only.',
        );
      case IrregularHeartRhythmEventRecord():
        throw UnsupportedError(
          '$IrregularHeartRhythmEventRecord is not supported on Android '
          'Health Connect. This data type is iOS-only.',
        );
      case InfrequentMenstrualCycleEventRecord():
        throw UnsupportedError(
          '$InfrequentMenstrualCycleEventRecord is not supported on Android '
          'Health Connect. This data type is iOS-only.',
        );
      case IrregularMenstrualCycleEventRecord():
        throw UnsupportedError(
          '$IrregularMenstrualCycleEventRecord is not supported on Android '
          'Health Connect. This data type is iOS-only.',
        );
      case HighHeartRateEventRecord():
        throw UnsupportedError(
          '$HighHeartRateEventRecord is not supported on Android '
          'Health Connect. This data type is iOS-only.',
        );
      case WalkingSteadinessEventRecord():
        throw UnsupportedError(
          '$WalkingSteadinessEventRecord is not supported on Android '
          'Health Connect. This data type is iOS-only.',
        );
      case PersistentIntermenstrualBleedingEventRecord():
        throw UnsupportedError(
          '$PersistentIntermenstrualBleedingEventRecord is not supported on '
          'Android Health Connect. This data type is iOS-only.',
        );
      case ProlongedMenstrualPeriodEventRecord():
        throw UnsupportedError(
          '$ProlongedMenstrualPeriodEventRecord is not supported on '
          'Android Health Connect. This data type is iOS-only.',
        );
      case AtrialFibrillationBurdenRecord():
        throw UnsupportedError(
          '$AtrialFibrillationBurdenRecord is not supported on '
          'Android Health Connect. This data type is iOS-only.',
        );
      case WalkingHeartRateAverageRecord():
        throw UnsupportedError(
          '$WalkingHeartRateAverageRecord is not supported on '
          'Android Health Connect. This data type is iOS-only.',
        );
    }
  }
}

/// Converts [HealthRecordDto] to [HealthRecord].
@sinceV1_0_0
@internal
extension HealthRecordDtoToDomain on HealthRecordDto {
  HealthRecord toDomain() {
    switch (this) {
      case final ActiveEnergyBurnedRecordDto dto:
        return ActiveEnergyBurnedRecordDtoToDomain(dto).toDomain();
      case final ActivityIntensityRecordDto dto:
        return ActivityIntensityRecordDtoToDomain(dto).toDomain();
      case final DistanceRecordDto dto:
        return DistanceRecordDtoToDomain(dto).toDomain();
      case final ElevationGainedRecordDto dto:
        return ElevationGainedRecordDtoToDomain(dto).toDomain();
      case final FloorsClimbedRecordDto dto:
        return FloorsClimbedRecordDtoToDomain(dto).toDomain();
      case final HeightRecordDto dto:
        return HeightRecordDtoToDomain(dto).toDomain();
      case final HydrationRecordDto dto:
        return HydrationRecordDtoToDomain(dto).toDomain();
      case final LeanBodyMassRecordDto dto:
        return LeanBodyMassRecordDtoToDomain(dto).toDomain();
      case final BodyFatPercentageRecordDto dto:
        return BodyFatPercentageRecordDtoToDomain(dto).toDomain();
      case final BodyTemperatureRecordDto dto:
        return BodyTemperatureRecordDtoToDomain(dto).toDomain();
      case final BasalBodyTemperatureRecordDto dto:
        return BasalBodyTemperatureRecordDtoToDomain(dto).toDomain();
      case final CervicalMucusRecordDto dto:
        return CervicalMucusRecordDtoToDomain(dto).toDomain();
      case final StepsRecordDto dto:
        return StepsRecordDtoToDomain(dto).toDomain();
      case final StepsCadenceSeriesRecordDto dto:
        return StepsCadenceSeriesRecordDtoToDomain(dto).toDomain();
      case final WeightRecordDto dto:
        return WeightRecordDtoToDomain(dto).toDomain();
      case final WheelchairPushesRecordDto dto:
        return WheelchairPushesRecordDtoToDomain(dto).toDomain();
      case final HeartRateSeriesRecordDto dto:
        return HeartRateSeriesRecordDtoToDomain(dto).toDomain();
      case final CyclingPedalingCadenceSeriesRecordDto dto:
        return CyclingPedalingCadenceSeriesRecordDtoToDomain(dto).toDomain();
      case final SexualActivityRecordDto dto:
        return SexualActivityRecordDtoToDomain(dto).toDomain();
      case final SleepSessionRecordDto dto:
        return SleepSessionRecordDtoToDomain(dto).toDomain();
      case final ExerciseSessionRecordDto dto:
        return ExerciseSessionRecordFromDto(dto).fromDto();
      case final MindfulnessSessionRecordDto dto:
        return MindfulnessSessionRecordDtoToDomainExtension(dto).toDomain();
      case final NutritionRecordDto dto:
        return NutritionRecordDtoToDomain(dto).toDomain();
      case final RestingHeartRateRecordDto dto:
        return RestingHeartRateRecordDtoToDomain(dto).toDomain();
      case final OvulationTestRecordDto dto:
        return OvulationTestRecordDtoToDomain(dto).toDomain();
      case final IntermenstrualBleedingRecordDto dto:
        return IntermenstrualBleedingRecordDtoToDomain(dto).toDomain();
      case final MenstrualFlowInstantRecordDto dto:
        return MenstrualFlowInstantRecordDtoToDomain(dto).toDomain();
      case final OxygenSaturationRecordDto dto:
        return OxygenSaturationRecordDtoToDomain(dto).toDomain();
      case final BloodPressureRecordDto dto:
        return BloodPressureRecordDtoToDomain(dto).toDomain();
      case final RespiratoryRateRecordDto dto:
        return RespiratoryRateRecordDtoToDomain(dto).toDomain();
      case final Vo2MaxRecordDto dto:
        return Vo2MaxRecordDtoToDomain(dto).toDomain();
      case final BloodGlucoseRecordDto dto:
        return BloodGlucoseRecordDtoToDomain(dto).toDomain();
      case final PowerSeriesRecordDto dto:
        return PowerSeriesRecordDtoToDomain(dto).toDomain();
      case final SpeedSeriesRecordDto dto:
        return SpeedSeriesRecordDtoToDomain(dto).toDomain();
      case final TotalEnergyBurnedRecordDto dto:
        return TotalEnergyBurnedRecordDtoToDomain(dto).toDomain();
      case final BoneMassRecordDto dto:
        return BoneMassRecordDtoToDomain(dto).toDomain();
      case final BodyWaterMassRecordDto dto:
        return BodyWaterMassRecordDtoToDomain(dto).toDomain();
      case final HeartRateVariabilityRMSSDRecordDto dto:
        return HeartRateVariabilityRMSSDRecordDtoToDomain(dto).toDomain();
    }
  }
}
