import 'package:health_connector_core/health_connector_core_internal.dart'
    show
        BasalEnergyBurnedRecord,
        DateTimeToDto,
        Energy,
        HealthRecordId;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show BasalEnergyBurnedRecordDto;
import 'package:meta/meta.dart' show internal;

/// Converts [BasalEnergyBurnedRecord] to [BasalEnergyBurnedRecordDto].
@internal
extension BasalEnergyBurnedRecordToDto on BasalEnergyBurnedRecord {
  BasalEnergyBurnedRecordDto toDto() {
    return BasalEnergyBurnedRecordDto(
      id: id.toDto(),
      startTime: startTime.millisecondsSinceEpoch,
      endTime: endTime.millisecondsSinceEpoch,
      startZoneOffsetSeconds: startTime.resolveZoneOffsetSeconds(
        startZoneOffsetSeconds,
      ),
      endZoneOffsetSeconds: endTime.resolveZoneOffsetSeconds(
        endZoneOffsetSeconds,
      ),
      metadata: metadata.toDto(),
      kilocalories: energy.inKilocalories,
    );
  }
}

/// Converts [BasalEnergyBurnedRecordDto] to [BasalEnergyBurnedRecord].
@internal
extension BasalEnergyBurnedRecordDtoToDomain on BasalEnergyBurnedRecordDto {
  BasalEnergyBurnedRecord toDomain() {
    return BasalEnergyBurnedRecord.internal(
      id: id?.toDomain() ?? HealthRecordId.none,
      startTime: DateTime.fromMillisecondsSinceEpoch(startTime, isUtc: true),
      endTime: DateTime.fromMillisecondsSinceEpoch(endTime, isUtc: true),
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
      metadata: metadata.toDomain(),
      energy: Energy.kilocalories(kilocalories),
    );
  }
}
