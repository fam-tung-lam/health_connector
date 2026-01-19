import 'package:health_connector_core/health_connector_core_internal.dart'
    show
        HealthRecord,
        ReadRecordsInTimeRangeRequest,
        ReadRecordsInTimeRangeResponse;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show ReadRecordsResponseDto;
import 'package:meta/meta.dart' show internal;

/// Converts [ReadRecordsResponseDto] to [ReadRecordsInTimeRangeResponse].
@internal
extension ReadRecordsResponseDtoToDomain on ReadRecordsResponseDto {
  ReadRecordsInTimeRangeResponse<R> toDomain<R extends HealthRecord>(
    ReadRecordsInTimeRangeRequest<R> originalRequest,
  ) {
    final records = this.records
        .map((dto) => dto.toDomain())
        .cast<R>()
        .toList();

    final nextPageRequest = nextPageToken?.isNotEmpty ?? false
        ? originalRequest.copyWith(pageToken: nextPageToken)
        : null;

    return ReadRecordsInTimeRangeResponse(
      records: records,
      nextPageRequest: nextPageRequest,
    );
  }
}
