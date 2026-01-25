import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/common/utils/mixins/process_operation_with_error_handler_page_state_mixin.dart';
import 'package:health_connector_toolbox/src/common/utils/show_app_snack_bar.dart';
import 'package:health_connector_toolbox/src/common/widgets/loading_overlay.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/base_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/custom_health_record_write_forms/blood_pressure_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/custom_health_record_write_forms/cervical_mucus_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/custom_health_record_write_forms/intermenstrual_bleeding_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/custom_health_record_write_forms/menstrual_flow_instant_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/custom_health_record_write_forms/menstrual_flow_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/custom_health_record_write_forms/ovulation_test_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/custom_health_record_write_forms/pregnancy_test_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/custom_health_record_write_forms/progesterone_test_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/custom_health_record_write_forms/sexual_activity_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/instant_health_record_write_forms/basal_body_temperature_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/instant_health_record_write_forms/basal_metabolic_rate_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/instant_health_record_write_forms/blood_alcohol_content_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/instant_health_record_write_forms/blood_glucose_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/instant_health_record_write_forms/body_fat_percentage_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/instant_health_record_write_forms/body_mass_index_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/instant_health_record_write_forms/body_temperature_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/instant_health_record_write_forms/body_water_mass_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/instant_health_record_write_forms/bone_mass_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/instant_health_record_write_forms/cycling_pedaling_cadence_measurement_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/instant_health_record_write_forms/cycling_power_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/instant_health_record_write_forms/diastolic_blood_pressure_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/instant_health_record_write_forms/forced_vital_capacity_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/instant_health_record_write_forms/heart_rate_measurement_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/instant_health_record_write_forms/heart_rate_variability_rmssd_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/instant_health_record_write_forms/heart_rate_variability_sdnn_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/instant_health_record_write_forms/height_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/instant_health_record_write_forms/lean_body_mass_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/instant_health_record_write_forms/nutrient_health_record_write_forms.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/instant_health_record_write_forms/oxygen_saturation_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/instant_health_record_write_forms/peripheral_perfusion_index_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/instant_health_record_write_forms/respiratory_rate_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/instant_health_record_write_forms/resting_heart_rate_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/instant_health_record_write_forms/running_power_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/instant_health_record_write_forms/running_speed_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/instant_health_record_write_forms/stair_ascent_speed_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/instant_health_record_write_forms/stair_descent_speed_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/instant_health_record_write_forms/systolic_blood_pressure_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/instant_health_record_write_forms/vo2_max_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/instant_health_record_write_forms/waist_circumference_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/instant_health_record_write_forms/walking_speed_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/instant_health_record_write_forms/weight_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_forms/active_energy_burned_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_forms/activity_intensity_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_forms/alcoholic_beverages_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_forms/basal_energy_burned_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_forms/contraceptive_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_forms/cross_country_skiing_distance_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_forms/cycling_distance_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_forms/distance_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_forms/downhill_snow_sports_distance_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_forms/electrodermal_activity_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_forms/elevation_gained_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_forms/environmental_audio_exposure_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_forms/exercise_session_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_forms/floors_climbed_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_forms/forced_expiratory_volume_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_forms/headphone_audio_exposure_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_forms/heart_rate_recovery_one_minute_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_forms/hydration_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_forms/inhaler_usage_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_forms/insulin_delivery_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_forms/lactation_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_forms/menstruation_period_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_forms/mindfulness_session_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_forms/number_of_times_fallen_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_forms/nutrition_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_forms/paddle_sports_distance_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_forms/peak_expiratory_flow_rate_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_forms/pregnancy_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_forms/rowing_distance_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_forms/running_ground_contact_time_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_forms/running_stride_length_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_forms/six_minute_walk_test_distance_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_forms/skating_sports_distance_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_forms/sleep_stage_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_forms/steps_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_forms/swimming_distance_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_forms/swimming_strokes_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_forms/total_energy_burned_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_forms/walking_double_support_percentage_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_forms/walking_running_distance_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_forms/walking_step_length_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_forms/wheelchair_distance_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_forms/wheelchair_pushes_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/series_health_record_write_forms/cycling_pedaling_cadence_series_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/series_health_record_write_forms/heart_rate_series_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/series_health_record_write_forms/power_series_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/series_health_record_write_forms/skin_temperature_delta_series_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/series_health_record_write_forms/sleep_session_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/series_health_record_write_forms/speed_series_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/series_health_record_write_forms/steps_cadence_series_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/write_health_record_change_notifier.dart';
import 'package:provider/provider.dart';

/// Unified page for writing health records.
///
/// This page renders the appropriate form widget based on the
/// provided [HealthDataType] using an exhaustive switch statement.
/// It handles the loading overlay and navigation on success.
/// All form UI (date pickers, metadata, submit button) is handled by the
/// form widgets.
@immutable
final class HealthRecordWritePage extends StatefulWidget {
  const HealthRecordWritePage({
    required this.dataType,
    super.key,
  });

  /// The health data type that determines which form widget to render.
  final HealthDataType dataType;

  @override
  State<HealthRecordWritePage> createState() => _HealthRecordWritePageState();
}

class _HealthRecordWritePageState extends State<HealthRecordWritePage>
    with ProcessOperationWithErrorHandlerPageStateMixin<HealthRecordWritePage> {
  late final WriteHealthRecordChangeNotifier _notifier =
      Provider.of<WriteHealthRecordChangeNotifier>(
        context,
        listen: false,
      );

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: context.watch<WriteHealthRecordChangeNotifier>().isLoading,
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppTexts.getInsertTextFor(widget.dataType)),
        ),
        body: _buildWriteForm(),
      ),
    );
  }

  /// Callback passed to form widgets for submitting records.
  Future<void> _onSubmit(HealthRecord record) async {
    await process(() async {
      final recordId = await _notifier.writeHealthRecord(record);

      if (mounted) {
        showAppSnackBar(
          context,
          SnackBarType.success,
          '${AppTexts.successfullyWroteRecord}: $recordId',
        );

        Navigator.of(context).pop();
      }
    });
  }

  /// Builds the appropriate form widget based on the data type.
  BaseHealthRecordWriteForm _buildWriteForm() {
    return switch (widget.dataType) {
      WeightDataType _ => WeightWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      HeightDataType _ => HeightWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      BloodAlcoholContentDataType _ => BloodAlcoholContentWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      BodyFatPercentageDataType _ => BodyFatPercentageWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      LeanBodyMassDataType _ => LeanBodyMassWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      OxygenSaturationDataType _ => OxygenSaturationWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      RespiratoryRateDataType _ => RespiratoryRateWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      BodyTemperatureDataType _ => BodyTemperatureWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      BasalBodyTemperatureDataType _ => BasalBodyTemperatureWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      RestingHeartRateDataType _ => RestingHeartRateWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      BloodPressureDataType _ => BloodPressureWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      SystolicBloodPressureDataType _ => SystolicBloodPressureWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      DiastolicBloodPressureDataType _ => DiastolicBloodPressureWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      HeartRateDataType _ => HeartRateMeasurementWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      CyclingPedalingCadenceDataType _ =>
        CyclingPedalingCadenceMeasurementWriteForm(
          healthPlatform: _notifier.healthPlatform,
          onSubmit: _onSubmit,
        ),
      CyclingPedalingCadenceSeriesDataType _ =>
        CyclingPedalingCadenceSeriesWriteForm(
          healthPlatform: _notifier.healthPlatform,
          onSubmit: _onSubmit,
        ),
      StepsCadenceSeriesDataType _ => StepsCadenceSeriesWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      BloodGlucoseDataType _ => BloodGlucoseWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      Vo2MaxDataType _ => Vo2MaxWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      SexualActivityDataType _ => SexualActivityWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      CervicalMucusDataType _ => CervicalMucusWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      OvulationTestDataType _ => OvulationTestWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      PregnancyTestDataType _ => PregnancyTestWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      ProgesteroneTestDataType _ => ProgesteroneTestWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      IntermenstrualBleedingDataType _ => IntermenstrualBleedingWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      MenstrualFlowInstantDataType _ => MenstrualFlowInstantWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      MenstrualFlowDataType _ => MenstrualFlowWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      WalkingSpeedDataType _ => WalkingSpeedWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      RunningSpeedDataType _ => RunningSpeedWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      StairAscentSpeedDataType _ => StairAscentSpeedWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      StairDescentSpeedDataType _ => StairDescentSpeedWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      CyclingPowerDataType _ => CyclingPowerWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      RunningPowerDataType _ => RunningPowerWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      DietaryEnergyConsumedDataType _ => EnergyNutrientWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      DietaryCaffeineDataType _ => DietaryCaffeineWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      DietaryProteinDataType _ => DietaryProteinWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      DietaryTotalCarbohydrateDataType _ => DietaryTotalCarbohydrateWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      DietaryTotalFatDataType _ => DietaryTotalFatWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      DietarySaturatedFatDataType _ => DietarySaturatedFatWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      DietaryMonounsaturatedFatDataType _ => DietaryMonounsaturatedFatWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      DietaryPolyunsaturatedFatDataType _ => DietaryPolyunsaturatedFatWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      DietaryCholesterolDataType _ => DietaryCholesterolWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      DietaryFiberNutrientDataType _ => DietaryFiberNutrientWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      DietarySugarDataType _ => DietarySugarWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      DietaryCalciumDataType _ => DietaryCalciumWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      DietaryIronDataType _ => DietaryIronWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      DietaryMagnesiumDataType _ => DietaryMagnesiumWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      DietaryManganeseDataType _ => DietaryManganeseWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      DietaryPhosphorusDataType _ => DietaryPhosphorusWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      DietaryPotassiumDataType _ => DietaryPotassiumWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      DietarySeleniumDataType _ => DietarySeleniumWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      DietarySodiumDataType _ => DietarySodiumWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      DietaryZincDataType _ => DietaryZincWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      DietaryVitaminADataType _ => DietaryVitaminAWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      DietaryVitaminB6DataType _ => DietaryVitaminB6WriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      DietaryVitaminB12DataType _ => DietaryVitaminB12WriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      DietaryVitaminCDataType _ => DietaryVitaminCWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      DietaryVitaminDDataType _ => DietaryVitaminDWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      DietaryVitaminEDataType _ => DietaryVitaminEWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      DietaryVitaminKDataType _ => DietaryVitaminKWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      DietaryThiaminDataType _ => DietaryThiaminWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      DietaryRiboflavinDataType _ => DietaryRiboflavinWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      DietaryNiacinDataType _ => DietaryNiacinWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      DietaryFolateDataType _ => DietaryFolateWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      DietaryBiotinDataType _ => DietaryBiotinWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      DietaryPantothenicAcidDataType _ => DietaryPantothenicAcidWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      StepsDataType _ => StepsWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      DistanceDataType _ => DistanceWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      ActiveEnergyBurnedDataType _ => ActiveEnergyBurnedWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      AlcoholicBeveragesDataType _ => AlcoholicBeveragesWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      FloorsClimbedDataType _ => FloorsClimbedWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      ElevationGainedDataType _ => ElevationGainedWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      WheelchairPushesDataType _ => WheelchairPushesWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      CyclingDistanceDataType _ => CyclingDistanceWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      CrossCountrySkiingDistanceDataType _ =>
        CrossCountrySkiingDistanceWriteForm(
          healthPlatform: _notifier.healthPlatform,
          onSubmit: _onSubmit,
        ),
      DownhillSnowSportsDistanceDataType _ =>
        DownhillSnowSportsDistanceWriteForm(
          healthPlatform: _notifier.healthPlatform,
          onSubmit: _onSubmit,
        ),
      PaddleSportsDistanceDataType _ => PaddleSportsDistanceWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      RowingDistanceDataType _ => RowingDistanceWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      SkatingSportsDistanceDataType _ => SkatingSportsDistanceWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      SwimmingDistanceDataType _ => SwimmingDistanceWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      WalkingRunningDistanceDataType _ => WalkingRunningDistanceWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      WheelchairDistanceDataType _ => WheelchairDistanceWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      SixMinuteWalkTestDistanceDataType _ => SixMinuteWalkTestDistanceWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      HydrationDataType _ => HydrationWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      NutritionDataType _ => NutritionWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      ExerciseSessionDataType _ => ExerciseSessionWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      SleepStageDataType _ => SleepStageWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      MindfulnessSessionDataType _ => MindfulnessSessionWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      HeartRateSeriesDataType _ => HeartRateSeriesWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      SpeedSeriesDataType _ => SpeedSeriesWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      PowerSeriesDataType _ => PowerSeriesWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      SkinTemperatureDataType _ => SkinTemperatureDeltaSeriesWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      SleepSessionDataType _ => SleepSessionWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      TotalEnergyBurnedDataType _ => TotalEnergyBurnedWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      BasalEnergyBurnedDataType _ => BasalEnergyBurnedWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      BasalMetabolicRateDataType _ => BasalMetabolicRateWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      BoneMassDataType _ => BoneMassWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      BodyWaterMassDataType _ => BodyWaterMassWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      HeartRateVariabilityRMSSDDataType _ => HeartRateVariabilityRMSSDWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      HeartRateVariabilitySDNNDataType _ => HeartRateVariabilitySDNNWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      BodyMassIndexDataType _ => BodyMassIndexWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      WaistCircumferenceDataType _ => WaistCircumferenceWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      ContraceptiveDataType _ => ContraceptiveRecordWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      MenstruationPeriodDataType _ => MenstruationPeriodRecordWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      LactationDataType _ => LactationRecordWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      PregnancyDataType _ => PregnancyRecordWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      SwimmingStrokesDataType _ => SwimmingStrokesWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      PeripheralPerfusionIndexDataType _ =>
        PeripheralPerfusionIndexRecordWriteForm(
          healthPlatform: _notifier.healthPlatform,
          onSubmit: _onSubmit,
        ),
      ForcedVitalCapacityDataType _ => ForcedVitalCapacityWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      ForcedExpiratoryVolumeDataType _ => ForcedExpiratoryVolumeWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      PeakExpiratoryFlowRateDataType _ => PeakExpiratoryFlowRateWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      NumberOfTimesFallenDataType _ => NumberOfTimesFallenWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      ActivityIntensityDataType _ => ActivityIntensityRecordWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      WalkingDoubleSupportPercentageDataType _ =>
        WalkingDoubleSupportPercentageWriteForm(
          healthPlatform: _notifier.healthPlatform,
          onSubmit: _onSubmit,
        ),
      WalkingStepLengthDataType _ => WalkingStepLengthWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      RunningGroundContactTimeDataType _ => RunningGroundContactTimeWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      RunningStrideLengthDataType _ => RunningStrideLengthWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      ElectrodermalActivityDataType _ => ElectrodermalActivityWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      InsulinDeliveryDataType _ => InsulinDeliveryWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      InhalerUsageDataType() => InhalerUsageWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),

      // region Read-only data types
      ExerciseTimeDataType _ => throw UnsupportedError(
        'Apple Exercise Time is read-only',
      ),
      MoveTimeDataType _ => throw UnsupportedError(
        'Apple Move Time is read-only',
      ),
      StandTimeDataType _ => throw UnsupportedError(
        'Apple Stand Time is read-only',
      ),
      WalkingSteadinessDataType _ => throw UnsupportedError(
        'Apple Walking Steadiness is read-only',
      ),
      SleepingWristTemperatureDataType _ => throw UnsupportedError(
        'Sleeping Wrist Temperature is read-only',
      ),
      WalkingAsymmetryPercentageDataType _ => throw UnsupportedError(
        'Walking Asymmetry Percentage is read-only',
      ),
      LowHeartRateEventDataType _ => throw UnsupportedError(
        'Low Heart Rate Event is read-only',
      ),
      LowCardioFitnessEventDataType _ => throw UnsupportedError(
        'Low Cardio Fitness Event is read-only',
      ),
      IrregularHeartRhythmEventDataType _ => throw UnsupportedError(
        'Irregular Heart Rhythm Event is read-only',
      ),
      HighHeartRateEventDataType _ => throw UnsupportedError(
        'High Heart Rate Event is read-only',
      ),
      InfrequentMenstrualCycleEventDataType _ => throw UnsupportedError(
        'Infrequent Menstrual Cycle Event is read-only',
      ),
      EnvironmentalAudioExposureEventDataType _ => throw UnsupportedError(
        'Environmental Audio Exposure Event is read-only',
      ),
      HeadphoneAudioExposureEventDataType _ => throw UnsupportedError(
        'Headphone Audio Exposure Event is read-only',
      ),
      EnvironmentalAudioExposureDataType _ =>
        EnvironmentalAudioExposureWriteForm(
          healthPlatform: _notifier.healthPlatform,
          onSubmit: _onSubmit,
        ),
      HeadphoneAudioExposureDataType _ => HeadphoneAudioExposureWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      IrregularMenstrualCycleEventDataType _ => throw UnsupportedError(
        'Irregular Menstrual Cycle Event is read-only',
      ),
      WalkingSteadinessEventDataType _ => throw UnsupportedError(
        'Walking Steadiness Event is read-only',
      ),
      PersistentIntermenstrualBleedingEventDataType _ => throw UnsupportedError(
        'Persistent Intermenstrual Bleeding Event is read-only',
      ),
      ProlongedMenstrualPeriodEventDataType _ => throw UnsupportedError(
        'Prolonged Menstrual Period Event is read-only',
      ),
      AtrialFibrillationBurdenDataType _ => throw UnsupportedError(
        'Atrial Fibrillation Burden is read-only',
      ),
      WalkingHeartRateAverageDataType _ => throw UnsupportedError(
        'Walking Heart Rate Average is read-only',
      ),
      HeartRateRecoveryOneMinuteDataType _ =>
        HeartRateRecoveryOneMinuteWriteForm(
          healthPlatform: _notifier.healthPlatform,
          onSubmit: _onSubmit,
        ),

      // endregion
    };
  }
}
