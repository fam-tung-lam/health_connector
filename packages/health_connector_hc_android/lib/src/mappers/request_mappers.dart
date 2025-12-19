import 'package:health_connector_core/health_connector_core.dart'
    show
        AggregateRequest,
        DeleteRecordsRequest,
        DeleteRecordsByIdsRequest,
        DeleteRecordsInTimeRangeRequest,
        HealthRecord,
        MeasurementUnit,
        ReadRecordRequest,
        ReadRecordsRequest,
        CommonAggregateRequest,
        BloodPressureAggregateRequest,
        BloodGlucoseHealthDataType,
        BloodPressureHealthDataType,
        DiastolicBloodPressureHealthDataType,
        SystolicBloodPressureHealthDataType,
        ActiveCaloriesBurnedHealthDataType,
        BodyFatPercentageHealthDataType,
        BodyTemperatureHealthDataType,
        DistanceHealthDataType,
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
        StepsHealthDataType,
        WeightHealthDataType,
        WheelchairPushesHealthDataType,
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
        sinceV2_0_0;
import 'package:health_connector_hc_android/src/mappers/'
    'aggregation_metric_mappers.dart';
import 'package:health_connector_hc_android/src/mappers/health_data_type_mappers.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/health_record_id_mappers.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show
        AggregateRequestDto,
        DeleteRecordsByIdsRequestDto,
        DeleteRecordsByTimeRangeRequestDto,
        ReadRecordRequestDto,
        ReadRecordsRequestDto,
        WriteRecordRequestDto,
        UpdateRecordRequestDto,
        WriteRecordsRequestDto,
        CommonAggregateRequestDto,
        BloodPressureAggregateRequestDto,
        BloodPressureHealthDataTypeDto,
        DeleteRecordsRequestDto;
import 'package:meta/meta.dart' show internal;

/// Converts [ReadRecordRequest] to [ReadRecordRequestDto].
@sinceV1_0_0
@internal
extension ReadRecordRequestDtoMapper<R extends HealthRecord>
    on ReadRecordRequest<R> {
  ReadRecordRequestDto toDto() {
    return ReadRecordRequestDto(
      recordId: id.toDto(),
      dataType: dataType.toDto(),
    );
  }
}

/// Converts [ReadRecordsRequest] to [ReadRecordsRequestDto].
@sinceV1_0_0
@internal
extension ReadRecordsRequestDtoMapper<R extends HealthRecord>
    on ReadRecordsRequest<R> {
  ReadRecordsRequestDto toDto() {
    return ReadRecordsRequestDto(
      dataType: dataType.toDto(),
      pageSize: pageSize,
      pageToken: pageToken,
      startTime: startTime.millisecondsSinceEpoch,
      endTime: endTime.millisecondsSinceEpoch,
      dataOriginPackageNames: dataOrigins
          .map((origin) => origin.packageName)
          .toList(),
    );
  }
}

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
          case DistanceHealthDataType _:
          case FloorsClimbedHealthDataType _:
          case HeartRateMeasurementRecordHealthDataType _:
          case HeartRateSeriesRecordHealthDataType _:
          case HeightHealthDataType _:
          case HydrationHealthDataType _:
          case LeanBodyMassHealthDataType _:
          case NutritionHealthDataType _:
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
            throw ArgumentError(
              'Invalid data type for BloodPressureAggregateRequest: $dataType.',
            );
        }
    }
  }
}

/// Converts [HealthRecord] to [WriteRecordRequestDto].
@sinceV1_0_0
@internal
extension HealthRecordToWriteRequestDto on HealthRecord {
  WriteRecordRequestDto toWriteRecordRequestDto() {
    return WriteRecordRequestDto(record: toDto());
  }
}

/// Converts [HealthRecord] to [UpdateRecordRequestDto].
@sinceV1_0_0
@internal
extension HealthRecordToUpdateRequestDto on HealthRecord {
  UpdateRecordRequestDto toUpdateRecordRequestDto() {
    return UpdateRecordRequestDto(record: toDto());
  }
}

/// Converts list of domain [HealthRecord] to [WriteRecordsRequestDto].
@sinceV1_0_0
@internal
extension HealthRecordListToWriteRequestDto on List<HealthRecord> {
  WriteRecordsRequestDto toWriteRecordsRequestDto() {
    return WriteRecordsRequestDto(
      records: map((record) => record.toDto()).toList(),
    );
  }
}

/// Converts [DeleteRecordsRequest] to the appropriate delete request DTO.
@sinceV2_0_0
@internal
extension DeleteRecordsRequestDtoMapper<R extends HealthRecord>
    on DeleteRecordsRequest<R> {
  DeleteRecordsRequestDto toDto() {
    return switch (this) {
      DeleteRecordsByIdsRequest(:final dataType, :final recordIds) =>
        DeleteRecordsByIdsRequestDto(
          dataType: dataType.toDto(),
          recordIds: recordIds.map((id) => id.toDto()).toList(),
        ),
      DeleteRecordsInTimeRangeRequest(
        :final dataType,
        :final startTime,
        :final endTime,
      ) =>
        DeleteRecordsByTimeRangeRequestDto(
          dataType: dataType.toDto(),
          startTime: startTime.millisecondsSinceEpoch,
          endTime: endTime.millisecondsSinceEpoch,
        ),
    };
  }
}
