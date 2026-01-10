import 'package:health_connector_core/src/models/health_data_types/health_data_type.dart';
import 'package:health_connector_core/src/models/health_records/health_record.dart';
import 'package:health_connector_core/src/models/measurement_units/measurement_unit.dart';
import 'package:meta/meta.dart' show internal;

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
/// // Returns: HealthDataType.height (HeightHealthDataType instance)
/// ```
///
/// @nodoc
@internal
extension HealthRecordDataTypeExtension on HealthRecord {
  /// Returns the [HealthDataType] associated with this [HealthRecord].
  ///
  /// This getter performs type switching on the health record instance
  /// and returns the appropriate [HealthDataType] for each implementation.
  HealthDataType<HealthRecord, MeasurementUnit> get dataType {
    return switch (this) {
      DistanceRecord _ => HealthDataType.distance,
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
      StepsRecord _ => HealthDataType.steps,
      WeightRecord _ => HealthDataType.weight,
      HeightRecord _ => HealthDataType.height,
      BloodGlucoseRecord _ => HealthDataType.bloodGlucose,
      BodyFatPercentageRecord _ => HealthDataType.bodyFatPercentage,
      BodyTemperatureRecord _ => HealthDataType.bodyTemperature,
      CervicalMucusRecord _ => HealthDataType.cervicalMucus,
      ActiveEnergyBurnedRecord _ => HealthDataType.activeEnergyBurned,
      ExerciseSessionRecord _ => HealthDataType.exerciseSession,
      FloorsClimbedRecord _ => HealthDataType.floorsClimbed,
      WheelchairPushesRecord _ => HealthDataType.wheelchairPushes,
      LeanBodyMassRecord _ => HealthDataType.leanBodyMass,
      HydrationRecord _ => HealthDataType.hydration,
      BloodPressureRecord _ => HealthDataType.bloodPressure,
      SystolicBloodPressureRecord _ => HealthDataType.systolicBloodPressure,
      DiastolicBloodPressureRecord _ => HealthDataType.diastolicBloodPressure,
      HeartRateSeriesRecord _ => HealthDataType.heartRateSeriesRecord,
      HeartRateMeasurementRecord _ => HealthDataType.heartRateMeasurementRecord,
      CyclingPedalingCadenceSeriesRecord _ =>
        HealthDataType.cyclingPedalingCadenceSeriesRecord,
      CyclingPedalingCadenceMeasurementRecord _ =>
        HealthDataType.cyclingPedalingCadenceMeasurementRecord,
      SleepSessionRecord _ => HealthDataType.sleepSession,
      SleepStageRecord _ => HealthDataType.sleepStageRecord,
      SexualActivityRecord _ => HealthDataType.sexualActivity,
      MindfulnessSessionRecord _ => HealthDataType.mindfulnessSession,
      RestingHeartRateRecord _ => HealthDataType.restingHeartRate,
      OvulationTestRecord _ => HealthDataType.ovulationTest,
      IntermenstrualBleedingRecord _ => HealthDataType.intermenstrualBleeding,
      MenstrualFlowInstantRecord _ => HealthDataType.menstrualFlowInstant,
      MenstrualFlowRecord _ => HealthDataType.menstrualFlow,
      OxygenSaturationRecord _ => HealthDataType.oxygenSaturation,
      RespiratoryRateRecord _ => HealthDataType.respiratoryRate,
      Vo2MaxRecord _ => HealthDataType.vo2Max,
      NutritionRecord _ => HealthDataType.nutrition,
      DietaryEnergyConsumedRecord _ => HealthDataType.dietaryEnergyConsumed,
      CaffeineNutrientRecord _ => HealthDataType.caffeine,
      ProteinNutrientRecord _ => HealthDataType.protein,
      TotalCarbohydrateNutrientRecord _ => HealthDataType.totalCarbohydrate,
      TotalFatNutrientRecord _ => HealthDataType.totalFat,
      SaturatedFatNutrientRecord _ => HealthDataType.saturatedFat,
      MonounsaturatedFatNutrientRecord _ => HealthDataType.monounsaturatedFat,
      PolyunsaturatedFatNutrientRecord _ => HealthDataType.polyunsaturatedFat,
      CholesterolNutrientRecord _ => HealthDataType.cholesterol,
      DietaryFiberNutrientRecord _ => HealthDataType.dietaryFiber,
      SugarNutrientRecord _ => HealthDataType.sugar,
      CalciumNutrientRecord _ => HealthDataType.calcium,
      IronNutrientRecord _ => HealthDataType.iron,
      MagnesiumNutrientRecord _ => HealthDataType.magnesium,
      ManganeseNutrientRecord _ => HealthDataType.manganese,
      PhosphorusNutrientRecord _ => HealthDataType.phosphorus,
      PotassiumNutrientRecord _ => HealthDataType.potassium,
      SeleniumNutrientRecord _ => HealthDataType.selenium,
      SodiumNutrientRecord _ => HealthDataType.sodium,
      ZincNutrientRecord _ => HealthDataType.zinc,
      VitaminANutrientRecord _ => HealthDataType.vitaminA,
      VitaminB6NutrientRecord _ => HealthDataType.vitaminB6,
      VitaminB12NutrientRecord _ => HealthDataType.vitaminB12,
      VitaminCNutrientRecord _ => HealthDataType.vitaminC,
      VitaminDNutrientRecord _ => HealthDataType.vitaminD,
      VitaminENutrientRecord _ => HealthDataType.vitaminE,
      VitaminKNutrientRecord _ => HealthDataType.vitaminK,
      ThiaminNutrientRecord _ => HealthDataType.thiamin,
      RiboflavinNutrientRecord _ => HealthDataType.riboflavin,
      NiacinNutrientRecord _ => HealthDataType.niacin,
      FolateNutrientRecord _ => HealthDataType.folate,
      BiotinNutrientRecord _ => HealthDataType.biotin,
      PantothenicAcidNutrientRecord _ => HealthDataType.pantothenicAcid,
      TotalEnergyBurnedRecord _ => HealthDataType.totalEnergyBurned,
      BasalEnergyBurnedRecord _ => HealthDataType.basalEnergyBurned,
      BasalBodyTemperatureRecord _ => HealthDataType.basalBodyTemperature,
      BoneMassRecord _ => HealthDataType.boneMass,
      BodyWaterMassRecord _ => HealthDataType.bodyWaterMass,
      HeartRateVariabilityRMSSDRecord _ =>
        HealthDataType.heartRateVariabilityRMSSD,
      BodyMassIndexRecord _ => HealthDataType.bodyMassIndex,
      WaistCircumferenceRecord _ => HealthDataType.waistCircumference,
      HeartRateVariabilitySDNNRecord _ =>
        HealthDataType.heartRateVariabilitySDNN,
    };
  }
}
