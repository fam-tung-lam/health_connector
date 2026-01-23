import 'package:health_connector_core/health_connector_core_internal.dart'
    show FloorsClimbedRecord, HealthRecordId, sinceV1_0_0, Number;
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
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
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
      metadata: metadata.toDto(),
      floors: count.value.toDouble(),
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
      count: Number(floors),
    );
  }
}
