import 'package:health_connector_core/health_connector_core_internal.dart'
    show Frequency, HealthRecordId, RespiratoryRateRecord;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show RespiratoryRateRecordDto;
import 'package:meta/meta.dart' show internal;

@internal
extension RespiratoryRateRecordToDto on RespiratoryRateRecord {
  RespiratoryRateRecordDto toDto() {
    return RespiratoryRateRecordDto(
      id: id.toDto(),
      time: time.millisecondsSinceEpoch,
      metadata: metadata.toDto(),
      zoneOffsetSeconds: zoneOffsetSeconds,
      breathsPerMinute: rate.inPerMinute,
    );
  }
}

@internal
extension RespiratoryRateRecordDtoToDomain on RespiratoryRateRecordDto {
  RespiratoryRateRecord toDomain() {
    return RespiratoryRateRecord.internal(
      id: id?.toDomain() ?? HealthRecordId.none,
      metadata: metadata.toDomain(),
      time: DateTime.fromMillisecondsSinceEpoch(time, isUtc: true),
      rate: Frequency.perMinute(breathsPerMinute),
    );
  }
}
