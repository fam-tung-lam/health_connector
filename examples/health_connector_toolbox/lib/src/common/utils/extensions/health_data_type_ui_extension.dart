import 'package:flutter/material.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/common/constants/app_icons.dart';
import 'package:health_connector_toolbox/src/common/constants/app_texts.dart';

/// Extension on [HealthDataType] to provide UI-related properties.
extension HealthDataTypeUI on HealthDataType {
  /// Returns the display name for this health data type.
  ///
  /// This name should be used in UI elements.
  String get displayName {
    return switch (this) {
      StepsDataType _ => AppTexts.steps,
      WeightDataType _ => AppTexts.weight,
      HeightDataType _ => AppTexts.height,
      BloodPressureDataType _ => AppTexts.bloodPressure,
      SystolicBloodPressureDataType _ => AppTexts.systolicBloodPressure,
      DiastolicBloodPressureDataType _ => AppTexts.diastolicBloodPressure,
      BodyFatPercentageDataType _ => AppTexts.bodyFatPercentage,
      LeanBodyMassDataType _ => AppTexts.leanBodyMass,
      BodyTemperatureDataType _ => AppTexts.bodyTemperature,
      BasalBodyTemperatureDataType _ => AppTexts.basalBodyTemperature,
      DistanceDataType _ => AppTexts.distance,
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
      ActiveEnergyBurnedDataType _ => AppTexts.activeCaloriesBurned,
      BasalEnergyBurnedDataType _ => AppTexts.basalEnergyBurned,
      TotalEnergyBurnedDataType _ => AppTexts.totalCaloriesBurned,
      FloorsClimbedDataType _ => AppTexts.floorsClimbed,
      WheelchairPushesDataType _ => AppTexts.wheelchairPushes,
      HydrationDataType _ => AppTexts.hydration,
      HeartRateMeasurementRecordDataType _ => AppTexts.heartRate,
      HeartRateSeriesRecordDataType _ => AppTexts.heartRate,
      CyclingPedalingCadenceDataType _ => AppTexts.cyclingPedalingCadence,
      CyclingPedalingCadenceSeriesDataType _ => AppTexts.cyclingPedalingCadence,
      RestingHeartRateDataType _ => AppTexts.restingHeartRate,
      SleepSessionDataType _ => AppTexts.sleepSession,
      SleepStageDataType _ => AppTexts.sleepStage,
      SexualActivityDataType _ => AppTexts.sexualActivity,
      IntermenstrualBleedingDataType _ => AppTexts.intermenstrualBleeding,
      OvulationTestDataType _ => AppTexts.ovulationTest,
      OxygenSaturationDataType _ => AppTexts.oxygenSaturation,
      NutritionDataType _ => AppTexts.nutrition,
      DietaryEnergyConsumedDataType _ => AppTexts.energy,
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
      RespiratoryRateDataType _ => AppTexts.respiratoryRate,
      Vo2MaxDataType _ => AppTexts.vo2Max,
      BloodGlucoseDataType _ => AppTexts.bloodGlucose,
      SpeedSeriesDataType _ => AppTexts.speed,
      WalkingSpeedDataType _ => AppTexts.walkingSpeed,
      RunningSpeedDataType _ => AppTexts.runningSpeed,
      StairAscentSpeedDataType _ => AppTexts.stairAscentSpeed,
      StairDescentSpeedDataType _ => AppTexts.stairDescentSpeed,
      PowerSeriesDataType _ => AppTexts.powerSeries,
      CyclingPowerDataType _ => AppTexts.cyclingPower,
      ExerciseSessionDataType _ => AppTexts.exerciseSession,
      CervicalMucusDataType _ => AppTexts.cervicalMucus,
      MindfulnessSessionDataType _ => AppTexts.mindfulnessSession,
      BoneMassDataType _ => AppTexts.boneMass,
      BodyWaterMassDataType _ => AppTexts.bodyWaterMass,
      HeartRateVariabilityRMSSDDataType _ => AppTexts.heartRateVariabilityRMSSD,
      BodyMassIndexDataType _ => AppTexts.bodyMassIndex,
      WaistCircumferenceDataType _ => AppTexts.waistCircumference,
      HeartRateVariabilitySDNNDataType _ => AppTexts.heartRateVariabilitySDNN,
      MenstrualFlowDataType _ => AppTexts.menstrualFlow,
      MenstrualFlowInstantDataType _ => AppTexts.menstrualFlow,
    };
  }

  /// Returns a description for this health data type.
  ///
  /// This description provides additional context about what the data type
  /// represents and is suitable for subtitle text or tooltips.
  String get description {
    return switch (this) {
      StepsDataType _ => AppTexts.stepsDescription,
      WeightDataType _ => AppTexts.weightDescription,
      HeightDataType _ => AppTexts.heightDescription,
      BloodPressureDataType _ => AppTexts.bloodPressureDescription,
      SystolicBloodPressureDataType _ =>
        AppTexts.systolicBloodPressureDescription,
      DiastolicBloodPressureDataType _ =>
        AppTexts.diastolicBloodPressureDescription,
      BodyFatPercentageDataType _ => AppTexts.bodyFatPercentageDescription,
      LeanBodyMassDataType _ => AppTexts.leanBodyMassDescription,
      BodyTemperatureDataType _ => AppTexts.bodyTemperatureDescription,
      BasalBodyTemperatureDataType _ =>
        AppTexts.basalBodyTemperatureDescription,
      DistanceDataType _ => AppTexts.distanceDescription,
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
      ActiveEnergyBurnedDataType _ => AppTexts.activeCaloriesBurnedDescription,
      BasalEnergyBurnedDataType _ => AppTexts.basalEnergyBurnedDescription,
      TotalEnergyBurnedDataType _ => AppTexts.totalCaloriesBurnedDescription,
      FloorsClimbedDataType _ => AppTexts.floorsClimbedDescription,
      WheelchairPushesDataType _ => AppTexts.wheelchairPushesDescription,
      HydrationDataType _ => AppTexts.hydrationDescription,
      HeartRateMeasurementRecordDataType _ =>
        AppTexts.heartRateRecordDescription,
      HeartRateSeriesRecordDataType _ =>
        AppTexts.heartRateSeriesRecordDescription,
      CyclingPedalingCadenceDataType _ =>
        AppTexts.cyclingPedalingCadenceRecordDescription,
      CyclingPedalingCadenceSeriesDataType _ =>
        AppTexts.cyclingPedalingCadenceSeriesRecordDescription,
      RestingHeartRateDataType _ => AppTexts.restingHeartRateDescription,
      SleepSessionDataType _ => AppTexts.sleepSessionDescription,
      SleepStageDataType _ => AppTexts.sleepStageRecordDescription,
      SexualActivityDataType _ => AppTexts.sexualActivityDescription,
      OxygenSaturationDataType _ => AppTexts.oxygenSaturationDescription,
      NutritionDataType _ => AppTexts.nutritionDescription,
      DietaryEnergyConsumedDataType _ => AppTexts.energyDescription,
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
      RespiratoryRateDataType _ => AppTexts.respiratoryRateDescription,
      Vo2MaxDataType _ => AppTexts.vo2MaxDescription,
      BloodGlucoseDataType _ => AppTexts.bloodGlucoseDescription,
      SpeedSeriesDataType _ => AppTexts.speedDescription,
      WalkingSpeedDataType _ => AppTexts.speedDescription,
      RunningSpeedDataType _ => AppTexts.speedDescription,
      StairAscentSpeedDataType _ => AppTexts.speedDescription,
      StairDescentSpeedDataType _ => AppTexts.speedDescription,
      PowerSeriesDataType _ => 'Power output measurements over time (Android)',
      CyclingPowerDataType _ => 'Cycling power output in watts (iOS)',
      ExerciseSessionDataType _ => 'Period of physical activity',
      MindfulnessSessionDataType _ => 'Period of mindfulness practice',
      CervicalMucusDataType _ => AppTexts.cervicalMucusDescription,
      IntermenstrualBleedingDataType _ =>
        'Record of intermenstrual bleeding or spotting between periods',
      OvulationTestDataType _ => AppTexts.ovulationTestDescription,
      BoneMassDataType _ => AppTexts.boneMassDescription,
      BodyWaterMassDataType _ => AppTexts.bodyWaterMassDescription,
      HeartRateVariabilityRMSSDDataType _ =>
        AppTexts.heartRateVariabilityRMSSDDescription,
      BodyMassIndexDataType _ => AppTexts.bodyMassIndexDescription,
      WaistCircumferenceDataType _ => AppTexts.waistCircumferenceDescription,
      HeartRateVariabilitySDNNDataType _ =>
        AppTexts.heartRateVariabilitySDNNDescription,
      MenstrualFlowDataType _ => 'Menstrual flow intensity over time (iOS)',
      MenstrualFlowInstantDataType _ =>
        'Menstrual flow intensity snapshot (Android)',
    };
  }

  /// Returns the icon for this health data type.
  ///
  /// This icon should be used consistently across the app to represent
  /// the health data type in UI elements.
  IconData get icon {
    return switch (this) {
      StepsDataType _ => AppIcons.directionsWalk,
      WeightDataType _ => AppIcons.monitorWeight,
      HeightDataType _ => AppIcons.height,
      BloodPressureDataType _ => AppIcons.bloodPressure,
      SystolicBloodPressureDataType _ => AppIcons.bloodPressure,
      DiastolicBloodPressureDataType _ => AppIcons.bloodPressure,
      BodyFatPercentageDataType _ => AppIcons.percent,
      LeanBodyMassDataType _ => AppIcons.monitorWeight,
      BodyTemperatureDataType _ => AppIcons.temperature,
      BasalBodyTemperatureDataType _ => AppIcons.temperature,
      DistanceDataType _ => AppIcons.straighten,
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
      ActiveEnergyBurnedDataType _ => AppIcons.localFireDepartment,
      BasalEnergyBurnedDataType _ => AppIcons.localFireDepartment,
      TotalEnergyBurnedDataType _ => AppIcons.localFireDepartment,
      FloorsClimbedDataType _ => AppIcons.stairs,
      WheelchairPushesDataType _ => AppIcons.accessible,
      HydrationDataType _ => AppIcons.volume,
      HeartRateMeasurementRecordDataType _ => AppIcons.favorite,
      HeartRateSeriesRecordDataType _ => AppIcons.favorite,
      CyclingPedalingCadenceDataType _ => AppIcons.speed,
      CyclingPedalingCadenceSeriesDataType _ => AppIcons.speed,
      RestingHeartRateDataType _ => AppIcons.favorite,
      SleepSessionDataType _ => AppIcons.bedtime,
      SleepStageDataType _ => AppIcons.bedtime,
      SexualActivityDataType _ => AppIcons.favorite,
      OxygenSaturationDataType _ => AppIcons.percent,
      NutritionDataType _ => AppIcons.fastfood,
      DietaryEnergyConsumedDataType _ => AppIcons.localFireDepartment,
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
      RespiratoryRateDataType _ => AppIcons.air,
      Vo2MaxDataType _ => AppIcons.vo2Max,
      BloodGlucoseDataType _ => AppIcons.bloodGlucose,
      SpeedSeriesDataType _ => AppIcons.speed,
      WalkingSpeedDataType _ => AppIcons.speed,
      RunningSpeedDataType _ => AppIcons.speed,
      StairAscentSpeedDataType _ => AppIcons.speed,
      StairDescentSpeedDataType _ => AppIcons.speed,
      PowerSeriesDataType _ => AppIcons.power,
      CyclingPowerDataType _ => AppIcons.power,
      ExerciseSessionDataType _ => AppIcons.fitnessCenter,
      CervicalMucusDataType _ => AppIcons.waterDrop,
      IntermenstrualBleedingDataType _ => AppIcons.waterDrop,
      OvulationTestDataType _ => AppIcons.science,
      MindfulnessSessionDataType _ => AppIcons.selfImprovement,
      BoneMassDataType _ => AppIcons.monitorWeight,
      BodyWaterMassDataType _ => AppIcons.waterDrop,
      HeartRateVariabilityRMSSDDataType _ => AppIcons.favorite,
      BodyMassIndexDataType _ => AppIcons.monitorWeight,
      WaistCircumferenceDataType _ => AppIcons.straighten,
      HeartRateVariabilitySDNNDataType _ => AppIcons.favorite,
      MenstrualFlowDataType _ => AppIcons.waterDrop,
      MenstrualFlowInstantDataType _ => AppIcons.waterDrop,
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
      const (StepsDataType) ||
      const (FloorsClimbedDataType) ||
      const (WheelchairPushesDataType) ||
      const (HeartRateMeasurementRecordDataType) ||
      const (RestingHeartRateDataType) => TextInputType.number,

      // All other types use decimal number input
      _ => const TextInputType.numberWithOptions(decimal: true),
    };
  }

  /// Returns the label text for the input field.
  String get fieldLabel {
    return switch (runtimeType) {
      // Count Types
      const (StepsDataType) => AppTexts.stepCount,
      const (FloorsClimbedDataType) => AppTexts.floorsClimbed,
      const (WheelchairPushesDataType) => AppTexts.wheelchairPushes,
      const (HeartRateMeasurementRecordDataType) => AppTexts.valueWithUnit(
        AppTexts.heartRate,
        AppTexts.bpm,
      ),
      const (RestingHeartRateDataType) => AppTexts.valueWithUnit(
        AppTexts.restingHeartRate,
        AppTexts.bpm,
      ),

      // Mass Types (Kilograms)
      const (WeightDataType) => AppTexts.valueWithUnit(
        AppTexts.weight,
        AppTexts.kilogram,
      ),
      const (LeanBodyMassDataType) => AppTexts.valueWithUnit(
        AppTexts.leanBodyMass,
        AppTexts.kilogram,
      ),
      const (BoneMassDataType) => AppTexts.valueWithUnit(
        AppTexts.boneMass,
        AppTexts.kilogram,
      ),
      const (BodyWaterMassDataType) => AppTexts.valueWithUnit(
        AppTexts.bodyWaterMass,
        AppTexts.kilogram,
      ),
      const (HeartRateVariabilityRMSSDDataType) => AppTexts.valueWithUnit(
        AppTexts.heartRateVariabilityRMSSD,
        AppTexts.millisecond,
      ),
      const (BodyMassIndexDataType) => AppTexts.valueWithUnit(
        AppTexts.bodyMassIndex,
        'kg/m²',
      ),
      const (WaistCircumferenceDataType) => AppTexts.valueWithUnit(
        AppTexts.waistCircumference,
        AppTexts.meter,
      ),
      const (HeartRateVariabilitySDNNDataType) => AppTexts.valueWithUnit(
        AppTexts.heartRateVariabilitySDNN,
        AppTexts.millisecond,
      ),

      // Percentage Types
      const (BodyFatPercentageDataType) => AppTexts.withUnit(
        AppTexts.bodyFatPercentage,
        AppTexts.percent,
      ),
      const (OxygenSaturationDataType) => AppTexts.withUnit(
        AppTexts.oxygenSaturation,
        AppTexts.percent,
      ),

      // Distance Types
      const (HeightDataType) => AppTexts.valueWithUnit(
        AppTexts.height,
        AppTexts.meter,
      ),
      const (DistanceDataType) => AppTexts.valueWithUnit(
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
      const (BodyTemperatureDataType) => AppTexts.withUnit(
        AppTexts.bodyTemperature,
        AppTexts.celsius,
      ),
      const (BasalBodyTemperatureDataType) => AppTexts.withUnit(
        AppTexts.basalBodyTemperature,
        AppTexts.celsius,
      ),
      const (SystolicBloodPressureDataType) => AppTexts.withUnit(
        '${AppTexts.systolic} ${AppTexts.bloodPressure}',
        AppTexts.millimetersOfMercury,
      ),
      const (DiastolicBloodPressureDataType) => AppTexts.withUnit(
        '${AppTexts.diastolic} ${AppTexts.bloodPressure}',
        AppTexts.millimetersOfMercury,
      ),
      const (BloodGlucoseDataType) => AppTexts.withUnit(
        AppTexts.bloodGlucose,
        AppTexts.milligramsPerDeciliter,
      ),
      const (RespiratoryRateDataType) => AppTexts.withUnit(
        AppTexts.respiratoryRate,
        AppTexts.breathsPerMinute,
      ),
      const (Vo2MaxDataType) => AppTexts.withUnit(
        AppTexts.vo2Max,
        AppTexts.millilitersPerKilogramPerMinute,
      ),

      // Activity & Energy
      const (ActiveEnergyBurnedDataType) => AppTexts.withUnit(
        AppTexts.activeCaloriesBurned,
        AppTexts.kilocalories,
      ),
      const (TotalEnergyBurnedDataType) => AppTexts.withUnit(
        AppTexts.activeCaloriesBurned,
        AppTexts.kilocalories,
      ),
      const (BasalEnergyBurnedDataType) => AppTexts.withUnit(
        AppTexts.activeCaloriesBurned,
        AppTexts.kilocalories,
      ),
      const (DietaryEnergyConsumedDataType) => AppTexts.withUnit(
        AppTexts.energy,
        AppTexts.kilocalories,
      ),
      const (HydrationDataType) => AppTexts.valueWithUnit(
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

      // Reproductive Health
      const (SexualActivityDataType) => AppTexts.sexualActivity,
      const (CervicalMucusDataType) => AppTexts.cervicalMucus,
      const (CyclingPedalingCadenceDataType) => AppTexts.cyclingPedalingCadence,

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
      const (WeightDataType) ||
      const (LeanBodyMassDataType) ||
      const (BoneMassDataType) ||
      const (BodyWaterMassDataType) => AppTexts.kilogram,

      // Percentage types
      const (BodyFatPercentageDataType) ||
      const (OxygenSaturationDataType) => '%',

      const (BodyMassIndexDataType) => 'kg/m²',

      // Distance types
      const (HeightDataType) ||
      const (DistanceDataType) ||
      const (CrossCountrySkiingDistanceDataType) ||
      const (CyclingDistanceDataType) ||
      const (DownhillSnowSportsDistanceDataType) ||
      const (PaddleSportsDistanceDataType) ||
      const (RowingDistanceDataType) ||
      const (SixMinuteWalkTestDistanceDataType) ||
      const (SkatingSportsDistanceDataType) ||
      const (SwimmingDistanceDataType) ||
      const (WheelchairDistanceDataType) ||
      const (WaistCircumferenceDataType) ||
      const (WalkingRunningDistanceDataType) => AppTexts.meter,

      // Vital Signs
      const (BodyTemperatureDataType) => AppTexts.celsius,
      const (BasalEnergyBurnedDataType) => AppTexts.celsius,
      const (SystolicBloodPressureDataType) ||
      const (DiastolicBloodPressureDataType) => AppTexts.millimetersOfMercury,
      const (BloodGlucoseDataType) => AppTexts.milligramsPerDeciliter,
      const (RespiratoryRateDataType) => AppTexts.breathsPerMinute,
      const (Vo2MaxDataType) => AppTexts.millilitersPerKilogramPerMinute,
      const (HeartRateVariabilityRMSSDDataType) ||
      const (HeartRateVariabilitySDNNDataType) => AppTexts.millisecond,

      // Power
      const (CyclingPowerDataType) => 'W',

      // Activity & Energy
      const (ActiveEnergyBurnedDataType) ||
      const (BasalEnergyBurnedDataType) ||
      const (TotalEnergyBurnedDataType) ||
      const (DietaryEnergyConsumedDataType) => AppTexts.kilocalories,
      const (HydrationDataType) => AppTexts.liter,

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
      const (StepsDataType) ||
      const (FloorsClimbedDataType) ||
      const (WheelchairPushesDataType) ||
      const (WalkingSpeedDataType) ||
      const (RunningSpeedDataType) ||
      const (StairAscentSpeedDataType) ||
      const (StairDescentSpeedDataType) => AppTexts.pleaseEnterValidNumber,

      const (HeartRateMeasurementRecordDataType) => AppTexts.getPleaseEnterText(
        AppTexts.heartRate,
      ),
      const (RestingHeartRateDataType) => AppTexts.getPleaseEnterText(
        AppTexts.restingHeartRate,
      ),
      const (WeightDataType) => AppTexts.getPleaseEnterText(
        AppTexts.weight,
      ),
      const (LeanBodyMassDataType) => AppTexts.getPleaseEnterText(
        AppTexts.leanBodyMass,
      ),
      const (BodyFatPercentageDataType) => AppTexts.getPleaseEnterText(
        AppTexts.bodyFatPercentage,
      ),
      const (OxygenSaturationDataType) => AppTexts.getPleaseEnterText(
        AppTexts.oxygenSaturation,
      ),
      const (HeightDataType) => AppTexts.getPleaseEnterText(
        AppTexts.height,
      ),
      const (DistanceDataType) ||
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
      const (BodyTemperatureDataType) => AppTexts.getPleaseEnterText(
        AppTexts.bodyTemperature,
      ),
      const (BasalBodyTemperatureDataType) => AppTexts.getPleaseEnterText(
        AppTexts.basalBodyTemperature,
      ),
      const (SystolicBloodPressureDataType) => AppTexts.getPleaseEnterText(
        '${AppTexts.systolic} ${AppTexts.bloodPressure}',
      ),
      const (DiastolicBloodPressureDataType) => AppTexts.getPleaseEnterText(
        '${AppTexts.diastolic} ${AppTexts.bloodPressure}',
      ),
      const (BloodGlucoseDataType) => AppTexts.getPleaseEnterText(
        AppTexts.bloodGlucose,
      ),
      const (RespiratoryRateDataType) => AppTexts.getPleaseEnterText(
        AppTexts.respiratoryRate,
      ),
      const (Vo2MaxDataType) => AppTexts.getPleaseEnterText(
        AppTexts.vo2Max,
      ),
      const (CyclingPowerDataType) => AppTexts.getPleaseEnterText(
        AppTexts.power,
      ),
      const (ActiveEnergyBurnedDataType) => AppTexts.getPleaseEnterText(
        AppTexts.activeCaloriesBurned,
      ),
      const (DietaryEnergyConsumedDataType) => AppTexts.getPleaseEnterText(
        AppTexts.energy,
      ),
      const (HydrationDataType) => AppTexts.getPleaseEnterText(
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
