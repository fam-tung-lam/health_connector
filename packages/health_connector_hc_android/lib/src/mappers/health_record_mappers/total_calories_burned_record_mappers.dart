import 'package:health_connector_core/health_connector_core_internal.dart'
    show HealthRecordId, TotalCaloriesBurnedRecord, sinceV2_2_0;
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/health_record_id_mappers.dart';
import 'package:health_connector_hc_android/src/mappers/measurement_unit_mappers/measurement_unit_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show TotalCaloriesBurnedRecordDto;
import 'package:meta/meta.dart' show internal;

/// Converts [TotalCaloriesBurnedRecord] to [TotalCaloriesBurnedRecordDto].
@sinceV2_2_0
@internal
extension TotalCaloriesBurnedRecordToDto on TotalCaloriesBurnedRecord {
  TotalCaloriesBurnedRecordDto toDto() {
    return TotalCaloriesBurnedRecordDto(
      id: id.toDto(),
      startTime: startTime.millisecondsSinceEpoch,
      endTime: endTime.millisecondsSinceEpoch,
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
      metadata: metadata.toDto(),
      energy: energy.toDto(),
    );
  }
}

/// Converts [TotalCaloriesBurnedRecordDto] to [TotalCaloriesBurnedRecord].
@sinceV2_2_0
@internal
extension TotalCaloriesBurnedRecordDtoToDomain on TotalCaloriesBurnedRecordDto {
  TotalCaloriesBurnedRecord toDomain() {
    return TotalCaloriesBurnedRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      startTime: DateTime.fromMillisecondsSinceEpoch(startTime, isUtc: true),
      endTime: DateTime.fromMillisecondsSinceEpoch(endTime, isUtc: true),
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
      metadata: metadata.toDomain(),
      energy: energy.toDomain(),
    );
  }
}
