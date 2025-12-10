import 'package:health_connector_core/health_connector_core.dart'
    show HeartRateMeasurementRecord, HealthRecordId;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mappers.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/heart_rate_measurement_mappers.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_platform_api.g.dart'
    show HeartRateMeasurementRecordDto;
import 'package:meta/meta.dart' show internal;

/// Converts [HeartRateMeasurementRecord] to [HeartRateMeasurementRecordDto].
@internal
extension HeartRateMeasurementRecordToDto on HeartRateMeasurementRecord {
  HeartRateMeasurementRecordDto toDto() {
    return HeartRateMeasurementRecordDto(
      id: id.toDto(),
      time: measurement.time.millisecondsSinceEpoch,
      metadata: metadata.toDto(),
      measurement: measurement.toDto(),
    );
  }
}

/// Converts [HeartRateMeasurementRecordDto] to [HeartRateMeasurementRecord].
@internal
extension HeartRateMeasurementRecordDtoToDomain
    on HeartRateMeasurementRecordDto {
  HeartRateMeasurementRecord toDomain() {
    return HeartRateMeasurementRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      metadata: metadata.toDomain(),
      measurement: measurement.toDomain(),
    );
  }
}
