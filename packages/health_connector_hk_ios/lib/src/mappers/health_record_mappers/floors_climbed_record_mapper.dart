import 'package:health_connector_core/health_connector_core_internal.dart'
    show FloorsClimbedRecord, HealthRecordId, sinceV1_0_0, DateTimeToDto;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/measurement_unit_mappers/measurement_unit_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show FloorsClimbedRecordDto;
import 'package:meta/meta.dart' show internal;

/// Converts [FloorsClimbedRecord] to [FloorsClimbedRecordDto].
@sinceV1_0_0
@internal
extension FloorsClimbedRecordToDto on FloorsClimbedRecord {
  FloorsClimbedRecordDto toDto() {
    return FloorsClimbedRecordDto(
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
      floors: count.toDto(),
    );
  }
}

/// Converts [FloorsClimbedRecordDto] to [FloorsClimbedRecord].
@sinceV1_0_0
@internal
extension FloorsClimbedRecordDtoToDomain on FloorsClimbedRecordDto {
  FloorsClimbedRecord toDomain() {
    return FloorsClimbedRecord.internal(
      id: id?.toDomain() ?? HealthRecordId.none,
      startTime: DateTime.fromMillisecondsSinceEpoch(startTime, isUtc: true),
      endTime: DateTime.fromMillisecondsSinceEpoch(endTime, isUtc: true),
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
      metadata: metadata.toDomain(),
      count: floors.toDomain(),
    );
  }
}
