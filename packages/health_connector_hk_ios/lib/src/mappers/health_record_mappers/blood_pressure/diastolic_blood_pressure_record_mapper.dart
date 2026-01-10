import 'package:health_connector_core/health_connector_core_internal.dart'
    show DiastolicBloodPressureRecord, HealthRecordId, sinceV1_2_0;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/blood_pressure/blood_pressure_body_position_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/blood_pressure/blood_pressure_measurement_location_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
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
      bodyPosition: bodyPosition.toDto(),
      measurementLocation: measurementLocation.toDto(),
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
    return DiastolicBloodPressureRecord.internal(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time, isUtc: true),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      pressure: pressure.toDomain(),
      bodyPosition: bodyPosition.toDomain(),
      measurementLocation: measurementLocation.toDomain(),
    );
  }
}
