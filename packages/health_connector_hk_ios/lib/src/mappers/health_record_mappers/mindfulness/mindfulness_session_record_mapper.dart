import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/mindfulness/mindfulness_session_type_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
import 'package:meta/meta.dart' show internal;

/// Extension for converting [MindfulnessSessionRecord] to DTO.
@sinceV2_1_0
@internal
extension MindfulnessSessionRecordToDtoExtension on MindfulnessSessionRecord {
  /// Converts to [MindfulnessSessionRecordDto].
  MindfulnessSessionRecordDto toDto() {
    return MindfulnessSessionRecordDto(
      id: id == HealthRecordId.none ? null : id.value,
      metadata: metadata.toDto(),
      startTime: startTime.millisecondsSinceEpoch,
      endTime: endTime.millisecondsSinceEpoch,
      startZoneOffsetSeconds: startTime.resolveZoneOffsetSeconds(
        startZoneOffsetSeconds,
      ),
      endZoneOffsetSeconds: endTime.resolveZoneOffsetSeconds(
        endZoneOffsetSeconds,
      ),
      sessionType: sessionType.toDto(),
      title: title,
      notes: notes,
    );
  }
}

/// Extension for converting DTO to [MindfulnessSessionRecord].
@sinceV2_1_0
@internal
extension MindfulnessSessionRecordDtoToDomainExtension
    on MindfulnessSessionRecordDto {
  /// Converts to [MindfulnessSessionRecord].
  MindfulnessSessionRecord toDomain() {
    final recordId = id;
    return MindfulnessSessionRecord(
      id: recordId != null ? HealthRecordId(recordId) : HealthRecordId.none,
      metadata: metadata.toDomain(),
      startTime: DateTime.fromMillisecondsSinceEpoch(startTime, isUtc: true),
      endTime: DateTime.fromMillisecondsSinceEpoch(endTime, isUtc: true),
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
      sessionType: sessionType.toDomain(),
      title: title,
      notes: notes,
    );
  }
}
