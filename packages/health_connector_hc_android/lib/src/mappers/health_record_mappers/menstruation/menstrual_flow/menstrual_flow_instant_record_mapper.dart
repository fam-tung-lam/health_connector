import 'package:health_connector_core/health_connector_core_internal.dart'
    show HealthRecordId, MenstrualFlowInstantRecord, sinceV2_2_0;
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/menstruation/menstrual_flow/menstrual_flow_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show MenstrualFlowInstantRecordDto;
import 'package:meta/meta.dart' show internal;

@sinceV2_2_0
@internal
extension MenstrualFlowInstantRecordToDto on MenstrualFlowInstantRecord {
  MenstrualFlowInstantRecordDto toDto() => MenstrualFlowInstantRecordDto(
    id: id.value,
    time: time.millisecondsSinceEpoch,
    zoneOffsetSeconds: zoneOffsetSeconds,
    metadata: metadata.toDto(),
    flow: flow.toDto(),
  );
}

@sinceV2_2_0
@internal
extension MenstrualFlowInstantRecordDtoToDomain
    on MenstrualFlowInstantRecordDto {
  MenstrualFlowInstantRecord toDomain() => MenstrualFlowInstantRecord.internal(
    id: id?.toDomain() ?? HealthRecordId.none,
    time: DateTime.fromMillisecondsSinceEpoch(time, isUtc: true),
    zoneOffsetSeconds: zoneOffsetSeconds,
    metadata: metadata.toDomain(),
    flow: flow.toDomain(),
  );
}
