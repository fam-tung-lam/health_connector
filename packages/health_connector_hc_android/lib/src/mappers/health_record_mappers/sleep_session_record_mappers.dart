import 'package:health_connector_core/health_connector_core.dart'
    show SleepSessionRecord, HealthRecordId;
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/health_record_id_mappers.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/sleep_stage_mappers.dart';
import 'package:health_connector_hc_android/src/mappers/metadata_mappers.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_platform_api.g.dart'
    show SleepSessionRecordDto;
import 'package:meta/meta.dart' show internal;

/// Converts [SleepSessionRecord] to [SleepSessionRecordDto].
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
@internal
extension SleepSessionRecordDtoToDomain on SleepSessionRecordDto {
  SleepSessionRecord toDomain() {
    return SleepSessionRecord(
      id: id?.toHealthRecordId() ?? HealthRecordId.none,
      startTime: DateTime.fromMillisecondsSinceEpoch(startTime),
      endTime: DateTime.fromMillisecondsSinceEpoch(endTime),
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
      metadata: metadata.toDomain(),
      samples: stages.map((s) => s.toDomain()).toList(),
      title: title,
      notes: notes,
    );
  }
}
