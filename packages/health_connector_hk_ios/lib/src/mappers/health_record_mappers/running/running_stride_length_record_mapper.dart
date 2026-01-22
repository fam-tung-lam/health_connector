import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
import 'package:meta/meta.dart' show internal;

/// Extension to convert [RunningStrideLengthRecord] to
/// [RunningStrideLengthRecordDto].
@internal
extension RunningStrideLengthRecordToDto on RunningStrideLengthRecord {
  RunningStrideLengthRecordDto toDto() {
    return RunningStrideLengthRecordDto(
      id: id.toDto(),
      startTime: startTime.millisecondsSinceEpoch,
      endTime: endTime.millisecondsSinceEpoch,
      strideLength: strideLength.inMeters,
      metadata: metadata.toDto(),
      startZoneOffsetSeconds: startTime.resolveZoneOffsetSeconds(
        startZoneOffsetSeconds,
      ),
      endZoneOffsetSeconds: endTime.resolveZoneOffsetSeconds(
        endZoneOffsetSeconds,
      ),
    );
  }
}

/// Extension to convert [RunningStrideLengthRecordDto] to
/// [RunningStrideLengthRecord].
@internal
extension RunningStrideLengthRecordDtoToDomain on RunningStrideLengthRecordDto {
  RunningStrideLengthRecord toDomain() {
    return RunningStrideLengthRecord.internal(
      id: id?.toDomain() ?? HealthRecordId.none,
      startTime: DateTime.fromMillisecondsSinceEpoch(startTime, isUtc: true),
      endTime: DateTime.fromMillisecondsSinceEpoch(endTime, isUtc: true),
      strideLength: Length.meters(strideLength),
      metadata: metadata.toDomain(),
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
    );
  }
}
