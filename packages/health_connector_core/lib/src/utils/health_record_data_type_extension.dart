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
/// // Returns: HealthDataType.height (HeightHealthDataType instance)
/// ```
///
/// @nodoc
extension HealthRecordDataTypeExtension on HealthRecord {
  /// Returns the [HealthDataType] associated with this [HealthRecord].
  ///
  /// This getter performs type switching on the health record instance
  /// and returns the appropriate [HealthDataType] for each implementation.
  HealthDataType<HealthRecord, MeasurementUnit> get dataType {
    return switch (this) {
      // Distance records
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

      // Speed records
      SpeedSeriesRecord _ => HealthDataType.speedSeries,
      WalkingSpeedRecord _ => HealthDataType.walkingSpeed,
      RunningSpeedRecord _ => HealthDataType.runningSpeed,
      StairAscentSpeedRecord _ => HealthDataType.stairAscentSpeed,
      StairDescentSpeedRecord _ => HealthDataType.stairDescentSpeed,

      // Power records
      PowerSeriesRecord _ => HealthDataType.powerSeries,
      CyclingPowerRecord _ => HealthDataType.cyclingPower,

      // Basic health records
      StepsRecord _ => HealthDataType.steps,
      WeightRecord _ => HealthDataType.weight,
      HeightRecord _ => HealthDataType.height,
      BloodGlucoseRecord _ => HealthDataType.bloodGlucose,
      BodyFatPercentageRecord _ => HealthDataType.bodyFatPercentage,
      BodyTemperatureRecord _ => HealthDataType.bodyTemperature,
      CervicalMucusRecord _ => HealthDataType.cervicalMucus,
      ActiveCaloriesBurnedRecord _ => HealthDataType.activeCaloriesBurned,
      ExerciseSessionRecord _ => HealthDataType.exerciseSession,
      FloorsClimbedRecord _ => HealthDataType.floorsClimbed,
      WheelchairPushesRecord _ => HealthDataType.wheelchairPushes,
      LeanBodyMassRecord _ => HealthDataType.leanBodyMass,
      HydrationRecord _ => HealthDataType.hydration,

      // Blood pressure records
      BloodPressureRecord _ => HealthDataType.bloodPressure,
      SystolicBloodPressureRecord _ => HealthDataType.systolicBloodPressure,
      DiastolicBloodPressureRecord _ => HealthDataType.diastolicBloodPressure,

      // Heart rate records
      HeartRateSeriesRecord _ => HealthDataType.heartRateSeriesRecord,
      HeartRateMeasurementRecord _ => HealthDataType.heartRateMeasurementRecord,

      // Cycling pedaling cadence records
      CyclingPedalingCadenceSeriesRecord _ =>
        HealthDataType.cyclingPedalingCadenceSeriesRecord,
      CyclingPedalingCadenceMeasurementRecord _ =>
        HealthDataType.cyclingPedalingCadenceMeasurementRecord,

      // Sleep records
      SleepSessionRecord _ => HealthDataType.sleepSession,
      SleepStageRecord _ => HealthDataType.sleepStageRecord,

      // Sexual activity
      SexualActivityRecord _ => HealthDataType.sexualActivity,

      // Mindfulness records
      MindfulnessSessionRecord _ => HealthDataType.mindfulnessSession,

      // Vital signs
      RestingHeartRateRecord _ => HealthDataType.restingHeartRate,
      OvulationTestRecord _ => HealthDataType.ovulationTest,
      OxygenSaturationRecord _ => HealthDataType.oxygenSaturation,
      RespiratoryRateRecord _ => HealthDataType.respiratoryRate,
      Vo2MaxRecord _ => HealthDataType.vo2Max,

      // Nutrition records
      NutritionRecord _ => HealthDataType.nutrition,
      EnergyNutrientRecord _ => HealthDataType.energyNutrient,
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

      // Mineral nutrients
      CalciumNutrientRecord _ => HealthDataType.calcium,
      IronNutrientRecord _ => HealthDataType.iron,
      MagnesiumNutrientRecord _ => HealthDataType.magnesium,
      ManganeseNutrientRecord _ => HealthDataType.manganese,
      PhosphorusNutrientRecord _ => HealthDataType.phosphorus,
      PotassiumNutrientRecord _ => HealthDataType.potassium,
      SeleniumNutrientRecord _ => HealthDataType.selenium,
      SodiumNutrientRecord _ => HealthDataType.sodium,
      ZincNutrientRecord _ => HealthDataType.zinc,

      // Vitamin nutrients
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
    };
  }
}
