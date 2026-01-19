import 'package:health_connector_core/health_connector_core_internal.dart'
    show HealthRecordId, HeightRecord, Length;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show HeightRecordDto;
import 'package:meta/meta.dart' show internal;

/// Converts [HeightRecord] to [HeightRecordDto].
@internal
extension HeightRecordToDto on HeightRecord {
  HeightRecordDto toDto() {
    return HeightRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      meters: height.inMeters,
    );
  }
}

/// Converts [HeightRecordDto] to [HeightRecord].
@internal
extension HeightRecordDtoToDomain on HeightRecordDto {
  HeightRecord toDomain() {
    return HeightRecord.internal(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time, isUtc: true),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      height: Length.meters(meters),
    );
  }
}
