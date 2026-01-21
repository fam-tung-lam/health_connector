import 'package:health_connector_core/health_connector_core.dart';
import 'package:health_connector_hk_ios/src/mappers/device_placement_side_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/health_record_id_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
import 'package:meta/meta.dart';

/// Extension to map [WalkingStepLengthRecord] to [WalkingStepLengthRecordDto].
@internal
extension WalkingStepLengthRecordToDto on WalkingStepLengthRecord {
  WalkingStepLengthRecordDto toDto() {
    return WalkingStepLengthRecordDto(
      id: id.value,
      startTime: startTime.millisecondsSinceEpoch,
      endTime: endTime.millisecondsSinceEpoch,
      metadata: metadata.toDto(),
      meters: length.inMeters,
      devicePlacementSide: devicePlacementSide.toDto(),
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
    );
  }
}

/// Extension to map Pigeon [WalkingStepLengthRecordDto] to
/// [WalkingStepLengthRecord].
@internal
extension WalkingStepLengthRecordDtoToDomain on WalkingStepLengthRecordDto {
  WalkingStepLengthRecord toDomain() {
    return WalkingStepLengthRecord.internal(
      id: id?.toDomain() ?? HealthRecordId.none,
      startTime: DateTime.fromMillisecondsSinceEpoch(startTime, isUtc: true),
      endTime: DateTime.fromMillisecondsSinceEpoch(endTime, isUtc: true),
      metadata: metadata.toDomain(),
      length: Length.meters(meters),
      devicePlacementSide: devicePlacementSide.toDomain(),
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
    );
  }
}
