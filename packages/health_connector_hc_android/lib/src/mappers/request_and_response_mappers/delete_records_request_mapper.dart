import 'package:health_connector_core/health_connector_core_internal.dart'
    show
        DeleteRecordsRequest,
        DeleteRecordsByIdsRequest,
        DeleteRecordsInTimeRangeRequest,
        HealthRecord,
        sinceV2_0_0;
import 'package:health_connector_hc_android/src/mappers/health_data_type_mappers.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/health_record_id_mappers.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show
        DeleteRecordsRequestDto,
        DeleteRecordsByIdsRequestDto,
        DeleteRecordsByTimeRangeRequestDto;
import 'package:meta/meta.dart' show internal;

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
