import 'package:health_connector_core/health_connector_core_internal.dart'
    show
        ActiveEnergyBurnedRecord,
        DateTimeToDto,
        Energy,
        HealthRecordId,
        sinceV1_0_0;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';

import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show ActiveEnergyBurnedRecordDto;
import 'package:meta/meta.dart' show internal;

/// Converts [ActiveEnergyBurnedRecord] to [ActiveEnergyBurnedRecordDto].
@sinceV1_0_0
@internal
extension ActiveEnergyBurnedRecordToDto on ActiveEnergyBurnedRecord {
  ActiveEnergyBurnedRecordDto toDto() {
    return ActiveEnergyBurnedRecordDto(
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

/// Converts [ActiveEnergyBurnedRecordDto] to [ActiveEnergyBurnedRecord].
@sinceV1_0_0
@internal
extension ActiveEnergyBurnedRecordDtoToDomain on ActiveEnergyBurnedRecordDto {
  ActiveEnergyBurnedRecord toDomain() {
    return ActiveEnergyBurnedRecord.internal(
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
