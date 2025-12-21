import 'package:health_connector_core/health_connector_core.dart'
    show HealthRecord, ReadRecordByIdRequest, sinceV1_0_0;
import 'package:health_connector_hc_android/src/mappers/health_data_type_mappers.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/health_record_id_mappers.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show ReadRecordRequestDto;
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
