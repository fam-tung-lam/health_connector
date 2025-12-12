import 'package:flutter/material.dart';
import 'package:health_connector/health_connector.dart'
    show
        ActiveCaloriesBurnedHealthDataType,
        BiotinNutrientDataType,
        BloodPressureBodyPosition,
        BloodPressureHealthDataType,
        BloodPressureMeasurementLocation,
        BodyFatPercentageHealthDataType,
        DiastolicBloodPressureHealthDataType,
        BodyTemperatureHealthDataType,
        CaffeineNutrientDataType,
        CalciumNutrientDataType,
        CholesterolNutrientDataType,
        DataOrigin,
        Device,
        DietaryFiberNutrientDataType,
        Energy,
        Mass,
        DistanceHealthDataType,
        EnergyNutrientDataType,
        FloorsClimbedHealthDataType,
        FolateNutrientDataType,
        HealthConnectorErrorCode,
        HealthConnectorException,
        HealthDataType,
        HeartRateMeasurement,
        HeartRateMeasurementRecordHealthDataType,
        HeartRateSeriesRecordHealthDataType,
        HeightHealthDataType,
        HydrationHealthDataType,
        IronNutrientDataType,
        LeanBodyMassHealthDataType,
        MagnesiumNutrientDataType,
        ManganeseNutrientDataType,
        MealType,
        MeasurementUnit,
        Metadata,
        MonounsaturatedFatNutrientDataType,
        NiacinNutrientDataType,
        NutritionHealthDataType,
        PantothenicAcidNutrientDataType,
        PhosphorusNutrientDataType,
        OxygenSaturationHealthDataType,
        PolyunsaturatedFatNutrientDataType,
        PotassiumNutrientDataType,
        Pressure,
        ProteinNutrientDataType,
        RecordingMethod,
        RiboflavinNutrientDataType,
        RestingHeartRateHealthDataType,
        SaturatedFatNutrientDataType,
        SeleniumNutrientDataType,
        SodiumNutrientDataType,
        StepsHealthDataType,
        RespiratoryRateHealthDataType,
        SugarNutrientDataType,
        SystolicBloodPressureHealthDataType,
        ThiaminNutrientDataType,
        TotalCarbohydrateNutrientDataType,
        TotalFatNutrientDataType,
        VitaminANutrientDataType,
        VitaminB12NutrientDataType,
        VitaminB6NutrientDataType,
        VitaminCNutrientDataType,
        VitaminDNutrientDataType,
        VitaminENutrientDataType,
        VitaminKNutrientDataType,
        WeightHealthDataType,
        WheelchairPushesHealthDataType,
        ZincNutrientDataType,
        SleepSessionHealthDataType,
        SleepStageHealthDataType,
        SleepStage,
        SleepStageType;
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';
import 'package:health_connector_toolbox/src/common/utils/show_snack_bar.dart';
import 'package:health_connector_toolbox/src/common/widgets/date_time_picker_row.dart';
import 'package:health_connector_toolbox/src/common/widgets/loading_overlay.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/models/health_record_form_config.dart'
    show
        BloodPressureFormConfig,
        HealthRecordFormConfig,
        HeartRateSeriesRecordFormConfig,
        NutritionFormConfig,
        NutrientFormConfig,
        SleepSessionRecordFormConfig,
        SleepStageRecordFormConfig;
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/blood_pressure_form_field.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/duration_picker_field.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/health_value_field.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/heart_rate_samples_form_field.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/meal_type_dropdown_field.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/metadata_form_fields.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/nutrition_form_field.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/sleep_stage_type_dropdown_field.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/widgets/sleep_stages_form_field.dart';
import 'package:health_connector_toolbox/src/features/write_health_record/write_health_record_change_notifier.dart';
import 'package:provider/provider.dart' show Provider;

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

class _WriteHealthRecordFormPageState extends State<WriteHealthRecordFormPage> {
  late final WriteHealthRecordChangeNotifier _notifier =
      Provider.of<WriteHealthRecordChangeNotifier>(
        context,
        listen: false,
      );

  late final HealthRecordFormConfig _config =
      HealthRecordFormConfig.fromDataType(widget.dataType);

  final _formKey = GlobalKey<FormState>();
  RecordingMethod _recordingMethod = RecordingMethod.unknown;
  Device? _device;
  MeasurementUnit? _value;
  bool _isWriting = false;

  // State for heart rate series samples (Android)
  List<HeartRateMeasurement>? _heartRateSamples;

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

  // State for nutrition record
  String? _nutritionFoodName;
  MealType _nutritionMealType = MealType.unknown;
  Energy? _nutritionEnergy;
  Mass? _nutritionProtein;
  Mass? _nutritionTotalCarbohydrate;
  Mass? _nutritionTotalFat;
  Mass? _nutritionSaturatedFat;
  Mass? _nutritionMonounsaturatedFat;
  Mass? _nutritionPolyunsaturatedFat;
  Mass? _nutritionCholesterol;
  Mass? _nutritionDietaryFiber;
  Mass? _nutritionSugar;
  Mass? _nutritionVitaminA;
  Mass? _nutritionVitaminB6;
  Mass? _nutritionVitaminB12;
  Mass? _nutritionVitaminC;
  Mass? _nutritionVitaminD;
  Mass? _nutritionVitaminE;
  Mass? _nutritionVitaminK;
  Mass? _nutritionThiamin;
  Mass? _nutritionRiboflavin;
  Mass? _nutritionNiacin;
  Mass? _nutritionFolate;
  Mass? _nutritionBiotin;
  Mass? _nutritionPantothenicAcid;
  Mass? _nutritionCalcium;
  Mass? _nutritionIron;
  Mass? _nutritionMagnesium;
  Mass? _nutritionManganese;
  Mass? _nutritionPhosphorus;
  Mass? _nutritionPotassium;
  Mass? _nutritionSelenium;
  Mass? _nutritionSodium;
  Mass? _nutritionZinc;
  Mass? _nutritionCaffeine;

  // State for blood pressure record
  Pressure? _systolic;
  Pressure? _diastolic;

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
    if (!_config.needsDuration) {
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
    if (_config.needsDuration) {
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
      return 'Duration must be greater than 0';
    }
    if (startDateTime == null) {
      return AppTexts.pleaseSelectDateTime;
    }
    final end = endDateTime;
    if (end == null) {
      return 'Failed to calculate end time';
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
    if (_config.needsDuration && endDateTime == null) {
      return;
    }

    // Special validation for heart rate series record
    if (widget.dataType is HeartRateSeriesRecordHealthDataType) {
      if (_heartRateSamples == null || _heartRateSamples!.isEmpty) {
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
    } else if (_config is NutrientFormConfig) {
      // Nutrient records need a value
      if (_value == null) {
        return;
      }
    } else {
      if (_value == null) {
        return;
      }
    }

    setState(() {
      _isWriting = true;
    });

    try {
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
          (_config as HeartRateSeriesRecordFormConfig).buildRecordWithSamples(
            startDateTime: startDateTime!,
            endDateTime: endDateTime!,
            samples: _heartRateSamples!,
            metadata: metadata,
          ),
        SleepSessionHealthDataType() =>
          (_config as SleepSessionRecordFormConfig).buildRecordWithStages(
            startDateTime: startDateTime!,
            endDateTime: endDateTime!,
            stages: _sleepStages!,
            metadata: metadata,
            title: _sleepTitle?.isEmpty ?? true ? null : _sleepTitle,
            notes: _sleepNotes?.isEmpty ?? true ? null : _sleepNotes,
          ),
        SleepStageHealthDataType() =>
          (_config as SleepStageRecordFormConfig).buildRecordWithStage(
            startDateTime: startDateTime!,
            endDateTime: endDateTime!,
            stageType: _sleepStage!.stageType,
            metadata: metadata,
            title: _sleepTitle?.isEmpty ?? true ? null : _sleepTitle,
            notes: _sleepNotes?.isEmpty ?? true ? null : _sleepNotes,
          ),
        NutritionHealthDataType() =>
          (_config as NutritionFormConfig).buildRecordWithNutritionData(
            startDateTime: startDateTime!,
            endDateTime: endDateTime!,
            metadata: metadata,
            foodName: _nutritionFoodName?.isEmpty ?? true
                ? null
                : _nutritionFoodName,
            mealType: _nutritionMealType,
            energy: _nutritionEnergy,
            protein: _nutritionProtein,
            totalCarbohydrate: _nutritionTotalCarbohydrate,
            totalFat: _nutritionTotalFat,
            saturatedFat: _nutritionSaturatedFat,
            monounsaturatedFat: _nutritionMonounsaturatedFat,
            polyunsaturatedFat: _nutritionPolyunsaturatedFat,
            cholesterol: _nutritionCholesterol,
            dietaryFiber: _nutritionDietaryFiber,
            sugar: _nutritionSugar,
            vitaminA: _nutritionVitaminA,
            vitaminB6: _nutritionVitaminB6,
            vitaminB12: _nutritionVitaminB12,
            vitaminC: _nutritionVitaminC,
            vitaminD: _nutritionVitaminD,
            vitaminE: _nutritionVitaminE,
            vitaminK: _nutritionVitaminK,
            thiamin: _nutritionThiamin,
            riboflavin: _nutritionRiboflavin,
            niacin: _nutritionNiacin,
            folate: _nutritionFolate,
            biotin: _nutritionBiotin,
            pantothenicAcid: _nutritionPantothenicAcid,
            calcium: _nutritionCalcium,
            iron: _nutritionIron,
            magnesium: _nutritionMagnesium,
            manganese: _nutritionManganese,
            phosphorus: _nutritionPhosphorus,
            potassium: _nutritionPotassium,
            selenium: _nutritionSelenium,
            sodium: _nutritionSodium,
            zinc: _nutritionZinc,
            caffeine: _nutritionCaffeine,
          ),
        BloodPressureHealthDataType() =>
          (_config as BloodPressureFormConfig).buildBloodPressureRecord(
            time: startDateTime!,
            systolic: _systolic!,
            diastolic: _diastolic!,
            bodyPosition: BloodPressureBodyPosition.unknown,
            measurementLocation: BloodPressureMeasurementLocation.unknown,
            metadata: metadata,
          ),
        _ =>
          _config is NutrientFormConfig
              ? _config.buildRecordWithNutrientData(
                  time: startDateTime!,
                  value: _value!,
                  metadata: metadata,
                  foodName: _foodName?.isEmpty ?? true ? null : _foodName,
                  mealType: _mealType,
                )
              : _config.buildRecord(
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
    } on HealthConnectorException catch (e) {
      if (!mounted) {
        return;
      }

      final message = _getErrorMessage(e);
      showAppSnackBar(context, SnackBarType.error, message);
    } on Exception catch (e) {
      if (!mounted) {
        return;
      }

      showAppSnackBar(
        context,
        SnackBarType.error,
        '${AppTexts.errorPrefixColon} $e',
      );
    } finally {
      if (mounted) {
        setState(() {
          _isWriting = false;
        });
      }
    }
  }

  String _getErrorMessage(HealthConnectorException e) {
    if (e.code == HealthConnectorErrorCode.unsupportedHealthPlatformApi) {
      return switch (widget.dataType) {
        StepsHealthDataType() => AppTexts.writePermissionDeniedSteps,
        WeightHealthDataType() => AppTexts.writePermissionDeniedWeight,
        HeightHealthDataType() => AppTexts.writePermissionDeniedHeight,
        BodyFatPercentageHealthDataType() =>
          AppTexts.writePermissionDeniedBodyFatPercentage,
        LeanBodyMassHealthDataType() =>
          AppTexts.writePermissionDeniedLeanBodyMass,
        BodyTemperatureHealthDataType() =>
          AppTexts.writePermissionDeniedBodyTemperature,
        BloodPressureHealthDataType() =>
          AppTexts.writePermissionDeniedBloodPressure,
        SystolicBloodPressureHealthDataType() =>
          AppTexts.writePermissionDeniedSystolicBloodPressure,
        DiastolicBloodPressureHealthDataType() =>
          AppTexts.writePermissionDeniedDiastolicBloodPressure,
        DistanceHealthDataType() => AppTexts.writePermissionDeniedDistance,
        ActiveCaloriesBurnedHealthDataType() =>
          AppTexts.writePermissionDeniedActiveCaloriesBurned,
        FloorsClimbedHealthDataType() =>
          AppTexts.writePermissionDeniedFloorsClimbed,
        WheelchairPushesHealthDataType() =>
          AppTexts.writePermissionDeniedWheelchairPushes,
        HydrationHealthDataType() => AppTexts.writePermissionDeniedHydration,
        HeartRateMeasurementRecordHealthDataType() =>
          AppTexts.writePermissionDeniedHeartRateRecord,
        HeartRateSeriesRecordHealthDataType() =>
          AppTexts.writePermissionDeniedHeartRateRecord,
        SleepSessionHealthDataType() =>
          AppTexts.writePermissionDeniedSleepSession,
        SleepStageHealthDataType() =>
          AppTexts.writePermissionDeniedSleepStageRecord,
        EnergyNutrientDataType() =>
          AppTexts.writePermissionDeniedEnergyNutrient,
        CaffeineNutrientDataType() => AppTexts.writePermissionDeniedCaffeine,
        ProteinNutrientDataType() => AppTexts.writePermissionDeniedProtein,
        TotalCarbohydrateNutrientDataType() =>
          AppTexts.writePermissionDeniedTotalCarbohydrate,
        TotalFatNutrientDataType() => AppTexts.writePermissionDeniedTotalFat,
        SaturatedFatNutrientDataType() =>
          AppTexts.writePermissionDeniedSaturatedFat,
        MonounsaturatedFatNutrientDataType() =>
          AppTexts.writePermissionDeniedMonounsaturatedFat,
        PolyunsaturatedFatNutrientDataType() =>
          AppTexts.writePermissionDeniedPolyunsaturatedFat,
        CholesterolNutrientDataType() =>
          AppTexts.writePermissionDeniedCholesterol,
        DietaryFiberNutrientDataType() =>
          AppTexts.writePermissionDeniedDietaryFiber,
        SugarNutrientDataType() => AppTexts.writePermissionDeniedSugar,
        CalciumNutrientDataType() => AppTexts.writePermissionDeniedCalcium,
        IronNutrientDataType() => AppTexts.writePermissionDeniedIron,
        MagnesiumNutrientDataType() => AppTexts.writePermissionDeniedMagnesium,
        ManganeseNutrientDataType() => AppTexts.writePermissionDeniedManganese,
        PhosphorusNutrientDataType() =>
          AppTexts.writePermissionDeniedPhosphorus,
        PotassiumNutrientDataType() => AppTexts.writePermissionDeniedPotassium,
        SeleniumNutrientDataType() => AppTexts.writePermissionDeniedSelenium,
        SodiumNutrientDataType() => AppTexts.writePermissionDeniedSodium,
        ZincNutrientDataType() => AppTexts.writePermissionDeniedZinc,
        VitaminANutrientDataType() => AppTexts.writePermissionDeniedVitaminA,
        VitaminB6NutrientDataType() => AppTexts.writePermissionDeniedVitaminB6,
        VitaminB12NutrientDataType() =>
          AppTexts.writePermissionDeniedVitaminB12,
        VitaminCNutrientDataType() => AppTexts.writePermissionDeniedVitaminC,
        VitaminDNutrientDataType() => AppTexts.writePermissionDeniedVitaminD,
        VitaminENutrientDataType() => AppTexts.writePermissionDeniedVitaminE,
        VitaminKNutrientDataType() => AppTexts.writePermissionDeniedVitaminK,
        ThiaminNutrientDataType() => AppTexts.writePermissionDeniedThiamin,
        RiboflavinNutrientDataType() =>
          AppTexts.writePermissionDeniedRiboflavin,
        NiacinNutrientDataType() => AppTexts.writePermissionDeniedNiacin,
        FolateNutrientDataType() => AppTexts.writePermissionDeniedFolate,
        BiotinNutrientDataType() => AppTexts.writePermissionDeniedBiotin,
        PantothenicAcidNutrientDataType() =>
          AppTexts.writePermissionDeniedPantothenicAcid,
        NutritionHealthDataType() => AppTexts.writePermissionDeniedNutrition,
        RestingHeartRateHealthDataType() =>
          AppTexts.writePermissionDeniedRestingHeartRateRecord,
        OxygenSaturationHealthDataType() =>
          AppTexts.writePermissionDeniedOxygenSaturation,
        RespiratoryRateHealthDataType() =>
          AppTexts.writePermissionDeniedRespiratoryRate,
      };
    }
    return e.message;
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      isLoading: _isWriting,
      message: AppTexts.save,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            switch (widget.dataType) {
              StepsHealthDataType() => AppTexts.insertSteps,
              WeightHealthDataType() => AppTexts.insertWeight,
              HeightHealthDataType() => AppTexts.insertHeight,
              BodyFatPercentageHealthDataType() =>
                AppTexts.insertBodyFatPercentage,
              LeanBodyMassHealthDataType() => AppTexts.insertLeanBodyMass,
              BodyTemperatureHealthDataType() => AppTexts.insertBodyTemperature,
              BloodPressureHealthDataType() => AppTexts.insertBloodPressure,
              SystolicBloodPressureHealthDataType() =>
                AppTexts.insertSystolicBloodPressure,
              DiastolicBloodPressureHealthDataType() =>
                AppTexts.insertDiastolicBloodPressure,
              DistanceHealthDataType() => AppTexts.insertDistance,
              ActiveCaloriesBurnedHealthDataType() =>
                AppTexts.insertActiveCaloriesBurned,
              FloorsClimbedHealthDataType() => AppTexts.insertFloorsClimbed,
              WheelchairPushesHealthDataType() =>
                AppTexts.insertWheelchairPushes,
              HydrationHealthDataType() => AppTexts.insertHydration,
              HeartRateMeasurementRecordHealthDataType() =>
                AppTexts.insertHeartRateRecord,
              HeartRateSeriesRecordHealthDataType() =>
                AppTexts.insertHeartRateRecord,
              SleepSessionHealthDataType() => AppTexts.insertSleepSession,
              SleepStageHealthDataType() => AppTexts.insertSleepStageRecord,
              EnergyNutrientDataType() => AppTexts.insertEnergy,
              CaffeineNutrientDataType() => AppTexts.insertCaffeine,
              ProteinNutrientDataType() => AppTexts.insertProtein,
              TotalCarbohydrateNutrientDataType() =>
                AppTexts.insertTotalCarbohydrate,
              TotalFatNutrientDataType() => AppTexts.insertTotalFat,
              SaturatedFatNutrientDataType() => AppTexts.insertSaturatedFat,
              MonounsaturatedFatNutrientDataType() =>
                AppTexts.insertMonounsaturatedFat,
              PolyunsaturatedFatNutrientDataType() =>
                AppTexts.insertPolyunsaturatedFat,
              CholesterolNutrientDataType() => AppTexts.insertCholesterol,
              DietaryFiberNutrientDataType() => AppTexts.insertDietaryFiber,
              SugarNutrientDataType() => AppTexts.insertSugar,
              CalciumNutrientDataType() => AppTexts.insertCalcium,
              IronNutrientDataType() => AppTexts.insertIron,
              MagnesiumNutrientDataType() => AppTexts.insertMagnesium,
              ManganeseNutrientDataType() => AppTexts.insertManganese,
              PhosphorusNutrientDataType() => AppTexts.insertPhosphorus,
              PotassiumNutrientDataType() => AppTexts.insertPotassium,
              SeleniumNutrientDataType() => AppTexts.insertSelenium,
              SodiumNutrientDataType() => AppTexts.insertSodium,
              ZincNutrientDataType() => AppTexts.insertZinc,
              VitaminANutrientDataType() => AppTexts.insertVitaminA,
              VitaminB6NutrientDataType() => AppTexts.insertVitaminB6,
              VitaminB12NutrientDataType() => AppTexts.insertVitaminB12,
              VitaminCNutrientDataType() => AppTexts.insertVitaminC,
              VitaminDNutrientDataType() => AppTexts.insertVitaminD,
              VitaminENutrientDataType() => AppTexts.insertVitaminE,
              VitaminKNutrientDataType() => AppTexts.insertVitaminK,
              ThiaminNutrientDataType() => AppTexts.insertThiamin,
              RiboflavinNutrientDataType() => AppTexts.insertRiboflavin,
              NiacinNutrientDataType() => AppTexts.insertNiacin,
              FolateNutrientDataType() => AppTexts.insertFolate,
              BiotinNutrientDataType() => AppTexts.insertBiotin,
              PantothenicAcidNutrientDataType() =>
                AppTexts.insertPantothenicAcid,
              NutritionHealthDataType() => AppTexts.insertNutrition,
              RestingHeartRateHealthDataType() =>
                AppTexts.insertRestingHeartRateRecord,
              OxygenSaturationHealthDataType() =>
                AppTexts.insertOxygenSaturation,
              RespiratoryRateHealthDataType() => AppTexts.insertRespiratoryRate,
            },
          ),
        ),
        body: SingleChildScrollView(
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
                if (_config.needsDuration) ...[
                  const SizedBox(height: 16),
                  DurationPickerField(
                    label: 'Duration (HH:MM)',
                    initialValue: _duration,
                    onChanged: setDuration,
                    validator: _durationValidator,
                  ),
                ],
                const SizedBox(height: 16),
                if (widget.dataType is HeartRateSeriesRecordHealthDataType)
                  HeartRateSamplesFormField(
                    startDateTime: startDateTime,
                    endDateTime: endDateTime,
                    onChanged: (samples) {
                      setState(() {
                        _heartRateSamples = samples;
                      });
                    },
                  )
                else if (widget.dataType is SleepSessionHealthDataType)
                  SleepStagesFormField(
                    startDateTime: startDateTime,
                    endDateTime: endDateTime,
                    onChanged: (stages) {
                      setState(() {
                        _sleepStages = stages;
                      });
                    },
                  )
                else if (widget.dataType is SleepStageHealthDataType) ...[
                  SleepStageTypeDropdownField(
                    value: _sleepStageType,
                    onChanged: (type) {
                      setState(() {
                        _sleepStageType = type;
                      });
                      _updateSleepStage();
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a sleep stage type';
                      }
                      return null;
                    },
                  ),
                ] else if (widget.dataType is NutritionHealthDataType)
                  NutritionFormField(
                    onChanged:
                        ({
                          foodName,
                          mealType,
                          energy,
                          protein,
                          totalCarbohydrate,
                          totalFat,
                          saturatedFat,
                          monounsaturatedFat,
                          polyunsaturatedFat,
                          cholesterol,
                          dietaryFiber,
                          sugar,
                          vitaminA,
                          vitaminB6,
                          vitaminB12,
                          vitaminC,
                          vitaminD,
                          vitaminE,
                          vitaminK,
                          thiamin,
                          riboflavin,
                          niacin,
                          folate,
                          biotin,
                          pantothenicAcid,
                          calcium,
                          iron,
                          magnesium,
                          manganese,
                          phosphorus,
                          potassium,
                          selenium,
                          sodium,
                          zinc,
                          caffeine,
                        }) {
                          setState(() {
                            _nutritionFoodName = foodName;
                            _nutritionMealType = mealType ?? MealType.unknown;
                            _nutritionEnergy = energy;
                            _nutritionProtein = protein;
                            _nutritionTotalCarbohydrate = totalCarbohydrate;
                            _nutritionTotalFat = totalFat;
                            _nutritionSaturatedFat = saturatedFat;
                            _nutritionMonounsaturatedFat = monounsaturatedFat;
                            _nutritionPolyunsaturatedFat = polyunsaturatedFat;
                            _nutritionCholesterol = cholesterol;
                            _nutritionDietaryFiber = dietaryFiber;
                            _nutritionSugar = sugar;
                            _nutritionVitaminA = vitaminA;
                            _nutritionVitaminB6 = vitaminB6;
                            _nutritionVitaminB12 = vitaminB12;
                            _nutritionVitaminC = vitaminC;
                            _nutritionVitaminD = vitaminD;
                            _nutritionVitaminE = vitaminE;
                            _nutritionVitaminK = vitaminK;
                            _nutritionThiamin = thiamin;
                            _nutritionRiboflavin = riboflavin;
                            _nutritionNiacin = niacin;
                            _nutritionFolate = folate;
                            _nutritionBiotin = biotin;
                            _nutritionPantothenicAcid = pantothenicAcid;
                            _nutritionCalcium = calcium;
                            _nutritionIron = iron;
                            _nutritionMagnesium = magnesium;
                            _nutritionManganese = manganese;
                            _nutritionPhosphorus = phosphorus;
                            _nutritionPotassium = potassium;
                            _nutritionSelenium = selenium;
                            _nutritionSodium = sodium;
                            _nutritionZinc = zinc;
                            _nutritionCaffeine = caffeine;
                          });
                        },
                  )
                else if (widget.dataType is BloodPressureHealthDataType)
                  BloodPressureFormField(
                    onChanged:
                        ({
                          required systolic,
                          required diastolic,
                        }) {
                          setState(() {
                            _systolic = systolic;
                            _diastolic = diastolic;
                          });
                        },
                  )
                else ...[
                  HealthValueField(
                    dataType: widget.dataType,
                    onChanged: (value) {
                      setState(() {
                        _value = value;
                      });
                    },
                  ),
                  // Food name and meal type fields for nutrient records
                  if (_config is NutrientFormConfig) ...[
                    const SizedBox(height: 16),
                    TextFormField(
                      initialValue: _foodName,
                      decoration: const InputDecoration(
                        labelText: AppTexts.foodNameOptional,
                        border: OutlineInputBorder(),
                        helperText: AppTexts.foodNameOptionalHelper,
                      ),
                      onChanged: (value) {
                        setState(() {
                          _foodName = value.isEmpty ? null : value;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    MealTypeDropdownField(
                      value: _mealType,
                      onChanged: (type) {
                        setState(() {
                          _mealType = type ?? MealType.unknown;
                        });
                      },
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
                      labelText: 'Title (optional)',
                      border: OutlineInputBorder(),
                      helperText: 'Optional title for the sleep record',
                    ),
                    onChanged: (value) {
                      setState(() {
                        _sleepTitle = value.isEmpty ? null : value;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    initialValue: _sleepNotes,
                    decoration: const InputDecoration(
                      labelText: 'Notes (optional)',
                      border: OutlineInputBorder(),
                      helperText: 'Optional notes about the sleep record',
                    ),
                    maxLines: 3,
                    onChanged: (value) {
                      setState(() {
                        _sleepNotes = value.isEmpty ? null : value;
                      });
                    },
                  ),
                ],
                const SizedBox(height: 16),
                MetadataFormFields(
                  healthPlatform: _notifier.healthPlatform,
                  initialRecordingMethod: _recordingMethod,
                  initialDevice: _device,
                  onRecordingMethodChanged: (method) {
                    setState(() {
                      _recordingMethod = method ?? RecordingMethod.unknown;
                    });
                  },
                  onDeviceChanged: (device) {
                    setState(() {
                      _device = device;
                    });
                  },
                  recordingMethodValidator: (value) {
                    if (value == null) {
                      return AppTexts.pleaseSelectRecordingMethod;
                    }
                    return null;
                  },
                  deviceTypeValidator: (value) {
                    if (value == null) {
                      return AppTexts.pleaseSelectDeviceType;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _isWriting ? null : _submitRecord,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16.0),
                  ),
                  child: const Text(AppTexts.save),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
