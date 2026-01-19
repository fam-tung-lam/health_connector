import 'package:health_connector_core/health_connector_core.dart';
import 'package:health_connector_hk_ios/src/mappers/device_placement_side_mapper.dart';
import 'package:health_connector_hk_ios/src/mappers/metadata_mappers/metadata_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';

/// Extension to map [WalkingAsymmetryPercentageRecord] to Pigeon DTO.
extension WalkingAsymmetryPercentageRecordToDto
    on WalkingAsymmetryPercentageRecord {
  /// Converts this [WalkingAsymmetryPercentageRecord] to a
  /// [WalkingAsymmetryPercentageRecordDto].
  WalkingAsymmetryPercentageRecordDto toDto() {
    return WalkingAsymmetryPercentageRecordDto(
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

/// Extension to map Pigeon [WalkingAsymmetryPercentageRecordDto] to domain.
extension WalkingAsymmetryPercentageRecordDtoToDomain
    on WalkingAsymmetryPercentageRecordDto {
  /// Converts this [WalkingAsymmetryPercentageRecordDto] to a
  /// [WalkingAsymmetryPercentageRecord].
  WalkingAsymmetryPercentageRecord toDomain() {
    return WalkingAsymmetryPercentageRecord.internal(
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
