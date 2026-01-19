import 'package:health_connector_core/health_connector_core_internal.dart'
    show HealthRecordId, SleepingWristTemperatureRecord, Temperature;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show SleepingWristTemperatureRecordDto;
import 'package:meta/meta.dart' show internal;

/// Converts [SleepingWristTemperatureRecordDto] to
/// [SleepingWristTemperatureRecord].
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
