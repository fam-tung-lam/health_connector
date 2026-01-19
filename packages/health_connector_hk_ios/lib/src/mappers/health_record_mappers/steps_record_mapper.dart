import 'package:health_connector_core/health_connector_core_internal.dart'
    show Number, StepsRecord, HealthRecordId, DateTimeToDto;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show StepsRecordDto;
import 'package:meta/meta.dart' show internal;

/// Converts [StepsRecord] to [StepsRecordDto].
@internal
extension StepsRecordToDto on StepsRecord {
  StepsRecordDto toDto() {
    return StepsRecordDto(
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
      count: count.value.toDouble(),
    );
  }
}

/// Converts [StepsRecordDto] to [StepsRecord].
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
