import 'package:health_connector_core/health_connector_core_internal.dart'
    show DiastolicBloodPressureRecord, HealthRecordId, Pressure;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/blood_pressure/blood_pressure_body_position_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/blood_pressure/blood_pressure_measurement_location_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show DiastolicBloodPressureRecordDto;
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
      millimetersOfMercury: pressure.inMillimetersOfMercury,
      bodyPosition: bodyPosition.toDto(),
      measurementLocation: measurementLocation.toDto(),
    );
  }
}

/// Converts [DiastolicBloodPressureRecordDto] to
/// [DiastolicBloodPressureRecord].
@internal
extension DiastolicBloodPressureRecordDtoToDomain
    on DiastolicBloodPressureRecordDto {
  DiastolicBloodPressureRecord toDomain() {
    return DiastolicBloodPressureRecord.internal(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time, isUtc: true),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      pressure: Pressure.millimetersOfMercury(millimetersOfMercury),
      bodyPosition: bodyPosition.toDomain(),
      measurementLocation: measurementLocation.toDomain(),
    );
  }
}
