import 'package:health_connector_core/health_connector_core.dart'
    show
        HealthDataType,
        HealthRecord,
        ReadRecordsRequest,
        AggregateResponse,
        ReadRecordsResponse,
        MeasurementUnit,
        sinceV1_0_0;
import 'package:health_connector_hk_ios/src/mappers/health_record_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/measurement_unit_mappers.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show AggregateResponseDto, ReadRecordsResponseDto;
import 'package:meta/meta.dart' show internal;

/// Converts [ReadRecordsResponseDto] to [ReadRecordsResponse].
@sinceV1_0_0
@internal
extension ReadRecordsResponseDtoToDomain on ReadRecordsResponseDto {
  ReadRecordsResponse<R> toDomain<R extends HealthRecord>(
    ReadRecordsRequest<R> originalRequest,
  ) {
    // Convert all records from DTOs to domain objects
    final records = this.records
        .map((dto) => dto.toDomain())
        .cast<R>()
        .toList();

    // Create next page request if token is present and not empty
    final nextPageRequest = nextPageToken?.isNotEmpty ?? false
        ? originalRequest.copyWith(pageToken: nextPageToken)
        : null;

    return ReadRecordsResponse(
      records: records,
      nextPageRequest: nextPageRequest,
    );
  }
}

/// Converts [AggregateResponseDto] to [AggregateResponse].
@sinceV1_0_0
@internal
extension AggregateResponseDtoToDomain on AggregateResponseDto {
  AggregateResponse<R, U> toDomain<
    R extends HealthRecord,
    U extends MeasurementUnit
  >(HealthDataType<R, U> dataType) {
    return AggregateResponse(value.toDomain() as U);
  }
}
