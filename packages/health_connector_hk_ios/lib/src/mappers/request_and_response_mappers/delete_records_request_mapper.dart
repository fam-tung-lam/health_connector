import 'package:health_connector_core/health_connector_core_internal.dart'
    show
        DeleteRecordsRequest,
        DeleteRecordsByIdsRequest,
        DeleteRecordsInTimeRangeRequest,
        HealthRecordId;
import 'package:health_connector_hk_ios/src/mappers/health_data_type_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show
        DeleteRecordsRequestDto,
        DeleteRecordsByIdsRequestDto,
        DeleteRecordsByTimeRangeRequestDto;
import 'package:meta/meta.dart' show internal;

/// Converts [DeleteRecordsRequest] to the appropriate delete request DTO.
@internal
extension DeleteRecordsRequestDtoMapper on DeleteRecordsRequest {
  DeleteRecordsRequestDto toDto() {
    switch (this) {
      case DeleteRecordsByIdsRequest(:final dataType, :final recordIds):
        if (recordIds.any((id) => id == HealthRecordId.none)) {
          throw ArgumentError.value(
            recordIds,
            'recordIds',
            '`DeleteRecordsRequest.recordIds` list cannot '
                'contain `HealthRecordId.none`.',
          );
        }

        return DeleteRecordsByIdsRequestDto(
          dataType: dataType.toDto(),
          recordIds: recordIds
              .map(
                (id) => id.toDto(),
              )
              .cast<String>() // Safe cast because of the check above.
              .toList(),
        );
      case DeleteRecordsInTimeRangeRequest(
        :final dataType,
        :final startTime,
        :final endTime,
      ):
        return DeleteRecordsByTimeRangeRequestDto(
          dataType: dataType.toDto(),
          startTime: startTime.millisecondsSinceEpoch,
          endTime: endTime.millisecondsSinceEpoch,
        );
    }
  }
}
