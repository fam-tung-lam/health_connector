import 'package:health_connector_core/health_connector_core_internal.dart'
    show HeartRateMeasurementRecord, HealthRecordId, sinceV1_0_0;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/measurement_unit_mappers/measurement_unit_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show HeartRateMeasurementRecordDto;
import 'package:meta/meta.dart' show internal;

/// Converts [HeartRateMeasurementRecord] to [HeartRateMeasurementRecordDto].
@sinceV1_0_0
@internal
extension HeartRateMeasurementRecordToDto on HeartRateMeasurementRecord {
  HeartRateMeasurementRecordDto toDto() {
    return HeartRateMeasurementRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      metadata: metadata.toDto(),
      beatsPerMinute: beatsPerMinute.toDto(),
    );
  }
}

/// Converts [HeartRateMeasurementRecordDto] to [HeartRateMeasurementRecord].
@sinceV1_0_0
@internal
extension HeartRateMeasurementRecordDtoToDomain
    on HeartRateMeasurementRecordDto {
  HeartRateMeasurementRecord toDomain() {
    return HeartRateMeasurementRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      metadata: metadata.toDomain(),
      time: DateTime.fromMillisecondsSinceEpoch(time, isUtc: true),
      beatsPerMinute: beatsPerMinute.toDomain(),
    );
  }
}
