import 'package:health_connector_core/health_connector_core.dart'
    show HeightRecord, Length, HealthRecordId, sinceV1_0_0;
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/health_record_id_mappers.dart';
import 'package:health_connector_hc_android/src/mappers/measurement_unit_mappers.dart';
import 'package:health_connector_hc_android/src/mappers/metadata_mappers.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show HeightRecordDto, LengthDto;
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
      height: height.toDto() as LengthDto,
    );
  }
}

/// Converts [HeightRecordDto] to [HeightRecord].
@sinceV1_0_0
@internal
extension HeightRecordDtoToDomain on HeightRecordDto {
  HeightRecord toDomain() {
    return HeightRecord(
      id: id?.toHealthRecordId() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      height: height.toDomain() as Length,
    );
  }
}
