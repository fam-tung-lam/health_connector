import 'package:flutter/material.dart' hide Velocity;
import 'package:health_connector/health_connector.dart'
    show
        ActiveCaloriesBurnedHealthDataType,
        BiotinNutrientDataType,
        BloodPressureHealthDataType,
        BodyFatPercentageHealthDataType,
        BodyTemperatureHealthDataType,
        CaffeineNutrientDataType,
        CalciumNutrientDataType,
        CholesterolNutrientDataType,
        DietaryFiberNutrientDataType,
        DiastolicBloodPressureHealthDataType,
        DistanceHealthDataType,
        CrossCountrySkiingDistanceDataType,
        CyclingDistanceDataType,
        DownhillSnowSportsDistanceDataType,
        PaddleSportsDistanceDataType,
        RowingDistanceDataType,
        SixMinuteWalkTestDistanceDataType,
        SkatingSportsDistanceDataType,
        SwimmingDistanceDataType,
        WheelchairDistanceDataType,
        WalkingRunningDistanceDataType,
        Energy,
        EnergyNutrientDataType,
        FloorsClimbedHealthDataType,
        FolateNutrientDataType,
        HealthDataType,
        HeartRateMeasurementRecordHealthDataType,
        HeartRateSeriesRecordHealthDataType,
        HeightHealthDataType,
        HydrationHealthDataType,
        IronNutrientDataType,
        LeanBodyMassHealthDataType,
        Length,
        MagnesiumNutrientDataType,
        ManganeseNutrientDataType,
        Mass,
        MeasurementUnit,
        MonounsaturatedFatNutrientDataType,
        NiacinNutrientDataType,
        Number,
        NutritionHealthDataType,
        PantothenicAcidNutrientDataType,
        Percentage,
        PhosphorusNutrientDataType,
        PolyunsaturatedFatNutrientDataType,
        PotassiumNutrientDataType,
        Pressure,
        ProteinNutrientDataType,
        RiboflavinNutrientDataType,
        RestingHeartRateHealthDataType,
        SaturatedFatNutrientDataType,
        SeleniumNutrientDataType,
        SodiumNutrientDataType,
        StepsHealthDataType,
        SugarNutrientDataType,
        SystolicBloodPressureHealthDataType,
        Temperature,
        ThiaminNutrientDataType,
        TotalCarbohydrateNutrientDataType,
        TotalFatNutrientDataType,
        Volume,
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
        OxygenSaturationHealthDataType,
        RespiratoryRateHealthDataType,
        BloodGlucose,
        BloodGlucoseHealthDataType,
        Vo2MaxHealthDataType,
        SpeedSeriesDataType,
        Velocity,
        WalkingSpeedDataType,
        RunningSpeedDataType,
        StairAscentSpeedDataType,
        StairDescentSpeedDataType;
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';

/// A widget that renders the appropriate value input field based on
/// the health data type.
///
/// This widget handles the data-type-specific input requirements:
/// - Integer input for step count (Count)
/// - Decimal input for weight (Mass in kg)
/// - Decimal input for distance (Length in meters)
@immutable
final class HealthValueField extends StatefulWidget {
  const HealthValueField({
    required this.dataType,
    required this.onChanged,
    super.key,
    this.validator,
  });

  /// The health data type that determines which input field to render.
  final HealthDataType dataType;

  /// Callback when the value changes.
  ///
  /// Provides a [MeasurementUnit] object (e.g., [Number], [Mass]) or null
  /// if the input is invalid or empty.
  final ValueChanged<MeasurementUnit?> onChanged;

  /// Validator for the value field.
  final String? Function(MeasurementUnit?)? validator;

  @override
  State<HealthValueField> createState() => _HealthValueFieldState();
}

class _HealthValueFieldState extends State<HealthValueField> {
  late final TextEditingController _controller;
  MeasurementUnit? _value;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    setState(() {
      if (value.isEmpty) {
        _value = null;
      } else {
        _value = switch (widget.dataType) {
          StepsHealthDataType() => _parseCount(value),
          WeightHealthDataType() => _parseMass(value),
          HeightHealthDataType() => _parseLength(value),
          BodyFatPercentageHealthDataType() => _parseBodyFatPercentage(value),
          LeanBodyMassHealthDataType() => _parseMass(value),
          BodyTemperatureHealthDataType() => _parseTemperature(value),
          BloodPressureHealthDataType() => throw UnsupportedError(
            'BloodPressureHealthDataType requires custom form handling',
          ),
          SystolicBloodPressureHealthDataType() => _parsePressure(value),
          DiastolicBloodPressureHealthDataType() => _parsePressure(value),
          DistanceHealthDataType() => _parseLength(value),
          CrossCountrySkiingDistanceDataType() => _parseLength(value),
          CyclingDistanceDataType() => _parseLength(value),
          DownhillSnowSportsDistanceDataType() => _parseLength(value),
          PaddleSportsDistanceDataType() => _parseLength(value),
          RowingDistanceDataType() => _parseLength(value),
          SixMinuteWalkTestDistanceDataType() => _parseLength(value),
          SkatingSportsDistanceDataType() => _parseLength(value),
          SwimmingDistanceDataType() => _parseLength(value),
          WheelchairDistanceDataType() => _parseLength(value),
          WalkingRunningDistanceDataType() => _parseLength(value),
          ActiveCaloriesBurnedHealthDataType() => _parseEnergy(value),
          FloorsClimbedHealthDataType() => _parseCount(value),
          WheelchairPushesHealthDataType() => _parseCount(value),
          HydrationHealthDataType() => _parseVolume(value),
          OxygenSaturationHealthDataType() => _parseBodyFatPercentage(value),
          HeartRateMeasurementRecordHealthDataType() => _parseCount(value),
          HeartRateSeriesRecordHealthDataType() => throw UnsupportedError(
            'HeartRateSeriesRecordHealthDataType '
            'should use HeartRateSamplesFormField',
          ),
          SleepSessionHealthDataType() => throw UnsupportedError(
            'SleepSessionHealthDataType requires custom form handling',
          ),
          SleepStageHealthDataType() => throw UnsupportedError(
            'SleepStageHealthDataType requires custom form handling',
          ),
          RestingHeartRateHealthDataType() => _parseCount(value),
          RespiratoryRateHealthDataType() => _parseCount(value),
          Vo2MaxHealthDataType() => _parseVo2Max(value),
          BloodGlucoseHealthDataType() => _parseBloodGlucose(value),

          EnergyNutrientDataType() => _parseEnergy(value),
          CaffeineNutrientDataType() => _parseMass(value),
          ProteinNutrientDataType() => _parseMass(value),
          TotalCarbohydrateNutrientDataType() => _parseMass(value),
          TotalFatNutrientDataType() => _parseMass(value),
          SaturatedFatNutrientDataType() => _parseMass(value),
          MonounsaturatedFatNutrientDataType() => _parseMass(value),
          PolyunsaturatedFatNutrientDataType() => _parseMass(value),
          CholesterolNutrientDataType() => _parseMass(value),
          DietaryFiberNutrientDataType() => _parseMass(value),
          SugarNutrientDataType() => _parseMass(value),
          CalciumNutrientDataType() => _parseMass(value),
          IronNutrientDataType() => _parseMass(value),
          MagnesiumNutrientDataType() => _parseMass(value),
          ManganeseNutrientDataType() => _parseMass(value),
          PhosphorusNutrientDataType() => _parseMass(value),
          PotassiumNutrientDataType() => _parseMass(value),
          SeleniumNutrientDataType() => _parseMass(value),
          SodiumNutrientDataType() => _parseMass(value),
          ZincNutrientDataType() => _parseMass(value),
          VitaminANutrientDataType() => _parseMass(value),
          VitaminB6NutrientDataType() => _parseMass(value),
          VitaminB12NutrientDataType() => _parseMass(value),
          VitaminCNutrientDataType() => _parseMass(value),
          VitaminDNutrientDataType() => _parseMass(value),
          VitaminENutrientDataType() => _parseMass(value),
          VitaminKNutrientDataType() => _parseMass(value),
          ThiaminNutrientDataType() => _parseMass(value),
          RiboflavinNutrientDataType() => _parseMass(value),
          NiacinNutrientDataType() => _parseMass(value),
          FolateNutrientDataType() => _parseMass(value),
          BiotinNutrientDataType() => _parseMass(value),
          PantothenicAcidNutrientDataType() => _parseMass(value),
          NutritionHealthDataType() => throw UnsupportedError(
            'NutritionHealthDataType requires NutritionFormField',
          ),
          SpeedSeriesDataType() => throw UnsupportedError(
            'SpeedHealthDataType requires samples. '
            'Use HeartRateSamplesFormField pattern',
          ),
          WalkingSpeedDataType() ||
          RunningSpeedDataType() ||
          StairAscentSpeedDataType() ||
          StairDescentSpeedDataType() => _parseVelocity(value),
        };
      }
    });
    widget.onChanged(_value);
  }

  Number? _parseCount(String value) {
    final count = int.tryParse(value);
    if (count != null && count >= 0) {
      return Number(count);
    }
    return null;
  }

  Mass? _parseMass(String value) {
    final weightValue = double.tryParse(value);
    if (weightValue != null && weightValue > 0) {
      // Use kilograms for Weight and LeanBodyMass,
      // grams for all nutrient data types
      if (widget.dataType is WeightHealthDataType ||
          widget.dataType is LeanBodyMassHealthDataType) {
        return Mass.kilograms(weightValue);
      } else {
        // All nutrient data types should use grams
        return Mass.grams(weightValue);
      }
    }
    return null;
  }

  Length? _parseLength(String value) {
    final distanceValue = double.tryParse(value);
    if (distanceValue != null && distanceValue > 0) {
      return Length.meters(distanceValue);
    }
    return null;
  }

  Energy? _parseEnergy(String value) {
    final energyValue = double.tryParse(value);
    if (energyValue != null && energyValue > 0) {
      return Energy.kilocalories(energyValue);
    }
    return null;
  }

  Percentage? _parseBodyFatPercentage(String value) {
    final percentageValue = double.tryParse(value);
    if (percentageValue != null &&
        percentageValue >= 0 &&
        percentageValue <= 100) {
      // Convert percentage (0-100) to Percentage type
      return Percentage.fromWhole(percentageValue);
    }
    return null;
  }

  Temperature? _parseTemperature(String value) {
    final tempValue = double.tryParse(value);
    if (tempValue != null) {
      return Temperature.celsius(tempValue);
    }
    return null;
  }

  Pressure? _parsePressure(String value) {
    final pressureValue = double.tryParse(value);
    if (pressureValue != null && pressureValue > 0) {
      return Pressure.millimetersOfMercury(pressureValue);
    }
    return null;
  }

  Volume? _parseVolume(String value) {
    final volumeValue = double.tryParse(value);
    if (volumeValue != null && volumeValue > 0) {
      return Volume.liters(volumeValue);
    }
    return null;
  }

  Number? _parseVo2Max(String value) {
    final val = double.tryParse(value);
    if (val != null && val >= 0) {
      return Number(val);
    }
    return null;
  }

  BloodGlucose? _parseBloodGlucose(String value) {
    final val = double.tryParse(value);
    if (val != null && val > 0) {
      return BloodGlucose.milligramsPerDeciliter(val);
    }
    return null;
  }

  Velocity? _parseVelocity(String value) {
    final speedValue = double.tryParse(value);
    if (speedValue != null && speedValue > 0) {
      return Velocity.metersPerSecond(speedValue);
    }
    return null;
  }

  String? _validate(String? value) {
    if (value == null || value.isEmpty) {
      return switch (widget.dataType) {
        StepsHealthDataType() => AppTexts.pleaseEnterStepCount,
        WeightHealthDataType() => AppTexts.pleaseEnterWeight,
        HeightHealthDataType() => AppTexts.pleaseEnterHeight,
        BodyFatPercentageHealthDataType() =>
          AppTexts.pleaseEnterBodyFatPercentage,
        LeanBodyMassHealthDataType() => AppTexts.pleaseEnterLeanBodyMass,
        BodyTemperatureHealthDataType() => AppTexts.pleaseEnterBodyTemperature,
        BloodPressureHealthDataType() => throw UnsupportedError(
          'BloodPressureHealthDataType requires custom form handling',
        ),
        SystolicBloodPressureHealthDataType() =>
          AppTexts.pleaseEnterSystolicBloodPressure,
        DiastolicBloodPressureHealthDataType() =>
          AppTexts.pleaseEnterDiastolicBloodPressure,
        DistanceHealthDataType() => AppTexts.pleaseEnterDistance,
        CrossCountrySkiingDistanceDataType() => AppTexts.pleaseEnterDistance,
        CyclingDistanceDataType() => AppTexts.pleaseEnterDistance,
        DownhillSnowSportsDistanceDataType() => AppTexts.pleaseEnterDistance,
        PaddleSportsDistanceDataType() => AppTexts.pleaseEnterDistance,
        RowingDistanceDataType() => AppTexts.pleaseEnterDistance,
        SixMinuteWalkTestDistanceDataType() => AppTexts.pleaseEnterDistance,
        SkatingSportsDistanceDataType() => AppTexts.pleaseEnterDistance,
        SwimmingDistanceDataType() => AppTexts.pleaseEnterDistance,
        WheelchairDistanceDataType() => AppTexts.pleaseEnterDistance,
        WalkingRunningDistanceDataType() => AppTexts.pleaseEnterDistance,
        ActiveCaloriesBurnedHealthDataType() =>
          AppTexts.pleaseEnterActiveCaloriesBurned,
        FloorsClimbedHealthDataType() => AppTexts.pleaseEnterFloorsClimbed,
        WheelchairPushesHealthDataType() =>
          AppTexts.pleaseEnterWheelchairPushes,
        HydrationHealthDataType() => AppTexts.pleaseEnterHydration,
        OxygenSaturationHealthDataType() =>
          AppTexts.pleaseEnterOxygenSaturation,
        HeartRateMeasurementRecordHealthDataType() =>
          AppTexts.pleaseEnterHeartRate,
        HeartRateSeriesRecordHealthDataType() => throw UnsupportedError(
          'HeartRateSeriesRecordHealthDataType '
          'should use HeartRateSamplesFormField',
        ),
        SleepSessionHealthDataType() => throw UnsupportedError(
          'SleepSessionHealthDataType requires custom form handling',
        ),
        SleepStageHealthDataType() => throw UnsupportedError(
          'SleepStageHealthDataType requires custom form handling',
        ),
        RestingHeartRateHealthDataType() => AppTexts.pleaseEnterHeartRate,
        RespiratoryRateHealthDataType() => AppTexts.pleaseEnterRespiratoryRate,
        Vo2MaxHealthDataType() => AppTexts.pleaseEnterVo2Max,
        BloodGlucoseHealthDataType() => AppTexts.pleaseEnterBloodGlucose,

        EnergyNutrientDataType() => AppTexts.pleaseEnterEnergy,
        CaffeineNutrientDataType() => AppTexts.pleaseEnterCaffeine,
        ProteinNutrientDataType() => AppTexts.pleaseEnterProtein,
        TotalCarbohydrateNutrientDataType() =>
          AppTexts.pleaseEnterTotalCarbohydrate,
        TotalFatNutrientDataType() => AppTexts.pleaseEnterTotalFat,
        SaturatedFatNutrientDataType() => AppTexts.pleaseEnterSaturatedFat,
        MonounsaturatedFatNutrientDataType() =>
          AppTexts.pleaseEnterMonounsaturatedFat,
        PolyunsaturatedFatNutrientDataType() =>
          AppTexts.pleaseEnterPolyunsaturatedFat,
        CholesterolNutrientDataType() => AppTexts.pleaseEnterCholesterol,
        DietaryFiberNutrientDataType() => AppTexts.pleaseEnterDietaryFiber,
        SugarNutrientDataType() => AppTexts.pleaseEnterSugar,
        CalciumNutrientDataType() => AppTexts.pleaseEnterCalcium,
        IronNutrientDataType() => AppTexts.pleaseEnterIron,
        MagnesiumNutrientDataType() => AppTexts.pleaseEnterMagnesium,
        ManganeseNutrientDataType() => AppTexts.pleaseEnterManganese,
        PhosphorusNutrientDataType() => AppTexts.pleaseEnterPhosphorus,
        PotassiumNutrientDataType() => AppTexts.pleaseEnterPotassium,
        SeleniumNutrientDataType() => AppTexts.pleaseEnterSelenium,
        SodiumNutrientDataType() => AppTexts.pleaseEnterSodium,
        ZincNutrientDataType() => AppTexts.pleaseEnterZinc,
        VitaminANutrientDataType() => AppTexts.pleaseEnterVitaminA,
        VitaminB6NutrientDataType() => AppTexts.pleaseEnterVitaminB6,
        VitaminB12NutrientDataType() => AppTexts.pleaseEnterVitaminB12,
        VitaminCNutrientDataType() => AppTexts.pleaseEnterVitaminC,
        VitaminDNutrientDataType() => AppTexts.pleaseEnterVitaminD,
        VitaminENutrientDataType() => AppTexts.pleaseEnterVitaminE,
        VitaminKNutrientDataType() => AppTexts.pleaseEnterVitaminK,
        ThiaminNutrientDataType() => AppTexts.pleaseEnterThiamin,
        RiboflavinNutrientDataType() => AppTexts.pleaseEnterRiboflavin,
        NiacinNutrientDataType() => AppTexts.pleaseEnterNiacin,
        FolateNutrientDataType() => AppTexts.pleaseEnterFolate,
        BiotinNutrientDataType() => AppTexts.pleaseEnterBiotin,
        PantothenicAcidNutrientDataType() =>
          AppTexts.pleaseEnterPantothenicAcid,
        NutritionHealthDataType() => throw UnsupportedError(
          'NutritionHealthDataType requires NutritionFormField',
        ),
        SpeedSeriesDataType() => throw UnsupportedError(
          'SpeedHealthDataType requires samples',
        ),
        WalkingSpeedDataType() ||
        RunningSpeedDataType() ||
        StairAscentSpeedDataType() ||
        StairDescentSpeedDataType() => 'Please enter speed value',
      };
    }

    final parsed = switch (widget.dataType) {
      StepsHealthDataType() => int.tryParse(value),
      WeightHealthDataType() => double.tryParse(value),
      HeightHealthDataType() => double.tryParse(value),
      BodyFatPercentageHealthDataType() => double.tryParse(value),
      LeanBodyMassHealthDataType() => double.tryParse(value),
      BodyTemperatureHealthDataType() => double.tryParse(value),
      BloodPressureHealthDataType() => throw UnsupportedError(
        'BloodPressureHealthDataType requires custom form handling',
      ),
      SystolicBloodPressureHealthDataType() => double.tryParse(value),
      DiastolicBloodPressureHealthDataType() => double.tryParse(value),
      DistanceHealthDataType() => double.tryParse(value),
      CrossCountrySkiingDistanceDataType() => double.tryParse(value),
      CyclingDistanceDataType() => double.tryParse(value),
      DownhillSnowSportsDistanceDataType() => double.tryParse(value),
      PaddleSportsDistanceDataType() => double.tryParse(value),
      RowingDistanceDataType() => double.tryParse(value),
      SixMinuteWalkTestDistanceDataType() => double.tryParse(value),
      SkatingSportsDistanceDataType() => double.tryParse(value),
      SwimmingDistanceDataType() => double.tryParse(value),
      WheelchairDistanceDataType() => double.tryParse(value),
      WalkingRunningDistanceDataType() => double.tryParse(value),
      ActiveCaloriesBurnedHealthDataType() => double.tryParse(value),
      FloorsClimbedHealthDataType() => int.tryParse(value),
      WheelchairPushesHealthDataType() => int.tryParse(value),
      HydrationHealthDataType() => double.tryParse(value),
      OxygenSaturationHealthDataType() => double.tryParse(value),
      HeartRateMeasurementRecordHealthDataType() => int.tryParse(value),
      HeartRateSeriesRecordHealthDataType() => throw UnsupportedError(
        'HeartRateSeriesRecordHealthDataType should '
        'use HeartRateSamplesFormField',
      ),
      SleepSessionHealthDataType() => throw UnsupportedError(
        'SleepSessionHealthDataType requires custom form handling',
      ),
      SleepStageHealthDataType() => throw UnsupportedError(
        'SleepStageHealthDataType requires custom form handling',
      ),
      RestingHeartRateHealthDataType() => int.tryParse(value),
      RespiratoryRateHealthDataType() => double.tryParse(value),
      Vo2MaxHealthDataType() => double.tryParse(value),
      BloodGlucoseHealthDataType() => double.tryParse(value),

      EnergyNutrientDataType() => double.tryParse(value),
      CaffeineNutrientDataType() => double.tryParse(value),
      ProteinNutrientDataType() => double.tryParse(value),
      TotalCarbohydrateNutrientDataType() => double.tryParse(value),
      TotalFatNutrientDataType() => double.tryParse(value),
      SaturatedFatNutrientDataType() => double.tryParse(value),
      MonounsaturatedFatNutrientDataType() => double.tryParse(value),
      PolyunsaturatedFatNutrientDataType() => double.tryParse(value),
      CholesterolNutrientDataType() => double.tryParse(value),
      DietaryFiberNutrientDataType() => double.tryParse(value),
      SugarNutrientDataType() => double.tryParse(value),
      CalciumNutrientDataType() => double.tryParse(value),
      IronNutrientDataType() => double.tryParse(value),
      MagnesiumNutrientDataType() => double.tryParse(value),
      ManganeseNutrientDataType() => double.tryParse(value),
      PhosphorusNutrientDataType() => double.tryParse(value),
      PotassiumNutrientDataType() => double.tryParse(value),
      SeleniumNutrientDataType() => double.tryParse(value),
      SodiumNutrientDataType() => double.tryParse(value),
      ZincNutrientDataType() => double.tryParse(value),
      VitaminANutrientDataType() => double.tryParse(value),
      VitaminB6NutrientDataType() => double.tryParse(value),
      VitaminB12NutrientDataType() => double.tryParse(value),
      VitaminCNutrientDataType() => double.tryParse(value),
      VitaminDNutrientDataType() => double.tryParse(value),
      VitaminENutrientDataType() => double.tryParse(value),
      VitaminKNutrientDataType() => double.tryParse(value),
      ThiaminNutrientDataType() => double.tryParse(value),
      RiboflavinNutrientDataType() => double.tryParse(value),
      NiacinNutrientDataType() => double.tryParse(value),
      FolateNutrientDataType() => double.tryParse(value),
      BiotinNutrientDataType() => double.tryParse(value),
      PantothenicAcidNutrientDataType() => double.tryParse(value),
      NutritionHealthDataType() => throw UnsupportedError(
        'NutritionHealthDataType requires NutritionFormField',
      ),
      SpeedSeriesDataType() => throw UnsupportedError(
        'SpeedHealthDataType requires samples',
      ),
      WalkingSpeedDataType() ||
      RunningSpeedDataType() ||
      StairAscentSpeedDataType() ||
      StairDescentSpeedDataType() => double.tryParse(value),
    };

    if (parsed == null) {
      return AppTexts.pleaseEnterValidNumber;
    }

    final validationError = switch (widget.dataType) {
      StepsHealthDataType() =>
        (parsed as int) < 0 ? AppTexts.countMustBeNonNegative : null,
      FloorsClimbedHealthDataType() =>
        (parsed as int) < 0 ? AppTexts.floorsClimbedMustBeNonNegative : null,
      WheelchairPushesHealthDataType() =>
        (parsed as int) < 0 ? AppTexts.wheelchairPushesMustBeNonNegative : null,
      HeartRateMeasurementRecordHealthDataType() =>
        (parsed as int) < 0 ? AppTexts.heartRateMustBePositive : null,
      RestingHeartRateHealthDataType() =>
        (parsed as int) < 0 ? AppTexts.heartRateMustBePositive : null,
      RespiratoryRateHealthDataType() =>
        (parsed as double) < 0 ? AppTexts.respiratoryRateMustBePositive : null,
      Vo2MaxHealthDataType() =>
        (parsed as double) < 0 ? AppTexts.vo2MaxMustBePositive : null,
      WeightHealthDataType() =>
        (parsed as double) <= 0 ? AppTexts.weightMustBeGreaterThanZero : null,
      HeightHealthDataType() =>
        (parsed as double) <= 0 ? AppTexts.heightMustBeGreaterThanZero : null,
      LeanBodyMassHealthDataType() =>
        (parsed as double) <= 0
            ? AppTexts.leanBodyMassMustBeGreaterThanZero
            : null,
      BodyTemperatureHealthDataType() => null,
      // Temperature can be any valid number (including negative for very cold)
      // No specific validation needed beyond being a valid number
      BloodPressureHealthDataType() => throw UnsupportedError(
        'BloodPressureHealthDataType requires custom form handling',
      ),
      SystolicBloodPressureHealthDataType() =>
        (parsed as double) <= 0
            ? AppTexts.systolicBloodPressureMustBeGreaterThanZero
            : null,
      DiastolicBloodPressureHealthDataType() =>
        (parsed as double) <= 0
            ? AppTexts.diastolicBloodPressureMustBeGreaterThanZero
            : null,
      BodyFatPercentageHealthDataType() => () {
        final percentage = parsed as double;
        return (percentage < 0 || percentage > 100)
            ? AppTexts.bodyFatPercentageMustBeBetween0And100
            : null;
      }(),
      OxygenSaturationHealthDataType() => () {
        final percentage = parsed as double;
        return (percentage < 0 || percentage > 100)
            ? AppTexts.oxygenSaturationMustBeBetween0And100
            : null;
      }(),
      DistanceHealthDataType() =>
        (parsed as double) <= 0 ? AppTexts.distanceMustBeGreaterThanZero : null,
      CrossCountrySkiingDistanceDataType() =>
        (parsed as double) <= 0 ? AppTexts.distanceMustBeGreaterThanZero : null,
      CyclingDistanceDataType() =>
        (parsed as double) <= 0 ? AppTexts.distanceMustBeGreaterThanZero : null,
      DownhillSnowSportsDistanceDataType() =>
        (parsed as double) <= 0 ? AppTexts.distanceMustBeGreaterThanZero : null,
      PaddleSportsDistanceDataType() =>
        (parsed as double) <= 0 ? AppTexts.distanceMustBeGreaterThanZero : null,
      RowingDistanceDataType() =>
        (parsed as double) <= 0 ? AppTexts.distanceMustBeGreaterThanZero : null,
      SixMinuteWalkTestDistanceDataType() =>
        (parsed as double) <= 0 ? AppTexts.distanceMustBeGreaterThanZero : null,
      SkatingSportsDistanceDataType() =>
        (parsed as double) <= 0 ? AppTexts.distanceMustBeGreaterThanZero : null,
      SwimmingDistanceDataType() =>
        (parsed as double) <= 0 ? AppTexts.distanceMustBeGreaterThanZero : null,
      WheelchairDistanceDataType() =>
        (parsed as double) <= 0 ? AppTexts.distanceMustBeGreaterThanZero : null,
      WalkingRunningDistanceDataType() =>
        (parsed as double) <= 0 ? AppTexts.distanceMustBeGreaterThanZero : null,
      ActiveCaloriesBurnedHealthDataType() =>
        (parsed as double) <= 0
            ? AppTexts.activeCaloriesBurnedMustBeGreaterThanZero
            : null,
      HydrationHealthDataType() =>
        (parsed as double) <= 0
            ? AppTexts.hydrationMustBeGreaterThanZero
            : null,
      EnergyNutrientDataType() =>
        (parsed as double) <= 0 ? AppTexts.pleaseEnterValidNumber : null,
      CaffeineNutrientDataType() =>
        (parsed as double) <= 0 ? AppTexts.pleaseEnterValidNumber : null,
      ProteinNutrientDataType() =>
        (parsed as double) <= 0 ? AppTexts.pleaseEnterValidNumber : null,
      TotalCarbohydrateNutrientDataType() =>
        (parsed as double) <= 0 ? AppTexts.pleaseEnterValidNumber : null,
      TotalFatNutrientDataType() =>
        (parsed as double) <= 0 ? AppTexts.pleaseEnterValidNumber : null,
      SaturatedFatNutrientDataType() =>
        (parsed as double) <= 0 ? AppTexts.pleaseEnterValidNumber : null,
      MonounsaturatedFatNutrientDataType() =>
        (parsed as double) <= 0 ? AppTexts.pleaseEnterValidNumber : null,
      PolyunsaturatedFatNutrientDataType() =>
        (parsed as double) <= 0 ? AppTexts.pleaseEnterValidNumber : null,
      CholesterolNutrientDataType() =>
        (parsed as double) <= 0 ? AppTexts.pleaseEnterValidNumber : null,
      DietaryFiberNutrientDataType() =>
        (parsed as double) <= 0 ? AppTexts.pleaseEnterValidNumber : null,
      SugarNutrientDataType() =>
        (parsed as double) <= 0 ? AppTexts.pleaseEnterValidNumber : null,
      CalciumNutrientDataType() =>
        (parsed as double) <= 0 ? AppTexts.pleaseEnterValidNumber : null,
      IronNutrientDataType() =>
        (parsed as double) <= 0 ? AppTexts.pleaseEnterValidNumber : null,
      MagnesiumNutrientDataType() =>
        (parsed as double) <= 0 ? AppTexts.pleaseEnterValidNumber : null,
      ManganeseNutrientDataType() =>
        (parsed as double) <= 0 ? AppTexts.pleaseEnterValidNumber : null,
      PhosphorusNutrientDataType() =>
        (parsed as double) <= 0 ? AppTexts.pleaseEnterValidNumber : null,
      PotassiumNutrientDataType() =>
        (parsed as double) <= 0 ? AppTexts.pleaseEnterValidNumber : null,
      SeleniumNutrientDataType() =>
        (parsed as double) <= 0 ? AppTexts.pleaseEnterValidNumber : null,
      SodiumNutrientDataType() =>
        (parsed as double) <= 0 ? AppTexts.pleaseEnterValidNumber : null,
      ZincNutrientDataType() =>
        (parsed as double) <= 0 ? AppTexts.pleaseEnterValidNumber : null,
      VitaminANutrientDataType() =>
        (parsed as double) <= 0 ? AppTexts.pleaseEnterValidNumber : null,
      VitaminB6NutrientDataType() =>
        (parsed as double) <= 0 ? AppTexts.pleaseEnterValidNumber : null,
      VitaminB12NutrientDataType() =>
        (parsed as double) <= 0 ? AppTexts.pleaseEnterValidNumber : null,
      VitaminCNutrientDataType() =>
        (parsed as double) <= 0 ? AppTexts.pleaseEnterValidNumber : null,
      VitaminDNutrientDataType() =>
        (parsed as double) <= 0 ? AppTexts.pleaseEnterValidNumber : null,
      VitaminENutrientDataType() =>
        (parsed as double) <= 0 ? AppTexts.pleaseEnterValidNumber : null,
      VitaminKNutrientDataType() =>
        (parsed as double) <= 0 ? AppTexts.pleaseEnterValidNumber : null,
      ThiaminNutrientDataType() =>
        (parsed as double) <= 0 ? AppTexts.pleaseEnterValidNumber : null,
      RiboflavinNutrientDataType() =>
        (parsed as double) <= 0 ? AppTexts.pleaseEnterValidNumber : null,
      NiacinNutrientDataType() =>
        (parsed as double) <= 0 ? AppTexts.pleaseEnterValidNumber : null,
      FolateNutrientDataType() =>
        (parsed as double) <= 0 ? AppTexts.pleaseEnterValidNumber : null,
      BiotinNutrientDataType() =>
        (parsed as double) <= 0 ? AppTexts.pleaseEnterValidNumber : null,
      PantothenicAcidNutrientDataType() =>
        (parsed as double) <= 0 ? AppTexts.pleaseEnterValidNumber : null,
      HeartRateSeriesRecordHealthDataType() => throw UnsupportedError(
        'HeartRateSeriesRecordHealthDataType should '
        'use HeartRateSamplesFormField',
      ),
      SleepSessionHealthDataType() => throw UnsupportedError(
        'SleepSessionHealthDataType requires custom form handling',
      ),
      SleepStageHealthDataType() => throw UnsupportedError(
        'SleepStageHealthDataType requires custom form handling',
      ),
      BloodGlucoseHealthDataType() =>
        (parsed as double) <= 0
            ? AppTexts.bloodGlucoseMustBeGreaterThanZero
            : null,

      NutritionHealthDataType() => throw UnsupportedError(
        'NutritionHealthDataType requires NutritionFormField',
      ),
      SpeedSeriesDataType() => null, // Series record, no validation
      WalkingSpeedDataType() ||
      RunningSpeedDataType() ||
      StairAscentSpeedDataType() ||
      StairDescentSpeedDataType() => null,
    };

    if (validationError != null) {
      return validationError;
    }

    if (_value == null) {
      return switch (widget.dataType) {
        StepsHealthDataType() => AppTexts.pleaseEnterStepCount,
        WeightHealthDataType() => AppTexts.pleaseEnterWeight,
        HeightHealthDataType() => AppTexts.pleaseEnterHeight,
        BodyFatPercentageHealthDataType() =>
          AppTexts.pleaseEnterBodyFatPercentage,
        LeanBodyMassHealthDataType() => AppTexts.pleaseEnterLeanBodyMass,
        BodyTemperatureHealthDataType() => AppTexts.pleaseEnterBodyTemperature,
        BloodPressureHealthDataType() => throw UnsupportedError(
          'BloodPressureHealthDataType requires custom form handling',
        ),
        SystolicBloodPressureHealthDataType() =>
          AppTexts.pleaseEnterSystolicBloodPressure,
        DiastolicBloodPressureHealthDataType() =>
          AppTexts.pleaseEnterDiastolicBloodPressure,
        DistanceHealthDataType() => AppTexts.pleaseEnterDistance,
        CrossCountrySkiingDistanceDataType() => AppTexts.pleaseEnterDistance,
        CyclingDistanceDataType() => AppTexts.pleaseEnterDistance,
        DownhillSnowSportsDistanceDataType() => AppTexts.pleaseEnterDistance,
        PaddleSportsDistanceDataType() => AppTexts.pleaseEnterDistance,
        RowingDistanceDataType() => AppTexts.pleaseEnterDistance,
        SixMinuteWalkTestDistanceDataType() => AppTexts.pleaseEnterDistance,
        SkatingSportsDistanceDataType() => AppTexts.pleaseEnterDistance,
        SwimmingDistanceDataType() => AppTexts.pleaseEnterDistance,
        WheelchairDistanceDataType() => AppTexts.pleaseEnterDistance,
        WalkingRunningDistanceDataType() => AppTexts.pleaseEnterDistance,
        ActiveCaloriesBurnedHealthDataType() =>
          AppTexts.pleaseEnterActiveCaloriesBurned,
        FloorsClimbedHealthDataType() => AppTexts.pleaseEnterFloorsClimbed,
        WheelchairPushesHealthDataType() =>
          AppTexts.pleaseEnterWheelchairPushes,
        HydrationHealthDataType() => AppTexts.pleaseEnterHydration,
        OxygenSaturationHealthDataType() =>
          AppTexts.pleaseEnterOxygenSaturation,
        HeartRateMeasurementRecordHealthDataType() =>
          AppTexts.pleaseEnterHeartRate,
        HeartRateSeriesRecordHealthDataType() => throw UnsupportedError(
          'HeartRateSeriesRecordHealthDataType should use '
          'HeartRateSamplesFormField',
        ),
        SleepSessionHealthDataType() => throw UnsupportedError(
          'SleepSessionHealthDataType requires custom form handling',
        ),
        SleepStageHealthDataType() => throw UnsupportedError(
          'SleepStageHealthDataType requires custom form handling',
        ),
        RestingHeartRateHealthDataType() => AppTexts.pleaseEnterHeartRate,
        RespiratoryRateHealthDataType() => AppTexts.pleaseEnterRespiratoryRate,

        EnergyNutrientDataType() => AppTexts.pleaseEnterEnergy,
        CaffeineNutrientDataType() => AppTexts.pleaseEnterCaffeine,
        ProteinNutrientDataType() => AppTexts.pleaseEnterProtein,
        TotalCarbohydrateNutrientDataType() =>
          AppTexts.pleaseEnterTotalCarbohydrate,
        TotalFatNutrientDataType() => AppTexts.pleaseEnterTotalFat,
        SaturatedFatNutrientDataType() => AppTexts.pleaseEnterSaturatedFat,
        MonounsaturatedFatNutrientDataType() =>
          AppTexts.pleaseEnterMonounsaturatedFat,
        PolyunsaturatedFatNutrientDataType() =>
          AppTexts.pleaseEnterPolyunsaturatedFat,
        CholesterolNutrientDataType() => AppTexts.pleaseEnterCholesterol,
        DietaryFiberNutrientDataType() => AppTexts.pleaseEnterDietaryFiber,
        SugarNutrientDataType() => AppTexts.pleaseEnterSugar,
        CalciumNutrientDataType() => AppTexts.pleaseEnterCalcium,
        IronNutrientDataType() => AppTexts.pleaseEnterIron,
        MagnesiumNutrientDataType() => AppTexts.pleaseEnterMagnesium,
        ManganeseNutrientDataType() => AppTexts.pleaseEnterManganese,
        PhosphorusNutrientDataType() => AppTexts.pleaseEnterPhosphorus,
        PotassiumNutrientDataType() => AppTexts.pleaseEnterPotassium,
        SeleniumNutrientDataType() => AppTexts.pleaseEnterSelenium,
        SodiumNutrientDataType() => AppTexts.pleaseEnterSodium,
        ZincNutrientDataType() => AppTexts.pleaseEnterZinc,
        VitaminANutrientDataType() => AppTexts.pleaseEnterVitaminA,
        VitaminB6NutrientDataType() => AppTexts.pleaseEnterVitaminB6,
        VitaminB12NutrientDataType() => AppTexts.pleaseEnterVitaminB12,
        VitaminCNutrientDataType() => AppTexts.pleaseEnterVitaminC,
        VitaminDNutrientDataType() => AppTexts.pleaseEnterVitaminD,
        VitaminENutrientDataType() => AppTexts.pleaseEnterVitaminE,
        VitaminKNutrientDataType() => AppTexts.pleaseEnterVitaminK,
        ThiaminNutrientDataType() => AppTexts.pleaseEnterThiamin,
        RiboflavinNutrientDataType() => AppTexts.pleaseEnterRiboflavin,
        NiacinNutrientDataType() => AppTexts.pleaseEnterNiacin,
        FolateNutrientDataType() => AppTexts.pleaseEnterFolate,
        BiotinNutrientDataType() => AppTexts.pleaseEnterBiotin,
        PantothenicAcidNutrientDataType() =>
          AppTexts.pleaseEnterPantothenicAcid,
        NutritionHealthDataType() => throw UnsupportedError(
          'NutritionHealthDataType requires NutritionFormField',
        ),
        Vo2MaxHealthDataType() => AppTexts.pleaseEnterVo2Max,
        BloodGlucoseHealthDataType() => AppTexts.pleaseEnterBloodGlucose,
        SpeedSeriesDataType() => throw UnsupportedError(
          'SpeedHealthDataType requires samples',
        ),
        WalkingSpeedDataType() ||
        RunningSpeedDataType() ||
        StairAscentSpeedDataType() ||
        StairDescentSpeedDataType() => 'Please enter speed value',
      };
    }

    if (widget.validator != null) {
      return widget.validator!(_value);
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return switch (widget.dataType) {
      StepsHealthDataType() => TextFormField(
        controller: _controller,
        decoration: const InputDecoration(
          labelText: AppTexts.stepCount,
          border: OutlineInputBorder(),
          prefixIcon: Icon(AppIcons.numbers),
        ),
        keyboardType: TextInputType.number,
        onChanged: _onChanged,
        validator: _validate,
      ),
      WeightHealthDataType() => TextFormField(
        controller: _controller,
        decoration: const InputDecoration(
          labelText: AppTexts.weightValue,
          border: OutlineInputBorder(),
          prefixIcon: Icon(AppIcons.monitorWeight),
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        onChanged: _onChanged,
        validator: _validate,
      ),
      HeightHealthDataType() => TextFormField(
        controller: _controller,
        decoration: const InputDecoration(
          labelText: AppTexts.heightValue,
          border: OutlineInputBorder(),
          prefixIcon: Icon(AppIcons.height),
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        onChanged: _onChanged,
        validator: _validate,
      ),
      BodyFatPercentageHealthDataType() => TextFormField(
        controller: _controller,
        decoration: const InputDecoration(
          labelText: AppTexts.bodyFatPercentageValue,
          border: OutlineInputBorder(),
          prefixIcon: Icon(AppIcons.percent),
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        onChanged: _onChanged,
        validator: _validate,
      ),
      OxygenSaturationHealthDataType() => TextFormField(
        controller: _controller,
        decoration: const InputDecoration(
          labelText: AppTexts.oxygenSaturationValue,
          border: OutlineInputBorder(),
          prefixIcon: Icon(AppIcons.percent),
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        onChanged: _onChanged,
        validator: _validate,
      ),
      LeanBodyMassHealthDataType() => TextFormField(
        controller: _controller,
        decoration: const InputDecoration(
          labelText: AppTexts.leanBodyMassValue,
          border: OutlineInputBorder(),
          prefixIcon: Icon(AppIcons.monitorWeight),
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        onChanged: _onChanged,
        validator: _validate,
      ),
      BodyTemperatureHealthDataType() => TextFormField(
        controller: _controller,
        decoration: const InputDecoration(
          labelText: AppTexts.bodyTemperatureValue,
          border: OutlineInputBorder(),
          prefixIcon: Icon(AppIcons.temperature),
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        onChanged: _onChanged,
        validator: _validate,
      ),
      BloodPressureHealthDataType() => throw UnsupportedError(
        'BloodPressureHealthDataType requires custom form handling',
      ),
      BloodGlucoseHealthDataType() => TextFormField(
        controller: _controller,
        decoration: const InputDecoration(
          labelText: AppTexts.bloodGlucoseMgDl,
          border: OutlineInputBorder(),
          prefixIcon: Icon(AppIcons.bloodGlucose),
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        onChanged: _onChanged,
        validator: _validate,
      ),
      SystolicBloodPressureHealthDataType() => TextFormField(
        controller: _controller,
        decoration: const InputDecoration(
          labelText: AppTexts.systolicBloodPressureValue,
          border: OutlineInputBorder(),
          prefixIcon: Icon(AppIcons.bloodPressure),
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        onChanged: _onChanged,
        validator: _validate,
      ),
      DiastolicBloodPressureHealthDataType() => TextFormField(
        controller: _controller,
        decoration: const InputDecoration(
          labelText: AppTexts.diastolicBloodPressureValue,
          border: OutlineInputBorder(),
          prefixIcon: Icon(AppIcons.bloodPressure),
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        onChanged: _onChanged,
        validator: _validate,
      ),
      DistanceHealthDataType() => TextFormField(
        controller: _controller,
        decoration: const InputDecoration(
          labelText: AppTexts.distanceValue,
          border: OutlineInputBorder(),
          prefixIcon: Icon(AppIcons.straighten),
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        onChanged: _onChanged,
        validator: _validate,
      ),
      CrossCountrySkiingDistanceDataType() => TextFormField(
        controller: _controller,
        decoration: const InputDecoration(
          labelText: AppTexts.distanceValue,
          border: OutlineInputBorder(),
          prefixIcon: Icon(AppIcons.straighten),
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        onChanged: _onChanged,
        validator: _validate,
      ),
      CyclingDistanceDataType() => TextFormField(
        controller: _controller,
        decoration: const InputDecoration(
          labelText: AppTexts.distanceValue,
          border: OutlineInputBorder(),
          prefixIcon: Icon(AppIcons.straighten),
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        onChanged: _onChanged,
        validator: _validate,
      ),
      DownhillSnowSportsDistanceDataType() => TextFormField(
        controller: _controller,
        decoration: const InputDecoration(
          labelText: AppTexts.distanceValue,
          border: OutlineInputBorder(),
          prefixIcon: Icon(AppIcons.straighten),
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        onChanged: _onChanged,
        validator: _validate,
      ),
      PaddleSportsDistanceDataType() => TextFormField(
        controller: _controller,
        decoration: const InputDecoration(
          labelText: AppTexts.distanceValue,
          border: OutlineInputBorder(),
          prefixIcon: Icon(AppIcons.straighten),
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        onChanged: _onChanged,
        validator: _validate,
      ),
      RowingDistanceDataType() => TextFormField(
        controller: _controller,
        decoration: const InputDecoration(
          labelText: AppTexts.distanceValue,
          border: OutlineInputBorder(),
          prefixIcon: Icon(AppIcons.straighten),
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        onChanged: _onChanged,
        validator: _validate,
      ),
      SixMinuteWalkTestDistanceDataType() => TextFormField(
        controller: _controller,
        decoration: const InputDecoration(
          labelText: AppTexts.distanceValue,
          border: OutlineInputBorder(),
          prefixIcon: Icon(AppIcons.straighten),
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        onChanged: _onChanged,
        validator: _validate,
      ),
      SkatingSportsDistanceDataType() => TextFormField(
        controller: _controller,
        decoration: const InputDecoration(
          labelText: AppTexts.distanceValue,
          border: OutlineInputBorder(),
          prefixIcon: Icon(AppIcons.straighten),
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        onChanged: _onChanged,
        validator: _validate,
      ),
      SwimmingDistanceDataType() => TextFormField(
        controller: _controller,
        decoration: const InputDecoration(
          labelText: AppTexts.distanceValue,
          border: OutlineInputBorder(),
          prefixIcon: Icon(AppIcons.straighten),
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        onChanged: _onChanged,
        validator: _validate,
      ),
      WheelchairDistanceDataType() => TextFormField(
        controller: _controller,
        decoration: const InputDecoration(
          labelText: AppTexts.distanceValue,
          border: OutlineInputBorder(),
          prefixIcon: Icon(AppIcons.straighten),
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        onChanged: _onChanged,
        validator: _validate,
      ),
      WalkingRunningDistanceDataType() => TextFormField(
        controller: _controller,
        decoration: const InputDecoration(
          labelText: AppTexts.distanceValue,
          border: OutlineInputBorder(),
          prefixIcon: Icon(AppIcons.straighten),
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        onChanged: _onChanged,
        validator: _validate,
      ),
      ActiveCaloriesBurnedHealthDataType() => TextFormField(
        controller: _controller,
        decoration: const InputDecoration(
          labelText: AppTexts.activeCaloriesBurnedValue,
          border: OutlineInputBorder(),
          prefixIcon: Icon(AppIcons.localFireDepartment),
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        onChanged: _onChanged,
        validator: _validate,
      ),
      FloorsClimbedHealthDataType() => TextFormField(
        controller: _controller,
        decoration: const InputDecoration(
          labelText: AppTexts.floorsClimbedValue,
          border: OutlineInputBorder(),
          prefixIcon: Icon(AppIcons.stairs),
        ),
        keyboardType: TextInputType.number,
        onChanged: _onChanged,
        validator: _validate,
      ),
      WheelchairPushesHealthDataType() => TextFormField(
        controller: _controller,
        decoration: const InputDecoration(
          labelText: AppTexts.wheelchairPushesValue,
          border: OutlineInputBorder(),
          prefixIcon: Icon(AppIcons.accessible),
        ),
        keyboardType: TextInputType.number,
        onChanged: _onChanged,
        validator: _validate,
      ),
      HydrationHealthDataType() => TextFormField(
        controller: _controller,
        decoration: const InputDecoration(
          labelText: AppTexts.hydrationValue,
          border: OutlineInputBorder(),
          prefixIcon: Icon(AppIcons.volume),
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        onChanged: _onChanged,
        validator: _validate,
      ),
      HeartRateMeasurementRecordHealthDataType() => TextFormField(
        controller: _controller,
        decoration: const InputDecoration(
          labelText: AppTexts.heartRateValue,
          border: OutlineInputBorder(),
          prefixIcon: Icon(AppIcons.favorite),
        ),
        keyboardType: TextInputType.number,
        onChanged: _onChanged,
        validator: _validate,
      ),
      HeartRateSeriesRecordHealthDataType() => throw UnsupportedError(
        'HeartRateSeriesRecordHealthDataType should '
        'use HeartRateSamplesFormField',
      ),
      SleepSessionHealthDataType() => throw UnsupportedError(
        'SleepSessionHealthDataType requires custom form handling',
      ),
      SleepStageHealthDataType() => throw UnsupportedError(
        'SleepStageHealthDataType requires custom form handling',
      ),
      RestingHeartRateHealthDataType() => TextFormField(
        controller: _controller,
        decoration: const InputDecoration(
          labelText: AppTexts.restingHeartRateValue,
          border: OutlineInputBorder(),
          prefixIcon: Icon(AppIcons.favorite),
        ),
        keyboardType: TextInputType.number,
        onChanged: _onChanged,
        validator: _validate,
      ),
      EnergyNutrientDataType() => TextFormField(
        controller: _controller,
        decoration: const InputDecoration(
          labelText: AppTexts.energyValue,
          border: OutlineInputBorder(),
          prefixIcon: Icon(AppIcons.localFireDepartment),
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        onChanged: _onChanged,
        validator: _validate,
      ),
      CaffeineNutrientDataType() => TextFormField(
        controller: _controller,
        decoration: const InputDecoration(
          labelText: AppTexts.caffeineG,
          border: OutlineInputBorder(),
          prefixIcon: Icon(AppIcons.fastfood),
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        onChanged: _onChanged,
        validator: _validate,
      ),
      ProteinNutrientDataType() => TextFormField(
        controller: _controller,
        decoration: const InputDecoration(
          labelText: AppTexts.proteinG,
          border: OutlineInputBorder(),
          prefixIcon: Icon(AppIcons.fastfood),
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        onChanged: _onChanged,
        validator: _validate,
      ),
      TotalCarbohydrateNutrientDataType() => TextFormField(
        controller: _controller,
        decoration: const InputDecoration(
          labelText: AppTexts.totalCarbohydrateG,
          border: OutlineInputBorder(),
          prefixIcon: Icon(AppIcons.fastfood),
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        onChanged: _onChanged,
        validator: _validate,
      ),
      TotalFatNutrientDataType() => TextFormField(
        controller: _controller,
        decoration: const InputDecoration(
          labelText: AppTexts.totalFatG,
          border: OutlineInputBorder(),
          prefixIcon: Icon(AppIcons.fastfood),
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        onChanged: _onChanged,
        validator: _validate,
      ),
      SaturatedFatNutrientDataType() => TextFormField(
        controller: _controller,
        decoration: const InputDecoration(
          labelText: AppTexts.saturatedFatG,
          border: OutlineInputBorder(),
          prefixIcon: Icon(AppIcons.fastfood),
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        onChanged: _onChanged,
        validator: _validate,
      ),
      MonounsaturatedFatNutrientDataType() => TextFormField(
        controller: _controller,
        decoration: const InputDecoration(
          labelText: AppTexts.monounsaturatedFatG,
          border: OutlineInputBorder(),
          prefixIcon: Icon(AppIcons.fastfood),
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        onChanged: _onChanged,
        validator: _validate,
      ),
      PolyunsaturatedFatNutrientDataType() => TextFormField(
        controller: _controller,
        decoration: const InputDecoration(
          labelText: AppTexts.polyunsaturatedFatG,
          border: OutlineInputBorder(),
          prefixIcon: Icon(AppIcons.fastfood),
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        onChanged: _onChanged,
        validator: _validate,
      ),
      CholesterolNutrientDataType() => TextFormField(
        controller: _controller,
        decoration: const InputDecoration(
          labelText: AppTexts.cholesterolG,
          border: OutlineInputBorder(),
          prefixIcon: Icon(AppIcons.fastfood),
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        onChanged: _onChanged,
        validator: _validate,
      ),
      DietaryFiberNutrientDataType() => TextFormField(
        controller: _controller,
        decoration: const InputDecoration(
          labelText: AppTexts.dietaryFiberG,
          border: OutlineInputBorder(),
          prefixIcon: Icon(AppIcons.fastfood),
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        onChanged: _onChanged,
        validator: _validate,
      ),
      SugarNutrientDataType() => TextFormField(
        controller: _controller,
        decoration: const InputDecoration(
          labelText: AppTexts.sugarG,
          border: OutlineInputBorder(),
          prefixIcon: Icon(AppIcons.fastfood),
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        onChanged: _onChanged,
        validator: _validate,
      ),
      CalciumNutrientDataType() => TextFormField(
        controller: _controller,
        decoration: const InputDecoration(
          labelText: AppTexts.calciumG,
          border: OutlineInputBorder(),
          prefixIcon: Icon(AppIcons.fastfood),
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        onChanged: _onChanged,
        validator: _validate,
      ),
      IronNutrientDataType() => TextFormField(
        controller: _controller,
        decoration: const InputDecoration(
          labelText: AppTexts.ironG,
          border: OutlineInputBorder(),
          prefixIcon: Icon(AppIcons.fastfood),
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        onChanged: _onChanged,
        validator: _validate,
      ),
      MagnesiumNutrientDataType() => TextFormField(
        controller: _controller,
        decoration: const InputDecoration(
          labelText: AppTexts.magnesiumG,
          border: OutlineInputBorder(),
          prefixIcon: Icon(AppIcons.fastfood),
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        onChanged: _onChanged,
        validator: _validate,
      ),
      ManganeseNutrientDataType() => TextFormField(
        controller: _controller,
        decoration: const InputDecoration(
          labelText: AppTexts.manganeseG,
          border: OutlineInputBorder(),
          prefixIcon: Icon(AppIcons.fastfood),
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        onChanged: _onChanged,
        validator: _validate,
      ),
      PhosphorusNutrientDataType() => TextFormField(
        controller: _controller,
        decoration: const InputDecoration(
          labelText: AppTexts.phosphorusG,
          border: OutlineInputBorder(),
          prefixIcon: Icon(AppIcons.fastfood),
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        onChanged: _onChanged,
        validator: _validate,
      ),
      PotassiumNutrientDataType() => TextFormField(
        controller: _controller,
        decoration: const InputDecoration(
          labelText: AppTexts.potassiumG,
          border: OutlineInputBorder(),
          prefixIcon: Icon(AppIcons.fastfood),
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        onChanged: _onChanged,
        validator: _validate,
      ),
      SeleniumNutrientDataType() => TextFormField(
        controller: _controller,
        decoration: const InputDecoration(
          labelText: AppTexts.seleniumG,
          border: OutlineInputBorder(),
          prefixIcon: Icon(AppIcons.fastfood),
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        onChanged: _onChanged,
        validator: _validate,
      ),
      SodiumNutrientDataType() => TextFormField(
        controller: _controller,
        decoration: const InputDecoration(
          labelText: AppTexts.sodiumG,
          border: OutlineInputBorder(),
          prefixIcon: Icon(AppIcons.fastfood),
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        onChanged: _onChanged,
        validator: _validate,
      ),
      ZincNutrientDataType() => TextFormField(
        controller: _controller,
        decoration: const InputDecoration(
          labelText: AppTexts.zincG,
          border: OutlineInputBorder(),
          prefixIcon: Icon(AppIcons.fastfood),
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        onChanged: _onChanged,
        validator: _validate,
      ),
      VitaminANutrientDataType() => TextFormField(
        controller: _controller,
        decoration: const InputDecoration(
          labelText: AppTexts.vitaminAG,
          border: OutlineInputBorder(),
          prefixIcon: Icon(AppIcons.fastfood),
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        onChanged: _onChanged,
        validator: _validate,
      ),
      VitaminB6NutrientDataType() => TextFormField(
        controller: _controller,
        decoration: const InputDecoration(
          labelText: AppTexts.vitaminB6G,
          border: OutlineInputBorder(),
          prefixIcon: Icon(AppIcons.fastfood),
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        onChanged: _onChanged,
        validator: _validate,
      ),
      VitaminB12NutrientDataType() => TextFormField(
        controller: _controller,
        decoration: const InputDecoration(
          labelText: AppTexts.vitaminB12G,
          border: OutlineInputBorder(),
          prefixIcon: Icon(AppIcons.fastfood),
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        onChanged: _onChanged,
        validator: _validate,
      ),
      VitaminCNutrientDataType() => TextFormField(
        controller: _controller,
        decoration: const InputDecoration(
          labelText: AppTexts.vitaminCG,
          border: OutlineInputBorder(),
          prefixIcon: Icon(AppIcons.fastfood),
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        onChanged: _onChanged,
        validator: _validate,
      ),
      VitaminDNutrientDataType() => TextFormField(
        controller: _controller,
        decoration: const InputDecoration(
          labelText: AppTexts.vitaminDG,
          border: OutlineInputBorder(),
          prefixIcon: Icon(AppIcons.fastfood),
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        onChanged: _onChanged,
        validator: _validate,
      ),
      VitaminENutrientDataType() => TextFormField(
        controller: _controller,
        decoration: const InputDecoration(
          labelText: AppTexts.vitaminEG,
          border: OutlineInputBorder(),
          prefixIcon: Icon(AppIcons.fastfood),
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        onChanged: _onChanged,
        validator: _validate,
      ),
      VitaminKNutrientDataType() => TextFormField(
        controller: _controller,
        decoration: const InputDecoration(
          labelText: AppTexts.vitaminKG,
          border: OutlineInputBorder(),
          prefixIcon: Icon(AppIcons.fastfood),
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        onChanged: _onChanged,
        validator: _validate,
      ),
      ThiaminNutrientDataType() => TextFormField(
        controller: _controller,
        decoration: const InputDecoration(
          labelText: AppTexts.thiaminG,
          border: OutlineInputBorder(),
          prefixIcon: Icon(AppIcons.fastfood),
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        onChanged: _onChanged,
        validator: _validate,
      ),
      RiboflavinNutrientDataType() => TextFormField(
        controller: _controller,
        decoration: const InputDecoration(
          labelText: AppTexts.riboflavinG,
          border: OutlineInputBorder(),
          prefixIcon: Icon(AppIcons.fastfood),
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        onChanged: _onChanged,
        validator: _validate,
      ),
      NiacinNutrientDataType() => TextFormField(
        controller: _controller,
        decoration: const InputDecoration(
          labelText: AppTexts.niacinG,
          border: OutlineInputBorder(),
          prefixIcon: Icon(AppIcons.fastfood),
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        onChanged: _onChanged,
        validator: _validate,
      ),
      FolateNutrientDataType() => TextFormField(
        controller: _controller,
        decoration: const InputDecoration(
          labelText: AppTexts.folateG,
          border: OutlineInputBorder(),
          prefixIcon: Icon(AppIcons.fastfood),
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        onChanged: _onChanged,
        validator: _validate,
      ),
      BiotinNutrientDataType() => TextFormField(
        controller: _controller,
        decoration: const InputDecoration(
          labelText: AppTexts.biotinG,
          border: OutlineInputBorder(),
          prefixIcon: Icon(AppIcons.fastfood),
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        onChanged: _onChanged,
        validator: _validate,
      ),
      PantothenicAcidNutrientDataType() => TextFormField(
        controller: _controller,
        decoration: const InputDecoration(
          labelText: AppTexts.pantothenicAcidG,
          border: OutlineInputBorder(),
          prefixIcon: Icon(AppIcons.fastfood),
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        onChanged: _onChanged,
        validator: _validate,
      ),
      RespiratoryRateHealthDataType() => TextFormField(
        controller: _controller,
        decoration: const InputDecoration(
          labelText: AppTexts.respiratoryRateValue,
          border: OutlineInputBorder(),
          prefixIcon: Icon(AppIcons.air),
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        onChanged: _onChanged,
        validator: _validate,
      ),
      NutritionHealthDataType() => throw UnsupportedError(
        'NutritionHealthDataType requires NutritionFormField',
      ),
      Vo2MaxHealthDataType() => TextFormField(
        controller: _controller,
        decoration: const InputDecoration(
          labelText: AppTexts.vo2MaxValue,
          border: OutlineInputBorder(),
          prefixIcon: Icon(AppIcons.vo2Max),
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        onChanged: _onChanged,
        validator: _validate,
      ),
      SpeedSeriesDataType() => throw UnsupportedError(
        'SpeedHealthDataType requires samples. '
        'Use HeartRateSamplesFormField pattern',
      ),
      WalkingSpeedDataType() ||
      RunningSpeedDataType() ||
      StairAscentSpeedDataType() ||
      StairDescentSpeedDataType() => TextFormField(
        controller: _controller,
        decoration: const InputDecoration(
          labelText: 'Speed (m/s)',
          border: OutlineInputBorder(),
          prefixIcon: Icon(AppIcons.speed),
        ),
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        onChanged: _onChanged,
        validator: _validate,
      ),
    };
  }
}
