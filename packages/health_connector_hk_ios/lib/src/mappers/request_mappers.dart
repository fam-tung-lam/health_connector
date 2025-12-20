import 'package:health_connector_core/health_connector_core.dart'
    show
        AggregateRequest,
        DeleteRecordsRequest,
        DeleteRecordsByIdsRequest,
        DeleteRecordsInTimeRangeRequest,
        HealthRecord,
        MeasurementUnit,
        ReadRecordByIdRequest,
        ReadRecordsInTimeRangeRequest,
        sinceV1_0_0,
        sinceV2_0_0;
import 'package:health_connector_hk_ios/src/mappers/'
    'aggregation_metric_mappers.dart';
import 'package:health_connector_hk_ios/src/mappers/health_data_type_mappers.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mappers.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show
        AggregateRequestDto,
        DeleteRecordsByIdsRequestDto,
        DeleteRecordsByTimeRangeRequestDto,
        ReadRecordRequestDto,
        ReadRecordsRequestDto,
        DeleteRecordsRequestDto;
import 'package:meta/meta.dart' show internal;

/// Converts [ReadRecordByIdRequest] to [ReadRecordRequestDto].
@sinceV1_0_0
@internal
extension ReadRecordRequestDtoMapper<R extends HealthRecord>
    on ReadRecordByIdRequest<R> {
  ReadRecordRequestDto toDto() {
    return ReadRecordRequestDto(
      recordId: id.toDto(),
      dataType: dataType.toDto(),
    );
  }
}

/// Converts [ReadRecordsInTimeRangeRequest] to [ReadRecordsRequestDto].
@sinceV1_0_0
@internal
extension ReadRecordsRequestDtoMapper<R extends HealthRecord>
    on ReadRecordsInTimeRangeRequest<R> {
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
    return AggregateRequestDto(
      dataType: dataType.toDto(),
      aggregationMetric: aggregationMetric.toDto(),
      startTime: startTime.millisecondsSinceEpoch,
      endTime: endTime.millisecondsSinceEpoch,
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
