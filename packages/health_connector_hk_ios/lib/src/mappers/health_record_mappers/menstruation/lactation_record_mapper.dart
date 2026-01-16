import 'package:health_connector_core/health_connector_core_internal.dart'
    show DateTimeToDto, HealthRecordId, LactationRecord;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';

import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
import 'package:meta/meta.dart';

/// Converts [LactationRecord] to [LactationRecordDto].
@internal
extension LactationRecordToDto on LactationRecord {
  LactationRecordDto toDto() {
    return LactationRecordDto(
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

/// Converts [LactationRecordDto] to [LactationRecord].
@internal
extension LactationRecordDtoToDomain on LactationRecordDto {
  LactationRecord toDomain() {
    return LactationRecord.internal(
      id: id?.toDomain() ?? HealthRecordId.none,
      metadata: metadata.toDomain(),
      startTime: DateTime.fromMillisecondsSinceEpoch(startTime, isUtc: true),
      endTime: DateTime.fromMillisecondsSinceEpoch(endTime, isUtc: true),
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
    );
  }
}
