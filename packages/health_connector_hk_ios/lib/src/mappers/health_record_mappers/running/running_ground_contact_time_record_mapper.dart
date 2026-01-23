import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
import 'package:meta/meta.dart' show internal;

/// Extension to convert [RunningGroundContactTimeRecord] to
/// [RunningGroundContactTimeRecordDto].
@internal
extension RunningGroundContactTimeRecordToDto
    on RunningGroundContactTimeRecord {
  RunningGroundContactTimeRecordDto toDto() {
    return RunningGroundContactTimeRecordDto(
      id: id.toDto(),
      startTime: startTime.millisecondsSinceEpoch,
      endTime: endTime.millisecondsSinceEpoch,
      seconds: groundContactTime.inSeconds,
      metadata: metadata.toDto(),
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
    );
  }
}

/// Extension to convert [RunningGroundContactTimeRecordDto] to
/// [RunningGroundContactTimeRecord].
@internal
extension RunningGroundContactTimeRecordDtoToDomain
    on RunningGroundContactTimeRecordDto {
  RunningGroundContactTimeRecord toDomain() {
    return RunningGroundContactTimeRecord.internal(
      id: id?.toDomain() ?? HealthRecordId.none,
      startTime: DateTime.fromMillisecondsSinceEpoch(startTime, isUtc: true),
      endTime: DateTime.fromMillisecondsSinceEpoch(endTime, isUtc: true),
      groundContactTime: TimeDuration.seconds(seconds),
      metadata: metadata.toDomain(),
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
    );
  }
}
