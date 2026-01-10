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
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/custom_health_record_write_forms/sexual_activity_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/instant_health_record_write_forms/basal_body_temperature_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/instant_health_record_write_forms/blood_glucose_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/instant_health_record_write_forms/body_fat_percentage_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/instant_health_record_write_forms/body_mass_index_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/instant_health_record_write_forms/body_temperature_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/instant_health_record_write_forms/body_water_mass_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/instant_health_record_write_forms/bone_mass_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/instant_health_record_write_forms/cycling_pedaling_cadence_measurement_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/instant_health_record_write_forms/cycling_power_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/instant_health_record_write_forms/diastolic_blood_pressure_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/instant_health_record_write_forms/heart_rate_measurement_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/instant_health_record_write_forms/heart_rate_variability_rmssd_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/instant_health_record_write_forms/heart_rate_variability_sdnn_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/instant_health_record_write_forms/height_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/instant_health_record_write_forms/lean_body_mass_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/instant_health_record_write_forms/nutrient_health_record_write_forms.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/instant_health_record_write_forms/oxygen_saturation_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/instant_health_record_write_forms/respiratory_rate_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/instant_health_record_write_forms/resting_heart_rate_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/instant_health_record_write_forms/running_speed_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/instant_health_record_write_forms/stair_ascent_speed_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/instant_health_record_write_forms/stair_descent_speed_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/instant_health_record_write_forms/systolic_blood_pressure_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/instant_health_record_write_forms/vo2_max_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/instant_health_record_write_forms/waist_circumference_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/instant_health_record_write_forms/walking_speed_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/instant_health_record_write_forms/weight_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_forms/active_calories_burned_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_forms/basal_energy_burned_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_forms/cross_country_skiing_distance_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_forms/cycling_distance_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_forms/distance_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_forms/downhill_snow_sports_distance_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_forms/exercise_session_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_forms/floors_climbed_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_forms/hydration_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_forms/mindfulness_session_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_forms/nutrition_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_forms/paddle_sports_distance_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_forms/rowing_distance_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_forms/six_minute_walk_test_distance_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_forms/skating_sports_distance_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_forms/sleep_stage_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_forms/steps_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_forms/swimming_distance_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_forms/total_calories_burned_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_forms/walking_running_distance_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_forms/wheelchair_distance_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/interval_health_record_write_forms/wheelchair_pushes_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/series_health_record_write_forms/cycling_pedaling_cadence_series_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/series_health_record_write_forms/heart_rate_series_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/series_health_record_write_forms/power_series_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/series_health_record_write_forms/sleep_session_health_record_write_form.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/write_forms/series_health_record_write_forms/speed_series_health_record_write_form.dart';
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
      DietaryEnergyConsumedDataType _ => EnergyNutrientWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      CaffeineNutrientDataType _ => CaffeineNutrientWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      ProteinNutrientDataType _ => ProteinNutrientWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      TotalCarbohydrateNutrientDataType _ => TotalCarbohydrateNutrientWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      TotalFatNutrientDataType _ => TotalFatNutrientWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      SaturatedFatNutrientDataType _ => SaturatedFatNutrientWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      MonounsaturatedFatNutrientDataType _ =>
        MonounsaturatedFatNutrientWriteForm(
          healthPlatform: _notifier.healthPlatform,
          onSubmit: _onSubmit,
        ),
      PolyunsaturatedFatNutrientDataType _ =>
        PolyunsaturatedFatNutrientWriteForm(
          healthPlatform: _notifier.healthPlatform,
          onSubmit: _onSubmit,
        ),
      CholesterolNutrientDataType _ => CholesterolNutrientWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      DietaryFiberNutrientDataType _ => DietaryFiberNutrientWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      SugarNutrientDataType _ => SugarNutrientWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      CalciumNutrientDataType _ => CalciumNutrientWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      IronNutrientDataType _ => IronNutrientWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      MagnesiumNutrientDataType _ => MagnesiumNutrientWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      ManganeseNutrientDataType _ => ManganeseNutrientWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      PhosphorusNutrientDataType _ => PhosphorusNutrientWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      PotassiumNutrientDataType _ => PotassiumNutrientWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      SeleniumNutrientDataType _ => SeleniumNutrientWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      SodiumNutrientDataType _ => SodiumNutrientWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      ZincNutrientDataType _ => ZincNutrientWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      VitaminANutrientDataType _ => VitaminANutrientWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      VitaminB6NutrientDataType _ => VitaminB6NutrientWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      VitaminB12NutrientDataType _ => VitaminB12NutrientWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      VitaminCNutrientDataType _ => VitaminCNutrientWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      VitaminDNutrientDataType _ => VitaminDNutrientWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      VitaminENutrientDataType _ => VitaminENutrientWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      VitaminKNutrientDataType _ => VitaminKNutrientWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      ThiaminNutrientDataType _ => ThiaminNutrientWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      RiboflavinNutrientDataType _ => RiboflavinNutrientWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      NiacinNutrientDataType _ => NiacinNutrientWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      FolateNutrientDataType _ => FolateNutrientWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      BiotinNutrientDataType _ => BiotinNutrientWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      PantothenicAcidNutrientDataType _ => PantothenicAcidNutrientWriteForm(
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
      ActiveEnergyBurnedDataType _ => ActiveCaloriesBurnedWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      FloorsClimbedDataType _ => FloorsClimbedWriteForm(
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
      SleepSessionDataType _ => SleepSessionWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      TotalEnergyBurnedDataType _ => TotalCaloriesBurnedWriteForm(
        healthPlatform: _notifier.healthPlatform,
        onSubmit: _onSubmit,
      ),
      BasalEnergyBurnedDataType _ => BasalEnergyBurnedWriteForm(
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
    };
  }
}
