import 'package:health_connector_core/health_connector_core_internal.dart'
    show SystolicBloodPressureRecord, HealthRecordId, sinceV1_2_0;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/blood_pressure/blood_pressure_body_position_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/blood_pressure/blood_pressure_measurement_location_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/measurement_unit_mappers/measurement_unit_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show SystolicBloodPressureRecordDto;
import 'package:meta/meta.dart' show internal;

/// Converts [SystolicBloodPressureRecord] to [SystolicBloodPressureRecordDto].
@sinceV1_2_0
@internal
extension SystolicBloodPressureRecordToDto on SystolicBloodPressureRecord {
  SystolicBloodPressureRecordDto toDto() {
    return SystolicBloodPressureRecordDto(
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

/// Converts [SystolicBloodPressureRecordDto] to [SystolicBloodPressureRecord].
@sinceV1_2_0
@internal
extension SystolicBloodPressureRecordDtoToDomain
    on SystolicBloodPressureRecordDto {
  SystolicBloodPressureRecord toDomain() {
    return SystolicBloodPressureRecord(
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
