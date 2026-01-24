import 'package:health_connector_core/src/annotations/internal_use.dart';
import 'package:health_connector_core/src/models/health_data_types/health_data_type.dart';
import 'package:health_connector_core/src/models/health_records/health_record.dart';
import 'package:health_connector_core/src/models/measurement_units/measurement_unit.dart';

/// Extension on [HealthRecord] that provides a getter for the associated
/// [HealthDataType].
///
/// This extension maps each concrete [HealthRecord] implementation to its
/// corresponding [HealthDataType] instance.
///
/// ## Example
///
/// ```dart
/// final heightRecord = HeightRecord(
///   time: DateTime.now(),
///   height: Length.centimeters(175),
///   metadata: Metadata.manualEntry(
///     dataOrigin: DataOrigin(packageName: 'com.example.app'),
///   ),
/// );
///
/// final dataType = heightRecord.dataType;
/// // Returns: HealthDataType.height (HeightDataType instance)
/// ```
///
/// @nodoc
@internalUse
extension HealthRecordDataTypeExtension on HealthRecord {
  /// Returns the [HealthDataType] associated with this [HealthRecord].
  ///
  /// This getter performs type switching on the health record instance
  /// and returns the appropriate [HealthDataType] for each implementation.
  HealthDataType<HealthRecord, MeasurementUnit> get dataType {
    return switch (this) {
      DistanceRecord _ => HealthDataType.distance,
      ElevationGainedRecord _ => HealthDataType.elevationGained,
      CyclingDistanceRecord _ => HealthDataType.cyclingDistance,
      SwimmingDistanceRecord _ => HealthDataType.swimmingDistance,
      WheelchairDistanceRecord _ => HealthDataType.wheelchairDistance,
      DownhillSnowSportsDistanceRecord _ =>
        HealthDataType.downhillSnowSportsDistance,
      RowingDistanceRecord _ => HealthDataType.rowingDistance,
      PaddleSportsDistanceRecord _ => HealthDataType.paddleSportsDistance,
      CrossCountrySkiingDistanceRecord _ =>
        HealthDataType.crossCountrySkiingDistance,
      SkatingSportsDistanceRecord _ => HealthDataType.skatingSportsDistance,
      SwimmingStrokesRecord _ => HealthDataType.swimmingStrokes,
      SixMinuteWalkTestDistanceRecord _ =>
        HealthDataType.sixMinuteWalkTestDistance,
      WalkingRunningDistanceRecord _ => HealthDataType.walkingRunningDistance,
      SpeedSeriesRecord _ => HealthDataType.speedSeries,
      WalkingSpeedRecord _ => HealthDataType.walkingSpeed,
      RunningSpeedRecord _ => HealthDataType.runningSpeed,
      StairAscentSpeedRecord _ => HealthDataType.stairAscentSpeed,
      StairDescentSpeedRecord _ => HealthDataType.stairDescentSpeed,
      PowerSeriesRecord _ => HealthDataType.powerSeries,
      CyclingPowerRecord _ => HealthDataType.cyclingPower,
      RunningPowerRecord _ => HealthDataType.runningPower,
      StepsRecord _ => HealthDataType.steps,
      StepsCadenceSeriesRecord _ => HealthDataType.stepsCadenceSeries,
      WeightRecord _ => HealthDataType.weight,
      HeightRecord _ => HealthDataType.height,
      BloodGlucoseRecord _ => HealthDataType.bloodGlucose,
      BodyFatPercentageRecord _ => HealthDataType.bodyFatPercentage,
      BodyTemperatureRecord _ => HealthDataType.bodyTemperature,
      SleepingWristTemperatureRecord _ =>
        HealthDataType.sleepingWristTemperature,
      CervicalMucusRecord _ => HealthDataType.cervicalMucus,
      ActiveEnergyBurnedRecord _ => HealthDataType.activeEnergyBurned,
      ActivityIntensityRecord _ => HealthDataType.activityIntensity,
      AlcoholicBeveragesRecord _ => HealthDataType.alcoholicBeverages,
      ExerciseTimeRecord _ => HealthDataType.exerciseTime,
      StandTimeRecord _ => HealthDataType.standTime,
      MoveTimeRecord _ => HealthDataType.moveTime,
      WalkingSteadinessRecord _ => HealthDataType.walkingSteadiness,
      BloodAlcoholContentRecord _ => HealthDataType.bloodAlcoholContent,
      ExerciseSessionRecord _ => HealthDataType.exerciseSession,
      FloorsClimbedRecord _ => HealthDataType.floorsClimbed,
      WheelchairPushesRecord _ => HealthDataType.wheelchairPushes,
      LeanBodyMassRecord _ => HealthDataType.leanBodyMass,
      ElectrodermalActivityRecord _ => HealthDataType.electrodermalActivity,
      HydrationRecord _ => HealthDataType.hydration,
      InhalerUsageRecord _ => HealthDataType.inhalerUsage,
      InsulinDeliveryRecord _ => HealthDataType.insulinDelivery,
      BloodPressureRecord _ => HealthDataType.bloodPressure,
      SystolicBloodPressureRecord _ => HealthDataType.systolicBloodPressure,
      DiastolicBloodPressureRecord _ => HealthDataType.diastolicBloodPressure,
      HeartRateSeriesRecord _ => HealthDataType.heartRateSeries,
      HeartRateRecord _ => HealthDataType.heartRate,
      HeartRateRecoveryOneMinuteRecord _ =>
        HealthDataType.heartRateRecoveryOneMinute,
      CyclingPedalingCadenceSeriesRecord _ =>
        HealthDataType.cyclingPedalingCadenceSeries,
      CyclingPedalingCadenceRecord _ => HealthDataType.cyclingPedalingCadence,
      SleepSessionRecord _ => HealthDataType.sleepSession,
      SleepStageRecord _ => HealthDataType.sleepStageRecord,
      SexualActivityRecord _ => HealthDataType.sexualActivity,
      MindfulnessSessionRecord _ => HealthDataType.mindfulnessSession,
      RestingHeartRateRecord _ => HealthDataType.restingHeartRate,
      WalkingHeartRateAverageRecord _ => HealthDataType.walkingHeartRateAverage,
      OvulationTestRecord _ => HealthDataType.ovulationTest,
      PregnancyTestRecord _ => HealthDataType.pregnancyTest,
      ProgesteroneTestRecord _ => HealthDataType.progesteroneTest,
      PregnancyRecord _ => HealthDataType.pregnancy,
      ContraceptiveRecord _ => HealthDataType.contraceptive,
      LactationRecord _ => HealthDataType.lactation,
      IntermenstrualBleedingRecord _ => HealthDataType.intermenstrualBleeding,
      MenstrualFlowInstantRecord _ => HealthDataType.menstrualFlowInstant,
      MenstrualFlowRecord _ => HealthDataType.menstrualFlow,
      OxygenSaturationRecord _ => HealthDataType.oxygenSaturation,
      RespiratoryRateRecord _ => HealthDataType.respiratoryRate,
      Vo2MaxRecord _ => HealthDataType.vo2Max,
      NutritionRecord _ => HealthDataType.nutrition,
      DietaryEnergyConsumedRecord _ => HealthDataType.dietaryEnergyConsumed,
      DietaryCaffeineRecord _ => HealthDataType.dietaryCaffeine,
      DietaryProteinRecord _ => HealthDataType.dietaryProtein,
      DietaryTotalCarbohydrateRecord _ =>
        HealthDataType.dietaryTotalCarbohydrate,
      DietaryTotalFatRecord _ => HealthDataType.dietaryTotalFat,
      DietarySaturatedFatRecord _ => HealthDataType.dietarySaturatedFat,
      DietaryMonounsaturatedFatRecord _ =>
        HealthDataType.dietaryMonounsaturatedFat,
      DietaryPolyunsaturatedFatRecord _ =>
        HealthDataType.dietaryPolyunsaturatedFat,
      DietaryCholesterolRecord _ => HealthDataType.dietaryCholesterol,
      DietaryFiberRecord _ => HealthDataType.dietaryFiber,
      DietarySugarRecord _ => HealthDataType.dietarySugar,
      DietaryCalciumRecord _ => HealthDataType.dietaryCalcium,
      DietaryIronRecord _ => HealthDataType.dietaryIron,
      DietaryMagnesiumRecord _ => HealthDataType.dietaryMagnesium,
      DietaryManganeseRecord _ => HealthDataType.dietaryManganese,
      DietaryPhosphorusRecord _ => HealthDataType.dietaryPhosphorus,
      DietaryPotassiumRecord _ => HealthDataType.dietaryPotassium,
      DietarySeleniumRecord _ => HealthDataType.dietarySelenium,
      DietarySodiumRecord _ => HealthDataType.dietarySodium,
      DietaryZincRecord _ => HealthDataType.dietaryZinc,
      DietaryVitaminARecord _ => HealthDataType.dietaryVitaminA,
      DietaryVitaminB6Record _ => HealthDataType.dietaryVitaminB6,
      DietaryVitaminB12Record _ => HealthDataType.dietaryVitaminB12,
      DietaryVitaminCRecord _ => HealthDataType.dietaryVitaminC,
      DietaryVitaminDRecord _ => HealthDataType.dietaryVitaminD,
      DietaryVitaminERecord _ => HealthDataType.dietaryVitaminE,
      DietaryVitaminKRecord _ => HealthDataType.dietaryVitaminK,
      DietaryThiaminRecord _ => HealthDataType.dietaryThiamin,
      DietaryRiboflavinRecord _ => HealthDataType.dietaryRiboflavin,
      DietaryNiacinRecord _ => HealthDataType.dietaryNiacin,
      DietaryFolateRecord _ => HealthDataType.dietaryFolate,
      DietaryBiotinRecord _ => HealthDataType.dietaryBiotin,
      DietaryPantothenicAcidRecord _ => HealthDataType.dietaryPantothenicAcid,
      TotalEnergyBurnedRecord _ => HealthDataType.totalEnergyBurned,
      BasalEnergyBurnedRecord _ => HealthDataType.basalEnergyBurned,
      NumberOfTimesFallenRecord _ => HealthDataType.numberOfTimesFallen,
      AtrialFibrillationBurdenRecord _ =>
        HealthDataType.atrialFibrillationBurden,
      BasalBodyTemperatureRecord _ => HealthDataType.basalBodyTemperature,
      BoneMassRecord _ => HealthDataType.boneMass,
      BodyWaterMassRecord _ => HealthDataType.bodyWaterMass,
      HeartRateVariabilityRMSSDRecord _ =>
        HealthDataType.heartRateVariabilityRMSSD,
      BodyMassIndexRecord _ => HealthDataType.bodyMassIndex,
      WaistCircumferenceRecord _ => HealthDataType.waistCircumference,
      WalkingAsymmetryPercentageRecord _ =>
        HealthDataType.walkingAsymmetryPercentage,
      WalkingDoubleSupportPercentageRecord _ =>
        HealthDataType.walkingDoubleSupportPercentage,
      WalkingStepLengthRecord _ => HealthDataType.walkingStepLength,
      RunningGroundContactTimeRecord _ =>
        HealthDataType.runningGroundContactTime,
      RunningStrideLengthRecord _ => HealthDataType.runningStrideLength,
      HeartRateVariabilitySDNNRecord _ =>
        HealthDataType.heartRateVariabilitySDNN,
      PeripheralPerfusionIndexRecord _ =>
        HealthDataType.peripheralPerfusionIndex,
      ForcedVitalCapacityRecord _ => HealthDataType.forcedVitalCapacity,
      ForcedExpiratoryVolumeRecord _ => HealthDataType.forcedExpiratoryVolume,
      LowHeartRateEventRecord _ => HealthDataType.lowHeartRateEvent,
      HighHeartRateEventRecord _ => HealthDataType.highHeartRateEvent,
      InfrequentMenstrualCycleEventRecord _ =>
        HealthDataType.infrequentMenstrualCycleEvent,
      IrregularMenstrualCycleEventRecord _ =>
        HealthDataType.irregularMenstrualCycleEvent,
      IrregularHeartRhythmEventRecord _ =>
        HealthDataType.irregularHeartRhythmEvent,
      WalkingSteadinessEventRecord _ => HealthDataType.walkingSteadinessEvent,
      PersistentIntermenstrualBleedingEventRecord _ =>
        HealthDataType.persistentIntermenstrualBleedingEvent,
      ProlongedMenstrualPeriodEventRecord _ =>
        HealthDataType.prolongedMenstrualPeriodEvent,
      LowCardioFitnessEventRecord _ => HealthDataType.lowCardioFitnessEvent,
      EnvironmentalAudioExposureEventRecord _ =>
        HealthDataType.environmentalAudioExposureEvent,
      EnvironmentalAudioExposureRecord _ =>
        HealthDataType.environmentalAudioExposure,
      HeadphoneAudioExposureEventRecord _ =>
        HealthDataType.headphoneAudioExposureEvent,
      HeadphoneAudioExposureRecord _ => HealthDataType.headphoneAudioExposure,
    };
  }
}
