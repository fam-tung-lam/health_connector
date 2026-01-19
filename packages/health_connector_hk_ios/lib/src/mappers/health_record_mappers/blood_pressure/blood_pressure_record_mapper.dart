import 'package:health_connector_core/health_connector_core_internal.dart'
    show BloodPressureRecord, HealthRecordId, Pressure;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/blood_pressure/blood_pressure_body_position_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/blood_pressure/blood_pressure_measurement_location_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show BloodPressureRecordDto;
import 'package:meta/meta.dart' show internal;

/// Converts [BloodPressureRecord] to [BloodPressureRecordDto].
@internal
extension BloodPressureRecordToDto on BloodPressureRecord {
  BloodPressureRecordDto toDto() {
    return BloodPressureRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDto(),
      systolicInMillimetersOfMercury: systolic.inMillimetersOfMercury,
      diastolicInMillimetersOfMercury: diastolic.inMillimetersOfMercury,
      bodyPosition: bodyPosition.toDto(),
      measurementLocation: measurementLocation.toDto(),
    );
  }
}

/// Converts [BloodPressureRecordDto] to [BloodPressureRecord].
@internal
extension BloodPressureRecordDtoToDomain on BloodPressureRecordDto {
  BloodPressureRecord toDomain() {
    return BloodPressureRecord.internal(
      id: id?.toDomain() ?? HealthRecordId.none,
      time: DateTime.fromMillisecondsSinceEpoch(time, isUtc: true),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      systolic: Pressure.millimetersOfMercury(systolicInMillimetersOfMercury),
      diastolic: Pressure.millimetersOfMercury(diastolicInMillimetersOfMercury),
      bodyPosition: bodyPosition.toDomain(),
      measurementLocation: measurementLocation.toDomain(),
    );
  }
}
