import 'package:health_connector_core/health_connector_core_internal.dart'
    show
        ActiveCaloriesBurnedHealthDataType,
        BodyFatPercentageHealthDataType,
        BodyTemperatureHealthDataType,
        CervicalMucusDataType,
        CrossCountrySkiingDistanceDataType,
        CyclingDistanceDataType,
        CyclingPedalingCadenceMeasurementRecordHealthDataType,
        CyclingPedalingCadenceSeriesRecordHealthDataType,
        CyclingPowerDataType,
        DistanceHealthDataType,
        DownhillSnowSportsDistanceDataType,
        FloorsClimbedHealthDataType,
        HealthDataType,
        HealthRecord,
        HeartRateMeasurementRecordHealthDataType,
        HeartRateSeriesRecordHealthDataType,
        HeightHealthDataType,
        SexualActivityDataType,
        SleepSessionHealthDataType,
        SleepStageHealthDataType,
        MindfulnessSessionDataType,
        HydrationHealthDataType,
        LeanBodyMassHealthDataType,
        MeasurementUnit,
        PaddleSportsDistanceDataType,
        RowingDistanceDataType,
        SixMinuteWalkTestDistanceDataType,
        SkatingSportsDistanceDataType,
        StepsHealthDataType,
        SwimmingDistanceDataType,
        WeightHealthDataType,
        WheelchairDistanceDataType,
        WheelchairPushesHealthDataType,
        WalkingRunningDistanceDataType,
        PolyunsaturatedFatNutrientDataType,
        NutritionHealthDataType,
        EnergyNutrientDataType,
        CaffeineNutrientDataType,
        ProteinNutrientDataType,
        TotalCarbohydrateNutrientDataType,
        TotalFatNutrientDataType,
        SaturatedFatNutrientDataType,
        MonounsaturatedFatNutrientDataType,
        CholesterolNutrientDataType,
        RespiratoryRateHealthDataType,
        OvulationTestDataType,
        OxygenSaturationHealthDataType,
        RestingHeartRateHealthDataType,
        DietaryFiberNutrientDataType,
        SugarNutrientDataType,
        CalciumNutrientDataType,
        IronNutrientDataType,
        MagnesiumNutrientDataType,
        ManganeseNutrientDataType,
        PhosphorusNutrientDataType,
        PotassiumNutrientDataType,
        PowerSeriesDataType,
        SeleniumNutrientDataType,
        SodiumNutrientDataType,
        ZincNutrientDataType,
        VitaminANutrientDataType,
        VitaminB6NutrientDataType,
        VitaminB12NutrientDataType,
        VitaminCNutrientDataType,
        VitaminDNutrientDataType,
        VitaminENutrientDataType,
        VitaminKNutrientDataType,
        ThiaminNutrientDataType,
        RiboflavinNutrientDataType,
        NiacinNutrientDataType,
        FolateNutrientDataType,
        BiotinNutrientDataType,
        PantothenicAcidNutrientDataType,
        BloodPressureHealthDataType,
        SystolicBloodPressureHealthDataType,
        DiastolicBloodPressureHealthDataType,
        Vo2MaxHealthDataType,
        sinceV1_0_0,
        BloodGlucoseHealthDataType,
        SpeedSeriesDataType,
        WalkingSpeedDataType,
        RunningSpeedDataType,
        StairAscentSpeedDataType,
        StairDescentSpeedDataType,
        ExerciseSessionHealthDataType;
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show HealthDataTypeDto;
import 'package:meta/meta.dart' show internal;

/// Converts [HealthDataTypeDto] to [HealthDataType].
@sinceV1_0_0
@internal
extension HealthDataTypeDtoToDomain on HealthDataTypeDto {
  HealthDataType<HealthRecord, MeasurementUnit> toDomain() {
    switch (this) {
      case HealthDataTypeDto.activeCaloriesBurned:
        return HealthDataType.activeCaloriesBurned;
      case HealthDataTypeDto.distance:
        return HealthDataType.distance;
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
      case HealthDataTypeDto.cervicalMucus:
        return HealthDataType.cervicalMucus;
      case HealthDataTypeDto.steps:
        return HealthDataType.steps;
      case HealthDataTypeDto.weight:
        return HealthDataType.weight;
      case HealthDataTypeDto.wheelchairPushes:
        return HealthDataType.wheelchairPushes;
      case HealthDataTypeDto.heartRateMeasurementRecord:
        return HealthDataType.heartRateMeasurementRecord;
      case HealthDataTypeDto.cyclingPedalingCadenceMeasurementRecord:
        return HealthDataType.cyclingPedalingCadenceMeasurementRecord;
      case HealthDataTypeDto.sleepStageRecord:
        return HealthDataType.sleepStageRecord;
      case HealthDataTypeDto.sexualActivity:
        return HealthDataType.sexualActivity;
      case HealthDataTypeDto.energyNutrient:
        return HealthDataType.energyNutrient;
      case HealthDataTypeDto.caffeine:
        return HealthDataType.caffeine;
      case HealthDataTypeDto.protein:
        return HealthDataType.protein;
      case HealthDataTypeDto.totalCarbohydrate:
        return HealthDataType.totalCarbohydrate;
      case HealthDataTypeDto.totalFat:
        return HealthDataType.totalFat;
      case HealthDataTypeDto.saturatedFat:
        return HealthDataType.saturatedFat;
      case HealthDataTypeDto.monounsaturatedFat:
        return HealthDataType.monounsaturatedFat;
      case HealthDataTypeDto.polyunsaturatedFat:
        return HealthDataType.polyunsaturatedFat;
      case HealthDataTypeDto.cholesterol:
        return HealthDataType.cholesterol;
      case HealthDataTypeDto.dietaryFiber:
        return HealthDataType.dietaryFiber;
      case HealthDataTypeDto.sugar:
        return HealthDataType.sugar;
      case HealthDataTypeDto.vitaminA:
        return HealthDataType.vitaminA;
      case HealthDataTypeDto.vitaminB6:
        return HealthDataType.vitaminB6;
      case HealthDataTypeDto.vitaminB12:
        return HealthDataType.vitaminB12;
      case HealthDataTypeDto.vitaminC:
        return HealthDataType.vitaminC;
      case HealthDataTypeDto.vitaminD:
        return HealthDataType.vitaminD;
      case HealthDataTypeDto.vitaminE:
        return HealthDataType.vitaminE;
      case HealthDataTypeDto.vitaminK:
        return HealthDataType.vitaminK;
      case HealthDataTypeDto.thiamin:
        return HealthDataType.thiamin;
      case HealthDataTypeDto.riboflavin:
        return HealthDataType.riboflavin;
      case HealthDataTypeDto.niacin:
        return HealthDataType.niacin;
      case HealthDataTypeDto.folate:
        return HealthDataType.folate;
      case HealthDataTypeDto.biotin:
        return HealthDataType.biotin;
      case HealthDataTypeDto.pantothenicAcid:
        return HealthDataType.pantothenicAcid;
      case HealthDataTypeDto.calcium:
        return HealthDataType.calcium;
      case HealthDataTypeDto.iron:
        return HealthDataType.iron;
      case HealthDataTypeDto.magnesium:
        return HealthDataType.magnesium;
      case HealthDataTypeDto.manganese:
        return HealthDataType.manganese;
      case HealthDataTypeDto.phosphorus:
        return HealthDataType.phosphorus;
      case HealthDataTypeDto.potassium:
        return HealthDataType.potassium;
      case HealthDataTypeDto.selenium:
        return HealthDataType.selenium;
      case HealthDataTypeDto.sodium:
        return HealthDataType.sodium;
      case HealthDataTypeDto.zinc:
        return HealthDataType.zinc;
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
      case HealthDataTypeDto.oxygenSaturation:
        return HealthDataType.oxygenSaturation;
      case HealthDataTypeDto.respiratoryRate:
        return HealthDataType.respiratoryRate;
      case HealthDataTypeDto.bloodGlucose:
        return HealthDataType.bloodGlucose;
      case HealthDataTypeDto.vo2Max:
        return HealthDataType.vo2Max;
      case HealthDataTypeDto.cyclingDistance:
        return HealthDataType.cyclingDistance;
      case HealthDataTypeDto.cyclingPower:
        return HealthDataType.cyclingPower;
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
      case HealthDataTypeDto.skatingSportsDistance:
        return HealthDataType.skatingSportsDistance;
      case HealthDataTypeDto.sixMinuteWalkTestDistance:
        return HealthDataType.sixMinuteWalkTestDistance;
      case HealthDataTypeDto.walkingSpeed:
        return HealthDataType.walkingSpeed;
      case HealthDataTypeDto.runningSpeed:
        return HealthDataType.runningSpeed;
      case HealthDataTypeDto.stairAscentSpeed:
        return HealthDataType.stairAscentSpeed;
      case HealthDataTypeDto.stairDescentSpeed:
        return HealthDataType.stairDescentSpeed;
      case HealthDataTypeDto.exerciseSession:
        return HealthDataType.exerciseSession;
      case HealthDataTypeDto.mindfulnessSession:
        return HealthDataType.mindfulnessSession;
    }
  }
}

/// Converts [HealthDataType] to [HealthDataTypeDto].
@sinceV1_0_0
@internal
extension HealthDataTypeToDto on HealthDataType<HealthRecord, MeasurementUnit> {
  HealthDataTypeDto toDto() {
    switch (this) {
      case ActiveCaloriesBurnedHealthDataType _:
        return HealthDataTypeDto.activeCaloriesBurned;
      case DistanceHealthDataType _:
        return HealthDataTypeDto.distance;
      case FloorsClimbedHealthDataType _:
        return HealthDataTypeDto.floorsClimbed;
      case HeightHealthDataType _:
        return HealthDataTypeDto.height;
      case HydrationHealthDataType _:
        return HealthDataTypeDto.hydration;
      case LeanBodyMassHealthDataType _:
        return HealthDataTypeDto.leanBodyMass;
      case BodyFatPercentageHealthDataType _:
        return HealthDataTypeDto.bodyFatPercentage;
      case BodyTemperatureHealthDataType _:
        return HealthDataTypeDto.bodyTemperature;
      case CervicalMucusDataType _:
        return HealthDataTypeDto.cervicalMucus;
      case StepsHealthDataType _:
        return HealthDataTypeDto.steps;
      case WeightHealthDataType _:
        return HealthDataTypeDto.weight;
      case WheelchairPushesHealthDataType _:
        return HealthDataTypeDto.wheelchairPushes;
      case HeartRateMeasurementRecordHealthDataType _:
        return HealthDataTypeDto.heartRateMeasurementRecord;
      case CyclingPedalingCadenceMeasurementRecordHealthDataType _:
        return HealthDataTypeDto.cyclingPedalingCadenceMeasurementRecord;
      case SleepStageHealthDataType _:
        return HealthDataTypeDto.sleepStageRecord;
      case SexualActivityDataType _:
        return HealthDataTypeDto.sexualActivity;
      case EnergyNutrientDataType _:
        return HealthDataTypeDto.energyNutrient;
      case CaffeineNutrientDataType _:
        return HealthDataTypeDto.caffeine;
      case ProteinNutrientDataType _:
        return HealthDataTypeDto.protein;
      case TotalCarbohydrateNutrientDataType _:
        return HealthDataTypeDto.totalCarbohydrate;
      case TotalFatNutrientDataType _:
        return HealthDataTypeDto.totalFat;
      case SaturatedFatNutrientDataType _:
        return HealthDataTypeDto.saturatedFat;
      case MonounsaturatedFatNutrientDataType _:
        return HealthDataTypeDto.monounsaturatedFat;
      case PolyunsaturatedFatNutrientDataType _:
        return HealthDataTypeDto.polyunsaturatedFat;
      case CholesterolNutrientDataType _:
        return HealthDataTypeDto.cholesterol;
      case DietaryFiberNutrientDataType _:
        return HealthDataTypeDto.dietaryFiber;
      case SugarNutrientDataType _:
        return HealthDataTypeDto.sugar;

      case VitaminANutrientDataType _:
        return HealthDataTypeDto.vitaminA;
      case VitaminB6NutrientDataType _:
        return HealthDataTypeDto.vitaminB6;
      case VitaminB12NutrientDataType _:
        return HealthDataTypeDto.vitaminB12;
      case VitaminCNutrientDataType _:
        return HealthDataTypeDto.vitaminC;
      case VitaminDNutrientDataType _:
        return HealthDataTypeDto.vitaminD;
      case VitaminENutrientDataType _:
        return HealthDataTypeDto.vitaminE;
      case VitaminKNutrientDataType _:
        return HealthDataTypeDto.vitaminK;
      case ThiaminNutrientDataType _:
        return HealthDataTypeDto.thiamin;
      case RiboflavinNutrientDataType _:
        return HealthDataTypeDto.riboflavin;
      case NiacinNutrientDataType _:
        return HealthDataTypeDto.niacin;
      case FolateNutrientDataType _:
        return HealthDataTypeDto.folate;
      case BiotinNutrientDataType _:
        return HealthDataTypeDto.biotin;
      case PantothenicAcidNutrientDataType _:
        return HealthDataTypeDto.pantothenicAcid;

      case CalciumNutrientDataType _:
        return HealthDataTypeDto.calcium;
      case IronNutrientDataType _:
        return HealthDataTypeDto.iron;
      case MagnesiumNutrientDataType _:
        return HealthDataTypeDto.magnesium;
      case ManganeseNutrientDataType _:
        return HealthDataTypeDto.manganese;
      case PhosphorusNutrientDataType _:
        return HealthDataTypeDto.phosphorus;
      case PotassiumNutrientDataType _:
        return HealthDataTypeDto.potassium;
      case SeleniumNutrientDataType _:
        return HealthDataTypeDto.selenium;
      case SodiumNutrientDataType _:
        return HealthDataTypeDto.sodium;
      case ZincNutrientDataType _:
        return HealthDataTypeDto.zinc;

      case NutritionHealthDataType _:
        return HealthDataTypeDto.nutrition;
      case BloodPressureHealthDataType _:
        return HealthDataTypeDto.bloodPressure;
      case SystolicBloodPressureHealthDataType _:
        return HealthDataTypeDto.systolicBloodPressure;
      case DiastolicBloodPressureHealthDataType _:
        return HealthDataTypeDto.diastolicBloodPressure;
      case RestingHeartRateHealthDataType _:
        return HealthDataTypeDto.restingHeartRate;
      case OvulationTestDataType _:
        return HealthDataTypeDto.ovulationTest;
      case OxygenSaturationHealthDataType _:
        return HealthDataTypeDto.oxygenSaturation;
      case RespiratoryRateHealthDataType _:
        return HealthDataTypeDto.respiratoryRate;
      case Vo2MaxHealthDataType _:
        return HealthDataTypeDto.vo2Max;
      case BloodGlucoseHealthDataType _:
        return HealthDataTypeDto.bloodGlucose;
      // Distance activity types (iOS HealthKit only)
      case CyclingDistanceDataType _:
        return HealthDataTypeDto.cyclingDistance;
      case CyclingPowerDataType _:
        return HealthDataTypeDto.cyclingPower;
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
        return HealthDataTypeDto.distance;
      // Speed activity types (iOS HealthKit only)
      case WalkingSpeedDataType _:
        return HealthDataTypeDto.walkingSpeed;
      case RunningSpeedDataType _:
        return HealthDataTypeDto.runningSpeed;
      case StairAscentSpeedDataType _:
        return HealthDataTypeDto.stairAscentSpeed;
      case StairDescentSpeedDataType _:
        return HealthDataTypeDto.stairDescentSpeed;
      case ExerciseSessionHealthDataType():
        return HealthDataTypeDto.exerciseSession;
      case MindfulnessSessionDataType():
        return HealthDataTypeDto.mindfulnessSession;
      case SpeedSeriesDataType _:
        throw UnsupportedError(
          '$SpeedSeriesDataType is not supported on iOS. '
          'Use WalkingSpeedDataType, RunningSpeedDataType, etc. instead.',
        );
      case PowerSeriesDataType _:
        throw UnsupportedError(
          '$PowerSeriesDataType is not supported on iOS. '
          'Use CyclingPowerDataType instead.',
        );
      case SleepSessionHealthDataType _:
        throw UnsupportedError(
          '$SleepSessionHealthDataType is not supported on iOS. '
          'Use $SleepStageHealthDataType instead.',
        );
      case HeartRateSeriesRecordHealthDataType _:
        throw UnsupportedError(
          '$HeartRateSeriesRecordHealthDataType is not supported on iOS. '
          'Use $HeartRateMeasurementRecordHealthDataType instead.',
        );
      case CyclingPedalingCadenceSeriesRecordHealthDataType _:
        throw UnsupportedError(
          '$CyclingPedalingCadenceSeriesRecordHealthDataType is not '
          'supported on iOS HealthKit. '
          'Use $CyclingPedalingCadenceMeasurementRecordHealthDataType instead.',
        );
    }
  }
}
