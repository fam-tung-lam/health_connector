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
      SleepingWristTemperatureDataType _ => 'Sleeping Wrist Temperature',
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
      ActiveEnergyBurnedDataType _ => AppTexts.activeEnergyBurned,
      AlcoholicBeveragesDataType _ => AppTexts.alcoholicBeverages,
      BloodAlcoholContentDataType _ => AppTexts.bloodAlcoholContent,
      BasalEnergyBurnedDataType _ => AppTexts.basalEnergyBurned,
      TotalEnergyBurnedDataType _ => AppTexts.totalEnergyBurned,
      FloorsClimbedDataType _ => AppTexts.floorsClimbed,
      ElevationGainedDataType _ => AppTexts.elevationGained,
      WheelchairPushesDataType _ => AppTexts.wheelchairPushes,
      SwimmingStrokesDataType _ => AppTexts.swimmingStrokes,
      HydrationDataType _ => AppTexts.hydration,
      HeartRateDataType _ => AppTexts.heartRate,
      HeartRateSeriesDataType _ => AppTexts.heartRate,
      StepsCadenceSeriesDataType _ => AppTexts.stepsCadence,
      CyclingPedalingCadenceDataType _ => AppTexts.cyclingPedalingCadence,
      CyclingPedalingCadenceSeriesDataType _ => AppTexts.cyclingPedalingCadence,
      RestingHeartRateDataType _ => AppTexts.restingHeartRate,
      SleepSessionDataType _ => AppTexts.sleepSession,
      SleepStageDataType _ => AppTexts.sleepStage,
      SexualActivityDataType _ => AppTexts.sexualActivity,
      IntermenstrualBleedingDataType _ => AppTexts.intermenstrualBleeding,
      OvulationTestDataType _ => AppTexts.ovulationTest,
      PregnancyDataType _ => AppTexts.pregnancy,
      ContraceptiveDataType _ => AppTexts.contraceptive,
      PregnancyTestDataType _ => AppTexts.pregnancyTest,
      ProgesteroneTestDataType _ => AppTexts.progesteroneTest,
      OxygenSaturationDataType _ => AppTexts.oxygenSaturation,
      NutritionDataType _ => AppTexts.nutrition,
      DietaryEnergyConsumedDataType _ => AppTexts.energy,
      DietaryCaffeineDataType _ => AppTexts.caffeine,
      DietaryProteinDataType _ => AppTexts.protein,
      DietaryTotalCarbohydrateDataType _ => AppTexts.totalCarbohydrate,
      DietaryTotalFatDataType _ => AppTexts.totalFat,
      DietarySaturatedFatDataType _ => AppTexts.saturatedFat,
      DietaryMonounsaturatedFatDataType _ => AppTexts.monounsaturatedFat,
      DietaryPolyunsaturatedFatDataType _ => AppTexts.polyunsaturatedFat,
      DietaryCholesterolDataType _ => AppTexts.cholesterol,
      DietaryFiberNutrientDataType _ => AppTexts.dietaryFiber,
      DietarySugarDataType _ => AppTexts.sugar,
      DietaryCalciumDataType _ => AppTexts.calcium,
      DietaryIronDataType _ => AppTexts.iron,
      DietaryMagnesiumDataType _ => AppTexts.magnesium,
      DietaryManganeseDataType _ => AppTexts.manganese,
      DietaryPhosphorusDataType _ => AppTexts.phosphorus,
      DietaryPotassiumDataType _ => AppTexts.potassium,
      DietarySeleniumDataType _ => AppTexts.selenium,
      DietarySodiumDataType _ => AppTexts.sodium,
      DietaryZincDataType _ => AppTexts.zinc,
      DietaryVitaminADataType _ => AppTexts.vitaminA,
      DietaryVitaminB6DataType _ => AppTexts.vitaminB6,
      DietaryVitaminB12DataType _ => AppTexts.vitaminB12,
      DietaryVitaminCDataType _ => AppTexts.vitaminC,
      DietaryVitaminDDataType _ => AppTexts.vitaminD,
      DietaryVitaminEDataType _ => AppTexts.vitaminE,
      DietaryVitaminKDataType _ => AppTexts.vitaminK,
      DietaryThiaminDataType _ => AppTexts.thiamin,
      DietaryRiboflavinDataType _ => AppTexts.riboflavin,
      DietaryNiacinDataType _ => AppTexts.niacin,
      DietaryFolateDataType _ => AppTexts.folate,
      DietaryBiotinDataType _ => AppTexts.biotin,
      DietaryPantothenicAcidDataType _ => AppTexts.pantothenicAcid,
      RespiratoryRateDataType _ => AppTexts.respiratoryRate,
      ForcedVitalCapacityDataType _ => AppTexts.forcedVitalCapacity,
      Vo2MaxDataType _ => AppTexts.vo2Max,
      BloodGlucoseDataType _ => AppTexts.bloodGlucose,
      SpeedSeriesDataType _ => AppTexts.speed,
      WalkingSpeedDataType _ => AppTexts.walkingSpeed,
      RunningSpeedDataType _ => AppTexts.runningSpeed,
      StairAscentSpeedDataType _ => AppTexts.stairAscentSpeed,
      StairDescentSpeedDataType _ => AppTexts.stairDescentSpeed,
      PowerSeriesDataType _ => AppTexts.powerSeries,
      CyclingPowerDataType _ => AppTexts.cyclingPower,
      RunningPowerDataType _ => AppTexts.runningPower,
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
      PeripheralPerfusionIndexDataType _ => AppTexts.peripheralPerfusionIndex,
      LactationDataType _ => AppTexts.lactation,
      ActivityIntensityDataType _ => AppTexts.activityIntensity,
      ExerciseTimeDataType _ => AppTexts.exerciseTime,
      MoveTimeDataType _ => AppTexts.moveTime,
      StandTimeDataType _ => AppTexts.standTime,
      WalkingSteadinessDataType _ => 'Walking Steadiness',
      WalkingAsymmetryPercentageDataType _ =>
        AppTexts.walkingAsymmetryPercentage,
      WalkingDoubleSupportPercentageDataType _ =>
        AppTexts.walkingDoubleSupportPercentage,
      WalkingStepLengthDataType _ => AppTexts.walkingStepLength,
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
      SleepingWristTemperatureDataType _ =>
        'Temperature measured while sleeping (iOS only)',
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
      ActiveEnergyBurnedDataType _ => AppTexts.activeEnergyBurnedDescription,
      AlcoholicBeveragesDataType _ => AppTexts.alcoholicBeveragesDescription,
      BloodAlcoholContentDataType _ => AppTexts.bloodAlcoholContentDescription,
      BasalEnergyBurnedDataType _ => AppTexts.basalEnergyBurnedDescription,
      TotalEnergyBurnedDataType _ => AppTexts.totalEnergyBurnedDescription,
      FloorsClimbedDataType _ => AppTexts.floorsClimbedDescription,
      ElevationGainedDataType _ => 'Accumulated elevation gain',
      WheelchairPushesDataType _ => AppTexts.wheelchairPushesDescription,
      SwimmingStrokesDataType _ => 'Count of swimming strokes',
      HydrationDataType _ => AppTexts.hydrationDescription,
      HeartRateDataType _ => AppTexts.heartRateRecordDescription,
      HeartRateSeriesDataType _ => AppTexts.heartRateSeriesRecordDescription,
      StepsCadenceSeriesDataType _ =>
        AppTexts.stepsCadenceSeriesRecordDescription,
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
      DietaryCaffeineDataType _ => AppTexts.caffeineDescription,
      DietaryProteinDataType _ => AppTexts.proteinDescription,
      DietaryTotalCarbohydrateDataType _ =>
        AppTexts.totalCarbohydrateDescription,
      DietaryTotalFatDataType _ => AppTexts.totalFatDescription,
      DietarySaturatedFatDataType _ => AppTexts.saturatedFatDescription,
      DietaryMonounsaturatedFatDataType _ =>
        AppTexts.monounsaturatedFatDescription,
      DietaryPolyunsaturatedFatDataType _ =>
        AppTexts.polyunsaturatedFatDescription,
      DietaryCholesterolDataType _ => AppTexts.cholesterolDescription,
      DietaryFiberNutrientDataType _ => AppTexts.dietaryFiberDescription,
      DietarySugarDataType _ => AppTexts.sugarDescription,
      DietaryCalciumDataType _ => AppTexts.calciumDescription,
      DietaryIronDataType _ => AppTexts.ironDescription,
      DietaryMagnesiumDataType _ => AppTexts.magnesiumDescription,
      DietaryManganeseDataType _ => AppTexts.manganeseDescription,
      DietaryPhosphorusDataType _ => AppTexts.phosphorusDescription,
      DietaryPotassiumDataType _ => AppTexts.potassiumDescription,
      DietarySeleniumDataType _ => AppTexts.seleniumDescription,
      DietarySodiumDataType _ => AppTexts.sodiumDescription,
      DietaryZincDataType _ => AppTexts.zincDescription,
      DietaryVitaminADataType _ => AppTexts.vitaminADescription,
      DietaryVitaminB6DataType _ => AppTexts.vitaminB6Description,
      DietaryVitaminB12DataType _ => AppTexts.vitaminB12Description,
      DietaryVitaminCDataType _ => AppTexts.vitaminCDescription,
      DietaryVitaminDDataType _ => AppTexts.vitaminDDescription,
      DietaryVitaminEDataType _ => AppTexts.vitaminEDescription,
      DietaryVitaminKDataType _ => AppTexts.vitaminKDescription,
      DietaryThiaminDataType _ => AppTexts.thiaminDescription,
      DietaryRiboflavinDataType _ => AppTexts.riboflavinDescription,
      DietaryNiacinDataType _ => AppTexts.niacinDescription,
      DietaryFolateDataType _ => AppTexts.folateDescription,
      DietaryBiotinDataType _ => AppTexts.biotinDescription,
      DietaryPantothenicAcidDataType _ => AppTexts.pantothenicAcidDescription,
      RespiratoryRateDataType _ => AppTexts.respiratoryRateDescription,
      ForcedVitalCapacityDataType _ => AppTexts.forcedVitalCapacityDescription,
      Vo2MaxDataType _ => AppTexts.vo2MaxDescription,
      BloodGlucoseDataType _ => AppTexts.bloodGlucoseDescription,
      SpeedSeriesDataType _ => AppTexts.speedDescription,
      WalkingSpeedDataType _ => AppTexts.speedDescription,
      RunningSpeedDataType _ => AppTexts.speedDescription,
      StairAscentSpeedDataType _ => AppTexts.speedDescription,
      StairDescentSpeedDataType _ => AppTexts.speedDescription,
      PowerSeriesDataType _ => 'Power output measurements over time (Android)',
      CyclingPowerDataType _ => 'Cycling power output in watts (iOS)',
      RunningPowerDataType _ => 'Running power output in watts (iOS)',
      ExerciseSessionDataType _ => 'Period of physical activity',
      MindfulnessSessionDataType _ => 'Period of mindfulness practice',
      CervicalMucusDataType _ => AppTexts.cervicalMucusDescription,
      IntermenstrualBleedingDataType _ =>
        'Record of intermenstrual bleeding or spotting between periods',
      OvulationTestDataType _ => AppTexts.ovulationTestDescription,
      PregnancyDataType _ => AppTexts.pregnancyDescription,
      ContraceptiveDataType _ => 'Record of contraceptive usage periods',
      PregnancyTestDataType _ => AppTexts.pregnancyTestDescription,
      ProgesteroneTestDataType _ => AppTexts.progesteroneTestDescription,
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
      PeripheralPerfusionIndexDataType _ =>
        AppTexts.peripheralPerfusionIndexDescription,
      LactationDataType _ => 'Record of lactation events',
      ActivityIntensityDataType _ =>
        'Minutes spent in moderate or vigorous activity (Android only)',
      ExerciseTimeDataType _ => AppTexts.exerciseTimeDescription,
      MoveTimeDataType _ => AppTexts.moveTimeDescription,
      StandTimeDataType _ => AppTexts.standTimeDescription,
      WalkingSteadinessDataType _ =>
        'Measure of walking stability and gait regularity (iOS only)',
      WalkingAsymmetryPercentageDataType _ =>
        AppTexts.walkingAsymmetryPercentageDescription,
      WalkingDoubleSupportPercentageDataType _ =>
        AppTexts.walkingDoubleSupportPercentageDescription,
      WalkingStepLengthDataType _ => AppTexts.walkingStepLengthDescription,
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
      SleepingWristTemperatureDataType _ => AppIcons.temperature,
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
      AlcoholicBeveragesDataType _ => Icons.local_bar,
      BloodAlcoholContentDataType _ => Icons.bloodtype,
      BasalEnergyBurnedDataType _ => AppIcons.localFireDepartment,
      TotalEnergyBurnedDataType _ => AppIcons.localFireDepartment,
      FloorsClimbedDataType _ => AppIcons.stairs,
      ElevationGainedDataType _ => AppIcons.terrain,
      WheelchairPushesDataType _ => AppIcons.accessible,
      SwimmingStrokesDataType _ => AppIcons.pool,
      HydrationDataType _ => AppIcons.volume,
      HeartRateDataType _ => AppIcons.favorite,
      HeartRateSeriesDataType _ => AppIcons.favorite,
      StepsCadenceSeriesDataType _ => AppIcons.speed,
      CyclingPedalingCadenceDataType _ => AppIcons.speed,
      CyclingPedalingCadenceSeriesDataType _ => AppIcons.speed,
      RestingHeartRateDataType _ => AppIcons.favorite,
      SleepSessionDataType _ => AppIcons.bedtime,
      SleepStageDataType _ => AppIcons.bedtime,
      SexualActivityDataType _ => AppIcons.favorite,
      OxygenSaturationDataType _ => AppIcons.percent,
      NutritionDataType _ => AppIcons.fastfood,
      DietaryEnergyConsumedDataType _ => AppIcons.localFireDepartment,
      DietaryCaffeineDataType _ => AppIcons.fastfood,
      DietaryProteinDataType _ => AppIcons.fastfood,
      DietaryTotalCarbohydrateDataType _ => AppIcons.fastfood,
      DietaryTotalFatDataType _ => AppIcons.fastfood,
      DietarySaturatedFatDataType _ => AppIcons.fastfood,
      DietaryMonounsaturatedFatDataType _ => AppIcons.fastfood,
      DietaryPolyunsaturatedFatDataType _ => AppIcons.fastfood,
      DietaryCholesterolDataType _ => AppIcons.fastfood,
      DietaryFiberNutrientDataType _ => AppIcons.fastfood,
      DietarySugarDataType _ => AppIcons.fastfood,
      DietaryCalciumDataType _ => AppIcons.fastfood,
      DietaryIronDataType _ => AppIcons.fastfood,
      DietaryMagnesiumDataType _ => AppIcons.fastfood,
      DietaryManganeseDataType _ => AppIcons.fastfood,
      DietaryPhosphorusDataType _ => AppIcons.fastfood,
      DietaryPotassiumDataType _ => AppIcons.fastfood,
      DietarySeleniumDataType _ => AppIcons.fastfood,
      DietarySodiumDataType _ => AppIcons.fastfood,
      DietaryZincDataType _ => AppIcons.fastfood,
      DietaryVitaminADataType _ => AppIcons.fastfood,
      DietaryVitaminB6DataType _ => AppIcons.fastfood,
      DietaryVitaminB12DataType _ => AppIcons.fastfood,
      DietaryVitaminCDataType _ => AppIcons.fastfood,
      DietaryVitaminDDataType _ => AppIcons.fastfood,
      DietaryVitaminEDataType _ => AppIcons.fastfood,
      DietaryVitaminKDataType _ => AppIcons.fastfood,
      DietaryThiaminDataType _ => AppIcons.fastfood,
      DietaryRiboflavinDataType _ => AppIcons.fastfood,
      DietaryNiacinDataType _ => AppIcons.fastfood,
      DietaryFolateDataType _ => AppIcons.fastfood,
      DietaryBiotinDataType _ => AppIcons.fastfood,
      DietaryPantothenicAcidDataType _ => AppIcons.fastfood,
      RespiratoryRateDataType _ => AppIcons.air,
      ForcedVitalCapacityDataType _ => AppIcons.air,
      Vo2MaxDataType _ => AppIcons.vo2Max,
      BloodGlucoseDataType _ => AppIcons.bloodGlucose,
      SpeedSeriesDataType _ => AppIcons.speed,
      WalkingSpeedDataType _ => AppIcons.speed,
      RunningSpeedDataType _ => AppIcons.speed,
      StairAscentSpeedDataType _ => AppIcons.speed,
      StairDescentSpeedDataType _ => AppIcons.speed,
      PowerSeriesDataType _ => AppIcons.power,
      CyclingPowerDataType _ => AppIcons.power,
      RunningPowerDataType _ => AppIcons.runCircle,
      ExerciseSessionDataType _ => AppIcons.fitnessCenter,
      CervicalMucusDataType _ => AppIcons.waterDrop,
      IntermenstrualBleedingDataType _ => AppIcons.waterDrop,
      OvulationTestDataType _ => AppIcons.science,
      PregnancyTestDataType _ => AppIcons.science,
      ProgesteroneTestDataType _ => AppIcons.science,
      MindfulnessSessionDataType _ => AppIcons.selfImprovement,
      BoneMassDataType _ => AppIcons.monitorWeight,
      BodyWaterMassDataType _ => AppIcons.waterDrop,
      HeartRateVariabilityRMSSDDataType _ => AppIcons.favorite,
      BodyMassIndexDataType _ => AppIcons.monitorWeight,
      WaistCircumferenceDataType _ => AppIcons.straighten,
      HeartRateVariabilitySDNNDataType _ => AppIcons.favorite,
      MenstrualFlowDataType _ => AppIcons.waterDrop,
      MenstrualFlowInstantDataType _ => AppIcons.waterDrop,
      LactationDataType _ => AppIcons.childCare,
      PregnancyDataType _ => AppIcons.childCare,
      PeripheralPerfusionIndexDataType _ => AppIcons.percent,
      ContraceptiveDataType _ => AppIcons.medication,
      ActivityIntensityDataType _ => AppIcons.fitnessCenter,
      ExerciseTimeDataType _ => AppIcons.time,
      MoveTimeDataType _ => AppIcons.time,
      StandTimeDataType _ => AppIcons.time,
      WalkingSteadinessDataType _ => AppIcons.directionsWalk,
      WalkingAsymmetryPercentageDataType _ => AppIcons.directionsWalk,
      WalkingDoubleSupportPercentageDataType _ => AppIcons.directionsWalk,
      WalkingStepLengthDataType _ => AppIcons.directionsWalk,
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
      const (SwimmingStrokesDataType) ||
      const (HeartRateDataType) ||
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
      const (AlcoholicBeveragesDataType) => AppTexts.alcoholicBeverages,
      const (FloorsClimbedDataType) => AppTexts.floorsClimbed,
      const (ElevationGainedDataType) => AppTexts.valueWithUnit(
        AppTexts.elevationGained,
        AppTexts.meter,
      ),
      const (WheelchairPushesDataType) => AppTexts.wheelchairPushes,
      const (SwimmingStrokesDataType) => AppTexts.swimmingStrokes,
      const (HeartRateDataType) => AppTexts.valueWithUnit(
        AppTexts.heartRate,
        AppTexts.bpm,
      ),
      const (StepsCadenceSeriesDataType) => AppTexts.valueWithUnit(
        AppTexts.stepsCadence,
        AppTexts.stepsPerMinute,
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
      const (BloodAlcoholContentDataType) => AppTexts.withUnit(
        AppTexts.bloodAlcoholContent,
        AppTexts.percent,
      ),
      const (PeripheralPerfusionIndexDataType) => AppTexts.withUnit(
        AppTexts.peripheralPerfusionIndex,
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
      const (ForcedVitalCapacityDataType) => AppTexts.valueWithUnit(
        AppTexts.forcedVitalCapacity,
        AppTexts.liter,
      ),
      const (Vo2MaxDataType) => AppTexts.withUnit(
        AppTexts.vo2Max,
        AppTexts.millilitersPerKilogramPerMinute,
      ),

      // Activity & Energy
      const (ActiveEnergyBurnedDataType) => AppTexts.withUnit(
        AppTexts.activeEnergyBurned,
        AppTexts.kilocalories,
      ),
      const (TotalEnergyBurnedDataType) => AppTexts.withUnit(
        AppTexts.activeEnergyBurned,
        AppTexts.kilocalories,
      ),
      const (BasalEnergyBurnedDataType) => AppTexts.withUnit(
        AppTexts.activeEnergyBurned,
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
      const (DietaryCaffeineDataType) => AppTexts.withUnit(
        AppTexts.caffeine,
        AppTexts.milligram,
      ),
      const (DietaryProteinDataType) => AppTexts.withUnit(
        AppTexts.protein,
        AppTexts.gram,
      ),
      const (DietaryTotalCarbohydrateDataType) => AppTexts.withUnit(
        AppTexts.totalCarbohydrate,
        AppTexts.gram,
      ),
      const (DietaryTotalFatDataType) => AppTexts.withUnit(
        AppTexts.totalFat,
        AppTexts.gram,
      ),
      const (DietarySaturatedFatDataType) => AppTexts.withUnit(
        AppTexts.saturatedFat,
        AppTexts.gram,
      ),
      const (DietaryMonounsaturatedFatDataType) => AppTexts.withUnit(
        AppTexts.monounsaturatedFat,
        AppTexts.gram,
      ),
      const (DietaryPolyunsaturatedFatDataType) => AppTexts.withUnit(
        AppTexts.polyunsaturatedFat,
        AppTexts.gram,
      ),
      const (DietaryCholesterolDataType) => AppTexts.withUnit(
        AppTexts.cholesterol,
        AppTexts.milligram,
      ),
      const (DietaryFiberNutrientDataType) => AppTexts.withUnit(
        AppTexts.dietaryFiber,
        AppTexts.gram,
      ),
      const (DietarySugarDataType) => AppTexts.withUnit(
        AppTexts.sugar,
        AppTexts.gram,
      ),

      // Minerals
      const (DietaryCalciumDataType) => AppTexts.withUnit(
        AppTexts.calcium,
        AppTexts.milligram,
      ),
      const (DietaryIronDataType) => AppTexts.withUnit(
        AppTexts.iron,
        AppTexts.milligram,
      ),
      const (DietaryMagnesiumDataType) => AppTexts.withUnit(
        AppTexts.magnesium,
        AppTexts.milligram,
      ),
      const (DietaryManganeseDataType) => AppTexts.withUnit(
        AppTexts.manganese,
        AppTexts.milligram,
      ),
      const (DietaryPhosphorusDataType) => AppTexts.withUnit(
        AppTexts.phosphorus,
        AppTexts.milligram,
      ),
      const (DietaryPotassiumDataType) => AppTexts.withUnit(
        AppTexts.potassium,
        AppTexts.milligram,
      ),
      const (DietarySeleniumDataType) => AppTexts.withUnit(
        AppTexts.selenium,
        AppTexts.microgram,
      ),
      const (DietarySodiumDataType) => AppTexts.withUnit(
        AppTexts.sodium,
        AppTexts.milligram,
      ),
      const (DietaryZincDataType) => AppTexts.withUnit(
        AppTexts.zinc,
        AppTexts.milligram,
      ),

      // Vitamins
      const (DietaryVitaminADataType) => AppTexts.withUnit(
        AppTexts.vitaminA,
        AppTexts.microgram,
      ),
      const (DietaryVitaminB6DataType) => AppTexts.withUnit(
        AppTexts.vitaminB6,
        AppTexts.milligram,
      ),
      const (DietaryVitaminB12DataType) => AppTexts.withUnit(
        AppTexts.vitaminB12,
        AppTexts.microgram,
      ),
      const (DietaryVitaminCDataType) => AppTexts.withUnit(
        AppTexts.vitaminC,
        AppTexts.milligram,
      ),
      const (DietaryVitaminDDataType) => AppTexts.withUnit(
        AppTexts.vitaminD,
        AppTexts.microgram,
      ),
      const (DietaryVitaminEDataType) => AppTexts.withUnit(
        AppTexts.vitaminE,
        AppTexts.milligram,
      ),
      const (DietaryVitaminKDataType) => AppTexts.withUnit(
        AppTexts.vitaminK,
        AppTexts.microgram,
      ),
      const (DietaryThiaminDataType) => AppTexts.withUnit(
        AppTexts.thiamin,
        AppTexts.milligram,
      ),
      const (DietaryRiboflavinDataType) => AppTexts.withUnit(
        AppTexts.riboflavin,
        AppTexts.milligram,
      ),
      const (DietaryNiacinDataType) => AppTexts.withUnit(
        AppTexts.niacin,
        AppTexts.milligram,
      ),
      const (DietaryFolateDataType) => AppTexts.withUnit(
        AppTexts.folate,
        AppTexts.microgram,
      ),
      const (DietaryBiotinDataType) => AppTexts.withUnit(
        AppTexts.biotin,
        AppTexts.microgram,
      ),
      const (DietaryPantothenicAcidDataType) => AppTexts.withUnit(
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
      const (RunningPowerDataType) => AppTexts.runningPower,

      // Reproductive Health
      const (SexualActivityDataType) => AppTexts.sexualActivity,
      const (CervicalMucusDataType) => AppTexts.cervicalMucus,
      const (CyclingPedalingCadenceDataType) => AppTexts.cyclingPedalingCadence,
      const (ExerciseTimeDataType) => AppTexts.valueWithUnit(
        AppTexts.duration,
        AppTexts.minutes,
      ),
      const (MoveTimeDataType) => AppTexts.valueWithUnit(
        AppTexts.duration,
        AppTexts.minutes,
      ),
      const (WalkingAsymmetryPercentageDataType) => AppTexts.withUnit(
        AppTexts.walkingAsymmetryPercentage,
        AppTexts.percent,
      ),
      const (WalkingDoubleSupportPercentageDataType) => AppTexts.withUnit(
        AppTexts.walkingDoubleSupportPercentage,
        AppTexts.percent,
      ),

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
      // Percentage types
      const (BodyFatPercentageDataType) ||
      const (BloodAlcoholContentDataType) ||
      const (PeripheralPerfusionIndexDataType) ||
      const (WalkingAsymmetryPercentageDataType) ||
      const (WalkingDoubleSupportPercentageDataType) ||
      const (OxygenSaturationDataType) => '%',

      const (BodyMassIndexDataType) => 'kg/m²',

      // Distance types
      const (HeightDataType) ||
      const (DistanceDataType) ||
      const (ElevationGainedDataType) ||
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
      const (ForcedVitalCapacityDataType) => AppTexts.liter,
      const (Vo2MaxDataType) => AppTexts.millilitersPerKilogramPerMinute,
      const (HeartRateVariabilityRMSSDDataType) ||
      const (HeartRateVariabilitySDNNDataType) => AppTexts.millisecond,

      // Power
      const (CyclingPowerDataType) || const (RunningPowerDataType) => 'W',

      // Activity & Energy
      const (ActiveEnergyBurnedDataType) ||
      const (BasalEnergyBurnedDataType) ||
      const (TotalEnergyBurnedDataType) ||
      const (DietaryEnergyConsumedDataType) => AppTexts.kilocalories,
      const (HydrationDataType) => AppTexts.liter,

      // Nutrients - grams
      const (DietaryProteinDataType) ||
      const (DietaryTotalCarbohydrateDataType) ||
      const (DietaryTotalFatDataType) ||
      const (DietarySaturatedFatDataType) ||
      const (DietaryMonounsaturatedFatDataType) ||
      const (DietaryPolyunsaturatedFatDataType) ||
      const (DietaryFiberNutrientDataType) ||
      const (DietarySugarDataType) => AppTexts.gram,

      // Time
      const (ExerciseTimeDataType) ||
      const (MoveTimeDataType) => AppTexts.minutes,

      // Nutrients - milligrams
      const (DietaryCaffeineDataType) ||
      const (DietaryCholesterolDataType) ||
      const (DietaryCalciumDataType) ||
      const (DietaryIronDataType) ||
      const (DietaryMagnesiumDataType) ||
      const (DietaryManganeseDataType) ||
      const (DietaryPhosphorusDataType) ||
      const (DietaryPotassiumDataType) ||
      const (DietarySodiumDataType) ||
      const (DietaryZincDataType) ||
      const (DietaryVitaminB6DataType) ||
      const (DietaryVitaminCDataType) ||
      const (DietaryVitaminEDataType) ||
      const (DietaryThiaminDataType) ||
      const (DietaryRiboflavinDataType) ||
      const (DietaryNiacinDataType) ||
      const (DietaryPantothenicAcidDataType) => AppTexts.milligram,

      // Nutrients - micrograms
      const (DietarySeleniumDataType) ||
      const (DietaryVitaminADataType) ||
      const (DietaryVitaminB12DataType) ||
      const (DietaryVitaminDDataType) ||
      const (DietaryVitaminKDataType) ||
      const (DietaryFolateDataType) ||
      const (DietaryBiotinDataType) => AppTexts.microgram,

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

      const (HeartRateDataType) => AppTexts.getPleaseEnterText(
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
        AppTexts.cyclingPower,
      ),
      const (RunningPowerDataType) => AppTexts.getPleaseEnterText(
        AppTexts.runningPower,
      ),
      const (ActiveEnergyBurnedDataType) => AppTexts.getPleaseEnterText(
        AppTexts.activeEnergyBurned,
      ),
      const (DietaryEnergyConsumedDataType) => AppTexts.getPleaseEnterText(
        AppTexts.energy,
      ),
      const (HydrationDataType) => AppTexts.getPleaseEnterText(
        AppTexts.hydration,
      ),
      const (DietaryCaffeineDataType) => AppTexts.getPleaseEnterText(
        AppTexts.caffeine,
      ),
      const (DietaryProteinDataType) => AppTexts.getPleaseEnterText(
        AppTexts.protein,
      ),
      const (DietaryTotalCarbohydrateDataType) => AppTexts.getPleaseEnterText(
        AppTexts.totalCarbohydrate,
      ),
      const (DietaryTotalFatDataType) => AppTexts.getPleaseEnterText(
        AppTexts.totalFat,
      ),
      const (DietarySaturatedFatDataType) => AppTexts.getPleaseEnterText(
        AppTexts.saturatedFat,
      ),
      const (DietaryMonounsaturatedFatDataType) => AppTexts.getPleaseEnterText(
        AppTexts.monounsaturatedFat,
      ),
      const (DietaryPolyunsaturatedFatDataType) => AppTexts.getPleaseEnterText(
        AppTexts.polyunsaturatedFat,
      ),
      const (DietaryCholesterolDataType) => AppTexts.getPleaseEnterText(
        AppTexts.cholesterol,
      ),
      const (DietaryFiberNutrientDataType) => AppTexts.getPleaseEnterText(
        AppTexts.dietaryFiber,
      ),
      const (DietarySugarDataType) => AppTexts.getPleaseEnterText(
        AppTexts.sugar,
      ),
      const (DietaryCalciumDataType) => AppTexts.getPleaseEnterText(
        AppTexts.calcium,
      ),
      const (DietaryIronDataType) => AppTexts.getPleaseEnterText(
        AppTexts.iron,
      ),
      const (DietaryMagnesiumDataType) => AppTexts.getPleaseEnterText(
        AppTexts.magnesium,
      ),
      const (DietaryManganeseDataType) => AppTexts.getPleaseEnterText(
        AppTexts.manganese,
      ),
      const (DietaryPhosphorusDataType) => AppTexts.getPleaseEnterText(
        AppTexts.phosphorus,
      ),
      const (DietaryPotassiumDataType) => AppTexts.getPleaseEnterText(
        AppTexts.potassium,
      ),
      const (DietarySeleniumDataType) => AppTexts.getPleaseEnterText(
        AppTexts.selenium,
      ),
      const (DietarySodiumDataType) => AppTexts.getPleaseEnterText(
        AppTexts.sodium,
      ),
      const (DietaryZincDataType) => AppTexts.getPleaseEnterText(
        AppTexts.zinc,
      ),
      const (DietaryVitaminADataType) => AppTexts.getPleaseEnterText(
        AppTexts.vitaminA,
      ),
      const (DietaryVitaminB6DataType) => AppTexts.getPleaseEnterText(
        AppTexts.vitaminB6,
      ),
      const (DietaryVitaminB12DataType) => AppTexts.getPleaseEnterText(
        AppTexts.vitaminB12,
      ),
      const (DietaryVitaminCDataType) => AppTexts.getPleaseEnterText(
        AppTexts.vitaminC,
      ),
      const (DietaryVitaminDDataType) => AppTexts.getPleaseEnterText(
        AppTexts.vitaminD,
      ),
      const (DietaryVitaminEDataType) => AppTexts.getPleaseEnterText(
        AppTexts.vitaminE,
      ),
      const (DietaryVitaminKDataType) => AppTexts.getPleaseEnterText(
        AppTexts.vitaminK,
      ),
      const (DietaryThiaminDataType) => AppTexts.getPleaseEnterText(
        AppTexts.thiamin,
      ),
      const (DietaryRiboflavinDataType) => AppTexts.getPleaseEnterText(
        AppTexts.riboflavin,
      ),
      const (DietaryNiacinDataType) => AppTexts.getPleaseEnterText(
        AppTexts.niacin,
      ),
      const (DietaryFolateDataType) => AppTexts.getPleaseEnterText(
        AppTexts.folate,
      ),
      const (DietaryBiotinDataType) => AppTexts.getPleaseEnterText(
        AppTexts.biotin,
      ),
      const (DietaryPantothenicAcidDataType) => AppTexts.getPleaseEnterText(
        AppTexts.pantothenicAcid,
      ),

      _ => AppTexts.pleaseEnterValidNumber,
    };
  }
}
