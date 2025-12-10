import 'package:health_connector_core/health_connector_core.dart'
    show HeightRecord, Length, HealthRecordId;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mappers.dart';
import 'package:health_connector_hk_ios/src/mappers/measurement_unit_mappers.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_platform_api.g.dart'
    show HeightRecordDto, LengthDto;
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
      height: height.toDto() as LengthDto,
    );
  }
}

/// Converts [HeightRecordDto] to [HeightRecord].
@internal
extension HeightRecordDtoToDomain on HeightRecordDto {
  HeightRecord toDomain() {
    return HeightRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      height: height.toDomain() as Length,
    );
  }
}
