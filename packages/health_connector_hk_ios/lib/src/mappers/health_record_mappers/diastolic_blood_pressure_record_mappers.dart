import 'package:health_connector_core/health_connector_core.dart'
    show DiastolicBloodPressureRecord, Pressure, HealthRecordId;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mappers.dart';
import 'package:health_connector_hk_ios/src/mappers/measurement_unit_mappers.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_platform_api.g.dart'
    show DiastolicBloodPressureRecordDto, PressureDto;
import 'package:meta/meta.dart' show internal;

/// Converts [DiastolicBloodPressureRecord] to
/// [DiastolicBloodPressureRecordDto].
@internal
extension DiastolicBloodPressureRecordToDto on DiastolicBloodPressureRecord {
  DiastolicBloodPressureRecordDto toDto() {
    return DiastolicBloodPressureRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      pressure: pressure.toDto() as PressureDto,
    );
  }
}

/// Converts [DiastolicBloodPressureRecordDto] to
/// [DiastolicBloodPressureRecord].
@internal
extension DiastolicBloodPressureRecordDtoToDomain
    on DiastolicBloodPressureRecordDto {
  DiastolicBloodPressureRecord toDomain() {
    return DiastolicBloodPressureRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      pressure: pressure.toDomain() as Pressure,
    );
  }
}
