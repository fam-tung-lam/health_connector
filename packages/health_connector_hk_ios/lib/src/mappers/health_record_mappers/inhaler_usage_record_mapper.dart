import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
import 'package:meta/meta.dart' show internal;

/// Converts [InhalerUsageRecord] to [InhalerUsageRecordDto].
@sinceV3_5_0
@internal
extension InhalerUsageRecordToDto on InhalerUsageRecord {
  InhalerUsageRecordDto toDto() {
    return InhalerUsageRecordDto(
      id: id.toDto(),
      startTime: startTime.millisecondsSinceEpoch,
      endTime: endTime.millisecondsSinceEpoch,
      startZoneOffsetSeconds: startTime.resolveZoneOffsetSeconds(
        startZoneOffsetSeconds,
      ),
      endZoneOffsetSeconds: endTime.resolveZoneOffsetSeconds(
        endZoneOffsetSeconds,
      ),
      metadata: metadata.toDto(),
      puffs: puffs.value.toDouble(),
    );
  }
}

/// Converts [InhalerUsageRecordDto] to [InhalerUsageRecord].
@sinceV3_5_0
@internal
extension InhalerUsageRecordDtoToDomain on InhalerUsageRecordDto {
  InhalerUsageRecord toDomain() {
    return InhalerUsageRecord.internal(
      id: id?.toDomain() ?? HealthRecordId.none,
      startTime: DateTime.fromMillisecondsSinceEpoch(startTime, isUtc: true),
      endTime: DateTime.fromMillisecondsSinceEpoch(endTime, isUtc: true),
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
      metadata: metadata.toDomain(),
      puffs: Number(puffs),
    );
  }
}
