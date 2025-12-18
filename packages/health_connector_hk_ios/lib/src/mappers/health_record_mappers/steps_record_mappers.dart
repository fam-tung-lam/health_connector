import 'package:health_connector_core/health_connector_core.dart'
    show StepsRecord, Numeric, HealthRecordId, sinceV1_0_0;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mappers.dart';
import 'package:health_connector_hk_ios/src/mappers/measurement_unit_mappers.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show StepsRecordDto, NumericDto;
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
      zoneOffsetSeconds: startZoneOffsetSeconds,

      metadata: metadata.toDto(),
      count: count.toDto() as NumericDto,
    );
  }
}

/// Converts [StepsRecordDto] to [StepsRecord].
@sinceV1_0_0
@internal
extension StepsRecordDtoToDomain on StepsRecordDto {
  StepsRecord toDomain() {
    return StepsRecord(
      id: id?.toDomain() ?? HealthRecordId.none,
      startTime: DateTime.fromMillisecondsSinceEpoch(startTime),
      endTime: DateTime.fromMillisecondsSinceEpoch(endTime),
      startZoneOffsetSeconds: zoneOffsetSeconds,
      endZoneOffsetSeconds: zoneOffsetSeconds,
      metadata: metadata.toDomain(),
      count: count.toDomain() as Numeric,
    );
  }
}
