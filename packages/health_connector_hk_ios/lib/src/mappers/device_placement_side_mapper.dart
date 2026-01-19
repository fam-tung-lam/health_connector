import 'package:health_connector_core/health_connector_core.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';

/// Extension to map [DevicePlacementSide] enum to Pigeon DTO.
extension DevicePlacementSideMapper on DevicePlacementSide {
  /// Converts this [DevicePlacementSide] to a [DevicePlacementSideDto].
  DevicePlacementSideDto toDto() {
    return switch (this) {
      DevicePlacementSide.unknown => DevicePlacementSideDto.unknown,
      DevicePlacementSide.central => DevicePlacementSideDto.central,
      DevicePlacementSide.left => DevicePlacementSideDto.left,
      DevicePlacementSide.right => DevicePlacementSideDto.right,
    };
  }
}

/// Extension to map Pigeon [DevicePlacementSideDto] to domain model.
extension DevicePlacementSideDtoMapper on DevicePlacementSideDto {
  /// Converts this [DevicePlacementSideDto] to a [DevicePlacementSide].
  DevicePlacementSide toDomain() {
    return switch (this) {
      DevicePlacementSideDto.unknown => DevicePlacementSide.unknown,
      DevicePlacementSideDto.central => DevicePlacementSide.central,
      DevicePlacementSideDto.left => DevicePlacementSide.left,
      DevicePlacementSideDto.right => DevicePlacementSide.right,
    };
  }
}
