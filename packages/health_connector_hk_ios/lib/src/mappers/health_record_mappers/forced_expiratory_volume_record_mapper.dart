import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
import 'package:meta/meta.dart' show internal;

/// Converts [ForcedExpiratoryVolumeRecordDto] to
/// [ForcedExpiratoryVolumeRecord].
@internal
extension ForcedExpiratoryVolumeRecordDtoToDomain
    on ForcedExpiratoryVolumeRecordDto {
  ForcedExpiratoryVolumeRecord toDomain() {
    return ForcedExpiratoryVolumeRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      startTime: DateTime.fromMillisecondsSinceEpoch(startTime, isUtc: true),
      endTime: DateTime.fromMillisecondsSinceEpoch(endTime, isUtc: true),
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
      metadata: metadata.toDomain(),
      volume: Volume.liters(liters),
    );
  }
}

/// Converts [ForcedExpiratoryVolumeRecord] to
/// [ForcedExpiratoryVolumeRecordDto].
@internal
extension ForcedExpiratoryVolumeRecordToDto on ForcedExpiratoryVolumeRecord {
  ForcedExpiratoryVolumeRecordDto toDto() {
    return ForcedExpiratoryVolumeRecordDto(
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
      liters: volume.inLiters,
    );
  }
}
