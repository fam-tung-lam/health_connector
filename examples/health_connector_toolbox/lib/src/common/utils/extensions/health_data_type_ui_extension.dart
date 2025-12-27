import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart'
    show
        HealthDataType,
        PantothenicAcidNutrientDataType,
        StepsHealthDataType,
        WeightHealthDataType,
        HeightHealthDataType,
        BloodPressureHealthDataType,
        SystolicBloodPressureHealthDataType,
        DiastolicBloodPressureHealthDataType,
        BodyFatPercentageHealthDataType,
        LeanBodyMassHealthDataType,
        BodyTemperatureHealthDataType,
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
        ActiveCaloriesBurnedHealthDataType,
        FloorsClimbedHealthDataType,
        WheelchairPushesHealthDataType,
        HydrationHealthDataType,
        HeartRateMeasurementRecordHealthDataType,
        HeartRateSeriesRecordHealthDataType,
        RestingHeartRateHealthDataType,
        SleepSessionHealthDataType,
        SleepStageHealthDataType,
        ExerciseSessionHealthDataType,
        MindfulnessSessionDataType,
        OxygenSaturationHealthDataType,
        NutritionHealthDataType,
        EnergyNutrientDataType,
        CaffeineNutrientDataType,
        ProteinNutrientDataType,
        TotalCarbohydrateNutrientDataType,
        TotalFatNutrientDataType,
        SaturatedFatNutrientDataType,
        MonounsaturatedFatNutrientDataType,
        PolyunsaturatedFatNutrientDataType,
        CholesterolNutrientDataType,
        DietaryFiberNutrientDataType,
        SugarNutrientDataType,
        CalciumNutrientDataType,
        IronNutrientDataType,
        MagnesiumNutrientDataType,
        ManganeseNutrientDataType,
        PhosphorusNutrientDataType,
        PotassiumNutrientDataType,
        SeleniumNutrientDataType,
        SodiumNutrientDataType,
        ZincNutrientDataType,
        VitaminANutrientDataType,
        VitaminB6NutrientDataType,
        VitaminB12NutrientDataType,
        VitaminCNutrientDataType,
        VitaminDNutrientDataType,
        VitaminENutrientDataType,
        VitaminKNutrientDataType,
        ThiaminNutrientDataType,
        RiboflavinNutrientDataType,
        NiacinNutrientDataType,
        FolateNutrientDataType,
        BiotinNutrientDataType,
        RespiratoryRateHealthDataType,
        Vo2MaxHealthDataType,
        BloodGlucoseHealthDataType,
        SpeedSeriesDataType,
        WalkingSpeedDataType,
        RunningSpeedDataType,
        StairAscentSpeedDataType,
        StairDescentSpeedDataType,
        PowerSeriesDataType,
        CyclingPowerDataType;
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';

/// Extension on [HealthDataType] to provide UI-related properties.
extension HealthDataTypeUI on HealthDataType {
  /// Returns the display name for this health data type.
  ///
  /// This name should be used in UI elements.
  String get displayName {
    return switch (this) {
      StepsHealthDataType _ => AppTexts.steps,
      WeightHealthDataType _ => AppTexts.weight,
      HeightHealthDataType _ => AppTexts.height,
      BloodPressureHealthDataType _ => AppTexts.bloodPressure,
      SystolicBloodPressureHealthDataType _ => AppTexts.systolicBloodPressure,
      DiastolicBloodPressureHealthDataType _ => AppTexts.diastolicBloodPressure,
      BodyFatPercentageHealthDataType _ => AppTexts.bodyFatPercentage,
      LeanBodyMassHealthDataType _ => AppTexts.leanBodyMass,
      BodyTemperatureHealthDataType _ => AppTexts.bodyTemperature,
      DistanceHealthDataType _ => AppTexts.distance,
      CrossCountrySkiingDistanceDataType _ => AppTexts.crossCountrySkiing,
      CyclingDistanceDataType _ => AppTexts.cyclingDistance,
      DownhillSnowSportsDistanceDataType _ =>
        AppTexts.downhillSnowSportsDistance,
      PaddleSportsDistanceDataType _ => AppTexts.paddleSportsDistance,
      RowingDistanceDataType _ => AppTexts.rowingDistance,
      SixMinuteWalkTestDistanceDataType _ => AppTexts.sixMinuteWalkTestDistance,
      SkatingSportsDistanceDataType _ => AppTexts.skatingSportsDistance,
      SwimmingDistanceDataType _ => AppTexts.swimmingDistance,
      WheelchairDistanceDataType _ => AppTexts.wheelchairDistance,
      WalkingRunningDistanceDataType _ => AppTexts.walkingRunningDistance,
      ActiveCaloriesBurnedHealthDataType _ => AppTexts.activeCaloriesBurned,
      FloorsClimbedHealthDataType _ => AppTexts.floorsClimbed,
      WheelchairPushesHealthDataType _ => AppTexts.wheelchairPushes,
      HydrationHealthDataType _ => AppTexts.hydration,
      HeartRateMeasurementRecordHealthDataType _ => AppTexts.heartRate,
      HeartRateSeriesRecordHealthDataType _ => AppTexts.heartRate,
      RestingHeartRateHealthDataType _ => AppTexts.restingHeartRate,
      SleepSessionHealthDataType _ => AppTexts.sleepSession,
      SleepStageHealthDataType _ => AppTexts.sleepStage,
      OxygenSaturationHealthDataType _ => AppTexts.oxygenSaturation,
      NutritionHealthDataType _ => AppTexts.nutrition,
      EnergyNutrientDataType _ => AppTexts.energy,
      CaffeineNutrientDataType _ => AppTexts.caffeine,
      ProteinNutrientDataType _ => AppTexts.protein,
      TotalCarbohydrateNutrientDataType _ => AppTexts.totalCarbohydrate,
      TotalFatNutrientDataType _ => AppTexts.totalFat,
      SaturatedFatNutrientDataType _ => AppTexts.saturatedFat,
      MonounsaturatedFatNutrientDataType _ => AppTexts.monounsaturatedFat,
      PolyunsaturatedFatNutrientDataType _ => AppTexts.polyunsaturatedFat,
      CholesterolNutrientDataType _ => AppTexts.cholesterol,
      DietaryFiberNutrientDataType _ => AppTexts.dietaryFiber,
      SugarNutrientDataType _ => AppTexts.sugar,
      CalciumNutrientDataType _ => AppTexts.calcium,
      IronNutrientDataType _ => AppTexts.iron,
      MagnesiumNutrientDataType _ => AppTexts.magnesium,
      ManganeseNutrientDataType _ => AppTexts.manganese,
      PhosphorusNutrientDataType _ => AppTexts.phosphorus,
      PotassiumNutrientDataType _ => AppTexts.potassium,
      SeleniumNutrientDataType _ => AppTexts.selenium,
      SodiumNutrientDataType _ => AppTexts.sodium,
      ZincNutrientDataType _ => AppTexts.zinc,
      VitaminANutrientDataType _ => AppTexts.vitaminA,
      VitaminB6NutrientDataType _ => AppTexts.vitaminB6,
      VitaminB12NutrientDataType _ => AppTexts.vitaminB12,
      VitaminCNutrientDataType _ => AppTexts.vitaminC,
      VitaminDNutrientDataType _ => AppTexts.vitaminD,
      VitaminENutrientDataType _ => AppTexts.vitaminE,
      VitaminKNutrientDataType _ => AppTexts.vitaminK,
      ThiaminNutrientDataType _ => AppTexts.thiamin,
      RiboflavinNutrientDataType _ => AppTexts.riboflavin,
      NiacinNutrientDataType _ => AppTexts.niacin,
      FolateNutrientDataType _ => AppTexts.folate,
      BiotinNutrientDataType _ => AppTexts.biotin,
      PantothenicAcidNutrientDataType _ => AppTexts.pantothenicAcid,
      RespiratoryRateHealthDataType _ => AppTexts.respiratoryRate,
      Vo2MaxHealthDataType _ => AppTexts.vo2Max,
      BloodGlucoseHealthDataType _ => AppTexts.bloodGlucose,
      SpeedSeriesDataType _ => AppTexts.speed,
      WalkingSpeedDataType _ => AppTexts.walkingSpeed,
      RunningSpeedDataType _ => AppTexts.runningSpeed,
      StairAscentSpeedDataType _ => AppTexts.stairAscentSpeed,
      StairDescentSpeedDataType _ => AppTexts.stairDescentSpeed,
      PowerSeriesDataType _ => AppTexts.powerSeries,
      CyclingPowerDataType _ => AppTexts.cyclingPower,
      ExerciseSessionHealthDataType _ => AppTexts.exerciseSession,
      MindfulnessSessionDataType _ => AppTexts.mindfulnessSession,
    };
  }

  /// Returns a description for this health data type.
  ///
  /// This description provides additional context about what the data type
  /// represents and is suitable for subtitle text or tooltips.
  String get description {
    return switch (this) {
      StepsHealthDataType _ => AppTexts.stepsDescription,
      WeightHealthDataType _ => AppTexts.weightDescription,
      HeightHealthDataType _ => AppTexts.heightDescription,
      BloodPressureHealthDataType _ => AppTexts.bloodPressureDescription,
      SystolicBloodPressureHealthDataType _ =>
        AppTexts.systolicBloodPressureDescription,
      DiastolicBloodPressureHealthDataType _ =>
        AppTexts.diastolicBloodPressureDescription,
      BodyFatPercentageHealthDataType _ =>
        AppTexts.bodyFatPercentageDescription,
      LeanBodyMassHealthDataType _ => AppTexts.leanBodyMassDescription,
      BodyTemperatureHealthDataType _ => AppTexts.bodyTemperatureDescription,
      DistanceHealthDataType _ => AppTexts.distanceDescription,
      CrossCountrySkiingDistanceDataType _ => AppTexts.distanceDescription,
      CyclingDistanceDataType _ => AppTexts.distanceDescription,
      DownhillSnowSportsDistanceDataType _ => AppTexts.distanceDescription,
      PaddleSportsDistanceDataType _ => AppTexts.distanceDescription,
      RowingDistanceDataType _ => AppTexts.distanceDescription,
      SixMinuteWalkTestDistanceDataType _ => AppTexts.distanceDescription,
      SkatingSportsDistanceDataType _ => AppTexts.distanceDescription,
      SwimmingDistanceDataType _ => AppTexts.distanceDescription,
      WheelchairDistanceDataType _ => AppTexts.distanceDescription,
      WalkingRunningDistanceDataType _ => AppTexts.distanceDescription,
      ActiveCaloriesBurnedHealthDataType _ =>
        AppTexts.activeCaloriesBurnedDescription,
      FloorsClimbedHealthDataType _ => AppTexts.floorsClimbedDescription,
      WheelchairPushesHealthDataType _ => AppTexts.wheelchairPushesDescription,
      HydrationHealthDataType _ => AppTexts.hydrationDescription,
      HeartRateMeasurementRecordHealthDataType _ =>
        AppTexts.heartRateRecordDescription,
      HeartRateSeriesRecordHealthDataType _ =>
        AppTexts.heartRateSeriesRecordDescription,
      RestingHeartRateHealthDataType _ => AppTexts.restingHeartRateDescription,
      SleepSessionHealthDataType _ => AppTexts.sleepSessionDescription,
      SleepStageHealthDataType _ => AppTexts.sleepStageRecordDescription,
      OxygenSaturationHealthDataType _ => AppTexts.oxygenSaturationDescription,
      NutritionHealthDataType _ => AppTexts.nutritionDescription,
      EnergyNutrientDataType _ => AppTexts.energyDescription,
      CaffeineNutrientDataType _ => AppTexts.caffeineDescription,
      ProteinNutrientDataType _ => AppTexts.proteinDescription,
      TotalCarbohydrateNutrientDataType _ =>
        AppTexts.totalCarbohydrateDescription,
      TotalFatNutrientDataType _ => AppTexts.totalFatDescription,
      SaturatedFatNutrientDataType _ => AppTexts.saturatedFatDescription,
      MonounsaturatedFatNutrientDataType _ =>
        AppTexts.monounsaturatedFatDescription,
      PolyunsaturatedFatNutrientDataType _ =>
        AppTexts.polyunsaturatedFatDescription,
      CholesterolNutrientDataType _ => AppTexts.cholesterolDescription,
      DietaryFiberNutrientDataType _ => AppTexts.dietaryFiberDescription,
      SugarNutrientDataType _ => AppTexts.sugarDescription,
      CalciumNutrientDataType _ => AppTexts.calciumDescription,
      IronNutrientDataType _ => AppTexts.ironDescription,
      MagnesiumNutrientDataType _ => AppTexts.magnesiumDescription,
      ManganeseNutrientDataType _ => AppTexts.manganeseDescription,
      PhosphorusNutrientDataType _ => AppTexts.phosphorusDescription,
      PotassiumNutrientDataType _ => AppTexts.potassiumDescription,
      SeleniumNutrientDataType _ => AppTexts.seleniumDescription,
      SodiumNutrientDataType _ => AppTexts.sodiumDescription,
      ZincNutrientDataType _ => AppTexts.zincDescription,
      VitaminANutrientDataType _ => AppTexts.vitaminADescription,
      VitaminB6NutrientDataType _ => AppTexts.vitaminB6Description,
      VitaminB12NutrientDataType _ => AppTexts.vitaminB12Description,
      VitaminCNutrientDataType _ => AppTexts.vitaminCDescription,
      VitaminDNutrientDataType _ => AppTexts.vitaminDDescription,
      VitaminENutrientDataType _ => AppTexts.vitaminEDescription,
      VitaminKNutrientDataType _ => AppTexts.vitaminKDescription,
      ThiaminNutrientDataType _ => AppTexts.thiaminDescription,
      RiboflavinNutrientDataType _ => AppTexts.riboflavinDescription,
      NiacinNutrientDataType _ => AppTexts.niacinDescription,
      FolateNutrientDataType _ => AppTexts.folateDescription,
      BiotinNutrientDataType _ => AppTexts.biotinDescription,
      PantothenicAcidNutrientDataType _ => AppTexts.pantothenicAcidDescription,
      RespiratoryRateHealthDataType _ => AppTexts.respiratoryRateDescription,
      Vo2MaxHealthDataType _ => AppTexts.vo2MaxDescription,
      BloodGlucoseHealthDataType _ => AppTexts.bloodGlucoseDescription,
      SpeedSeriesDataType _ => AppTexts.speedDescription,
      WalkingSpeedDataType _ => AppTexts.speedDescription,
      RunningSpeedDataType _ => AppTexts.speedDescription,
      StairAscentSpeedDataType _ => AppTexts.speedDescription,
      StairDescentSpeedDataType _ => AppTexts.speedDescription,
      PowerSeriesDataType _ => 'Power output measurements over time (Android)',
      CyclingPowerDataType _ => 'Cycling power output in watts (iOS)',
      ExerciseSessionHealthDataType _ => 'Period of physical activity',
      MindfulnessSessionDataType _ => 'Period of mindfulness practice',
    };
  }

  /// Returns the icon for this health data type.
  ///
  /// This icon should be used consistently across the app to represent
  /// the health data type in UI elements.
  IconData get icon {
    return switch (this) {
      StepsHealthDataType _ => AppIcons.directionsWalk,
      WeightHealthDataType _ => AppIcons.monitorWeight,
      HeightHealthDataType _ => AppIcons.height,
      BloodPressureHealthDataType _ => AppIcons.bloodPressure,
      SystolicBloodPressureHealthDataType _ => AppIcons.bloodPressure,
      DiastolicBloodPressureHealthDataType _ => AppIcons.bloodPressure,
      BodyFatPercentageHealthDataType _ => AppIcons.percent,
      LeanBodyMassHealthDataType _ => AppIcons.monitorWeight,
      BodyTemperatureHealthDataType _ => AppIcons.temperature,
      DistanceHealthDataType _ => AppIcons.straighten,
      CrossCountrySkiingDistanceDataType _ => AppIcons.straighten,
      CyclingDistanceDataType _ => AppIcons.straighten,
      DownhillSnowSportsDistanceDataType _ => AppIcons.straighten,
      PaddleSportsDistanceDataType _ => AppIcons.straighten,
      RowingDistanceDataType _ => AppIcons.straighten,
      SixMinuteWalkTestDistanceDataType _ => AppIcons.straighten,
      SkatingSportsDistanceDataType _ => AppIcons.straighten,
      SwimmingDistanceDataType _ => AppIcons.straighten,
      WheelchairDistanceDataType _ => AppIcons.straighten,
      WalkingRunningDistanceDataType _ => AppIcons.straighten,
      ActiveCaloriesBurnedHealthDataType _ => AppIcons.localFireDepartment,
      FloorsClimbedHealthDataType _ => AppIcons.stairs,
      WheelchairPushesHealthDataType _ => AppIcons.accessible,
      HydrationHealthDataType _ => AppIcons.volume,
      HeartRateMeasurementRecordHealthDataType _ => AppIcons.favorite,
      HeartRateSeriesRecordHealthDataType _ => AppIcons.favorite,
      RestingHeartRateHealthDataType _ => AppIcons.favorite,
      SleepSessionHealthDataType _ => AppIcons.bedtime,
      SleepStageHealthDataType _ => AppIcons.bedtime,
      OxygenSaturationHealthDataType _ => AppIcons.percent,
      NutritionHealthDataType _ => AppIcons.fastfood,
      EnergyNutrientDataType _ => AppIcons.localFireDepartment,
      CaffeineNutrientDataType _ => AppIcons.fastfood,
      ProteinNutrientDataType _ => AppIcons.fastfood,
      TotalCarbohydrateNutrientDataType _ => AppIcons.fastfood,
      TotalFatNutrientDataType _ => AppIcons.fastfood,
      SaturatedFatNutrientDataType _ => AppIcons.fastfood,
      MonounsaturatedFatNutrientDataType _ => AppIcons.fastfood,
      PolyunsaturatedFatNutrientDataType _ => AppIcons.fastfood,
      CholesterolNutrientDataType _ => AppIcons.fastfood,
      DietaryFiberNutrientDataType _ => AppIcons.fastfood,
      SugarNutrientDataType _ => AppIcons.fastfood,
      CalciumNutrientDataType _ => AppIcons.fastfood,
      IronNutrientDataType _ => AppIcons.fastfood,
      MagnesiumNutrientDataType _ => AppIcons.fastfood,
      ManganeseNutrientDataType _ => AppIcons.fastfood,
      PhosphorusNutrientDataType _ => AppIcons.fastfood,
      PotassiumNutrientDataType _ => AppIcons.fastfood,
      SeleniumNutrientDataType _ => AppIcons.fastfood,
      SodiumNutrientDataType _ => AppIcons.fastfood,
      ZincNutrientDataType _ => AppIcons.fastfood,
      VitaminANutrientDataType _ => AppIcons.fastfood,
      VitaminB6NutrientDataType _ => AppIcons.fastfood,
      VitaminB12NutrientDataType _ => AppIcons.fastfood,
      VitaminCNutrientDataType _ => AppIcons.fastfood,
      VitaminDNutrientDataType _ => AppIcons.fastfood,
      VitaminENutrientDataType _ => AppIcons.fastfood,
      VitaminKNutrientDataType _ => AppIcons.fastfood,
      ThiaminNutrientDataType _ => AppIcons.fastfood,
      RiboflavinNutrientDataType _ => AppIcons.fastfood,
      NiacinNutrientDataType _ => AppIcons.fastfood,
      FolateNutrientDataType _ => AppIcons.fastfood,
      BiotinNutrientDataType _ => AppIcons.fastfood,
      PantothenicAcidNutrientDataType _ => AppIcons.fastfood,
      RespiratoryRateHealthDataType _ => AppIcons.air,
      Vo2MaxHealthDataType _ => AppIcons.vo2Max,
      BloodGlucoseHealthDataType _ => AppIcons.bloodGlucose,
      SpeedSeriesDataType _ => AppIcons.speed,
      WalkingSpeedDataType _ => AppIcons.speed,
      RunningSpeedDataType _ => AppIcons.speed,
      StairAscentSpeedDataType _ => AppIcons.speed,
      StairDescentSpeedDataType _ => AppIcons.speed,
      PowerSeriesDataType _ => AppIcons.power,
      CyclingPowerDataType _ => AppIcons.power,
      ExerciseSessionHealthDataType _ => AppIcons.fitnessCenter,
      MindfulnessSessionDataType _ => AppIcons.selfImprovement,
    };
  }
}

/// Extension on [HealthDataType] to provide form-related properties and logic.
///
/// This extension provides UI configuration, parsing logic, and validation
/// for health data input fields, replacing the previous ConfigCategory,
/// ConfigMetadata, and ConfigFactory pattern.
extension HealthDataTypeUIFormExtension on HealthDataType {
  /// Returns the appropriate keyboard type for this data type.
  TextInputType get keyboardType {
    return switch (runtimeType) {
      // Integer types
      const (StepsHealthDataType) ||
      const (FloorsClimbedHealthDataType) ||
      const (WheelchairPushesHealthDataType) ||
      const (HeartRateMeasurementRecordHealthDataType) ||
      const (RestingHeartRateHealthDataType) => TextInputType.number,

      // All other types use decimal number input
      _ => const TextInputType.numberWithOptions(decimal: true),
    };
  }

  /// Returns the label text for the input field.
  String get fieldLabel {
    return switch (runtimeType) {
      // Count Types
      const (StepsHealthDataType) => AppTexts.stepCount,
      const (FloorsClimbedHealthDataType) => AppTexts.floorsClimbed,
      const (WheelchairPushesHealthDataType) => AppTexts.wheelchairPushes,
      const (HeartRateMeasurementRecordHealthDataType) =>
        AppTexts.valueWithUnit(AppTexts.heartRate, AppTexts.bpm),
      const (RestingHeartRateHealthDataType) => AppTexts.valueWithUnit(
        AppTexts.restingHeartRate,
        AppTexts.bpm,
      ),

      // Mass Types (Kilograms)
      const (WeightHealthDataType) => AppTexts.valueWithUnit(
        AppTexts.weight,
        AppTexts.kilogram,
      ),
      const (LeanBodyMassHealthDataType) => AppTexts.valueWithUnit(
        AppTexts.leanBodyMass,
        AppTexts.kilogram,
      ),

      // Percentage Types
      const (BodyFatPercentageHealthDataType) => AppTexts.withUnit(
        AppTexts.bodyFatPercentage,
        AppTexts.percent,
      ),
      const (OxygenSaturationHealthDataType) => AppTexts.withUnit(
        AppTexts.oxygenSaturation,
        AppTexts.percent,
      ),

      // Distance Types
      const (HeightHealthDataType) => AppTexts.valueWithUnit(
        AppTexts.height,
        AppTexts.meter,
      ),
      const (DistanceHealthDataType) => AppTexts.valueWithUnit(
        AppTexts.distance,
        AppTexts.meter,
      ),
      const (CrossCountrySkiingDistanceDataType) => AppTexts.withUnit(
        '${AppTexts.crossCountrySkiing} ${AppTexts.distance}',
        AppTexts.meter,
      ),
      const (CyclingDistanceDataType) => AppTexts.withUnit(
        '${AppTexts.cycling} ${AppTexts.distance}',
        AppTexts.meter,
      ),
      const (DownhillSnowSportsDistanceDataType) => AppTexts.withUnit(
        '${AppTexts.downhillSnowSports} ${AppTexts.distance}',
        AppTexts.meter,
      ),
      const (PaddleSportsDistanceDataType) => AppTexts.withUnit(
        '${AppTexts.paddleSports} ${AppTexts.distance}',
        AppTexts.meter,
      ),
      const (RowingDistanceDataType) => AppTexts.withUnit(
        '${AppTexts.rowing} ${AppTexts.distance}',
        AppTexts.meter,
      ),
      const (SixMinuteWalkTestDistanceDataType) => AppTexts.withUnit(
        '${AppTexts.sixMinuteWalkTest} ${AppTexts.distance}',
        AppTexts.meter,
      ),
      const (SkatingSportsDistanceDataType) => AppTexts.withUnit(
        '${AppTexts.skatingSports} ${AppTexts.distance}',
        AppTexts.meter,
      ),
      const (SwimmingDistanceDataType) => AppTexts.withUnit(
        '${AppTexts.swimming} ${AppTexts.distance}',
        AppTexts.meter,
      ),
      const (WheelchairDistanceDataType) => AppTexts.withUnit(
        '${AppTexts.wheelchair} ${AppTexts.distance}',
        AppTexts.meter,
      ),
      const (WalkingRunningDistanceDataType) => AppTexts.withUnit(
        '${AppTexts.walkingRunning} ${AppTexts.distance}',
        AppTexts.meter,
      ),

      // Vital Signs
      const (BodyTemperatureHealthDataType) => AppTexts.withUnit(
        AppTexts.bodyTemperature,
        AppTexts.celsius,
      ),
      const (SystolicBloodPressureHealthDataType) => AppTexts.withUnit(
        '${AppTexts.systolic} ${AppTexts.bloodPressure}',
        AppTexts.millimetersOfMercury,
      ),
      const (DiastolicBloodPressureHealthDataType) => AppTexts.withUnit(
        '${AppTexts.diastolic} ${AppTexts.bloodPressure}',
        AppTexts.millimetersOfMercury,
      ),
      const (BloodGlucoseHealthDataType) => AppTexts.withUnit(
        AppTexts.bloodGlucose,
        AppTexts.milligramsPerDeciliter,
      ),
      const (RespiratoryRateHealthDataType) => AppTexts.withUnit(
        AppTexts.respiratoryRate,
        AppTexts.breathsPerMinute,
      ),
      const (Vo2MaxHealthDataType) => AppTexts.withUnit(
        AppTexts.vo2Max,
        AppTexts.millilitersPerKilogramPerMinute,
      ),

      // Activity & Energy
      const (ActiveCaloriesBurnedHealthDataType) => AppTexts.withUnit(
        AppTexts.activeCaloriesBurned,
        AppTexts.kilocalories,
      ),
      const (EnergyNutrientDataType) => AppTexts.withUnit(
        AppTexts.energy,
        AppTexts.kilocalories,
      ),
      const (HydrationHealthDataType) => AppTexts.valueWithUnit(
        AppTexts.hydration,
        AppTexts.liter,
      ),

      // Macronutrients
      const (CaffeineNutrientDataType) => AppTexts.withUnit(
        AppTexts.caffeine,
        AppTexts.milligram,
      ),
      const (ProteinNutrientDataType) => AppTexts.withUnit(
        AppTexts.protein,
        AppTexts.gram,
      ),
      const (TotalCarbohydrateNutrientDataType) => AppTexts.withUnit(
        AppTexts.totalCarbohydrate,
        AppTexts.gram,
      ),
      const (TotalFatNutrientDataType) => AppTexts.withUnit(
        AppTexts.totalFat,
        AppTexts.gram,
      ),
      const (SaturatedFatNutrientDataType) => AppTexts.withUnit(
        AppTexts.saturatedFat,
        AppTexts.gram,
      ),
      const (MonounsaturatedFatNutrientDataType) => AppTexts.withUnit(
        AppTexts.monounsaturatedFat,
        AppTexts.gram,
      ),
      const (PolyunsaturatedFatNutrientDataType) => AppTexts.withUnit(
        AppTexts.polyunsaturatedFat,
        AppTexts.gram,
      ),
      const (CholesterolNutrientDataType) => AppTexts.withUnit(
        AppTexts.cholesterol,
        AppTexts.milligram,
      ),
      const (DietaryFiberNutrientDataType) => AppTexts.withUnit(
        AppTexts.dietaryFiber,
        AppTexts.gram,
      ),
      const (SugarNutrientDataType) => AppTexts.withUnit(
        AppTexts.sugar,
        AppTexts.gram,
      ),

      // Minerals
      const (CalciumNutrientDataType) => AppTexts.withUnit(
        AppTexts.calcium,
        AppTexts.milligram,
      ),
      const (IronNutrientDataType) => AppTexts.withUnit(
        AppTexts.iron,
        AppTexts.milligram,
      ),
      const (MagnesiumNutrientDataType) => AppTexts.withUnit(
        AppTexts.magnesium,
        AppTexts.milligram,
      ),
      const (ManganeseNutrientDataType) => AppTexts.withUnit(
        AppTexts.manganese,
        AppTexts.milligram,
      ),
      const (PhosphorusNutrientDataType) => AppTexts.withUnit(
        AppTexts.phosphorus,
        AppTexts.milligram,
      ),
      const (PotassiumNutrientDataType) => AppTexts.withUnit(
        AppTexts.potassium,
        AppTexts.milligram,
      ),
      const (SeleniumNutrientDataType) => AppTexts.withUnit(
        AppTexts.selenium,
        AppTexts.microgram,
      ),
      const (SodiumNutrientDataType) => AppTexts.withUnit(
        AppTexts.sodium,
        AppTexts.milligram,
      ),
      const (ZincNutrientDataType) => AppTexts.withUnit(
        AppTexts.zinc,
        AppTexts.milligram,
      ),

      // Vitamins
      const (VitaminANutrientDataType) => AppTexts.withUnit(
        AppTexts.vitaminA,
        AppTexts.microgram,
      ),
      const (VitaminB6NutrientDataType) => AppTexts.withUnit(
        AppTexts.vitaminB6,
        AppTexts.milligram,
      ),
      const (VitaminB12NutrientDataType) => AppTexts.withUnit(
        AppTexts.vitaminB12,
        AppTexts.microgram,
      ),
      const (VitaminCNutrientDataType) => AppTexts.withUnit(
        AppTexts.vitaminC,
        AppTexts.milligram,
      ),
      const (VitaminDNutrientDataType) => AppTexts.withUnit(
        AppTexts.vitaminD,
        AppTexts.microgram,
      ),
      const (VitaminENutrientDataType) => AppTexts.withUnit(
        AppTexts.vitaminE,
        AppTexts.milligram,
      ),
      const (VitaminKNutrientDataType) => AppTexts.withUnit(
        AppTexts.vitaminK,
        AppTexts.microgram,
      ),
      const (ThiaminNutrientDataType) => AppTexts.withUnit(
        AppTexts.thiamin,
        AppTexts.milligram,
      ),
      const (RiboflavinNutrientDataType) => AppTexts.withUnit(
        AppTexts.riboflavin,
        AppTexts.milligram,
      ),
      const (NiacinNutrientDataType) => AppTexts.withUnit(
        AppTexts.niacin,
        AppTexts.milligram,
      ),
      const (FolateNutrientDataType) => AppTexts.withUnit(
        AppTexts.folate,
        AppTexts.microgram,
      ),
      const (BiotinNutrientDataType) => AppTexts.withUnit(
        AppTexts.biotin,
        AppTexts.microgram,
      ),
      const (PantothenicAcidNutrientDataType) => AppTexts.withUnit(
        AppTexts.pantothenicAcid,
        AppTexts.milligram,
      ),

      // Speed Types
      const (WalkingSpeedDataType) => AppTexts.walkingSpeed,
      const (RunningSpeedDataType) => AppTexts.runningSpeed,
      const (StairAscentSpeedDataType) => AppTexts.stairAscentSpeed,
      const (StairDescentSpeedDataType) => AppTexts.stairDescentSpeed,

      // Power Types
      const (CyclingPowerDataType) => AppTexts.cyclingPower,

      _ => throw ArgumentError(
        'No field label for $runtimeType. '
        'This type may not be supported or unimplemented.',
      ),
    };
  }

  /// Returns the optional suffix text for the input field.
  String? get fieldSuffix {
    return switch (runtimeType) {
      // Mass types (kilograms)
      const (WeightHealthDataType) ||
      const (LeanBodyMassHealthDataType) => AppTexts.kilogram,

      // Percentage types
      const (BodyFatPercentageHealthDataType) ||
      const (OxygenSaturationHealthDataType) => '%',

      // Distance types
      const (HeightHealthDataType) ||
      const (DistanceHealthDataType) ||
      const (CrossCountrySkiingDistanceDataType) ||
      const (CyclingDistanceDataType) ||
      const (DownhillSnowSportsDistanceDataType) ||
      const (PaddleSportsDistanceDataType) ||
      const (RowingDistanceDataType) ||
      const (SixMinuteWalkTestDistanceDataType) ||
      const (SkatingSportsDistanceDataType) ||
      const (SwimmingDistanceDataType) ||
      const (WheelchairDistanceDataType) ||
      const (WalkingRunningDistanceDataType) => AppTexts.meter,

      // Vital Signs
      const (BodyTemperatureHealthDataType) => AppTexts.celsius,
      const (SystolicBloodPressureHealthDataType) ||
      const (DiastolicBloodPressureHealthDataType) =>
        AppTexts.millimetersOfMercury,
      const (BloodGlucoseHealthDataType) => AppTexts.milligramsPerDeciliter,
      const (RespiratoryRateHealthDataType) => AppTexts.breathsPerMinute,
      const (Vo2MaxHealthDataType) => AppTexts.millilitersPerKilogramPerMinute,

      // Power
      const (CyclingPowerDataType) => 'W',

      // Activity & Energy
      const (ActiveCaloriesBurnedHealthDataType) ||
      const (EnergyNutrientDataType) => AppTexts.kilocalories,
      const (HydrationHealthDataType) => AppTexts.liter,

      // Nutrients - grams
      const (ProteinNutrientDataType) ||
      const (TotalCarbohydrateNutrientDataType) ||
      const (TotalFatNutrientDataType) ||
      const (SaturatedFatNutrientDataType) ||
      const (MonounsaturatedFatNutrientDataType) ||
      const (PolyunsaturatedFatNutrientDataType) ||
      const (DietaryFiberNutrientDataType) ||
      const (SugarNutrientDataType) => AppTexts.gram,

      // Nutrients - milligrams
      const (CaffeineNutrientDataType) ||
      const (CholesterolNutrientDataType) ||
      const (CalciumNutrientDataType) ||
      const (IronNutrientDataType) ||
      const (MagnesiumNutrientDataType) ||
      const (ManganeseNutrientDataType) ||
      const (PhosphorusNutrientDataType) ||
      const (PotassiumNutrientDataType) ||
      const (SodiumNutrientDataType) ||
      const (ZincNutrientDataType) ||
      const (VitaminB6NutrientDataType) ||
      const (VitaminCNutrientDataType) ||
      const (VitaminENutrientDataType) ||
      const (ThiaminNutrientDataType) ||
      const (RiboflavinNutrientDataType) ||
      const (NiacinNutrientDataType) ||
      const (PantothenicAcidNutrientDataType) => AppTexts.milligram,

      // Nutrients - micrograms
      const (SeleniumNutrientDataType) ||
      const (VitaminANutrientDataType) ||
      const (VitaminB12NutrientDataType) ||
      const (VitaminDNutrientDataType) ||
      const (VitaminKNutrientDataType) ||
      const (FolateNutrientDataType) ||
      const (BiotinNutrientDataType) => AppTexts.microgram,

      // No suffix for other types
      _ => null,
    };
  }

  /// Returns the error message when the input is empty.
  String get emptyInputError {
    return switch (runtimeType) {
      const (StepsHealthDataType) ||
      const (FloorsClimbedHealthDataType) ||
      const (WheelchairPushesHealthDataType) ||
      const (WalkingSpeedDataType) ||
      const (RunningSpeedDataType) ||
      const (StairAscentSpeedDataType) ||
      const (StairDescentSpeedDataType) => AppTexts.pleaseEnterValidNumber,

      const (HeartRateMeasurementRecordHealthDataType) =>
        AppTexts.getPleaseEnterText(AppTexts.heartRate),
      const (RestingHeartRateHealthDataType) => AppTexts.getPleaseEnterText(
        AppTexts.restingHeartRate,
      ),
      const (WeightHealthDataType) => AppTexts.getPleaseEnterText(
        AppTexts.weight,
      ),
      const (LeanBodyMassHealthDataType) => AppTexts.getPleaseEnterText(
        AppTexts.leanBodyMass,
      ),
      const (BodyFatPercentageHealthDataType) => AppTexts.getPleaseEnterText(
        AppTexts.bodyFatPercentage,
      ),
      const (OxygenSaturationHealthDataType) => AppTexts.getPleaseEnterText(
        AppTexts.oxygenSaturation,
      ),
      const (HeightHealthDataType) => AppTexts.getPleaseEnterText(
        AppTexts.height,
      ),
      const (DistanceHealthDataType) ||
      const (CrossCountrySkiingDistanceDataType) ||
      const (CyclingDistanceDataType) ||
      const (DownhillSnowSportsDistanceDataType) ||
      const (PaddleSportsDistanceDataType) ||
      const (RowingDistanceDataType) ||
      const (SixMinuteWalkTestDistanceDataType) ||
      const (SkatingSportsDistanceDataType) ||
      const (SwimmingDistanceDataType) ||
      const (WheelchairDistanceDataType) ||
      const (WalkingRunningDistanceDataType) => AppTexts.getPleaseEnterText(
        AppTexts.distance,
      ),
      const (BodyTemperatureHealthDataType) => AppTexts.getPleaseEnterText(
        AppTexts.bodyTemperature,
      ),
      const (SystolicBloodPressureHealthDataType) =>
        AppTexts.getPleaseEnterText(
          '${AppTexts.systolic} ${AppTexts.bloodPressure}',
        ),
      const (DiastolicBloodPressureHealthDataType) =>
        AppTexts.getPleaseEnterText(
          '${AppTexts.diastolic} ${AppTexts.bloodPressure}',
        ),
      const (BloodGlucoseHealthDataType) => AppTexts.getPleaseEnterText(
        AppTexts.bloodGlucose,
      ),
      const (RespiratoryRateHealthDataType) => AppTexts.getPleaseEnterText(
        AppTexts.respiratoryRate,
      ),
      const (Vo2MaxHealthDataType) => AppTexts.getPleaseEnterText(
        AppTexts.vo2Max,
      ),
      const (CyclingPowerDataType) => AppTexts.getPleaseEnterText(
        AppTexts.power,
      ),
      const (ActiveCaloriesBurnedHealthDataType) => AppTexts.getPleaseEnterText(
        AppTexts.activeCaloriesBurned,
      ),
      const (EnergyNutrientDataType) => AppTexts.getPleaseEnterText(
        AppTexts.energy,
      ),
      const (HydrationHealthDataType) => AppTexts.getPleaseEnterText(
        AppTexts.hydration,
      ),
      const (CaffeineNutrientDataType) => AppTexts.getPleaseEnterText(
        AppTexts.caffeine,
      ),
      const (ProteinNutrientDataType) => AppTexts.getPleaseEnterText(
        AppTexts.protein,
      ),
      const (TotalCarbohydrateNutrientDataType) => AppTexts.getPleaseEnterText(
        AppTexts.totalCarbohydrate,
      ),
      const (TotalFatNutrientDataType) => AppTexts.getPleaseEnterText(
        AppTexts.totalFat,
      ),
      const (SaturatedFatNutrientDataType) => AppTexts.getPleaseEnterText(
        AppTexts.saturatedFat,
      ),
      const (MonounsaturatedFatNutrientDataType) => AppTexts.getPleaseEnterText(
        AppTexts.monounsaturatedFat,
      ),
      const (PolyunsaturatedFatNutrientDataType) => AppTexts.getPleaseEnterText(
        AppTexts.polyunsaturatedFat,
      ),
      const (CholesterolNutrientDataType) => AppTexts.getPleaseEnterText(
        AppTexts.cholesterol,
      ),
      const (DietaryFiberNutrientDataType) => AppTexts.getPleaseEnterText(
        AppTexts.dietaryFiber,
      ),
      const (SugarNutrientDataType) => AppTexts.getPleaseEnterText(
        AppTexts.sugar,
      ),
      const (CalciumNutrientDataType) => AppTexts.getPleaseEnterText(
        AppTexts.calcium,
      ),
      const (IronNutrientDataType) => AppTexts.getPleaseEnterText(
        AppTexts.iron,
      ),
      const (MagnesiumNutrientDataType) => AppTexts.getPleaseEnterText(
        AppTexts.magnesium,
      ),
      const (ManganeseNutrientDataType) => AppTexts.getPleaseEnterText(
        AppTexts.manganese,
      ),
      const (PhosphorusNutrientDataType) => AppTexts.getPleaseEnterText(
        AppTexts.phosphorus,
      ),
      const (PotassiumNutrientDataType) => AppTexts.getPleaseEnterText(
        AppTexts.potassium,
      ),
      const (SeleniumNutrientDataType) => AppTexts.getPleaseEnterText(
        AppTexts.selenium,
      ),
      const (SodiumNutrientDataType) => AppTexts.getPleaseEnterText(
        AppTexts.sodium,
      ),
      const (ZincNutrientDataType) => AppTexts.getPleaseEnterText(
        AppTexts.zinc,
      ),
      const (VitaminANutrientDataType) => AppTexts.getPleaseEnterText(
        AppTexts.vitaminA,
      ),
      const (VitaminB6NutrientDataType) => AppTexts.getPleaseEnterText(
        AppTexts.vitaminB6,
      ),
      const (VitaminB12NutrientDataType) => AppTexts.getPleaseEnterText(
        AppTexts.vitaminB12,
      ),
      const (VitaminCNutrientDataType) => AppTexts.getPleaseEnterText(
        AppTexts.vitaminC,
      ),
      const (VitaminDNutrientDataType) => AppTexts.getPleaseEnterText(
        AppTexts.vitaminD,
      ),
      const (VitaminENutrientDataType) => AppTexts.getPleaseEnterText(
        AppTexts.vitaminE,
      ),
      const (VitaminKNutrientDataType) => AppTexts.getPleaseEnterText(
        AppTexts.vitaminK,
      ),
      const (ThiaminNutrientDataType) => AppTexts.getPleaseEnterText(
        AppTexts.thiamin,
      ),
      const (RiboflavinNutrientDataType) => AppTexts.getPleaseEnterText(
        AppTexts.riboflavin,
      ),
      const (NiacinNutrientDataType) => AppTexts.getPleaseEnterText(
        AppTexts.niacin,
      ),
      const (FolateNutrientDataType) => AppTexts.getPleaseEnterText(
        AppTexts.folate,
      ),
      const (BiotinNutrientDataType) => AppTexts.getPleaseEnterText(
        AppTexts.biotin,
      ),
      const (PantothenicAcidNutrientDataType) => AppTexts.getPleaseEnterText(
        AppTexts.pantothenicAcid,
      ),

      _ => AppTexts.pleaseEnterValidNumber,
    };
  }
}
