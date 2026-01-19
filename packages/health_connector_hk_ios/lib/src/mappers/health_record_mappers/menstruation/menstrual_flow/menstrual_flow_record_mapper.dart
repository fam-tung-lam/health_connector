import 'package:health_connector_core/health_connector_core_internal.dart'
    show HealthRecordId, MenstrualFlowRecord;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/menstruation/menstrual_flow/menstrual_flow_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show MenstrualFlowRecordDto;
import 'package:meta/meta.dart' show internal;

@internal
extension MenstrualFlowRecordToDto on MenstrualFlowRecord {
  MenstrualFlowRecordDto toDto() {
    return MenstrualFlowRecordDto(
      id: id.toDto(),
      flow: flow.toDto(),
      isCycleStart: isCycleStart,
      startTime: startTime.toUtc().millisecondsSinceEpoch,
      startZoneOffsetSeconds: startTime.timeZoneOffset.inSeconds,
      endTime: endTime.toUtc().millisecondsSinceEpoch,
      endZoneOffsetSeconds: endTime.timeZoneOffset.inSeconds,
      metadata: metadata.toDto(),
    );
  }
}

@internal
extension MenstrualFlowRecordDtoToDomain on MenstrualFlowRecordDto {
  MenstrualFlowRecord toDomain() {
    return MenstrualFlowRecord.internal(
      id: id?.toDomain() ?? HealthRecordId.none,
      startTime: DateTime.fromMillisecondsSinceEpoch(startTime, isUtc: true),
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endTime: DateTime.fromMillisecondsSinceEpoch(endTime, isUtc: true),
      endZoneOffsetSeconds: endZoneOffsetSeconds,
      flow: flow.toDomain(),
      isCycleStart: isCycleStart,
      metadata: metadata.toDomain(),
    );
  }
}
