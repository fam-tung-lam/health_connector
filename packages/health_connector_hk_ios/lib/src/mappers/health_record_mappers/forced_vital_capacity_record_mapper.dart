import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
import 'package:meta/meta.dart' show internal;

/// Converts [ForcedVitalCapacityRecordDto] to [ForcedVitalCapacityRecord].
@internal
extension ForcedVitalCapacityRecordDtoToDomain on ForcedVitalCapacityRecordDto {
  ForcedVitalCapacityRecord toDomain() {
    return ForcedVitalCapacityRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time, isUtc: true),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      volume: Volume.liters(liters),
    );
  }
}

/// Converts [ForcedVitalCapacityRecord] to [ForcedVitalCapacityRecordDto].
@internal
extension ForcedVitalCapacityRecordToDto on ForcedVitalCapacityRecord {
  ForcedVitalCapacityRecordDto toDto() {
    return ForcedVitalCapacityRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      liters: volume.inLiters,
    );
  }
}
