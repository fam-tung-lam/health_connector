import 'package:health_connector_core/health_connector_core_internal.dart'
    show HealthRecord, ReadRecordsInTimeRangeRequest, sinceV1_0_0;
import 'package:health_connector_hc_android/src/mappers/health_data_type_mappers.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show ReadRecordsRequestDto;
import 'package:meta/meta.dart' show internal;

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
