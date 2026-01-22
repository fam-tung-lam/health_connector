import 'package:health_connector_core/health_connector_core_internal.dart'
    show Number, NumberOfTimesFallenRecord, HealthRecordId, DateTimeToDto;
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show NumberOfTimesFallenRecordDto;
import 'package:meta/meta.dart' show internal;

/// Converts [NumberOfTimesFallenRecord] to [NumberOfTimesFallenRecordDto].
@internal
extension NumberOfTimesFallenRecordToDto on NumberOfTimesFallenRecord {
  NumberOfTimesFallenRecordDto toDto() {
    return NumberOfTimesFallenRecordDto(
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

/// Converts [NumberOfTimesFallenRecordDto] to [NumberOfTimesFallenRecord].
@internal
extension NumberOfTimesFallenRecordDtoToDomain on NumberOfTimesFallenRecordDto {
  NumberOfTimesFallenRecord toDomain() {
    return NumberOfTimesFallenRecord.internal(
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
