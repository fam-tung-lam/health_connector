import 'package:health_connector_core/health_connector_core_internal.dart'
    show
        Number,
        SwimmingStrokesRecord,
        HealthRecordId,
        sinceV1_0_0,
        DateTimeToDto;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show SwimmingStrokesRecordDto;
import 'package:meta/meta.dart' show internal;

/// Converts [SwimmingStrokesRecord] to [SwimmingStrokesRecordDto].
@sinceV1_0_0
@internal
extension SwimmingStrokesRecordToDto on SwimmingStrokesRecord {
  SwimmingStrokesRecordDto toDto() {
    return SwimmingStrokesRecordDto(
      id: id.toDto(),
      count: count.value.toDouble(),
      startTime: startTime.millisecondsSinceEpoch,
      endTime: endTime.millisecondsSinceEpoch,
      startZoneOffsetSeconds: startTime.resolveZoneOffsetSeconds(
        startZoneOffsetSeconds,
      ),
      endZoneOffsetSeconds: endTime.resolveZoneOffsetSeconds(
        endZoneOffsetSeconds,
      ),
      metadata: metadata.toDto(),
    );
  }
}

/// Converts [SwimmingStrokesRecordDto] to [SwimmingStrokesRecord].
@sinceV1_0_0
@internal
extension SwimmingStrokesRecordDtoToDomain on SwimmingStrokesRecordDto {
  SwimmingStrokesRecord toDomain() {
    return SwimmingStrokesRecord.internal(
      id: id?.toDomain() ?? HealthRecordId.none,
      startTime: DateTime.fromMillisecondsSinceEpoch(
        startTime,
        isUtc: true,
      ),
      endTime: DateTime.fromMillisecondsSinceEpoch(
        endTime,
        isUtc: true,
      ),
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
      metadata: metadata.toDomain(),
      count: Number(count),
    );
  }
}
