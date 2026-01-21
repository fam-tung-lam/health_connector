import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/health_data_type_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/activity_intensity/activity_intensity_type_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/request_and_response_mappers/aggregation_metric_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show
        ActivityIntensityAggregateRequestDto,
        AggregateRequestDto,
        StandardAggregateRequestDto,
        BloodPressureAggregateRequestDto,
        BloodPressureDataTypeDto;
import 'package:meta/meta.dart' show internal;

/// Converts [AggregateRequest] to [AggregateRequestDto].
@sinceV1_0_0
@internal
extension AggregateRequestDtoMapper<U extends MeasurementUnit>
    on AggregateRequest<U> {
  AggregateRequestDto toDto() {
    switch (this) {
      case StandardAggregateRequest _:
        return StandardAggregateRequestDto(
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
          case AlcoholicBeveragesDataType _:
          case ExerciseTimeDataType _:
          case MoveTimeDataType _:
          case StandTimeDataType _:
          case WalkingSteadinessDataType _:
          case BloodAlcoholContentDataType _:
          case BloodPressureDataType _:
          case BodyFatPercentageDataType _:
          case BodyTemperatureDataType _:
          case CervicalMucusDataType _:
          case DistanceDataType _:
          case ElevationGainedDataType _:
          case CrossCountrySkiingDistanceDataType _:
          case CyclingDistanceDataType _:
          case CyclingPowerDataType _:
          case RunningPowerDataType _:
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
          case HeartRateDataType _:
          case HeartRateSeriesDataType _:
          case CyclingPedalingCadenceDataType _:
          case CyclingPedalingCadenceSeriesDataType _:
          case StepsCadenceSeriesDataType _:
          case HeightDataType _:
          case HydrationDataType _:
          case LeanBodyMassDataType _:
          case NutritionDataType _:
          case OvulationTestDataType _:
          case PregnancyTestDataType _:
          case ProgesteroneTestDataType _:
          case IntermenstrualBleedingDataType _:
          case MenstrualFlowInstantDataType _:
          case SexualActivityDataType _:
          case SleepSessionDataType _:
          case SleepStageDataType _:
          case StepsDataType _:
          case WeightDataType _:
          case WheelchairPushesDataType _:
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
          case DietaryCalciumDataType _:
          case DietaryIronDataType _:
          case DietaryMagnesiumDataType _:
          case DietaryManganeseDataType _:
          case DietaryPhosphorusDataType _:
          case DietaryPotassiumDataType _:
          case DietarySeleniumDataType _:
          case DietarySodiumDataType _:
          case DietaryZincDataType _:
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
          case SleepingWristTemperatureDataType _:
          case BoneMassDataType _:
          case BodyWaterMassDataType _:
          case HeartRateVariabilityRMSSDDataType _:
          case HeartRateVariabilitySDNNDataType _:
          case BodyMassIndexDataType _:
          case WaistCircumferenceDataType _:
          case MenstrualFlowDataType _:
          case ContraceptiveDataType _:
          case LactationDataType _:
          case PeripheralPerfusionIndexDataType _:
          case PregnancyDataType _:
          case SwimmingStrokesDataType _:
          case ForcedVitalCapacityDataType _:
          case WalkingAsymmetryPercentageDataType _:
          case WalkingDoubleSupportPercentageDataType _:
          case WalkingStepLengthDataType _:
          case ActivityIntensityDataType _:
          case LowHeartRateEventDataType _:
          case IrregularHeartRhythmEventDataType _:
          case InfrequentMenstrualCycleEventDataType _:
          case IrregularMenstrualCycleEventDataType _:
          case HighHeartRateEventDataType _:
          case WalkingSteadinessEventDataType _:
          case PersistentIntermenstrualBleedingEventDataType _:
            throw ArgumentError(
              'Invalid data type for BloodPressureAggregateRequest: $dataType.',
            );
        }
      case final ActivityIntensityAggregateRequest request:
        return ActivityIntensityAggregateRequestDto(
          intensityType: request.intensityType?.toDto(),
          startTime: startTime.millisecondsSinceEpoch,
          endTime: endTime.millisecondsSinceEpoch,
        );
    }
  }
}
