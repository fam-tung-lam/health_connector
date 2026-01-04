import 'package:health_connector_core/health_connector_core_internal.dart'
    show CyclingPedalingCadenceMeasurementRecord, HealthRecordId, sinceV2_2_0;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/cycling_pedaling_cadence_measurement_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show CyclingPedalingCadenceMeasurementRecordDto;
import 'package:meta/meta.dart' show internal;

/// Converts [CyclingPedalingCadenceMeasurementRecord] to
/// [CyclingPedalingCadenceMeasurementRecordDto].
@sinceV2_2_0
@internal
extension CyclingPedalingCadenceMeasurementRecordToDto
    on CyclingPedalingCadenceMeasurementRecord {
  CyclingPedalingCadenceMeasurementRecordDto toDto() {
    return CyclingPedalingCadenceMeasurementRecordDto(
      id: id.toDto(),
      time: measurement.time.millisecondsSinceEpoch,
      metadata: metadata.toDto(),
      measurement: measurement.toDto(),
    );
  }
}

/// Converts [CyclingPedalingCadenceMeasurementRecordDto] to
/// [CyclingPedalingCadenceMeasurementRecord].
@sinceV2_2_0
@internal
extension CyclingPedalingCadenceMeasurementRecordDtoToDomain
    on CyclingPedalingCadenceMeasurementRecordDto {
  CyclingPedalingCadenceMeasurementRecord toDomain() {
    return CyclingPedalingCadenceMeasurementRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      metadata: metadata.toDomain(),
      measurement: measurement.toDomain(),
    );
  }
}
