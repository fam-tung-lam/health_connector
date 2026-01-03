import 'package:health_connector/health_connector_internal.dart';

/// Extension on [MindfulnessSessionType] to provide display names.
extension MindfulnessSessionTypeExtension on MindfulnessSessionType {
  /// Display label for this mindfulness session type.
  String get displayName {
    return switch (this) {
      MindfulnessSessionType.meditation => 'Meditation',
      MindfulnessSessionType.breathing => 'Breathing',
      MindfulnessSessionType.unknown => 'Unknown',
      MindfulnessSessionType.music => 'Music',
      MindfulnessSessionType.movement => 'Movement',
      MindfulnessSessionType.unguided => 'Unguided',
    };
  }
}
