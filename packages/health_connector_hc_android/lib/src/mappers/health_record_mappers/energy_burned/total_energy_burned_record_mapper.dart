import 'package:health_connector_core/health_connector_core_internal.dart'
    show
        HealthRecordId,
        TotalEnergyBurnedRecord,
        sinceV2_2_0,
        DateTimeToDto,
        Energy;
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show TotalEnergyBurnedRecordDto;
import 'package:meta/meta.dart' show internal;

/// Converts [TotalEnergyBurnedRecord] to [TotalEnergyBurnedRecordDto].
@sinceV2_2_0
@internal
extension TotalEnergyBurnedRecordToDto on TotalEnergyBurnedRecord {
  TotalEnergyBurnedRecordDto toDto() {
    return TotalEnergyBurnedRecordDto(
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

/// Converts [TotalEnergyBurnedRecordDto] to [TotalEnergyBurnedRecord].
@sinceV2_2_0
@internal
extension TotalEnergyBurnedRecordDtoToDomain on TotalEnergyBurnedRecordDto {
  TotalEnergyBurnedRecord toDomain() {
    return TotalEnergyBurnedRecord.internal(
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
