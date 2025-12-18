import 'package:health_connector_core/health_connector_core.dart'
    show SystolicBloodPressureRecord, Pressure, HealthRecordId, sinceV1_2_0;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mappers.dart';
import 'package:health_connector_hk_ios/src/mappers/measurement_unit_mappers.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show SystolicBloodPressureRecordDto, PressureDto;
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
      pressure: pressure.toDto() as PressureDto,
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
      time: DateTime.fromMillisecondsSinceEpoch(time),
      zoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      pressure: pressure.toDomain() as Pressure,
    );
  }
}
