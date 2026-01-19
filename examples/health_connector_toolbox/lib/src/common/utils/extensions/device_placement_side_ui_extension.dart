import 'package:health_connector/health_connector.dart';

/// Extension on [DevicePlacementSide] to provide UI strings.
extension DevicePlacementSideUI on DevicePlacementSide {
  /// Returns a human-readable display name for the placement side.
  String get displayName {
    return switch (this) {
      DevicePlacementSide.unknown => 'Unknown',
      DevicePlacementSide.central => 'Central',
      DevicePlacementSide.left => 'Left',
      DevicePlacementSide.right => 'Right',
    };
  }
}
