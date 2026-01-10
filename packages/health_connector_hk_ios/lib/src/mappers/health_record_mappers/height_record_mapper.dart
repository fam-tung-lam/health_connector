import 'package:health_connector_core/health_connector_core_internal.dart'
    show HeightRecord, HealthRecordId, sinceV1_0_0;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/measurement_unit_mappers/measurement_unit_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show HeightRecordDto;
import 'package:meta/meta.dart' show internal;

/// Converts [HeightRecord] to [HeightRecordDto].
@sinceV1_0_0
@internal
extension HeightRecordToDto on HeightRecord {
  HeightRecordDto toDto() {
    return HeightRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      height: height.toDto(),
    );
  }
}

/// Converts [HeightRecordDto] to [HeightRecord].
@sinceV1_0_0
@internal
extension HeightRecordDtoToDomain on HeightRecordDto {
  HeightRecord toDomain() {
    return HeightRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time, isUtc: true),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      length: height.toDomain(),
    );
  }
}
