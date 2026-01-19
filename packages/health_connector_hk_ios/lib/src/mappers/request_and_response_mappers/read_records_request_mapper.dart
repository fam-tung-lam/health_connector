import 'package:health_connector_core/health_connector_core_internal.dart'
    show HealthRecord, ReadRecordsInTimeRangeRequest;
import 'package:health_connector_hk_ios/src/mappers/health_data_type_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/request_and_response_mappers/sort_descriptor_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show ReadRecordsRequestDto;
import 'package:meta/meta.dart' show internal;

/// Converts [ReadRecordsInTimeRangeRequest] to [ReadRecordsRequestDto].
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
      sortOrder: sortDescriptor.toDto(),
    );
  }
}
