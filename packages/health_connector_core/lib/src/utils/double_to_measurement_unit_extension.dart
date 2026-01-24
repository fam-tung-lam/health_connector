import 'package:health_connector_core/health_connector_core_internal.dart';

/// Extension on [double] to facilitate conversion to [MeasurementUnit] types
/// based on [HealthDataType].
@internalUse
extension DoubleToMeasurementUnit on double {
  /// Converts a raw aggregated [double] value to the appropriate
  /// [MeasurementUnit] for the given [dataType].
  ///
  /// The specific unit used (e.g., meters, kilograms, kilocalories) is
  /// determined by the provided [dataType].
  ///
  /// Throws [ArgumentError] for non-aggregatable data types (e.g., events,
  /// categorical data types).
  MeasurementUnit toMeasurementUnit(HealthDataType dataType) {
    switch (dataType) {
      // BloodGlucose
      case BloodGlucoseDataType _:
        return BloodGlucose.millimolesPerLiter(this);

      // Energy
      case ActiveEnergyBurnedDataType _:
      case BasalEnergyBurnedDataType _:
      case DietaryEnergyConsumedDataType _:
      case TotalEnergyBurnedDataType _:
        return Energy.kilocalories(this);

      // Frequency
      case CyclingPedalingCadenceDataType _:
      case CyclingPedalingCadenceSeriesDataType _:
      case HeartRateDataType _:
      case HeartRateRecoveryOneMinuteDataType _:
      case HeartRateSeriesDataType _:
      case RespiratoryRateDataType _:
      case RestingHeartRateDataType _:
      case StepsCadenceSeriesDataType _:
      case WalkingHeartRateAverageDataType _:
        return Frequency.perMinute(this);

      // Length
      case CrossCountrySkiingDistanceDataType _:
      case CyclingDistanceDataType _:
      case DistanceDataType _:
      case DownhillSnowSportsDistanceDataType _:
      case ElevationGainedDataType _:
      case HeightDataType _:
      case PaddleSportsDistanceDataType _:
      case RowingDistanceDataType _:
      case RunningStrideLengthDataType _:
      case SixMinuteWalkTestDistanceDataType _:
      case SkatingSportsDistanceDataType _:
      case SwimmingDistanceDataType _:
      case WaistCircumferenceDataType _:
      case WalkingRunningDistanceDataType _:
      case WalkingStepLengthDataType _:
      case WheelchairDistanceDataType _:
        return Length.meters(this);

      // Mass (grams)
      case DietaryBiotinDataType _:
      case DietaryCaffeineDataType _:
      case DietaryCalciumDataType _:
      case DietaryCholesterolDataType _:
      case DietaryFiberNutrientDataType _:
      case DietaryFolateDataType _:
      case DietaryIronDataType _:
      case DietaryMagnesiumDataType _:
      case DietaryManganeseDataType _:
      case DietaryMonounsaturatedFatDataType _:
      case DietaryNiacinDataType _:
      case DietaryPantothenicAcidDataType _:
      case DietaryPhosphorusDataType _:
      case DietaryPolyunsaturatedFatDataType _:
      case DietaryPotassiumDataType _:
      case DietaryProteinDataType _:
      case DietaryRiboflavinDataType _:
      case DietarySaturatedFatDataType _:
      case DietarySeleniumDataType _:
      case DietarySodiumDataType _:
      case DietarySugarDataType _:
      case DietaryThiaminDataType _:
      case DietaryTotalCarbohydrateDataType _:
      case DietaryTotalFatDataType _:
      case DietaryVitaminADataType _:
      case DietaryVitaminB6DataType _:
      case DietaryVitaminB12DataType _:
      case DietaryVitaminCDataType _:
      case DietaryVitaminDDataType _:
      case DietaryVitaminEDataType _:
      case DietaryVitaminKDataType _:
      case DietaryZincDataType _:
        return Mass.grams(this);

      // Mass (kilograms)
      case BodyWaterMassDataType _:
      case LeanBodyMassDataType _:
      case WeightDataType _:
        return Mass.kilograms(this);

      // Number
      case AlcoholicBeveragesDataType _:
      case BodyMassIndexDataType _:
      case ElectrodermalActivityDataType _:
      case FloorsClimbedDataType _:
      case InhalerUsageDataType _:
      case InsulinDeliveryDataType _:
      case NumberOfTimesFallenDataType _:
      case StepsDataType _:
      case SwimmingStrokesDataType _:
      case Vo2MaxDataType _:
      case WheelchairPushesDataType _:
      case EnvironmentalAudioExposureDataType _:
        return Number(this);

      // Percentage
      case AtrialFibrillationBurdenDataType _:
      case BloodAlcoholContentDataType _:
      case OxygenSaturationDataType _:
      case PeripheralPerfusionIndexDataType _:
      case WalkingAsymmetryPercentageDataType _:
      case WalkingDoubleSupportPercentageDataType _:
      case WalkingSteadinessDataType _:
        return Percentage.fromDecimal(this);

      // Power
      case CyclingPowerDataType _:
      case PowerSeriesDataType _:
      case RunningPowerDataType _:
        return Power.watts(this);

      // Pressure
      case BloodPressureDataType _:
      case DiastolicBloodPressureDataType _:
      case SystolicBloodPressureDataType _:
        return Pressure.millimetersOfMercury(this);

      // Temperature
      case SleepingWristTemperatureDataType _:
        return Temperature.celsius(this);

      // TimeDuration
      case ActivityIntensityDataType _:
      case ExerciseSessionDataType _:
      case ExerciseTimeDataType _:
      case HeartRateVariabilitySDNNDataType _:
      case MindfulnessSessionDataType _:
      case MoveTimeDataType _:
      case RunningGroundContactTimeDataType _:
      case SleepSessionDataType _:
      case SleepStageDataType _:
      case StandTimeDataType _:
        return TimeDuration.seconds(this);

      // Velocity
      case RunningSpeedDataType _:
      case SpeedSeriesDataType _:
      case StairAscentSpeedDataType _:
      case StairDescentSpeedDataType _:
      case WalkingSpeedDataType _:
        return Velocity.metersPerSecond(this);

      // Volume
      case ForcedExpiratoryVolumeDataType _:
      case ForcedVitalCapacityDataType _:
      case HydrationDataType _:
        return Volume.liters(this);

      // region Not aggregatable data types

      case BasalBodyTemperatureDataType _:
      case BodyFatPercentageDataType _:
      case BodyTemperatureDataType _:
      case BoneMassDataType _:
      case CervicalMucusDataType _:
      case HeartRateVariabilityRMSSDDataType _:
      case ContraceptiveDataType _:
      case HighHeartRateEventDataType _:
      case EnvironmentalAudioExposureEventDataType _:
      case InfrequentMenstrualCycleEventDataType _:
      case IntermenstrualBleedingDataType _:
      case IrregularHeartRhythmEventDataType _:
      case IrregularMenstrualCycleEventDataType _:
      case LactationDataType _:
      case LowCardioFitnessEventDataType _:
      case LowHeartRateEventDataType _:
      case MenstrualFlowDataType _:
      case MenstrualFlowInstantDataType _:
      case NutritionDataType _:
      case OvulationTestDataType _:
      case PersistentIntermenstrualBleedingEventDataType _:
      case PregnancyDataType _:
      case PregnancyTestDataType _:
      case ProgesteroneTestDataType _:
      case ProlongedMenstrualPeriodEventDataType _:
      case SexualActivityDataType _:
      case WalkingSteadinessEventDataType _:
        throw ArgumentError(
          '$dataType is not aggregatable and is not supported for '
          'conversion to MeasurementUnit.',
        );

      // endregion
    }
  }
}
