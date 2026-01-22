import 'package:health_connector_core/health_connector_core_internal.dart'
    show HealthRecord, ReadRecordByIdRequest;
import 'package:health_connector_hk_ios/src/mappers/health_data_type_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show ReadRecordRequestDto;
import 'package:meta/meta.dart' show internal;

/// Converts [ReadRecordByIdRequest] to [ReadRecordRequestDto].
@internal
extension ReadRecordRequestDtoMapper<R extends HealthRecord>
    on ReadRecordByIdRequest<R> {
  ReadRecordRequestDto toDto() {
    final idToRead = id.toDto();
    if (idToRead == null) {
      throw ArgumentError.value(
        idToRead,
        'id',
        '`ReadRecordByIdRequest.id` cannot be `HealthRecordId.none`.',
      );
    }

    return ReadRecordRequestDto(
      recordId: idToRead,
      dataType: dataType.toDto(),
    );
  }
}
