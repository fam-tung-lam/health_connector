import 'package:health_connector_core/health_connector_core_internal.dart'
    show HealthRecord, ReadRecordByIdRequest, sinceV1_0_0;
import 'package:health_connector_hc_android/src/mappers/health_data_type_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show ReadRecordRequestDto;
import 'package:meta/meta.dart' show internal;

/// Converts [ReadRecordByIdRequest] to [ReadRecordRequestDto].
@sinceV1_0_0
@internal
extension ReadRecordRequestDtoMapper<R extends HealthRecord>
    on ReadRecordByIdRequest<R> {
  ReadRecordRequestDto toDto() {
    final idDto = id.toDto();

    if (idDto == null) {
      throw ArgumentError(
        'ID cannot be `HealthRecordId.none` for ReadRecordByIdRequest.',
      );
    }

    return ReadRecordRequestDto(
      recordId: idDto,
      dataType: dataType.toDto(),
    );
  }
}
