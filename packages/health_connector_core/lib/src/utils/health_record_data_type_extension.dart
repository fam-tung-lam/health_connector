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
      DistanceRecord() => HealthDataType.distance,
      CyclingDistanceRecord() => HealthDataType.cyclingDistance,
      SwimmingDistanceRecord() => HealthDataType.swimmingDistance,
      WheelchairDistanceRecord() => HealthDataType.wheelchairDistance,
      DownhillSnowSportsDistanceRecord() =>
        HealthDataType.downhillSnowSportsDistance,
      RowingDistanceRecord() => HealthDataType.rowingDistance,
      PaddleSportsDistanceRecord() => HealthDataType.paddleSportsDistance,
      CrossCountrySkiingDistanceRecord() =>
        HealthDataType.crossCountrySkiingDistance,
      SkatingSportsDistanceRecord() => HealthDataType.skatingSportsDistance,
      SixMinuteWalkTestDistanceRecord() =>
        HealthDataType.sixMinuteWalkTestDistance,
      WalkingRunningDistanceRecord() => HealthDataType.walkingRunningDistance,

      // Speed records
      SpeedSeriesRecord() => HealthDataType.speedSeries,
      WalkingSpeedRecord() => HealthDataType.walkingSpeed,
      RunningSpeedRecord() => HealthDataType.runningSpeed,
      StairAscentSpeedRecord() => HealthDataType.stairAscentSpeed,
      StairDescentSpeedRecord() => HealthDataType.stairDescentSpeed,

      // Power records
      PowerSeriesRecord() => HealthDataType.powerSeries,
      CyclingPowerRecord() => HealthDataType.cyclingPower,

      // Basic health records
      StepsRecord() => HealthDataType.steps,
      WeightRecord() => HealthDataType.weight,
      HeightRecord() => HealthDataType.height,
      BloodGlucoseRecord() => HealthDataType.bloodGlucose,
      BodyFatPercentageRecord() => HealthDataType.bodyFatPercentage,
      BodyTemperatureRecord() => HealthDataType.bodyTemperature,
      ActiveCaloriesBurnedRecord() => HealthDataType.activeCaloriesBurned,
      ExerciseSessionRecord() => HealthDataType.exerciseSession,
      FloorsClimbedRecord() => HealthDataType.floorsClimbed,
      WheelchairPushesRecord() => HealthDataType.wheelchairPushes,
      LeanBodyMassRecord() => HealthDataType.leanBodyMass,
      HydrationRecord() => HealthDataType.hydration,

      // Blood pressure records
      BloodPressureRecord() => HealthDataType.bloodPressure,
      SystolicBloodPressureRecord() => HealthDataType.systolicBloodPressure,
      DiastolicBloodPressureRecord() => HealthDataType.diastolicBloodPressure,

      // Heart rate records
      HeartRateSeriesRecord() => HealthDataType.heartRateSeriesRecord,
      HeartRateMeasurementRecord() => HealthDataType.heartRateMeasurementRecord,

      // Sleep records
      SleepSessionRecord() => HealthDataType.sleepSession,
      SleepStageRecord() => HealthDataType.sleepStageRecord,

      // Mindfulness records
      MindfulnessSessionRecord() => HealthDataType.mindfulnessSession,

      // Vital signs
      RestingHeartRateRecord() => HealthDataType.restingHeartRate,
      OxygenSaturationRecord() => HealthDataType.oxygenSaturation,
      RespiratoryRateRecord() => HealthDataType.respiratoryRate,
      Vo2MaxRecord() => HealthDataType.vo2Max,

      // Nutrition records
      NutritionRecord() => HealthDataType.nutrition,
      EnergyNutrientRecord() => HealthDataType.energyNutrient,
      CaffeineNutrientRecord() => HealthDataType.caffeine,
      ProteinNutrientRecord() => HealthDataType.protein,
      TotalCarbohydrateNutrientRecord() => HealthDataType.totalCarbohydrate,
      TotalFatNutrientRecord() => HealthDataType.totalFat,
      SaturatedFatNutrientRecord() => HealthDataType.saturatedFat,
      MonounsaturatedFatNutrientRecord() => HealthDataType.monounsaturatedFat,
      PolyunsaturatedFatNutrientRecord() => HealthDataType.polyunsaturatedFat,
      CholesterolNutrientRecord() => HealthDataType.cholesterol,
      DietaryFiberNutrientRecord() => HealthDataType.dietaryFiber,
      SugarNutrientRecord() => HealthDataType.sugar,

      // Mineral nutrients
      CalciumNutrientRecord() => HealthDataType.calcium,
      IronNutrientRecord() => HealthDataType.iron,
      MagnesiumNutrientRecord() => HealthDataType.magnesium,
      ManganeseNutrientRecord() => HealthDataType.manganese,
      PhosphorusNutrientRecord() => HealthDataType.phosphorus,
      PotassiumNutrientRecord() => HealthDataType.potassium,
      SeleniumNutrientRecord() => HealthDataType.selenium,
      SodiumNutrientRecord() => HealthDataType.sodium,
      ZincNutrientRecord() => HealthDataType.zinc,

      // Vitamin nutrients
      VitaminANutrientRecord() => HealthDataType.vitaminA,
      VitaminB6NutrientRecord() => HealthDataType.vitaminB6,
      VitaminB12NutrientRecord() => HealthDataType.vitaminB12,
      VitaminCNutrientRecord() => HealthDataType.vitaminC,
      VitaminDNutrientRecord() => HealthDataType.vitaminD,
      VitaminENutrientRecord() => HealthDataType.vitaminE,
      VitaminKNutrientRecord() => HealthDataType.vitaminK,
      ThiaminNutrientRecord() => HealthDataType.thiamin,
      RiboflavinNutrientRecord() => HealthDataType.riboflavin,
      NiacinNutrientRecord() => HealthDataType.niacin,
      FolateNutrientRecord() => HealthDataType.folate,
      BiotinNutrientRecord() => HealthDataType.biotin,
      PantothenicAcidNutrientRecord() => HealthDataType.pantothenicAcid,
    };
  }
}
