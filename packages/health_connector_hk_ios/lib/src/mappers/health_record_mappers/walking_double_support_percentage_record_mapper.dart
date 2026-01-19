import 'package:health_connector_core/health_connector_core.dart';
import 'package:health_connector_hk_ios/src/mappers/device_placement_side_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';

/// Extension to map [WalkingDoubleSupportPercentageRecord] to Pigeon DTO.
extension WalkingDoubleSupportPercentageRecordToDto
    on WalkingDoubleSupportPercentageRecord {
  /// Converts this [WalkingDoubleSupportPercentageRecord] to a
  /// [WalkingDoubleSupportPercentageRecordDto].
  WalkingDoubleSupportPercentageRecordDto toDto() {
    return WalkingDoubleSupportPercentageRecordDto(
      id: id.value,
      startTime: startTime.millisecondsSinceEpoch,
      endTime: endTime.millisecondsSinceEpoch,
      metadata: metadata.toDto(),
      percentage: percentage.asDecimal,
      devicePlacementSide: devicePlacementSide.toDto(),
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
    );
  }
}

/// Extension to map Pigeon [WalkingDoubleSupportPercentageRecordDto] to domain.
extension WalkingDoubleSupportPercentageRecordDtoToDomain
    on WalkingDoubleSupportPercentageRecordDto {
  /// Converts this [WalkingDoubleSupportPercentageRecordDto] to a
  /// [WalkingDoubleSupportPercentageRecord].
  WalkingDoubleSupportPercentageRecord toDomain() {
    return WalkingDoubleSupportPercentageRecord.internal(
      id: HealthRecordId(id!),
      startTime: DateTime.fromMillisecondsSinceEpoch(startTime),
      endTime: DateTime.fromMillisecondsSinceEpoch(endTime),
      metadata: metadata.toDomain(),
      percentage: Percentage.fromDecimal(percentage),
      devicePlacementSide: devicePlacementSide.toDomain(),
      startZoneOffsetSeconds: startZoneOffsetSeconds,
      endZoneOffsetSeconds: endZoneOffsetSeconds,
    );
  }
}
