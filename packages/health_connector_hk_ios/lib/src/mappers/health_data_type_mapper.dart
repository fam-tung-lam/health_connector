import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show HealthDataTypeDto;
import 'package:meta/meta.dart' show internal;

/// Converts [HealthDataTypeDto] to [HealthDataType].
@internal
extension HealthDataTypeDtoToDomain on HealthDataTypeDto {
  HealthDataType<HealthRecord, MeasurementUnit> toDomain() {
    switch (this) {
      case HealthDataTypeDto.activeCaloriesBurned:
        return HealthDataType.activeEnergyBurned;
      case HealthDataTypeDto.alcoholicBeverages:
        return HealthDataType.alcoholicBeverages;
      case HealthDataTypeDto.bloodAlcoholContent:
        return HealthDataType.bloodAlcoholContent;
      case HealthDataTypeDto.basalEnergyBurned:
        return HealthDataType.basalEnergyBurned;
      case HealthDataTypeDto.distance:
        return HealthDataType.distance;
      case HealthDataTypeDto.floorsClimbed:
        return HealthDataType.floorsClimbed;
      case HealthDataTypeDto.height:
        return HealthDataType.height;
      case HealthDataTypeDto.electrodermalActivity:
        return HealthDataType.electrodermalActivity;
      case HealthDataTypeDto.hydration:
        return HealthDataType.hydration;
      case HealthDataTypeDto.insulinDelivery:
        return HealthDataType.insulinDelivery;
      case HealthDataTypeDto.leanBodyMass:
        return HealthDataType.leanBodyMass;
      case HealthDataTypeDto.bodyFatPercentage:
        return HealthDataType.bodyFatPercentage;
      case HealthDataTypeDto.bodyTemperature:
        return HealthDataType.bodyTemperature;
      case HealthDataTypeDto.bodyMassIndex:
        return HealthDataType.bodyMassIndex;
      case HealthDataTypeDto.basalBodyTemperature:
        return HealthDataType.basalBodyTemperature;
      case HealthDataTypeDto.cervicalMucus:
        return HealthDataType.cervicalMucus;
      case HealthDataTypeDto.steps:
        return HealthDataType.steps;
      case HealthDataTypeDto.weight:
        return HealthDataType.weight;
      case HealthDataTypeDto.waistCircumference:
        return HealthDataType.waistCircumference;
      case HealthDataTypeDto.wheelchairPushes:
        return HealthDataType.wheelchairPushes;
      case HealthDataTypeDto.heartRateMeasurementRecord:
        return HealthDataType.heartRate;
      case HealthDataTypeDto.heartRateRecoveryOneMinute:
        return HealthDataType.heartRateRecoveryOneMinute;
      case HealthDataTypeDto.heartRateVariabilitySDNN:
        return HealthDataType.heartRateVariabilitySDNN;
      case HealthDataTypeDto.cyclingPedalingCadence:
        return HealthDataType.cyclingPedalingCadence;
      case HealthDataTypeDto.sleepStageRecord:
        return HealthDataType.sleepStageRecord;
      case HealthDataTypeDto.sexualActivity:
        return HealthDataType.sexualActivity;
      case HealthDataTypeDto.dietaryEnergyConsumed:
        return HealthDataType.dietaryEnergyConsumed;
      case HealthDataTypeDto.caffeine:
        return HealthDataType.dietaryCaffeine;
      case HealthDataTypeDto.protein:
        return HealthDataType.dietaryProtein;
      case HealthDataTypeDto.totalCarbohydrate:
        return HealthDataType.dietaryTotalCarbohydrate;
      case HealthDataTypeDto.totalFat:
        return HealthDataType.dietaryTotalFat;
      case HealthDataTypeDto.saturatedFat:
        return HealthDataType.dietarySaturatedFat;
      case HealthDataTypeDto.monounsaturatedFat:
        return HealthDataType.dietaryMonounsaturatedFat;
      case HealthDataTypeDto.polyunsaturatedFat:
        return HealthDataType.dietaryPolyunsaturatedFat;
      case HealthDataTypeDto.cholesterol:
        return HealthDataType.dietaryCholesterol;
      case HealthDataTypeDto.dietaryFiber:
        return HealthDataType.dietaryFiber;
      case HealthDataTypeDto.sugar:
        return HealthDataType.dietarySugar;
      case HealthDataTypeDto.vitaminA:
        return HealthDataType.dietaryVitaminA;
      case HealthDataTypeDto.vitaminB6:
        return HealthDataType.dietaryVitaminB6;
      case HealthDataTypeDto.vitaminB12:
        return HealthDataType.dietaryVitaminB12;
      case HealthDataTypeDto.vitaminC:
        return HealthDataType.dietaryVitaminC;
      case HealthDataTypeDto.vitaminD:
        return HealthDataType.dietaryVitaminD;
      case HealthDataTypeDto.vitaminE:
        return HealthDataType.dietaryVitaminE;
      case HealthDataTypeDto.vitaminK:
        return HealthDataType.dietaryVitaminK;
      case HealthDataTypeDto.thiamin:
        return HealthDataType.dietaryThiamin;
      case HealthDataTypeDto.riboflavin:
        return HealthDataType.dietaryRiboflavin;
      case HealthDataTypeDto.niacin:
        return HealthDataType.dietaryNiacin;
      case HealthDataTypeDto.folate:
        return HealthDataType.dietaryFolate;
      case HealthDataTypeDto.biotin:
        return HealthDataType.dietaryBiotin;
      case HealthDataTypeDto.pantothenicAcid:
        return HealthDataType.dietaryPantothenicAcid;
      case HealthDataTypeDto.calcium:
        return HealthDataType.dietaryCalcium;
      case HealthDataTypeDto.iron:
        return HealthDataType.dietaryIron;
      case HealthDataTypeDto.magnesium:
        return HealthDataType.dietaryMagnesium;
      case HealthDataTypeDto.manganese:
        return HealthDataType.dietaryManganese;
      case HealthDataTypeDto.phosphorus:
        return HealthDataType.dietaryPhosphorus;
      case HealthDataTypeDto.potassium:
        return HealthDataType.dietaryPotassium;
      case HealthDataTypeDto.selenium:
        return HealthDataType.dietarySelenium;
      case HealthDataTypeDto.sodium:
        return HealthDataType.dietarySodium;
      case HealthDataTypeDto.zinc:
        return HealthDataType.dietaryZinc;
      case HealthDataTypeDto.nutrition:
        return HealthDataType.nutrition;
      case HealthDataTypeDto.bloodPressure:
        return HealthDataType.bloodPressure;
      case HealthDataTypeDto.systolicBloodPressure:
        return HealthDataType.systolicBloodPressure;
      case HealthDataTypeDto.diastolicBloodPressure:
        return HealthDataType.diastolicBloodPressure;
      case HealthDataTypeDto.restingHeartRate:
        return HealthDataType.restingHeartRate;
      case HealthDataTypeDto.ovulationTest:
        return HealthDataType.ovulationTest;
      case HealthDataTypeDto.pregnancyTest:
        return HealthDataType.pregnancyTest;
      case HealthDataTypeDto.progesteroneTest:
        return HealthDataType.progesteroneTest;
      case HealthDataTypeDto.intermenstrualBleeding:
        return HealthDataType.intermenstrualBleeding;
      case HealthDataTypeDto.menstrualFlow:
        return HealthDataType.menstrualFlow;
      case HealthDataTypeDto.oxygenSaturation:
        return HealthDataType.oxygenSaturation;
      case HealthDataTypeDto.respiratoryRate:
        return HealthDataType.respiratoryRate;
      case HealthDataTypeDto.bloodGlucose:
        return HealthDataType.bloodGlucose;
      case HealthDataTypeDto.lactation:
        return HealthDataType.lactation;
      case HealthDataTypeDto.vo2Max:
        return HealthDataType.vo2Max;
      case HealthDataTypeDto.forcedVitalCapacity:
        return HealthDataType.forcedVitalCapacity;
      case HealthDataTypeDto.forcedExpiratoryVolume:
        return HealthDataType.forcedExpiratoryVolume;
      case HealthDataTypeDto.peakExpiratoryFlowRate:
        return HealthDataType.peakExpiratoryFlowRate;
      case HealthDataTypeDto.cyclingDistance:
        return HealthDataType.cyclingDistance;
      case HealthDataTypeDto.cyclingPower:
        return HealthDataType.cyclingPower;
      case HealthDataTypeDto.runningPower:
        return HealthDataType.runningPower;
      case HealthDataTypeDto.swimmingDistance:
        return HealthDataType.swimmingDistance;
      case HealthDataTypeDto.wheelchairDistance:
        return HealthDataType.wheelchairDistance;
      case HealthDataTypeDto.walkingRunningDistance:
        return HealthDataType.walkingRunningDistance;
      case HealthDataTypeDto.downhillSnowSportsDistance:
        return HealthDataType.downhillSnowSportsDistance;
      case HealthDataTypeDto.rowingDistance:
        return HealthDataType.rowingDistance;
      case HealthDataTypeDto.paddleSportsDistance:
        return HealthDataType.paddleSportsDistance;
      case HealthDataTypeDto.crossCountrySkiingDistance:
        return HealthDataType.crossCountrySkiingDistance;
      case HealthDataTypeDto.runningGroundContactTime:
        return HealthDataType.runningGroundContactTime;
      case HealthDataTypeDto.runningStrideLength:
        return HealthDataType.runningStrideLength;
      case HealthDataTypeDto.skatingSportsDistance:
        return HealthDataType.skatingSportsDistance;
      case HealthDataTypeDto.sixMinuteWalkTestDistance:
        return HealthDataType.sixMinuteWalkTestDistance;
      case HealthDataTypeDto.walkingSpeed:
        return HealthDataType.walkingSpeed;
      case HealthDataTypeDto.runningSpeed:
        return HealthDataType.runningSpeed;
      case HealthDataTypeDto.swimmingStrokes:
        return HealthDataType.swimmingStrokes;
      case HealthDataTypeDto.stairAscentSpeed:
        return HealthDataType.stairAscentSpeed;
      case HealthDataTypeDto.stairDescentSpeed:
        return HealthDataType.stairDescentSpeed;
      case HealthDataTypeDto.exerciseSession:
        return HealthDataType.exerciseSession;
      case HealthDataTypeDto.mindfulnessSession:
        return HealthDataType.mindfulnessSession;
      case HealthDataTypeDto.ovulationTestResult:
      case HealthDataTypeDto.progesteroneTestResult:
      case HealthDataTypeDto.pregnancy:
        return HealthDataType.pregnancy;
      case HealthDataTypeDto.contraceptive:
        return HealthDataType.contraceptive;
      case HealthDataTypeDto.sleepStage:
        return HealthDataType.sleepStageRecord;
      case HealthDataTypeDto.peripheralPerfusionIndex:
        return HealthDataType.peripheralPerfusionIndex;
      case HealthDataTypeDto.exerciseTime:
        return HealthDataType.exerciseTime;
      case HealthDataTypeDto.moveTime:
        return HealthDataType.moveTime;
      case HealthDataTypeDto.standTime:
        return HealthDataType.standTime;
      case HealthDataTypeDto.walkingSteadiness:
        return HealthDataType.walkingSteadiness;
      case HealthDataTypeDto.walkingAsymmetryPercentage:
        return HealthDataType.walkingAsymmetryPercentage;
      case HealthDataTypeDto.walkingDoubleSupportPercentage:
        return HealthDataType.walkingDoubleSupportPercentage;
      case HealthDataTypeDto.walkingStepLength:
        return HealthDataType.walkingStepLength;
      case HealthDataTypeDto.sleepingWristTemperature:
        return HealthDataType.sleepingWristTemperature;
      case HealthDataTypeDto.lowHeartRateEvent:
        return HealthDataType.lowHeartRateEvent;
      case HealthDataTypeDto.lowCardioFitnessEvent:
        return HealthDataType.lowCardioFitnessEvent;
      case HealthDataTypeDto.environmentalAudioExposureEvent:
        return HealthDataType.environmentalAudioExposureEvent;
      case HealthDataTypeDto.environmentalAudioExposure:
        return HealthDataType.environmentalAudioExposure;
      case HealthDataTypeDto.headphoneAudioExposureEvent:
        return HealthDataType.headphoneAudioExposureEvent;
      case HealthDataTypeDto.headphoneAudioExposure:
        return HealthDataType.headphoneAudioExposure;
      case HealthDataTypeDto.irregularHeartRhythmEvent:
        return HealthDataType.irregularHeartRhythmEvent;
      case HealthDataTypeDto.infrequentMenstrualCycleEvent:
        return HealthDataType.infrequentMenstrualCycleEvent;
      case HealthDataTypeDto.irregularMenstrualCycleEvent:
        return HealthDataType.irregularMenstrualCycleEvent;
      case HealthDataTypeDto.highHeartRateEvent:
        return HealthDataType.highHeartRateEvent;
      case HealthDataTypeDto.walkingSteadinessEvent:
        return HealthDataType.walkingSteadinessEvent;
      case HealthDataTypeDto.persistentIntermenstrualBleedingEvent:
        return HealthDataType.persistentIntermenstrualBleedingEvent;
      case HealthDataTypeDto.prolongedMenstrualPeriodEvent:
        return HealthDataType.prolongedMenstrualPeriodEvent;
      case HealthDataTypeDto.atrialFibrillationBurden:
        return HealthDataType.atrialFibrillationBurden;
      case HealthDataTypeDto.walkingHeartRateAverage:
        return HealthDataType.walkingHeartRateAverage;
      case HealthDataTypeDto.numberOfTimesFallen:
        return HealthDataType.numberOfTimesFallen;
      case HealthDataTypeDto.inhalerUsage:
        return HealthDataType.inhalerUsage;
    }
  }
}

/// Converts [HealthDataType] to [HealthDataTypeDto].
@internal
extension HealthDataTypeToDto on HealthDataType {
  HealthDataTypeDto toDto() {
    switch (this) {
      case ActiveEnergyBurnedDataType _:
        return HealthDataTypeDto.activeCaloriesBurned;
      case AlcoholicBeveragesDataType _:
        return HealthDataTypeDto.alcoholicBeverages;
      case BloodAlcoholContentDataType _:
        return HealthDataTypeDto.bloodAlcoholContent;
      case BasalEnergyBurnedDataType _:
        return HealthDataTypeDto.basalEnergyBurned;
      case FloorsClimbedDataType _:
        return HealthDataTypeDto.floorsClimbed;
      case HeightDataType _:
        return HealthDataTypeDto.height;
      case ElectrodermalActivityDataType _:
        return HealthDataTypeDto.electrodermalActivity;
      case HydrationDataType _:
        return HealthDataTypeDto.hydration;
      case InsulinDeliveryDataType _:
        return HealthDataTypeDto.insulinDelivery;
      case LeanBodyMassDataType _:
        return HealthDataTypeDto.leanBodyMass;
      case BodyFatPercentageDataType _:
        return HealthDataTypeDto.bodyFatPercentage;
      case BodyTemperatureDataType _:
        return HealthDataTypeDto.bodyTemperature;
      case BodyMassIndexDataType _:
        return HealthDataTypeDto.bodyMassIndex;
      case BasalBodyTemperatureDataType _:
        return HealthDataTypeDto.basalBodyTemperature;
      case SleepingWristTemperatureDataType _:
        return HealthDataTypeDto.sleepingWristTemperature;
      case LowHeartRateEventDataType _:
        return HealthDataTypeDto.lowHeartRateEvent;
      case LowCardioFitnessEventDataType _:
        return HealthDataTypeDto.lowCardioFitnessEvent;
      case EnvironmentalAudioExposureEventDataType _:
        return HealthDataTypeDto.environmentalAudioExposureEvent;
      case EnvironmentalAudioExposureDataType _:
        return HealthDataTypeDto.environmentalAudioExposure;
      case HeadphoneAudioExposureDataType _:
        return HealthDataTypeDto.headphoneAudioExposure;
      case CervicalMucusDataType _:
        return HealthDataTypeDto.cervicalMucus;
      case StepsDataType _:
        return HealthDataTypeDto.steps;
      case WeightDataType _:
        return HealthDataTypeDto.weight;
      case WaistCircumferenceDataType _:
        return HealthDataTypeDto.waistCircumference;
      case WheelchairPushesDataType _:
        return HealthDataTypeDto.wheelchairPushes;
      case HeartRateDataType _:
        return HealthDataTypeDto.heartRateMeasurementRecord;
      case HeartRateRecoveryOneMinuteDataType _:
        return HealthDataTypeDto.heartRateRecoveryOneMinute;
      case CyclingPedalingCadenceDataType _:
        return HealthDataTypeDto.cyclingPedalingCadence;
      case SleepStageDataType _:
        return HealthDataTypeDto.sleepStageRecord;
      case SexualActivityDataType _:
        return HealthDataTypeDto.sexualActivity;
      case DietaryEnergyConsumedDataType _:
        return HealthDataTypeDto.dietaryEnergyConsumed;
      case DietaryCaffeineDataType _:
        return HealthDataTypeDto.caffeine;
      case DietaryProteinDataType _:
        return HealthDataTypeDto.protein;
      case DietaryTotalCarbohydrateDataType _:
        return HealthDataTypeDto.totalCarbohydrate;
      case DietaryTotalFatDataType _:
        return HealthDataTypeDto.totalFat;
      case DietarySaturatedFatDataType _:
        return HealthDataTypeDto.saturatedFat;
      case DietaryMonounsaturatedFatDataType _:
        return HealthDataTypeDto.monounsaturatedFat;
      case DietaryPolyunsaturatedFatDataType _:
        return HealthDataTypeDto.polyunsaturatedFat;
      case DietaryCholesterolDataType _:
        return HealthDataTypeDto.cholesterol;
      case DietaryFiberNutrientDataType _:
        return HealthDataTypeDto.dietaryFiber;
      case DietarySugarDataType _:
        return HealthDataTypeDto.sugar;
      case DietaryVitaminADataType _:
        return HealthDataTypeDto.vitaminA;
      case DietaryVitaminB6DataType _:
        return HealthDataTypeDto.vitaminB6;
      case DietaryVitaminB12DataType _:
        return HealthDataTypeDto.vitaminB12;
      case DietaryVitaminCDataType _:
        return HealthDataTypeDto.vitaminC;
      case DietaryVitaminDDataType _:
        return HealthDataTypeDto.vitaminD;
      case DietaryVitaminEDataType _:
        return HealthDataTypeDto.vitaminE;
      case DietaryVitaminKDataType _:
        return HealthDataTypeDto.vitaminK;
      case DietaryThiaminDataType _:
        return HealthDataTypeDto.thiamin;
      case DietaryRiboflavinDataType _:
        return HealthDataTypeDto.riboflavin;
      case DietaryNiacinDataType _:
        return HealthDataTypeDto.niacin;
      case DietaryFolateDataType _:
        return HealthDataTypeDto.folate;
      case DietaryBiotinDataType _:
        return HealthDataTypeDto.biotin;
      case DietaryPantothenicAcidDataType _:
        return HealthDataTypeDto.pantothenicAcid;
      case DietaryCalciumDataType _:
        return HealthDataTypeDto.calcium;
      case DietaryIronDataType _:
        return HealthDataTypeDto.iron;
      case DietaryMagnesiumDataType _:
        return HealthDataTypeDto.magnesium;
      case DietaryManganeseDataType _:
        return HealthDataTypeDto.manganese;
      case DietaryPhosphorusDataType _:
        return HealthDataTypeDto.phosphorus;
      case DietaryPotassiumDataType _:
        return HealthDataTypeDto.potassium;
      case DietarySeleniumDataType _:
        return HealthDataTypeDto.selenium;
      case DietarySodiumDataType _:
        return HealthDataTypeDto.sodium;
      case DietaryZincDataType _:
        return HealthDataTypeDto.zinc;
      case NutritionDataType _:
        return HealthDataTypeDto.nutrition;
      case BloodPressureDataType _:
        return HealthDataTypeDto.bloodPressure;
      case SystolicBloodPressureDataType _:
        return HealthDataTypeDto.systolicBloodPressure;
      case DiastolicBloodPressureDataType _:
        return HealthDataTypeDto.diastolicBloodPressure;
      case RestingHeartRateDataType _:
        return HealthDataTypeDto.restingHeartRate;
      case OvulationTestDataType _:
        return HealthDataTypeDto.ovulationTest;
      case PregnancyTestDataType _:
        return HealthDataTypeDto.pregnancyTest;
      case ProgesteroneTestDataType _:
        return HealthDataTypeDto.progesteroneTest;
      case PregnancyDataType _:
        return HealthDataTypeDto.pregnancy;
      case ContraceptiveDataType _:
        return HealthDataTypeDto.contraceptive;
      case MenstruationPeriodDataType _:
        throw UnsupportedError(
          '$MenstruationPeriodDataType is not supported on iOS HealthKit. '
          'It is only available on Android Health Connect.',
        );
      case IntermenstrualBleedingDataType _:
        return HealthDataTypeDto.intermenstrualBleeding;
      case MenstrualFlowDataType _:
        return HealthDataTypeDto.menstrualFlow;
      case OxygenSaturationDataType _:
        return HealthDataTypeDto.oxygenSaturation;
      case RespiratoryRateDataType _:
        return HealthDataTypeDto.respiratoryRate;
      case Vo2MaxDataType _:
        return HealthDataTypeDto.vo2Max;
      case ForcedVitalCapacityDataType _:
        return HealthDataTypeDto.forcedVitalCapacity;
      case ForcedExpiratoryVolumeDataType _:
        return HealthDataTypeDto.forcedExpiratoryVolume;
      case PeakExpiratoryFlowRateDataType _:
        return HealthDataTypeDto.peakExpiratoryFlowRate;
      case BloodGlucoseDataType _:
        return HealthDataTypeDto.bloodGlucose;
      case CyclingDistanceDataType _:
        return HealthDataTypeDto.cyclingDistance;
      case CyclingPowerDataType _:
        return HealthDataTypeDto.cyclingPower;
      case RunningPowerDataType _:
        return HealthDataTypeDto.runningPower;
      case SwimmingDistanceDataType _:
        return HealthDataTypeDto.swimmingDistance;
      case WheelchairDistanceDataType _:
        return HealthDataTypeDto.wheelchairDistance;
      case DownhillSnowSportsDistanceDataType _:
        return HealthDataTypeDto.downhillSnowSportsDistance;
      case RowingDistanceDataType _:
        return HealthDataTypeDto.rowingDistance;
      case PaddleSportsDistanceDataType _:
        return HealthDataTypeDto.paddleSportsDistance;
      case CrossCountrySkiingDistanceDataType _:
        return HealthDataTypeDto.crossCountrySkiingDistance;
      case SkatingSportsDistanceDataType _:
        return HealthDataTypeDto.skatingSportsDistance;
      case SixMinuteWalkTestDistanceDataType _:
        return HealthDataTypeDto.sixMinuteWalkTestDistance;
      case WalkingRunningDistanceDataType _:
        return HealthDataTypeDto.walkingRunningDistance;
      case SwimmingStrokesDataType _:
        return HealthDataTypeDto.swimmingStrokes;
      case WalkingSpeedDataType _:
        return HealthDataTypeDto.walkingSpeed;
      case RunningSpeedDataType _:
        return HealthDataTypeDto.runningSpeed;
      case StairAscentSpeedDataType _:
        return HealthDataTypeDto.stairAscentSpeed;
      case StairDescentSpeedDataType _:
        return HealthDataTypeDto.stairDescentSpeed;
      case ExerciseSessionDataType():
        return HealthDataTypeDto.exerciseSession;
      case MindfulnessSessionDataType():
        return HealthDataTypeDto.mindfulnessSession;
      case LactationDataType _:
        return HealthDataTypeDto.lactation;
      case HeartRateVariabilitySDNNDataType _:
        return HealthDataTypeDto.heartRateVariabilitySDNN;
      case ExerciseTimeDataType _:
        return HealthDataTypeDto.exerciseTime;
      case MoveTimeDataType _:
        return HealthDataTypeDto.moveTime;
      case StandTimeDataType _:
        return HealthDataTypeDto.standTime;
      case WalkingSteadinessDataType _:
        return HealthDataTypeDto.walkingSteadiness;
      case WalkingAsymmetryPercentageDataType _:
        return HealthDataTypeDto.walkingAsymmetryPercentage;
      case WalkingDoubleSupportPercentageDataType _:
        return HealthDataTypeDto.walkingDoubleSupportPercentage;
      case WalkingStepLengthDataType _:
        return HealthDataTypeDto.walkingStepLength;
      case RunningGroundContactTimeDataType _:
        return HealthDataTypeDto.runningGroundContactTime;
      case RunningStrideLengthDataType _:
        return HealthDataTypeDto.runningStrideLength;
      case IrregularHeartRhythmEventDataType _:
        return HealthDataTypeDto.irregularHeartRhythmEvent;
      case InfrequentMenstrualCycleEventDataType _:
        return HealthDataTypeDto.infrequentMenstrualCycleEvent;
      case IrregularMenstrualCycleEventDataType _:
        return HealthDataTypeDto.irregularMenstrualCycleEvent;
      case HighHeartRateEventDataType _:
        return HealthDataTypeDto.highHeartRateEvent;
      case WalkingSteadinessEventDataType _:
        return HealthDataTypeDto.walkingSteadinessEvent;
      case PersistentIntermenstrualBleedingEventDataType _:
        return HealthDataTypeDto.persistentIntermenstrualBleedingEvent;
      case ProlongedMenstrualPeriodEventDataType _:
        return HealthDataTypeDto.prolongedMenstrualPeriodEvent;
      case AtrialFibrillationBurdenDataType _:
        return HealthDataTypeDto.atrialFibrillationBurden;
      case WalkingHeartRateAverageDataType _:
        return HealthDataTypeDto.walkingHeartRateAverage;
      case NumberOfTimesFallenDataType _:
        return HealthDataTypeDto.numberOfTimesFallen;
      case InhalerUsageDataType _:
        return HealthDataTypeDto.inhalerUsage;
      case PeripheralPerfusionIndexDataType _:
        return HealthDataTypeDto.peripheralPerfusionIndex;
      case HeadphoneAudioExposureEventDataType _:
        return HealthDataTypeDto.headphoneAudioExposureEvent;

      // Region Unsupported data types
      case BasalMetabolicRateDataType _:
        throw UnsupportedError(
          '$BasalMetabolicRateDataType is not supported on iOS HealthKit. '
          'Use $BasalEnergyBurnedDataType instead.',
        );
      case SkinTemperatureDeltaSeriesDataType _:
        throw UnsupportedError(
          '$SkinTemperatureDeltaSeriesDataType is not supported on iOS '
          'HealthKit. Use $BodyTemperatureDataType or '
          '$SleepingWristTemperatureDataType instead.',
        );
      case ElevationGainedDataType _:
        throw UnsupportedError(
          '$ElevationGainedDataType is not supported on iOS '
          'HealthKit.',
        );
      case DistanceDataType _:
        throw UnsupportedError(
          'General $DistanceDataType type is not supported on iOS '
          'HealthKit. Use specific distance types (f.e. '
          '$RowingDistanceDataType, $SwimmingDistanceDataType) instead.',
        );
      case SpeedSeriesDataType _:
        throw UnsupportedError(
          'General $SpeedSeriesDataType type is not supported on iOS '
          'HealthKit. Use specific speed types (f.e. $WalkingSpeedDataType, '
          '$RunningSpeedDataType) instead.',
        );
      case PowerSeriesDataType _:
        throw UnsupportedError(
          'General $PowerSeriesDataType type is not supported on iOS '
          'HealthKit. Use specific power types (f.e. $CyclingPowerDataType) '
          'instead.',
        );
      case SleepSessionDataType _:
        throw UnsupportedError(
          '$SleepSessionDataType is not supported on '
          'iOS HealthKit. Use $SleepStageDataType instead.',
        );
      case HeartRateSeriesDataType _:
        throw UnsupportedError(
          '$HeartRateSeriesDataType is not supported on iOS '
          'HealthKit. Use $HeartRateDataType instead.',
        );
      case CyclingPedalingCadenceSeriesDataType _:
        throw UnsupportedError(
          '$CyclingPedalingCadenceSeriesDataType is not '
          'supported on iOS HealthKit. '
          'Use $CyclingPedalingCadenceDataType instead.',
        );
      case StepsCadenceSeriesDataType _:
        throw UnsupportedError(
          '$StepsCadenceSeriesDataType is not supported on iOS HealthKit.',
        );
      case TotalEnergyBurnedDataType _:
        throw UnsupportedError(
          '$TotalEnergyBurnedDataType is not supported on iOS '
          'HealthKit. Use $ActiveEnergyBurnedDataType and '
          '$BasalEnergyBurnedDataType instead.',
        );
      case BoneMassDataType _:
        throw UnsupportedError(
          '$BoneMassDataType is not supported on iOS HealthKit.',
        );
      case BodyWaterMassDataType _:
        throw UnsupportedError(
          '$BodyWaterMassDataType is not supported on iOS HealthKit.',
        );
      case HeartRateVariabilityRMSSDDataType _:
        throw UnsupportedError(
          '$HeartRateVariabilityRMSSDDataType is not supported on iOS '
          'HealthKit. Use $HeartRateVariabilitySDNNDataType instead.',
        );
      case MenstrualFlowInstantDataType _:
        throw UnsupportedError(
          '$MenstrualFlowInstantDataType is not supported on iOS HealthKit. '
          'Use $MenstrualFlowDataType instead.',
        );
      case ActivityIntensityDataType _:
        throw UnsupportedError(
          '$ActivityIntensityDataType is not supported on iOS HealthKit.',
        );

      // endregion
    }
  }
}
