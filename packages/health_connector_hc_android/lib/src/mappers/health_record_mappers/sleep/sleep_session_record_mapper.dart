import 'package:health_connector_core/health_connector_core_internal.dart'
    show SleepSessionRecord, HealthRecordId, sinceV1_0_0;
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/sleep/sleep_stage_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show SleepSessionRecordDto;
import 'package:meta/meta.dart' show internal;

/// Converts [SleepSessionRecord] to [SleepSessionRecordDto].
@sinceV1_0_0
@internal
extension SleepSessionRecordToDto on SleepSessionRecord {
  SleepSessionRecordDto toDto() {
    return SleepSessionRecordDto(
      id: id.toDto(),
      startTime: startTime.millisecondsSinceEpoch,
      endTime: endTime.millisecondsSinceEpoch,
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
      metadata: metadata.toDto(),
      title: title,
      notes: notes,
      stages: samples.map((s) => s.toDto()).toList(),
    );
  }
}

/// Converts [SleepSessionRecordDto] to [SleepSessionRecord].
@sinceV1_0_0
@internal
extension SleepSessionRecordDtoToDomain on SleepSessionRecordDto {
  SleepSessionRecord toDomain() {
    return SleepSessionRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      startTime: DateTime.fromMillisecondsSinceEpoch(startTime, isUtc: true),
      endTime: DateTime.fromMillisecondsSinceEpoch(endTime, isUtc: true),
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
      metadata: metadata.toDomain(),
      samples: stages.map((s) => s.toDomain()).toList(),
      title: title,
      notes: notes,
    );
  }
}
