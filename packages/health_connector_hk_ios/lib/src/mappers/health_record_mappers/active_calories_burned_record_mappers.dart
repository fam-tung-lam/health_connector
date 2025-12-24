import 'package:health_connector_core/health_connector_core_internal.dart'
    show ActiveCaloriesBurnedRecord, HealthRecordId, sinceV1_0_0;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mappers.dart';
import 'package:health_connector_hk_ios/src/mappers/measurement_unit_mappers/energy_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show ActiveCaloriesBurnedRecordDto;
import 'package:meta/meta.dart' show internal;

/// Converts [ActiveCaloriesBurnedRecord] to [ActiveCaloriesBurnedRecordDto].
@sinceV1_0_0
@internal
extension ActiveCaloriesBurnedRecordToDto on ActiveCaloriesBurnedRecord {
  ActiveCaloriesBurnedRecordDto toDto() {
    return ActiveCaloriesBurnedRecordDto(
      id: id.toDto(),
      startTime: startTime.millisecondsSinceEpoch,
      endTime: endTime.millisecondsSinceEpoch,
      zoneOffsetSeconds: startZoneOffsetSeconds ?? endZoneOffsetSeconds,
      metadata: metadata.toDto(),
      energy: energy.toDto(),
    );
  }
}

/// Converts [ActiveCaloriesBurnedRecordDto] to [ActiveCaloriesBurnedRecord].
@sinceV1_0_0
@internal
extension ActiveCaloriesBurnedRecordDtoToDomain
    on ActiveCaloriesBurnedRecordDto {
  ActiveCaloriesBurnedRecord toDomain() {
    return ActiveCaloriesBurnedRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      startTime: DateTime.fromMillisecondsSinceEpoch(startTime),
      endTime: DateTime.fromMillisecondsSinceEpoch(endTime),
      startZoneOffsetSeconds: zoneOffsetSeconds,
      endZoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      energy: energy.toDomain(),
    );
  }
}
