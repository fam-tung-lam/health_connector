import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/alcoholic_beverages_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/blood_glucose/blood_glucose_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/blood_pressure/blood_pressure_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/blood_pressure/diastolic_blood_pressure_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/blood_pressure/systolic_blood_pressure_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/body_fat_percentage_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/body_mass_index_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/cycling_pedaling_cadence_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/distance/distance_activity_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/energy_burned/active_energy_burned_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/energy_burned/basal_energy_burned_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/exercise/exercise_session_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/floors_climbed_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/heart_rate/heart_rate_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/heart_rate/heart_rate_variability_sdnn_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/heart_rate/resting_heart_rate_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/height_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/hydration_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/lean_body_mass_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/menstruation/cervical_mucus/cervical_mucus_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/menstruation/intermenstrual_bleeding_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/menstruation/menstrual_flow/menstrual_flow_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/menstruation/ovulation_test_result/ovulation_test_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/menstruation/pregnancy_test_result/pregnancy_test_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/menstruation/progesterone_test_result/progesterone_test_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/mindfulness/mindfulness_session_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/nutrition/dietary_biotin_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/nutrition/dietary_caffeine_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/nutrition/dietary_calcium_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/nutrition/dietary_cholesterol_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/nutrition/dietary_energy_consumed_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/nutrition/dietary_fiber_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/nutrition/dietary_folate_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/nutrition/dietary_iron_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/nutrition/dietary_magnesium_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/nutrition/dietary_manganese_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/nutrition/dietary_monounsaturated_fat_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/nutrition/dietary_niacin_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/nutrition/dietary_pantothenic_acid_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/nutrition/dietary_phosphorus_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/nutrition/dietary_polyunsaturated_fat_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/nutrition/dietary_potassium_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/nutrition/dietary_protein_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/nutrition/dietary_riboflavin_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/nutrition/dietary_saturated_fat_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/nutrition/dietary_selenium_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/nutrition/dietary_sodium_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/nutrition/dietary_sugar_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/nutrition/dietary_thiamin_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/nutrition/dietary_total_carbohydrate_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/nutrition/dietary_total_fat_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/nutrition/dietary_vitamin_a_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/nutrition/dietary_vitamin_b12_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/nutrition/dietary_vitamin_b6_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/nutrition/dietary_vitamin_c_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/nutrition/dietary_vitamin_d_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/nutrition/dietary_vitamin_e_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/nutrition/dietary_vitamin_k_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/nutrition/dietary_zinc_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/nutrition/nutrition_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/oxygen_saturation_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/power/cycling_power_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/power/running_power_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/reproductive_health/contraceptive_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/reproductive_health/lactation_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/reproductive_health/pregnancy_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/respiratory_rate_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/sexual_activity/sexual_activity_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/sleep/sleep_stage_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/speed/speed_activity_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/steps_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/swimming_strokes_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/temperature/basal_body_temperature_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/temperature/body_temperature_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/vo2_max_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/waist_circumference_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/weight_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/wheelchair_pushes_record_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
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
      case final AlcoholicBeveragesRecord record:
        return AlcoholicBeveragesRecordToDto(record).toDto();
      case final BasalEnergyBurnedRecord record:
        return BasalEnergyBurnedRecordToDto(record).toDto();
      case final FloorsClimbedRecord record:
        return FloorsClimbedRecordToDto(record).toDto();
      case final StepsRecord record:
        return StepsRecordToDto(record).toDto();
      case final WeightRecord record:
        return WeightRecordToDto(record).toDto();
      case final LeanBodyMassRecord record:
        return LeanBodyMassRecordToDto(record).toDto();
      case final HeightRecord record:
        return HeightRecordToDto(record).toDto();
      case final BodyFatPercentageRecord record:
        return BodyFatPercentageRecordToDto(record).toDto();
      case final BodyTemperatureRecord record:
        return BodyTemperatureRecordToDto(record).toDto();
      case final BasalBodyTemperatureRecord record:
        return BasalBodyTemperatureRecordToDto(record).toDto();
      case final CervicalMucusRecord record:
        return CervicalMucusRecordToDto(record).toDto();
      case final HydrationRecord record:
        return HydrationRecordToDto(record).toDto();
      case final WheelchairPushesRecord record:
        return WheelchairPushesRecordToDto(record).toDto();
      case final HeartRateRecord record:
        return HeartRateRecordToDto(record).toDto();
      case final CyclingPedalingCadenceRecord record:
        return CyclingPedalingCadenceRecordToDto(record).toDto();
      case final SexualActivityRecord record:
        return SexualActivityRecordToDto(record).toDto();
      case final SleepStageRecord record:
        return SleepStageRecordToDto(record).toDto();
      case final NutritionRecord record:
        return NutritionRecordToDto(record).toDto();
      case final DietaryEnergyConsumedRecord record:
        return DietaryEnergyConsumedRecordToDto(record).toDto();
      case final DietaryCaffeineRecord record:
        return DietaryCaffeineRecordToDto(record).toDto();
      case final DietaryProteinRecord record:
        return DietaryProteinRecordToDto(record).toDto();
      case final DietaryTotalCarbohydrateRecord record:
        return DietaryTotalCarbohydrateRecordToDto(record).toDto();
      case final DietaryTotalFatRecord record:
        return DietaryTotalFatRecordToDto(record).toDto();
      case final DietarySaturatedFatRecord record:
        return DietarySaturatedFatRecordToDto(record).toDto();
      case final DietaryMonounsaturatedFatRecord record:
        return DietaryMonounsaturatedFatRecordToDto(record).toDto();
      case final DietaryPolyunsaturatedFatRecord record:
        return DietaryPolyunsaturatedFatRecordToDto(record).toDto();
      case final DietaryCholesterolRecord record:
        return DietaryCholesterolRecordToDto(record).toDto();
      case final DietaryFiberRecord record:
        return DietaryFiberRecordToDto(record).toDto();
      case final DietarySugarRecord record:
        return DietarySugarRecordToDto(record).toDto();
      case final DietaryVitaminARecord record:
        return DietaryVitaminARecordToDto(record).toDto();
      case final DietaryVitaminB6Record record:
        return DietaryVitaminB6RecordToDto(record).toDto();
      case final DietaryVitaminB12Record record:
        return DietaryVitaminB12RecordToDto(record).toDto();
      case final DietaryVitaminCRecord record:
        return DietaryVitaminCRecordToDto(record).toDto();
      case final DietaryVitaminDRecord record:
        return DietaryVitaminDRecordToDto(record).toDto();
      case final DietaryVitaminERecord record:
        return DietaryVitaminERecordToDto(record).toDto();
      case final DietaryVitaminKRecord record:
        return DietaryVitaminKRecordToDto(record).toDto();
      case final DietaryThiaminRecord record:
        return DietaryThiaminRecordToDto(record).toDto();
      case final DietaryRiboflavinRecord record:
        return DietaryRiboflavinRecordToDto(record).toDto();
      case final DietaryNiacinRecord record:
        return DietaryNiacinRecordToDto(record).toDto();
      case final DietaryFolateRecord record:
        return DietaryFolateRecordToDto(record).toDto();
      case final DietaryBiotinRecord record:
        return DietaryBiotinRecordToDto(record).toDto();
      case final DietaryPantothenicAcidRecord record:
        return DietaryPantothenicAcidRecordToDto(record).toDto();
      case final DietaryCalciumRecord record:
        return DietaryCalciumRecordToDto(record).toDto();
      case final DietaryIronRecord record:
        return DietaryIronRecordToDto(record).toDto();
      case final DietaryMagnesiumRecord record:
        return DietaryMagnesiumRecordToDto(record).toDto();
      case final DietaryManganeseRecord record:
        return DietaryManganeseRecordToDto(record).toDto();
      case final DietaryPhosphorusRecord record:
        return DietaryPhosphorusRecordToDto(record).toDto();
      case final DietaryPotassiumRecord record:
        return DietaryPotassiumRecordToDto(record).toDto();
      case final DietarySeleniumRecord record:
        return DietarySeleniumRecordToDto(record).toDto();
      case final DietarySodiumRecord record:
        return DietarySodiumRecordToDto(record).toDto();
      case final DietaryZincRecord record:
        return DietaryZincRecordToDto(record).toDto();
      case final OvulationTestRecord record:
        return OvulationTestRecordToDto(record).toDto();
      case final PregnancyTestRecord record:
        return PregnancyTestRecordToDto(record).toDto();
      case final ProgesteroneTestRecord record:
        return ProgesteroneTestRecordToDto(record).toDto();
      case final IntermenstrualBleedingRecord record:
        return IntermenstrualBleedingRecordToDto(record).toDto();
      case final OxygenSaturationRecord record:
        return OxygenSaturationRecordToDto(record).toDto();
      case final RespiratoryRateRecord record:
        return RespiratoryRateRecordToDto(record).toDto();
      case final BloodPressureRecord record:
        return BloodPressureRecordToDto(record).toDto();
      case final SystolicBloodPressureRecord record:
        return SystolicBloodPressureRecordToDto(record).toDto();
      case final DiastolicBloodPressureRecord record:
        return DiastolicBloodPressureRecordToDto(record).toDto();
      case final RestingHeartRateRecord record:
        return RestingHeartRateRecordToDto(record).toDto();
      case final Vo2MaxRecord record:
        return Vo2MaxRecordToDto(record).toDto();
      case final BloodGlucoseRecord record:
        return BloodGlucoseRecordToDto(record).toDto();
      case final CyclingPowerRecord record:
        return CyclingPowerRecordToDto(record).toDto();
      case final RunningPowerRecord record:
        return RunningPowerRecordToDto(record).toDto();
      case final DistanceActivityRecord record:
        return DistanceActivityRecordToDto(record).toDto();
      case final MindfulnessSessionRecord record:
        return MindfulnessSessionRecordToDtoExtension(record).toDto();
      case final BodyMassIndexRecord record:
        return BodyMassIndexRecordToDto(record).toDto();
      case final WaistCircumferenceRecord record:
        return WaistCircumferenceRecordToDto(record).toDto();
      case final MenstrualFlowRecord record:
        return MenstrualFlowRecordToDto(record).toDto();
      case final HeartRateVariabilitySDNNRecord record:
        return HeartRateVariabilitySDNNRecordToDto(record).toDto();
      case ExerciseSessionRecord():
        return ExerciseSessionRecordToDto(
          this as ExerciseSessionRecord,
        ).toDto();
      case final HeartRateSeriesRecord _:
        throw UnsupportedError(
          '$HeartRateSeriesRecord is not supported on iOS HealthKit. '
          'Use $HeartRateRecord instead.',
        );
      case final CyclingPedalingCadenceSeriesRecord _:
        throw UnsupportedError(
          '$CyclingPedalingCadenceSeriesRecord is not supported on iOS '
          'HealthKit. Use $CyclingPedalingCadenceRecord instead.',
        );
      case final StepsCadenceSeriesRecord _:
        throw UnsupportedError(
          '$StepsCadenceSeriesRecord is not supported on iOS HealthKit.',
        );
      case final SleepSessionRecord _:
        throw UnsupportedError(
          '$SleepSessionRecord is not supported on iOS HealthKit. '
          'Use $SleepStageRecord instead.',
        );
      case DistanceRecord():
        throw UnsupportedError(
          '$DistanceRecord is not supported on iOS HealthKit. '
          'Use $DistanceActivityRecord instead.',
        );
      case final ElevationGainedRecord _:
        throw UnsupportedError(
          '$ElevationGainedRecord is not supported on iOS HealthKit.',
        );
      case final SpeedActivityRecord record:
        return SpeedActivityRecordToDto(record).toDto();
      case SpeedSeriesRecord():
        throw UnsupportedError(
          '$SpeedSeriesRecord is not supported on iOS HealthKit. '
          'Use $SpeedActivityRecord instead.',
        );
      case PowerSeriesRecord():
        throw UnsupportedError(
          '$PowerSeriesRecord is not supported on iOS HealthKit. '
          'Use $CyclingPowerRecord instead.',
        );
      case final TotalEnergyBurnedRecord _:
        throw UnsupportedError(
          '$TotalEnergyBurnedRecord is not supported on iOS HealthKit. '
          'Use $ActiveEnergyBurnedRecord + $BasalEnergyBurnedRecord.',
        );
      case final BoneMassRecord _:
        throw UnsupportedError(
          '$BoneMassRecord is not supported on iOS HealthKit.',
        );
      case final BodyWaterMassRecord _:
        throw UnsupportedError(
          '$BodyWaterMassRecord is not supported on iOS HealthKit.',
        );
      case final HeartRateVariabilityRMSSDRecord _:
        throw UnsupportedError(
          '$HeartRateVariabilityRMSSDRecord is not supported on iOS HealthKit.',
        );
      case final MenstrualFlowInstantRecord _:
        throw UnsupportedError(
          '$MenstrualFlowInstantRecord is not supported on iOS HealthKit. '
          'Use $MenstrualFlowRecord instead.',
        );
      case final LactationRecord record:
        return LactationRecordToDto(record).toDto();
      case final PregnancyRecord record:
        return PregnancyRecordToDto(record).toDto();
      case final ContraceptiveRecord record:
        return ContraceptiveRecordToDto(record).toDto();
      case final SwimmingStrokesRecord record:
        return SwimmingStrokesRecordToDto(record).toDto();
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
      case final AlcoholicBeveragesRecordDto dto:
        return AlcoholicBeveragesRecordDtoToDomain(dto).toDomain();
      case final BasalEnergyBurnedRecordDto dto:
        return BasalEnergyBurnedRecordDtoToDomain(dto).toDomain();
      case final FloorsClimbedRecordDto dto:
        return FloorsClimbedRecordDtoToDomain(dto).toDomain();
      case final StepsRecordDto dto:
        return StepsRecordDtoToDomain(dto).toDomain();
      case final WeightRecordDto dto:
        return WeightRecordDtoToDomain(dto).toDomain();
      case final LeanBodyMassRecordDto dto:
        return LeanBodyMassRecordDtoToDomain(dto).toDomain();
      case final HeightRecordDto dto:
        return HeightRecordDtoToDomain(dto).toDomain();
      case final BodyFatPercentageRecordDto dto:
        return BodyFatPercentageRecordDtoToDomain(dto).toDomain();
      case final BodyTemperatureRecordDto dto:
        return BodyTemperatureRecordDtoToDomain(dto).toDomain();
      case final BasalBodyTemperatureRecordDto dto:
        return BasalBodyTemperatureRecordDtoToDomain(dto).toDomain();
      case final CervicalMucusRecordDto dto:
        return CervicalMucusRecordDtoToDomain(dto).toDomain();
      case final HydrationRecordDto dto:
        return HydrationRecordDtoToDomain(dto).toDomain();
      case final WheelchairPushesRecordDto dto:
        return WheelchairPushesRecordDtoToDomain(dto).toDomain();
      case final HeartRateRecordDto dto:
        return HeartRateRecordDtoToDomain(dto).toDomain();
      case final CyclingPedalingCadenceRecordDto dto:
        return CyclingPedalingCadenceRecordDtoToDomain(
          dto,
        ).toDomain();
      case final SexualActivityRecordDto dto:
        return SexualActivityRecordDtoToDomain(dto).toDomain();
      case final SleepStageRecordDto dto:
        return SleepStageRecordDtoToDomain(dto).toDomain();
      case final OxygenSaturationRecordDto dto:
        return OxygenSaturationRecordDtoToDomain(dto).toDomain();
      case final RespiratoryRateRecordDto dto:
        return RespiratoryRateRecordDtoToDomain(dto).toDomain();
      case final BloodPressureRecordDto dto:
        return BloodPressureRecordDtoToDomain(dto).toDomain();
      case final SystolicBloodPressureRecordDto dto:
        return SystolicBloodPressureRecordDtoToDomain(dto).toDomain();
      case final DiastolicBloodPressureRecordDto dto:
        return DiastolicBloodPressureRecordDtoToDomain(dto).toDomain();
      case final RestingHeartRateRecordDto dto:
        return RestingHeartRateRecordDtoToDomain(dto).toDomain();
      case final DietaryEnergyConsumedRecordDto dto:
        return DietaryEnergyConsumedRecordDtoToDomain(dto).toDomain();
      case final DietaryCaffeineRecordDto dto:
        return DietaryCaffeineRecordDtoToDomain(dto).toDomain();
      case final DietaryProteinRecordDto dto:
        return DietaryProteinRecordDtoToDomain(dto).toDomain();
      case final DietaryTotalCarbohydrateRecordDto dto:
        return DietaryTotalCarbohydrateRecordDtoToDomain(dto).toDomain();
      case final DietaryTotalFatRecordDto dto:
        return DietaryTotalFatRecordDtoToDomain(dto).toDomain();
      case final DietarySaturatedFatRecordDto dto:
        return DietarySaturatedFatRecordDtoToDomain(dto).toDomain();
      case final DietaryMonounsaturatedFatRecordDto dto:
        return DietaryMonounsaturatedFatRecordDtoToDomain(dto).toDomain();
      case final DietaryPolyunsaturatedFatRecordDto dto:
        return DietaryPolyunsaturatedFatRecordDtoToDomain(dto).toDomain();
      case final DietaryCholesterolRecordDto dto:
        return DietaryCholesterolRecordDtoToDomain(dto).toDomain();
      case final DietaryFiberRecordDto dto:
        return DietaryFiberRecordDtoToDomain(dto).toDomain();
      case final DietarySugarRecordDto dto:
        return DietarySugarRecordDtoToDomain(dto).toDomain();
      case final DietaryVitaminARecordDto dto:
        return DietaryVitaminARecordDtoToDomain(dto).toDomain();
      case final DietaryVitaminB6RecordDto dto:
        return DietaryVitaminB6RecordDtoToDomain(dto).toDomain();
      case final DietaryVitaminB12RecordDto dto:
        return DietaryVitaminB12RecordDtoToDomain(dto).toDomain();
      case final DietaryVitaminCRecordDto dto:
        return DietaryVitaminCRecordDtoToDomain(dto).toDomain();
      case final DietaryVitaminDRecordDto dto:
        return DietaryVitaminDRecordDtoToDomain(dto).toDomain();
      case final DietaryVitaminERecordDto dto:
        return DietaryVitaminERecordDtoToDomain(dto).toDomain();
      case final DietaryVitaminKRecordDto dto:
        return DietaryVitaminKRecordDtoToDomain(dto).toDomain();
      case final DietaryThiaminRecordDto dto:
        return DietaryThiaminRecordDtoToDomain(dto).toDomain();
      case final DietaryRiboflavinRecordDto dto:
        return DietaryRiboflavinRecordDtoToDomain(dto).toDomain();
      case final DietaryNiacinRecordDto dto:
        return DietaryNiacinRecordDtoToDomain(dto).toDomain();
      case final DietaryFolateRecordDto dto:
        return DietaryFolateRecordDtoToDomain(dto).toDomain();
      case final DietaryBiotinRecordDto dto:
        return DietaryBiotinRecordDtoToDomain(dto).toDomain();
      case final DietaryPantothenicAcidRecordDto dto:
        return DietaryPantothenicAcidRecordDtoToDomain(dto).toDomain();
      case final DietaryCalciumRecordDto dto:
        return DietaryCalciumRecordDtoToDomain(dto).toDomain();
      case final DietaryIronRecordDto dto:
        return DietaryIronRecordDtoToDomain(dto).toDomain();
      case final DietaryMagnesiumRecordDto dto:
        return DietaryMagnesiumRecordDtoToDomain(dto).toDomain();
      case final DietaryManganeseRecordDto dto:
        return DietaryManganeseRecordDtoToDomain(dto).toDomain();
      case final DietaryPhosphorusRecordDto dto:
        return DietaryPhosphorusRecordDtoToDomain(dto).toDomain();
      case final DietaryPotassiumRecordDto dto:
        return DietaryPotassiumRecordDtoToDomain(dto).toDomain();
      case final DietarySeleniumRecordDto dto:
        return DietarySeleniumRecordDtoToDomain(dto).toDomain();
      case final DietarySodiumRecordDto dto:
        return DietarySodiumRecordDtoToDomain(dto).toDomain();
      case final DietaryZincRecordDto dto:
        return DietaryZincRecordDtoToDomain(dto).toDomain();
      case final OvulationTestRecordDto dto:
        return OvulationTestRecordDtoToDomain(dto).toDomain();
      case final PregnancyTestRecordDto dto:
        return PregnancyTestRecordDtoToDomain(dto).toDomain();
      case final ProgesteroneTestRecordDto dto:
        return ProgesteroneTestRecordDtoToDomain(dto).toDomain();
      case final IntermenstrualBleedingRecordDto dto:
        return IntermenstrualBleedingRecordDtoToDomain(dto).toDomain();
      case final NutritionRecordDto dto:
        return NutritionRecordDtoToDomain(dto).toDomain();
      case final Vo2MaxRecordDto dto:
        return Vo2MaxRecordDtoToDomain(dto).toDomain();
      case final BloodGlucoseRecordDto dto:
        return BloodGlucoseRecordDtoToDomain(dto).toDomain();
      case final CyclingPowerRecordDto dto:
        return CyclingPowerRecordDtoToDomain(dto).toDomain();
      case final RunningPowerRecordDto dto:
        return RunningPowerRecordDtoToDomain(dto).toDomain();
      case final DistanceActivityRecordDto dto:
        return DistanceActivityRecordDtoToDomain(dto).toDomain();
      case final SpeedActivityRecordDto dto:
        return SpeedActivityRecordDtoToDomain(dto).toDomain();
      case final ExerciseSessionRecordDto dto:
        return ExerciseSessionRecordDtoToDomain(dto).toDomain();
      case final MindfulnessSessionRecordDto dto:
        return MindfulnessSessionRecordDtoToDomainExtension(dto).toDomain();
      case final BodyMassIndexRecordDto dto:
        return BodyMassIndexRecordDtoToDomain(dto).toDomain();
      case final WaistCircumferenceRecordDto dto:
        return WaistCircumferenceRecordDtoToDomain(dto).toDomain();
      case final MenstrualFlowRecordDto dto:
        return MenstrualFlowRecordDtoToDomain(dto).toDomain();
      case final HeartRateVariabilitySDNNRecordDto dto:
        return HeartRateVariabilitySDNNRecordDtoToDomain(dto).toDomain();
      case final LactationRecordDto dto:
        return LactationRecordDtoToDomain(dto).toDomain();
      case final PregnancyRecordDto dto:
        return PregnancyRecordDtoToDomain(dto).toDomain();
      case final ContraceptiveRecordDto dto:
        return ContraceptiveRecordDtoToDomain(dto).toDomain();
      case final SwimmingStrokesRecordDto dto:
        return SwimmingStrokesRecordDtoToDomain(dto).toDomain();
    }
  }
}
