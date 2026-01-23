import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
import 'package:meta/meta.dart' show internal;

/// Converts [ElectrodermalActivityRecord] to [ElectrodermalActivityRecordDto].
@sinceV3_5_0
@internal
extension ElectrodermalActivityRecordToDto on ElectrodermalActivityRecord {
  ElectrodermalActivityRecordDto toDto() {
    return ElectrodermalActivityRecordDto(
      id: id.toDto(),
      startTime: startTime.millisecondsSinceEpoch,
      endTime: endTime.millisecondsSinceEpoch,
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
      metadata: metadata.toDto(),
      conductance: conductance.value.toDouble(),
    );
  }
}

/// Converts [ElectrodermalActivityRecordDto] to [ElectrodermalActivityRecord].
@sinceV3_5_0
@internal
extension ElectrodermalActivityRecordDtoToDomain
    on ElectrodermalActivityRecordDto {
  ElectrodermalActivityRecord toDomain() {
    return ElectrodermalActivityRecord.internal(
      id: id?.toDomain() ?? HealthRecordId.none,
      startTime: DateTime.fromMillisecondsSinceEpoch(startTime, isUtc: true),
      endTime: DateTime.fromMillisecondsSinceEpoch(endTime, isUtc: true),
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
      metadata: metadata.toDomain(),
      conductance: Number(conductance),
    );
  }
}
