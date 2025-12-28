import 'package:health_connector_core/health_connector_core_internal.dart'
    show
        AggregateRequest,
        HealthRecord,
        MeasurementUnit,
        CommonAggregateRequest,
        BloodPressureAggregateRequest,
        BloodGlucoseHealthDataType,
        BloodPressureHealthDataType,
        DiastolicBloodPressureHealthDataType,
        SystolicBloodPressureHealthDataType,
        ActiveCaloriesBurnedHealthDataType,
        BodyFatPercentageHealthDataType,
        BodyTemperatureHealthDataType,
        CervicalMucusDataType,
        CrossCountrySkiingDistanceDataType,
        CyclingDistanceDataType,
        CyclingPowerDataType,
        DistanceHealthDataType,
        DownhillSnowSportsDistanceDataType,
        FloorsClimbedHealthDataType,
        HeartRateMeasurementRecordHealthDataType,
        HeartRateSeriesRecordHealthDataType,
        HeightHealthDataType,
        HydrationHealthDataType,
        LeanBodyMassHealthDataType,
        NutritionHealthDataType,
        OxygenSaturationHealthDataType,
        SleepSessionHealthDataType,
        SleepStageHealthDataType,
        MindfulnessSessionDataType,
        StepsHealthDataType,
        WeightHealthDataType,
        WheelchairPushesHealthDataType,
        PaddleSportsDistanceDataType,
        RowingDistanceDataType,
        SixMinuteWalkTestDistanceDataType,
        SkatingSportsDistanceDataType,
        SwimmingDistanceDataType,
        WheelchairDistanceDataType,
        EnergyNutrientDataType,
        CaffeineNutrientDataType,
        ProteinNutrientDataType,
        TotalCarbohydrateNutrientDataType,
        TotalFatNutrientDataType,
        SaturatedFatNutrientDataType,
        MonounsaturatedFatNutrientDataType,
        PolyunsaturatedFatNutrientDataType,
        CholesterolNutrientDataType,
        DietaryFiberNutrientDataType,
        SugarNutrientDataType,
        CalciumNutrientDataType,
        IronNutrientDataType,
        MagnesiumNutrientDataType,
        ManganeseNutrientDataType,
        PhosphorusNutrientDataType,
        PotassiumNutrientDataType,
        PowerSeriesDataType,
        RestingHeartRateHealthDataType,
        SeleniumNutrientDataType,
        SodiumNutrientDataType,
        RespiratoryRateHealthDataType,
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
        Vo2MaxHealthDataType,
        sinceV1_0_0,
        WalkingRunningDistanceDataType,
        SpeedSeriesDataType,
        WalkingSpeedDataType,
        RunningSpeedDataType,
        StairAscentSpeedDataType,
        StairDescentSpeedDataType,
        SexualActivityDataType;
import 'package:health_connector_core/health_connector_core_internal.dart'
    show ExerciseSessionHealthDataType;
import 'package:health_connector_hc_android/src/mappers/health_data_type_mappers.dart';
import 'package:health_connector_hc_android/src/mappers/request_and_response_mappers/aggregation_metric_mappers.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show
        AggregateRequestDto,
        CommonAggregateRequestDto,
        BloodPressureAggregateRequestDto,
        BloodPressureHealthDataTypeDto;
import 'package:meta/meta.dart' show internal;

/// Converts [AggregateRequest] to [AggregateRequestDto].
@sinceV1_0_0
@internal
extension AggregateRequestDtoMapper<
  R extends HealthRecord,
  U extends MeasurementUnit
>
    on AggregateRequest<R, U> {
  AggregateRequestDto toDto() {
    switch (this) {
      case CommonAggregateRequest _:
        return CommonAggregateRequestDto(
          dataType: dataType.toDto(),
          aggregationMetric: aggregationMetric.toDto(),
          startTime: startTime.millisecondsSinceEpoch,
          endTime: endTime.millisecondsSinceEpoch,
        );
      case BloodPressureAggregateRequest _:
        switch (dataType) {
          case DiastolicBloodPressureHealthDataType _:
            return BloodPressureAggregateRequestDto(
              bloodPressureDataType: BloodPressureHealthDataTypeDto.diastolic,
              aggregationMetric: aggregationMetric.toDto(),
              startTime: startTime.millisecondsSinceEpoch,
              endTime: endTime.millisecondsSinceEpoch,
            );
          case SystolicBloodPressureHealthDataType _:
            return BloodPressureAggregateRequestDto(
              bloodPressureDataType: BloodPressureHealthDataTypeDto.systolic,
              aggregationMetric: aggregationMetric.toDto(),
              startTime: startTime.millisecondsSinceEpoch,
              endTime: endTime.millisecondsSinceEpoch,
            );
          case ActiveCaloriesBurnedHealthDataType _:
          case BloodPressureHealthDataType _:
          case BodyFatPercentageHealthDataType _:
          case BodyTemperatureHealthDataType _:
          case CervicalMucusDataType _:
          case DistanceHealthDataType _:
          case CrossCountrySkiingDistanceDataType _:
          case CyclingDistanceDataType _:
          case CyclingPowerDataType _:
          case PowerSeriesDataType _:
          case DownhillSnowSportsDistanceDataType _:
          case PaddleSportsDistanceDataType _:
          case RowingDistanceDataType _:
          case SixMinuteWalkTestDistanceDataType _:
          case SkatingSportsDistanceDataType _:
          case SwimmingDistanceDataType _:
          case WheelchairDistanceDataType _:
          case WalkingRunningDistanceDataType _:
          case ExerciseSessionHealthDataType _:
          case FloorsClimbedHealthDataType _:
          case HeartRateMeasurementRecordHealthDataType _:
          case HeartRateSeriesRecordHealthDataType _:
          case HeightHealthDataType _:
          case HydrationHealthDataType _:
          case LeanBodyMassHealthDataType _:
          case NutritionHealthDataType _:
          case SexualActivityDataType _:
          case SleepSessionHealthDataType _:
          case SleepStageHealthDataType _:
          case StepsHealthDataType _:
          case WeightHealthDataType _:
          case WheelchairPushesHealthDataType _:
          case EnergyNutrientDataType _:
          case CaffeineNutrientDataType _:
          case ProteinNutrientDataType _:
          case TotalCarbohydrateNutrientDataType _:
          case TotalFatNutrientDataType _:
          case SaturatedFatNutrientDataType _:
          case MonounsaturatedFatNutrientDataType _:
          case PolyunsaturatedFatNutrientDataType _:
          case CholesterolNutrientDataType _:
          case DietaryFiberNutrientDataType _:
          case SugarNutrientDataType _:
          case CalciumNutrientDataType _:
          case IronNutrientDataType _:
          case MagnesiumNutrientDataType _:
          case ManganeseNutrientDataType _:
          case PhosphorusNutrientDataType _:
          case PotassiumNutrientDataType _:
          case SeleniumNutrientDataType _:
          case SodiumNutrientDataType _:
          case ZincNutrientDataType _:
          case VitaminANutrientDataType _:
          case VitaminB6NutrientDataType _:
          case VitaminB12NutrientDataType _:
          case VitaminCNutrientDataType _:
          case VitaminDNutrientDataType _:
          case VitaminENutrientDataType _:
          case VitaminKNutrientDataType _:
          case ThiaminNutrientDataType _:
          case RiboflavinNutrientDataType _:
          case NiacinNutrientDataType _:
          case FolateNutrientDataType _:
          case BiotinNutrientDataType _:
          case PantothenicAcidNutrientDataType _:
          case OxygenSaturationHealthDataType _:
          case RestingHeartRateHealthDataType _:
          case RespiratoryRateHealthDataType _:
          case Vo2MaxHealthDataType _:
          case BloodGlucoseHealthDataType _:
          case SpeedSeriesDataType _:
          case WalkingSpeedDataType _:
          case RunningSpeedDataType _:
          case StairAscentSpeedDataType _:
          case StairDescentSpeedDataType _:
          case MindfulnessSessionDataType _:
            throw ArgumentError(
              'Invalid data type for BloodPressureAggregateRequest: $dataType.',
            );
        }
    }
  }
}
