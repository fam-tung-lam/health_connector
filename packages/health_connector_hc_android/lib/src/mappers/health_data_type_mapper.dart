import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show HealthDataTypeDto;
import 'package:meta/meta.dart' show internal;

/// Converts [HealthDataTypeDto] to [HealthDataType].
@sinceV1_0_0
@internal
extension HealthDataTypeDtoToDomain on HealthDataTypeDto {
  HealthDataType<HealthRecord, MeasurementUnit> toDomain() {
    switch (this) {
      case HealthDataTypeDto.activeCaloriesBurned:
        return HealthDataType.activeEnergyBurned;
      case HealthDataTypeDto.basalMetabolicRate:
        return HealthDataType.basalMetabolicRate;
      case HealthDataTypeDto.activityIntensity:
        return HealthDataType.activityIntensity;
      case HealthDataTypeDto.distance:
        return HealthDataType.distance;
      case HealthDataTypeDto.elevationGained:
        return HealthDataType.elevationGained;
      case HealthDataTypeDto.floorsClimbed:
        return HealthDataType.floorsClimbed;
      case HealthDataTypeDto.height:
        return HealthDataType.height;
      case HealthDataTypeDto.hydration:
        return HealthDataType.hydration;
      case HealthDataTypeDto.leanBodyMass:
        return HealthDataType.leanBodyMass;
      case HealthDataTypeDto.bodyFatPercentage:
        return HealthDataType.bodyFatPercentage;
      case HealthDataTypeDto.bodyTemperature:
        return HealthDataType.bodyTemperature;
      case HealthDataTypeDto.basalBodyTemperature:
        return HealthDataType.basalBodyTemperature;
      case HealthDataTypeDto.cervicalMucus:
        return HealthDataType.cervicalMucus;
      case HealthDataTypeDto.steps:
        return HealthDataType.steps;
      case HealthDataTypeDto.weight:
        return HealthDataType.weight;
      case HealthDataTypeDto.wheelchairPushes:
        return HealthDataType.wheelchairPushes;
      case HealthDataTypeDto.heartRateSeries:
        return HealthDataType.heartRateSeries;
      case HealthDataTypeDto.cyclingPedalingCadenceSeries:
        return HealthDataType.cyclingPedalingCadenceSeries;
      case HealthDataTypeDto.stepsCadenceSeriesRecord:
        return HealthDataType.stepsCadenceSeries;
      case HealthDataTypeDto.sexualActivity:
        return HealthDataType.sexualActivity;
      case HealthDataTypeDto.sleepSession:
        return HealthDataType.sleepSession;
      case HealthDataTypeDto.exerciseSession:
        return HealthDataType.exerciseSession;
      case HealthDataTypeDto.nutrition:
        return HealthDataType.nutrition;
      case HealthDataTypeDto.restingHeartRate:
        return HealthDataType.restingHeartRate;
      case HealthDataTypeDto.bloodPressure:
        return HealthDataType.bloodPressure;
      case HealthDataTypeDto.ovulationTest:
        return HealthDataType.ovulationTest;
      case HealthDataTypeDto.intermenstrualBleeding:
        return HealthDataType.intermenstrualBleeding;
      case HealthDataTypeDto.menstrualFlowInstant:
        return HealthDataType.menstrualFlowInstant;
      case HealthDataTypeDto.oxygenSaturation:
        return HealthDataType.oxygenSaturation;
      case HealthDataTypeDto.respiratoryRate:
        return HealthDataType.respiratoryRate;
      case HealthDataTypeDto.vo2Max:
        return HealthDataType.vo2Max;
      case HealthDataTypeDto.bloodGlucose:
        return HealthDataType.bloodGlucose;
      case HealthDataTypeDto.powerSeries:
        return HealthDataType.powerSeries;
      case HealthDataTypeDto.speedSeries:
        return HealthDataType.speedSeries;
      case HealthDataTypeDto.totalCaloriesBurned:
        return HealthDataType.totalEnergyBurned;
      case HealthDataTypeDto.mindfulnessSession:
        return HealthDataType.mindfulnessSession;
      case HealthDataTypeDto.boneMass:
        return HealthDataType.boneMass;
      case HealthDataTypeDto.bodyWaterMass:
        return HealthDataType.bodyWaterMass;
      case HealthDataTypeDto.heartRateVariabilityRMSSD:
        return HealthDataType.heartRateVariabilityRMSSD;
    }
  }
}

/// Converts [HealthDataType] to [HealthDataTypeDto].
@sinceV1_0_0
@internal
extension HealthDataTypeToDto on HealthDataType {
  HealthDataTypeDto toDto() {
    switch (this) {
      case ActiveEnergyBurnedDataType _:
        return HealthDataTypeDto.activeCaloriesBurned;
      case BasalMetabolicRateDataType _:
        return HealthDataTypeDto.basalMetabolicRate;
      case ActivityIntensityDataType _:
        return HealthDataTypeDto.activityIntensity;
      case DistanceDataType _:
        return HealthDataTypeDto.distance;
      case ElevationGainedDataType _:
        return HealthDataTypeDto.elevationGained;
      case FloorsClimbedDataType _:
        return HealthDataTypeDto.floorsClimbed;
      case HeightDataType _:
        return HealthDataTypeDto.height;
      case HydrationDataType _:
        return HealthDataTypeDto.hydration;
      case LeanBodyMassDataType _:
        return HealthDataTypeDto.leanBodyMass;
      case BodyFatPercentageDataType _:
        return HealthDataTypeDto.bodyFatPercentage;
      case BodyTemperatureDataType _:
        return HealthDataTypeDto.bodyTemperature;
      case BasalBodyTemperatureDataType _:
        return HealthDataTypeDto.basalBodyTemperature;
      case CervicalMucusDataType _:
        return HealthDataTypeDto.cervicalMucus;
      case StepsDataType _:
        return HealthDataTypeDto.steps;
      case WeightDataType _:
        return HealthDataTypeDto.weight;
      case WheelchairPushesDataType _:
        return HealthDataTypeDto.wheelchairPushes;
      case HeartRateSeriesDataType _:
        return HealthDataTypeDto.heartRateSeries;
      case CyclingPedalingCadenceSeriesDataType _:
        return HealthDataTypeDto.cyclingPedalingCadenceSeries;
      case StepsCadenceSeriesDataType _:
        return HealthDataTypeDto.stepsCadenceSeriesRecord;
      case SexualActivityDataType _:
        return HealthDataTypeDto.sexualActivity;
      case SleepSessionDataType _:
        return HealthDataTypeDto.sleepSession;
      case ExerciseSessionDataType _:
        return HealthDataTypeDto.exerciseSession;
      case MindfulnessSessionDataType _:
        return HealthDataTypeDto.mindfulnessSession;
      case BoneMassDataType _:
        return HealthDataTypeDto.boneMass;
      case BodyWaterMassDataType _:
        return HealthDataTypeDto.bodyWaterMass;
      case HeartRateVariabilityRMSSDDataType _:
        return HealthDataTypeDto.heartRateVariabilityRMSSD;
      case BloodPressureDataType _:
        return HealthDataTypeDto.bloodPressure;
      case OvulationTestDataType _:
        return HealthDataTypeDto.ovulationTest;
      case IntermenstrualBleedingDataType _:
        return HealthDataTypeDto.intermenstrualBleeding;
      case MenstrualFlowInstantDataType _:
        return HealthDataTypeDto.menstrualFlowInstant;
      case OxygenSaturationDataType _:
        return HealthDataTypeDto.oxygenSaturation;
      case RespiratoryRateDataType _:
        return HealthDataTypeDto.respiratoryRate;
      case NutritionDataType _:
        return HealthDataTypeDto.nutrition;
      case RestingHeartRateDataType _:
        return HealthDataTypeDto.restingHeartRate;
      case Vo2MaxDataType _:
        return HealthDataTypeDto.vo2Max;
      case BloodGlucoseDataType _:
        return HealthDataTypeDto.bloodGlucose;
      case TotalEnergyBurnedDataType _:
        return HealthDataTypeDto.totalCaloriesBurned;
      case SpeedSeriesDataType _:
        return HealthDataTypeDto.speedSeries;
      case PowerSeriesDataType _:
        return HealthDataTypeDto.powerSeries;

      // region Unsupported data types with alternative

      case DietaryEnergyConsumedDataType _:
      case DietaryCaffeineDataType _:
      case DietaryProteinDataType _:
      case DietaryTotalCarbohydrateDataType _:
      case DietaryTotalFatDataType _:
      case DietarySaturatedFatDataType _:
      case DietaryMonounsaturatedFatDataType _:
      case DietaryPolyunsaturatedFatDataType _:
      case DietaryCholesterolDataType _:
      case DietaryFiberNutrientDataType _:
      case DietarySugarDataType _:
      case DietaryVitaminADataType _:
      case DietaryVitaminB6DataType _:
      case DietaryVitaminB12DataType _:
      case DietaryVitaminCDataType _:
      case DietaryVitaminDDataType _:
      case DietaryVitaminEDataType _:
      case DietaryVitaminKDataType _:
      case DietaryThiaminDataType _:
      case DietaryRiboflavinDataType _:
      case DietaryNiacinDataType _:
      case DietaryFolateDataType _:
      case DietaryBiotinDataType _:
      case DietaryPantothenicAcidDataType _:
      case DietaryCalciumDataType _:
      case DietaryIronDataType _:
      case DietaryMagnesiumDataType _:
      case DietaryManganeseDataType _:
      case DietaryPhosphorusDataType _:
      case DietaryPotassiumDataType _:
      case DietarySeleniumDataType _:
      case DietarySodiumDataType _:
      case DietaryZincDataType _:
        throw UnsupportedError(
          '$this is not supported on Android Health Connect. '
          'Use $NutritionDataType instead.',
        );
      case BasalEnergyBurnedDataType _:
        throw UnsupportedError(
          '$BasalEnergyBurnedDataType is not supported on '
          'Android Health Connect. Use $TotalEnergyBurnedDataType '
          'and $ActiveEnergyBurnedDataType instead.',
        );
      case SleepStageDataType _:
        throw UnsupportedError(
          '$SleepStageDataType is not supported on '
          'Android Health Connect. Use $SleepSessionDataType instead.',
        );
      case HeartRateDataType _:
        throw UnsupportedError(
          '$HeartRateDataType is not '
          'supported on Android Health Connect. '
          'Use $HeartRateSeriesDataType instead.',
        );
      case CyclingPedalingCadenceDataType _:
        throw UnsupportedError(
          '$CyclingPedalingCadenceDataType is not '
          'supported on Android Health Connect. '
          'Use $CyclingPedalingCadenceSeriesDataType instead.',
        );
      case SystolicBloodPressureDataType _:
        throw UnsupportedError(
          '$SystolicBloodPressureDataType is not supported on '
          'Android Health Connect. Use $BloodPressureDataType instead.',
        );
      case DiastolicBloodPressureDataType _:
        throw UnsupportedError(
          '$DiastolicBloodPressureDataType is not supported on '
          'Health Connect. Use $BloodPressureDataType instead.',
        );
      case CyclingDistanceDataType _:
      case SwimmingDistanceDataType _:
      case WheelchairDistanceDataType _:
      case DownhillSnowSportsDistanceDataType _:
      case RowingDistanceDataType _:
      case PaddleSportsDistanceDataType _:
      case CrossCountrySkiingDistanceDataType _:
      case SkatingSportsDistanceDataType _:
      case SixMinuteWalkTestDistanceDataType _:
      case WalkingRunningDistanceDataType _:
        throw UnsupportedError(
          '$this is is not supported on Android Health Connect. '
          'Use general $DistanceDataType instead',
        );
      case CyclingPowerDataType _:
        throw UnsupportedError(
          '$CyclingPowerDataType is not supported on Android Health '
          'Connect. Use general $PowerSeriesDataType instead',
        );
      case RunningPowerDataType _:
        throw UnsupportedError(
          '$RunningPowerDataType is not supported on Android Health '
          'Connect. Use general $PowerSeriesDataType instead',
        );
      case WalkingSpeedDataType _:
      case RunningSpeedDataType _:
      case StairAscentSpeedDataType _:
      case StairDescentSpeedDataType _:
        throw UnsupportedError(
          '$this is not supported on Android Health Connect. '
          'Use general $SpeedSeriesDataType instead.',
        );
      case BodyMassIndexDataType _:
        throw UnsupportedError(
          '$BodyMassIndexDataType is not supported on Android '
          'Health Connect. Use $WeightDataType and '
          '$HeightDataType for calculation instead',
        );
      case HeartRateVariabilitySDNNDataType _:
        throw UnsupportedError(
          '$HeartRateVariabilitySDNNDataType is not supported on '
          'Android Health Connect. Use $HeartRateVariabilityRMSSDDataType '
          'instead.',
        );

      case MenstrualFlowDataType _:
        throw UnsupportedError(
          '$MenstrualFlowDataType is not supported on Android Health Connect. '
          'Use $MenstrualFlowInstantDataType instead.',
        );

      // endregion

      // region Unsupported data type without alternative

      case SleepingWristTemperatureDataType _:
      case ForcedVitalCapacityDataType _:
      case ForcedExpiratoryVolumeDataType _:
      case PregnancyTestDataType _:
      case ProgesteroneTestDataType _:
      case ContraceptiveDataType _:
      case LactationDataType _:
      case PregnancyDataType _:
      case PeripheralPerfusionIndexDataType _:
      case AlcoholicBeveragesDataType _:
      case ExerciseTimeDataType _:
      case MoveTimeDataType _:
      case StandTimeDataType _:
      case WalkingSteadinessDataType _:
      case BloodAlcoholContentDataType _:
      case SwimmingStrokesDataType _:
      case WaistCircumferenceDataType _:
      case WalkingAsymmetryPercentageDataType _:
      case WalkingDoubleSupportPercentageDataType _:
      case WalkingStepLengthDataType _:
      case LowHeartRateEventDataType():
      case IrregularHeartRhythmEventDataType():
      case IrregularMenstrualCycleEventDataType():
      case InfrequentMenstrualCycleEventDataType():
      case HighHeartRateEventDataType():
      case WalkingSteadinessEventDataType():
      case PersistentIntermenstrualBleedingEventDataType():
      case ProlongedMenstrualPeriodEventDataType():
      case AtrialFibrillationBurdenDataType():
      case HeartRateRecoveryOneMinuteDataType():
      case WalkingHeartRateAverageDataType():
      case NumberOfTimesFallenDataType():
      case ElectrodermalActivityDataType():
      case InsulinDeliveryDataType():
      case InhalerUsageDataType():
      case RunningStrideLengthDataType():
      case RunningGroundContactTimeDataType():
      case LowCardioFitnessEventDataType():
      case EnvironmentalAudioExposureEventDataType():
      case EnvironmentalAudioExposureDataType():
      case HeadphoneAudioExposureDataType():
      case HeadphoneAudioExposureEventDataType():
        throw UnsupportedError(
          '$this is not supported on Android Health Connect.',
        );

      // endregion
    }
  }
}
