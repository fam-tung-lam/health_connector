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
      case HealthDataTypeDto.heartRateSeriesRecord:
        return HealthDataType.heartRateSeries;
      case HealthDataTypeDto.cyclingPedalingCadenceSeriesRecord:
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
      case ActivityIntensityDataType _:
        return HealthDataTypeDto.activityIntensity;
      case AlcoholicBeveragesDataType _:
        throw UnsupportedError(
          '$AlcoholicBeveragesDataType is not supported on Android Health '
          'Connect. This data type is iOS-only.',
        );
      case BloodAlcoholContentDataType _:
        throw UnsupportedError(
          '$BloodAlcoholContentDataType is not supported on Android Health '
          'Connect. This data type is iOS-only.',
        );
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
        return HealthDataTypeDto.heartRateSeriesRecord;
      case CyclingPedalingCadenceSeriesDataType _:
        return HealthDataTypeDto.cyclingPedalingCadenceSeriesRecord;
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
      case PregnancyTestDataType _:
        throw UnsupportedError(
          '$PregnancyTestDataType is not supported on Android Health Connect. '
          'This data type is iOS-only (requires iOS 15.0+).',
        );
      case ProgesteroneTestDataType _:
        throw UnsupportedError(
          '$ProgesteroneTestDataType is not supported on Android Health '
          'Connect.',
        );
      case ContraceptiveDataType _:
        throw UnsupportedError(
          '$ContraceptiveDataType is not supported on Android Health Connect. '
          'This data type is iOS-only (requires iOS 14.3+).',
        );
      case LactationDataType _:
        throw UnsupportedError(
          '$LactationDataType is not supported on Android Health Connect. '
          'This data type is iOS-only (requires iOS 15.0+).',
        );
      case PregnancyDataType _:
        throw UnsupportedError(
          '$PregnancyDataType is not supported on Android Health Connect. '
          'This data type is iOS-only (requires iOS 15.0+).',
        );
      case IntermenstrualBleedingDataType _:
        return HealthDataTypeDto.intermenstrualBleeding;
      case MenstrualFlowInstantDataType _:
        return HealthDataTypeDto.menstrualFlowInstant;
      case PeripheralPerfusionIndexDataType _:
        throw UnsupportedError(
          '$PeripheralPerfusionIndexDataType is not supported on '
          'Android Health Connect.',
        );
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
      case SwimmingStrokesDataType _:
        throw UnsupportedError(
          '$SwimmingStrokesDataType is not supported on Android '
          'Health Connect.',
        );
      case BodyMassIndexDataType _:
        throw UnsupportedError(
          '$BodyMassIndexDataType is not supported on Android '
          'Health Connect. Use $WeightDataType and '
          '$HeightDataType for calculation instead',
        );
      case WaistCircumferenceDataType _:
        throw UnsupportedError(
          '$WaistCircumferenceDataType is not supported on '
          'Android Health Connect.',
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
      case ForcedVitalCapacityDataType():
        throw UnsupportedError(
          '$ForcedVitalCapacityDataType is not supported on Android Health '
          'Connect. This data type is iOS-only.',
        );
    }
  }
}
