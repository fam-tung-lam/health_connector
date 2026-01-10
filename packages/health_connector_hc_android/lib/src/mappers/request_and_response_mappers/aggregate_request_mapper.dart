import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/health_data_type_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/request_and_response_mappers/aggregation_metric_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show
        AggregateRequestDto,
        CommonAggregateRequestDto,
        BloodPressureAggregateRequestDto,
        BloodPressureDataTypeDto;
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
          case DiastolicBloodPressureDataType _:
            return BloodPressureAggregateRequestDto(
              bloodPressureDataType: BloodPressureDataTypeDto.diastolic,
              aggregationMetric: aggregationMetric.toDto(),
              startTime: startTime.millisecondsSinceEpoch,
              endTime: endTime.millisecondsSinceEpoch,
            );
          case SystolicBloodPressureDataType _:
            return BloodPressureAggregateRequestDto(
              bloodPressureDataType: BloodPressureDataTypeDto.systolic,
              aggregationMetric: aggregationMetric.toDto(),
              startTime: startTime.millisecondsSinceEpoch,
              endTime: endTime.millisecondsSinceEpoch,
            );
          case ActiveEnergyBurnedDataType _:
          case BloodPressureDataType _:
          case BodyFatPercentageDataType _:
          case BodyTemperatureDataType _:
          case CervicalMucusDataType _:
          case DistanceDataType _:
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
          case ExerciseSessionDataType _:
          case FloorsClimbedDataType _:
          case HeartRateMeasurementRecordDataType _:
          case HeartRateSeriesRecordDataType _:
          case CyclingPedalingCadenceMeasurementRecordDataType _:
          case CyclingPedalingCadenceSeriesRecordDataType _:
          case HeightDataType _:
          case HydrationDataType _:
          case LeanBodyMassDataType _:
          case NutritionDataType _:
          case OvulationTestDataType _:
          case IntermenstrualBleedingDataType _:
          case MenstrualFlowInstantDataType _:
          case SexualActivityDataType _:
          case SleepSessionDataType _:
          case SleepStageDataType _:
          case StepsDataType _:
          case WeightDataType _:
          case WheelchairPushesDataType _:
          case DietaryEnergyConsumedDataType _:
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
          case OxygenSaturationDataType _:
          case RestingHeartRateDataType _:
          case RespiratoryRateDataType _:
          case Vo2MaxDataType _:
          case BloodGlucoseDataType _:
          case SpeedSeriesDataType _:
          case WalkingSpeedDataType _:
          case RunningSpeedDataType _:
          case StairAscentSpeedDataType _:
          case StairDescentSpeedDataType _:
          case MindfulnessSessionDataType _:
          case TotalEnergyBurnedDataType _:
          case BasalEnergyBurnedDataType _:
          case BasalBodyTemperatureDataType _:
          case BoneMassDataType _:
          case BodyWaterMassDataType _:
          case HeartRateVariabilityRMSSDDataType _:
          case HeartRateVariabilitySDNNDataType _:
          case BodyMassIndexDataType _:
          case WaistCircumferenceDataType _:
          case MenstrualFlowDataType _:
            throw ArgumentError(
              'Invalid data type for BloodPressureAggregateRequest: $dataType.',
            );
        }
    }
  }
}
