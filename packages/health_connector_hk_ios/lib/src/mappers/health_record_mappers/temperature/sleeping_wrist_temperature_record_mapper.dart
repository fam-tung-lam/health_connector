import 'package:health_connector_core/health_connector_core_internal.dart'
    show
        HealthRecordId,
        SleepingWristTemperatureRecord,
        Temperature,
        sinceV1_0_0;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show SleepingWristTemperatureRecordDto;
import 'package:meta/meta.dart' show internal;

/// Converts [SleepingWristTemperatureRecord] to
/// [SleepingWristTemperatureRecordDto].
@sinceV1_0_0
@internal
extension SleepingWristTemperatureRecordToDto
    on SleepingWristTemperatureRecord {
  SleepingWristTemperatureRecordDto toDto() {
    return SleepingWristTemperatureRecordDto(
      id: id.toDto(),
      startTime: startTime.millisecondsSinceEpoch,
      endTime: endTime.millisecondsSinceEpoch,
      temperatureCelsius: temperature.inCelsius,
      metadata: metadata.toDto(),
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
    );
  }
}

/// Converts [SleepingWristTemperatureRecordDto] to
/// [SleepingWristTemperatureRecord].
@sinceV1_0_0
@internal
extension SleepingWristTemperatureRecordDtoToDomain
    on SleepingWristTemperatureRecordDto {
  SleepingWristTemperatureRecord toDomain() {
    return SleepingWristTemperatureRecord.internal(
      id: id?.toDomain() ?? HealthRecordId.none,
      startTime: DateTime.fromMillisecondsSinceEpoch(startTime, isUtc: true),
      endTime: DateTime.fromMillisecondsSinceEpoch(endTime, isUtc: true),
      temperature: Temperature.celsius(temperatureCelsius),
      metadata: metadata.toDomain(),
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
    );
  }
}
