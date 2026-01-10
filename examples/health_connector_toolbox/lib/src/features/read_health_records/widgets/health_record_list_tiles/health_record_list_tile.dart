import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/instant_health_record_list_tiles/basal_body_temperature_list_tile.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/instant_health_record_list_tiles/blood_glucose_list_tile.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/instant_health_record_list_tiles/blood_pressure_list_tile.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/instant_health_record_list_tiles/body_water_mass_list_tile.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/instant_health_record_list_tiles/bone_mass_list_tile.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/instant_health_record_list_tiles/cervical_mucus_list_tile.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/instant_health_record_list_tiles/cycling_pedaling_cadence_measurement_list_tile.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/instant_health_record_list_tiles/diastolic_blood_pressure_list_tile.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/instant_health_record_list_tiles/energy_nutrient_list_tile.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/instant_health_record_list_tiles/heart_rate_measurement_list_tile.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/instant_health_record_list_tiles/heart_rate_variability_rmssd_list_tile.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/instant_health_record_list_tiles/intermenstrual_bleeding_list_tile.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/instant_health_record_list_tiles/mass_nutrient_list_tile.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/instant_health_record_list_tiles/menstrual_flow_instant_record_list_tile.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/instant_health_record_list_tiles/nutrition_list_tile.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/instant_health_record_list_tiles/ovulation_test_list_tile.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/instant_health_record_list_tiles/respiratory_rate_list_tile.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/instant_health_record_list_tiles/sexual_activity_list_tile.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/instant_health_record_list_tiles/simple_instant_measurement_list_tile.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/instant_health_record_list_tiles/systolic_blood_pressure_list_tile.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/interval_health_record_list_tiles/distance_activity_list_tile.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/interval_health_record_list_tiles/exercise_session_list_tile.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/interval_health_record_list_tiles/menstrual_flow_record_list_tile.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/interval_health_record_list_tiles/mindfulness_session_list_tile.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/interval_health_record_list_tiles/simple_interval_measurement_list_tile.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/interval_health_record_list_tiles/sleep_session_list_tile.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/interval_health_record_list_tiles/sleep_stage_list_tile.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/series_health_record_list_tiles/cycling_pedaling_cadence_series_list_tile.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/series_health_record_list_tiles/heart_rate_series_list_tile.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/series_health_record_list_tiles/power_series_list_tile.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/series_health_record_list_tiles/speed_activity_list_tile.dart';
import 'package:health_connector_toolbox/src/features/read_health_records/widgets/health_record_list_tiles/series_health_record_list_tiles/speed_series_list_tile.dart';

/// A widget that displays a health record in a list tile format.
///
/// Automatically selects the appropriate tile widget based on the
/// record type using a switch-case pattern.
@immutable
final class HealthRecordListTile extends StatelessWidget {
  const HealthRecordListTile({
    required this.record,
    required this.onDelete,
    super.key,
  });

  final HealthRecord record;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final tile = switch (record) {
      // Blood-related records
      final BloodGlucoseRecord r => BloodGlucoseTile(
        record: r,
        onDelete: onDelete,
      ),
      final BloodPressureRecord r => BloodPressureTile(
        record: r,
        onDelete: onDelete,
      ),
      final SystolicBloodPressureRecord r => SystolicBloodPressureTile(
        record: r,
        onDelete: onDelete,
      ),
      final DiastolicBloodPressureRecord r => DiastolicBloodPressureTile(
        record: r,
        onDelete: onDelete,
      ),

      // Heart rate records
      final HeartRateSeriesRecord r => HeartRateSeriesTile(
        record: r,
        onDelete: onDelete,
      ),
      final HeartRateMeasurementRecord r => HeartRateMeasurementTile(
        record: r,
        onDelete: onDelete,
      ),
      final RestingHeartRateRecord r =>
        SimpleInstantMeasurementListTile<RestingHeartRateRecord>(
          record: r,
          icon: AppIcons.favorite,
          titleBuilder: (r) =>
              '${r.rate.inPerMinute.toStringAsFixed(0)} '
              '${AppTexts.bpm}',
          valueExtractor: (r) => r.rate,
          onDelete: onDelete,
        ),
      final HeartRateVariabilityRMSSDRecord r => HeartRateVariabilityRMSSDTile(
        record: r,
        onDelete: onDelete,
      ),
      final CyclingPedalingCadenceMeasurementRecord r =>
        CyclingPedalingCadenceMeasurementTile(
          record: r,
          onDelete: onDelete,
        ),
      final CyclingPedalingCadenceSeriesRecord r =>
        CyclingPedalingCadenceSeriesTile(
          record: r,
          onDelete: onDelete,
        ),
      final HeartRateVariabilitySDNNRecord r =>
        SimpleInstantMeasurementListTile<HeartRateVariabilitySDNNRecord>(
          record: r,
          icon: AppIcons.favorite,
          titleBuilder: (r) => '${r.sdnn.inMilliseconds.toStringAsFixed(1)} ms',
          valueExtractor: (r) => r.sdnn,
          onDelete: onDelete,
        ),

      // Respiratory records
      final RespiratoryRateRecord r => RespiratoryRateTile(
        record: r,
        onDelete: onDelete,
      ),

      // Sleep records
      final SleepSessionRecord r => SleepSessionTile(
        record: r,
        onDelete: onDelete,
      ),
      final SleepStageRecord r => SleepStageTile(record: r, onDelete: onDelete),

      // Exercise records
      final ExerciseSessionRecord r => ExerciseSessionTile(
        record: r,
        onDelete: onDelete,
      ),
      final MindfulnessSessionRecord r => MindfulnessSessionListTile(
        record: r,
        onDelete: onDelete,
      ),

      // Speed records
      final SpeedSeriesRecord r => SpeedSeriesTile(
        record: r,
        onDelete: onDelete,
      ),

      // Power records
      final PowerSeriesRecord r => PowerSeriesTile(
        record: r,
        onDelete: onDelete,
      ),
      final CyclingPowerRecord r => SimpleInstantMeasurementListTile(
        record: r,
        icon: AppIcons.power,
        titleBuilder: (r) => '${r.power.inWatts.toStringAsFixed(1)} W',
        valueExtractor: (r) => r.power,
        onDelete: onDelete,
      ),

      final WalkingSpeedRecord r => SpeedActivityTile(
        record: r,
        onDelete: onDelete,
      ),
      final RunningSpeedRecord r => SpeedActivityTile(
        record: r,
        onDelete: onDelete,
      ),
      final StairAscentSpeedRecord r => SpeedActivityTile(
        record: r,
        onDelete: onDelete,
      ),
      final StairDescentSpeedRecord r => SpeedActivityTile(
        record: r,
        onDelete: onDelete,
      ),

      // Body measurement records
      final BodyTemperatureRecord r =>
        SimpleInstantMeasurementListTile<BodyTemperatureRecord>(
          record: r,
          icon: AppIcons.temperature,
          titleBuilder: (r) =>
              '${r.temperature.inCelsius.toStringAsFixed(1)} °C',
          valueExtractor: (r) => r.temperature,
          onDelete: onDelete,
        ),
      final BasalBodyTemperatureRecord r => BasalBodyTemperatureTile(
        record: r,
        onDelete: onDelete,
      ),
      final HeightRecord r => SimpleInstantMeasurementListTile<HeightRecord>(
        record: r,
        icon: AppIcons.height,
        titleBuilder: (r) => '${r.height.inMeters.toStringAsFixed(2)} m',
        valueExtractor: (r) => r.height,
        onDelete: onDelete,
      ),
      final WeightRecord r => SimpleInstantMeasurementListTile<WeightRecord>(
        record: r,
        icon: AppIcons.monitorWeight,
        titleBuilder: (r) => '${r.weight.inKilograms.toStringAsFixed(1)} kg',
        valueExtractor: (r) => r.weight,
        onDelete: onDelete,
      ),
      final BodyFatPercentageRecord r =>
        SimpleInstantMeasurementListTile<BodyFatPercentageRecord>(
          record: r,
          icon: AppIcons.percent,
          titleBuilder: (r) => '${r.percentage.asWhole.toStringAsFixed(1)} %',
          valueExtractor: (r) => r.percentage,
          onDelete: onDelete,
        ),
      final LeanBodyMassRecord r =>
        SimpleInstantMeasurementListTile<LeanBodyMassRecord>(
          record: r,
          icon: AppIcons.fitnessCenter,
          titleBuilder: (r) => '${r.mass.inKilograms.toStringAsFixed(2)} kg',
          valueExtractor: (r) => r.mass,
          onDelete: onDelete,
        ),
      final BoneMassRecord r => BoneMassTile(record: r, onDelete: onDelete),
      final BodyWaterMassRecord r => BodyWaterMassTile(
        record: r,
        onDelete: onDelete,
      ),
      final BodyMassIndexRecord r =>
        SimpleInstantMeasurementListTile<BodyMassIndexRecord>(
          record: r,
          icon: AppIcons.monitorWeight,
          titleBuilder: (r) => '${r.bmi.value.toStringAsFixed(1)} kg/m²',
          valueExtractor: (r) => r.bmi,
          onDelete: onDelete,
        ),
      final WaistCircumferenceRecord r =>
        SimpleInstantMeasurementListTile<WaistCircumferenceRecord>(
          record: r,
          icon: AppIcons.straighten,
          titleBuilder: (r) =>
              '${r.circumference.inCentimeters.toStringAsFixed(1)} cm',
          valueExtractor: (r) => r.circumference,
          onDelete: onDelete,
        ),

      // Vitals
      final OxygenSaturationRecord r =>
        SimpleInstantMeasurementListTile<OxygenSaturationRecord>(
          record: r,
          icon: AppIcons.air,
          titleBuilder: (r) => '${r.saturation.asWhole.toStringAsFixed(1)} %',
          valueExtractor: (r) => r.saturation,
          onDelete: onDelete,
        ),
      final Vo2MaxRecord r => SimpleInstantMeasurementListTile<Vo2MaxRecord>(
        record: r,
        icon: AppIcons.favorite,
        titleBuilder: (r) =>
            '${r.vo2MlPerMinPerKg.value.toStringAsFixed(1)} mL/kg/min',
        valueExtractor: (r) => r.vo2MlPerMinPerKg,
        onDelete: onDelete,
      ),

      // Activity records
      final StepsRecord r => SimpleIntervalMeasurementListTile<StepsRecord>(
        record: r,
        icon: AppIcons.directionsWalk,
        titleBuilder: (r) => '${r.count.value} steps',
        valueExtractor: (r) => r.count,
        onDelete: onDelete,
      ),
      final DistanceRecord r =>
        SimpleIntervalMeasurementListTile<DistanceRecord>(
          record: r,
          icon: AppIcons.straighten,
          titleBuilder: (r) => '${r.distance.inMeters.toStringAsFixed(0)} m',
          valueExtractor: (r) => r.distance,
          onDelete: onDelete,
        ),
      final DistanceActivityRecord r => DistanceActivityTile(
        record: r,
        onDelete: onDelete,
      ),
      final FloorsClimbedRecord r =>
        SimpleIntervalMeasurementListTile<FloorsClimbedRecord>(
          record: r,
          icon: AppIcons.stairs,
          titleBuilder: (r) => '${r.count.value} floors',
          valueExtractor: (r) => r.count,
          onDelete: onDelete,
        ),
      final ActiveEnergyBurnedRecord r =>
        SimpleIntervalMeasurementListTile<ActiveEnergyBurnedRecord>(
          record: r,
          icon: AppIcons.localFireDepartment,
          titleBuilder: (r) =>
              '${r.energy.inKilocalories.toStringAsFixed(0)} kcal (Active)',
          valueExtractor: (r) => r.energy,
          onDelete: onDelete,
        ),
      final WheelchairPushesRecord r =>
        SimpleIntervalMeasurementListTile<WheelchairPushesRecord>(
          record: r,
          icon: AppIcons.accessible,
          titleBuilder: (r) =>
              '${r.count.value} ${AppTexts.wheelchairPushesLabel}',
          valueExtractor: (r) => r.count,
          onDelete: onDelete,
        ),

      // Hydration
      final HydrationRecord r =>
        SimpleIntervalMeasurementListTile<HydrationRecord>(
          record: r,
          icon: AppIcons.volume,
          titleBuilder: (r) => '${r.volume.inLiters.toStringAsFixed(2)} L',
          valueExtractor: (r) => r.volume,
          onDelete: onDelete,
        ),

      // Reproductive health
      final SexualActivityRecord r => SexualActivityListTile(
        record: r,
        onDelete: onDelete,
      ),
      final CervicalMucusRecord r => CervicalMucusListTile(
        record: r,
        onDelete: onDelete,
      ),
      final OvulationTestRecord r => OvulationTestListTile(
        record: r,
        onDelete: onDelete,
      ),
      final MenstrualFlowInstantRecord r => MenstrualFlowInstantRecordListTile(
        record: r,
        onDelete: onDelete,
      ),
      final MenstrualFlowRecord r => MenstrualFlowRecordListTile(
        record: r,
        onDelete: onDelete,
      ),
      final IntermenstrualBleedingRecord r => IntermenstrualBleedingListTile(
        record: r,
        onDelete: onDelete,
      ),

      // Nutrition
      final NutritionRecord r => NutritionTile(record: r, onDelete: onDelete),

      // Energy nutrient record
      final DietaryEnergyConsumedRecord r => EnergyNutrientListTile(
        record: r,
        onDelete: onDelete,
      ),

      // Mass nutrient records
      final CaffeineNutrientRecord r =>
        MassNutrientListTile<CaffeineNutrientRecord>(
          record: r,
          onDelete: onDelete,
        ),
      final ProteinNutrientRecord r =>
        MassNutrientListTile<ProteinNutrientRecord>(
          record: r,
          onDelete: onDelete,
        ),
      final TotalCarbohydrateNutrientRecord r =>
        MassNutrientListTile<TotalCarbohydrateNutrientRecord>(
          record: r,
          onDelete: onDelete,
        ),
      final TotalFatNutrientRecord r =>
        MassNutrientListTile<TotalFatNutrientRecord>(
          record: r,
          onDelete: onDelete,
        ),
      final SaturatedFatNutrientRecord r =>
        MassNutrientListTile<SaturatedFatNutrientRecord>(
          record: r,
          onDelete: onDelete,
        ),
      final MonounsaturatedFatNutrientRecord r =>
        MassNutrientListTile<MonounsaturatedFatNutrientRecord>(
          record: r,
          onDelete: onDelete,
        ),
      final PolyunsaturatedFatNutrientRecord r =>
        MassNutrientListTile<PolyunsaturatedFatNutrientRecord>(
          record: r,
          onDelete: onDelete,
        ),
      final CholesterolNutrientRecord r =>
        MassNutrientListTile<CholesterolNutrientRecord>(
          record: r,
          onDelete: onDelete,
        ),
      final DietaryFiberNutrientRecord r =>
        MassNutrientListTile<DietaryFiberNutrientRecord>(
          record: r,
          onDelete: onDelete,
        ),
      final SugarNutrientRecord r => MassNutrientListTile<SugarNutrientRecord>(
        record: r,
        onDelete: onDelete,
      ),
      final CalciumNutrientRecord r =>
        MassNutrientListTile<CalciumNutrientRecord>(
          record: r,
          onDelete: onDelete,
        ),
      final IronNutrientRecord r => MassNutrientListTile<IronNutrientRecord>(
        record: r,
        onDelete: onDelete,
      ),
      final MagnesiumNutrientRecord r =>
        MassNutrientListTile<MagnesiumNutrientRecord>(
          record: r,
          onDelete: onDelete,
        ),
      final ManganeseNutrientRecord r =>
        MassNutrientListTile<ManganeseNutrientRecord>(
          record: r,
          onDelete: onDelete,
        ),
      final PhosphorusNutrientRecord r =>
        MassNutrientListTile<PhosphorusNutrientRecord>(
          record: r,
          onDelete: onDelete,
        ),
      final PotassiumNutrientRecord r =>
        MassNutrientListTile<PotassiumNutrientRecord>(
          record: r,
          onDelete: onDelete,
        ),
      final SeleniumNutrientRecord r =>
        MassNutrientListTile<SeleniumNutrientRecord>(
          record: r,
          onDelete: onDelete,
        ),
      final SodiumNutrientRecord r =>
        MassNutrientListTile<SodiumNutrientRecord>(
          record: r,
          onDelete: onDelete,
        ),
      final ZincNutrientRecord r => MassNutrientListTile<ZincNutrientRecord>(
        record: r,
        onDelete: onDelete,
      ),
      final VitaminANutrientRecord r =>
        MassNutrientListTile<VitaminANutrientRecord>(
          record: r,
          onDelete: onDelete,
        ),
      final VitaminB6NutrientRecord r =>
        MassNutrientListTile<VitaminB6NutrientRecord>(
          record: r,
          onDelete: onDelete,
        ),
      final VitaminB12NutrientRecord r =>
        MassNutrientListTile<VitaminB12NutrientRecord>(
          record: r,
          onDelete: onDelete,
        ),
      final VitaminCNutrientRecord r =>
        MassNutrientListTile<VitaminCNutrientRecord>(
          record: r,
          onDelete: onDelete,
        ),
      final VitaminDNutrientRecord r =>
        MassNutrientListTile<VitaminDNutrientRecord>(
          record: r,
          onDelete: onDelete,
        ),
      final VitaminENutrientRecord r =>
        MassNutrientListTile<VitaminENutrientRecord>(
          record: r,
          onDelete: onDelete,
        ),
      final VitaminKNutrientRecord r =>
        MassNutrientListTile<VitaminKNutrientRecord>(
          record: r,
          onDelete: onDelete,
        ),
      final ThiaminNutrientRecord r =>
        MassNutrientListTile<ThiaminNutrientRecord>(
          record: r,
          onDelete: onDelete,
        ),
      final RiboflavinNutrientRecord r =>
        MassNutrientListTile<RiboflavinNutrientRecord>(
          record: r,
          onDelete: onDelete,
        ),
      final NiacinNutrientRecord r =>
        MassNutrientListTile<NiacinNutrientRecord>(
          record: r,
          onDelete: onDelete,
        ),
      final FolateNutrientRecord r =>
        MassNutrientListTile<FolateNutrientRecord>(
          record: r,
          onDelete: onDelete,
        ),
      final BiotinNutrientRecord r =>
        MassNutrientListTile<BiotinNutrientRecord>(
          record: r,
          onDelete: onDelete,
        ),
      final PantothenicAcidNutrientRecord r =>
        MassNutrientListTile<PantothenicAcidNutrientRecord>(
          record: r,
          onDelete: onDelete,
        ),
      final TotalEnergyBurnedRecord r =>
        SimpleIntervalMeasurementListTile<TotalEnergyBurnedRecord>(
          record: r,
          icon: AppIcons.localFireDepartment,
          titleBuilder: (r) =>
              '${r.energy.inKilocalories.toStringAsFixed(0)} kcal (Total)',
          valueExtractor: (r) => r.energy,
          onDelete: onDelete,
        ),
      final BasalEnergyBurnedRecord r =>
        SimpleIntervalMeasurementListTile<BasalEnergyBurnedRecord>(
          record: r,
          icon: AppIcons.localFireDepartment,
          titleBuilder: (r) =>
              '${r.energy.inKilocalories.toStringAsFixed(0)} kcal (Basal)',
          valueExtractor: (r) => r.energy,
          onDelete: onDelete,
        ),
    };

    // Wrap tile with consistent spacing
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: tile,
    );
  }
}
