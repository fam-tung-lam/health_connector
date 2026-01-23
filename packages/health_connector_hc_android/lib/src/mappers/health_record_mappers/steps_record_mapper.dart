import 'package:health_connector_core/health_connector_core_internal.dart'
    show StepsRecord, HealthRecordId, sinceV1_0_0, Number;
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hc_android/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show StepsRecordDto;
import 'package:meta/meta.dart' show internal;

/// Converts [StepsRecord] to [StepsRecordDto].
@sinceV1_0_0
@internal
extension StepsRecordToDto on StepsRecord {
  StepsRecordDto toDto() {
    return StepsRecordDto(
      id: id.toDto(),
      startTime: startTime.millisecondsSinceEpoch,
      endTime: endTime.millisecondsSinceEpoch,
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
      metadata: metadata.toDto(),
      count: count.value.toDouble(),
    );
  }
}

/// Converts [StepsRecordDto] to [StepsRecord].
@sinceV1_0_0
@internal
extension StepsRecordDtoToDomain on StepsRecordDto {
  StepsRecord toDomain() {
    return StepsRecord.internal(
      id: id?.toDomain() ?? HealthRecordId.none,
      startTime: DateTime.fromMillisecondsSinceEpoch(startTime, isUtc: true),
      endTime: DateTime.fromMillisecondsSinceEpoch(endTime, isUtc: true),
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
      metadata: metadata.toDomain(),
      count: Number(count),
    );
  }
}
