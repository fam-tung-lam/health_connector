import 'package:health_connector_core/health_connector_core.dart'
    show
        ActiveCaloriesBurnedHealthDataType,
        BiotinNutrientDataType,
        BodyFatPercentageHealthDataType,
        BodyTemperatureHealthDataType,
        CaffeineNutrientDataType,
        CalciumNutrientDataType,
        CholesterolNutrientDataType,
        DietaryFiberNutrientDataType,
        DistanceHealthDataType,
        EnergyNutrientDataType,
        FloorsClimbedHealthDataType,
        FolateNutrientDataType,
        HealthDataType,
        HealthRecord,
        HeartRateMeasurementRecordHealthDataType,
        HeartRateSeriesRecordHealthDataType,
        HeightHealthDataType,
        HydrationHealthDataType,
        IronNutrientDataType,
        LeanBodyMassHealthDataType,
        MagnesiumNutrientDataType,
        ManganeseNutrientDataType,
        MeasurementUnit,
        MonounsaturatedFatNutrientDataType,
        NiacinNutrientDataType,
        NutritionHealthDataType,
        PantothenicAcidNutrientDataType,
        PhosphorusNutrientDataType,
        PolyunsaturatedFatNutrientDataType,
        PotassiumNutrientDataType,
        ProteinNutrientDataType,
        RiboflavinNutrientDataType,
        RestingHeartRateHealthDataType,
        SaturatedFatNutrientDataType,
        SeleniumNutrientDataType,
        SleepSessionHealthDataType,
        SleepStageHealthDataType,
        SodiumNutrientDataType,
        StepsHealthDataType,
        SugarNutrientDataType,
        ThiaminNutrientDataType,
        TotalCarbohydrateNutrientDataType,
        TotalFatNutrientDataType,
        VitaminANutrientDataType,
        VitaminB6NutrientDataType,
        VitaminB12NutrientDataType,
        VitaminCNutrientDataType,
        VitaminDNutrientDataType,
        VitaminENutrientDataType,
        VitaminKNutrientDataType,
        WeightHealthDataType,
        WheelchairPushesHealthDataType,
        ZincNutrientDataType,
        BloodPressureHealthDataType,
        SystolicBloodPressureHealthDataType,
        DiastolicBloodPressureHealthDataType;
import 'package:health_connector_hc_android/src/pigeon/health_connector_platform_api.g.dart'
    show HealthDataTypeDto;
import 'package:meta/meta.dart' show internal;

/// Converts [HealthDataTypeDto] to [HealthDataType].
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
      case HealthDataTypeDto.steps:
        return HealthDataType.steps;
      case HealthDataTypeDto.weight:
        return HealthDataType.weight;
      case HealthDataTypeDto.wheelchairPushes:
        return HealthDataType.wheelchairPushes;
      case HealthDataTypeDto.heartRateSeriesRecord:
        return HealthDataType.heartRateSeriesRecord;
      case HealthDataTypeDto.sleepSession:
        return HealthDataType.sleepSession;
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
      case HealthDataTypeDto.restingHeartRate:
        return HealthDataType.restingHeartRate;
      case HealthDataTypeDto.bloodPressure:
        return HealthDataType.bloodPressure;
    }
  }
}

/// Converts [HealthDataType] to [HealthDataTypeDto].
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
      case StepsHealthDataType _:
        return HealthDataTypeDto.steps;
      case WeightHealthDataType _:
        return HealthDataTypeDto.weight;
      case WheelchairPushesHealthDataType _:
        return HealthDataTypeDto.wheelchairPushes;
      case HeartRateSeriesRecordHealthDataType _:
        return HealthDataTypeDto.heartRateSeriesRecord;
      case SleepSessionHealthDataType _:
        return HealthDataTypeDto.sleepSession;
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
      case BloodPressureHealthDataType _:
        return HealthDataTypeDto.bloodPressure;
      case NutritionHealthDataType _:
        return HealthDataTypeDto.nutrition;
      case RestingHeartRateHealthDataType _:
        return HealthDataTypeDto.restingHeartRate;
      case SleepStageHealthDataType _:
        throw UnsupportedError(
          '$SleepStageHealthDataType is not supported on '
          'Android Health Connect. Use $SleepSessionHealthDataType instead.',
        );
      case HeartRateMeasurementRecordHealthDataType _:
        throw UnsupportedError(
          '$HeartRateMeasurementRecordHealthDataType is not '
          'supported on Android Health Connect. '
          'Use $HeartRateSeriesRecordHealthDataType instead.',
        );
      case SystolicBloodPressureHealthDataType _:
        throw UnsupportedError(
          '$SystolicBloodPressureHealthDataType is not supported on '
          'Android Health Connect. Use $BloodPressureHealthDataType instead.',
        );
      case DiastolicBloodPressureHealthDataType _:
        throw UnsupportedError(
          '$DiastolicBloodPressureHealthDataType is not supported on '
          'Health Connect. Use $BloodPressureHealthDataType instead.',
        );
    }
  }
}
