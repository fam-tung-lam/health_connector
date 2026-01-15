import 'package:health_connector_core/health_connector_core_internal.dart'
    show DateTimeToDto, HealthRecordId, PregnancyRecord;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
import 'package:meta/meta.dart';

/// Converts [PregnancyRecord] to [PregnancyRecordDto].
@internal
extension PregnancyRecordToDto on PregnancyRecord {
  PregnancyRecordDto toDto() {
    return PregnancyRecordDto(
      id: id.toDto(),
      metadata: metadata.toDto(),
      startTime: startTime.millisecondsSinceEpoch,
      endTime: endTime.millisecondsSinceEpoch,
      startZoneOffsetSeconds: startTime.resolveZoneOffsetSeconds(
        startZoneOffsetSeconds,
      ),
      endZoneOffsetSeconds: endTime.resolveZoneOffsetSeconds(
        endZoneOffsetSeconds,
      ),
    );
  }
}

/// Converts [PregnancyRecordDto] to [PregnancyRecord].
@internal
extension PregnancyRecordDtoToDomain on PregnancyRecordDto {
  PregnancyRecord toDomain() {
    return PregnancyRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      metadata: metadata.toDomain(),
      startTime: DateTime.fromMillisecondsSinceEpoch(startTime, isUtc: true),
      endTime: DateTime.fromMillisecondsSinceEpoch(endTime, isUtc: true),
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
    );
  }
}
