import 'package:health_connector_core/health_connector_core_internal.dart'
    show DiastolicBloodPressureRecord, HealthRecordId, sinceV1_2_0;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mappers.dart';
import 'package:health_connector_hk_ios/src/mappers/measurement_unit_mappers/measurement_unit_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show DiastolicBloodPressureRecordDto;
import 'package:meta/meta.dart' show internal;

/// Converts [DiastolicBloodPressureRecord] to
/// [DiastolicBloodPressureRecordDto].
@sinceV1_2_0
@internal
extension DiastolicBloodPressureRecordToDto on DiastolicBloodPressureRecord {
  DiastolicBloodPressureRecordDto toDto() {
    return DiastolicBloodPressureRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      pressure: pressure.toDto(),
    );
  }
}

/// Converts [DiastolicBloodPressureRecordDto] to
/// [DiastolicBloodPressureRecord].
@sinceV1_2_0
@internal
extension DiastolicBloodPressureRecordDtoToDomain
    on DiastolicBloodPressureRecordDto {
  DiastolicBloodPressureRecord toDomain() {
    return DiastolicBloodPressureRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      pressure: pressure.toDomain(),
    );
  }
}
