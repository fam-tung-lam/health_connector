import 'package:health_connector_core/health_connector_core.dart'
    show HealthRecordId, MenstrualCycleRecord, sinceV1_0_0;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mappers.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/menstrual_flow_mappers.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_platform_api.g.dart'
    show MenstrualCycleRecordDto;
import 'package:meta/meta.dart' show internal;

/// Converts [MenstrualCycleRecord] to [MenstrualCycleRecordDto].
@sinceV1_0_0
@internal
extension MenstrualCycleRecordToDto on MenstrualCycleRecord {
  MenstrualCycleRecordDto toDto() {
    return MenstrualCycleRecordDto(
      id: id.toDto(),
      startTime: startTime.millisecondsSinceEpoch,
      endTime: endTime.millisecondsSinceEpoch,
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
      metadata: metadata.toDto(),
      flow: flow.toDto(),
      isStartOfCycle: isStartOfCycle,
    );
  }
}

/// Converts [MenstrualCycleRecordDto] to [MenstrualCycleRecord].
@sinceV1_0_0
@internal
extension MenstrualCycleRecordDtoToDomain on MenstrualCycleRecordDto {
  MenstrualCycleRecord toDomain() {
    return MenstrualCycleRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      startTime: DateTime.fromMillisecondsSinceEpoch(startTime),
      endTime: DateTime.fromMillisecondsSinceEpoch(endTime),
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
      metadata: metadata.toDomain(),
      flow: flow.toDomain(),
      isStartOfCycle: isStartOfCycle,
    );
  }
}
