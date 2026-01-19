import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
import 'package:meta/meta.dart' show internal;

/// Extension for converting [MindfulnessSessionType] to DTO.
@internal
extension MindfulnessSessionTypeToDtoExtension on MindfulnessSessionType {
  /// Converts to [MindfulnessSessionTypeDto].
  MindfulnessSessionTypeDto toDto() {
    return switch (this) {
      MindfulnessSessionType.unknown => MindfulnessSessionTypeDto.unknown,
      MindfulnessSessionType.meditation => MindfulnessSessionTypeDto.meditation,
      MindfulnessSessionType.breathing => MindfulnessSessionTypeDto.breathing,
      MindfulnessSessionType.music => MindfulnessSessionTypeDto.music,
      MindfulnessSessionType.movement => MindfulnessSessionTypeDto.movement,
      MindfulnessSessionType.unguided => MindfulnessSessionTypeDto.unguided,
    };
  }
}

/// Extension for converting DTO to [MindfulnessSessionType].
@internal
extension MindfulnessSessionTypeDtoToDomainExtension
    on MindfulnessSessionTypeDto {
  /// Converts to [MindfulnessSessionType].
  MindfulnessSessionType toDomain() {
    return switch (this) {
      MindfulnessSessionTypeDto.unknown => MindfulnessSessionType.unknown,
      MindfulnessSessionTypeDto.meditation => MindfulnessSessionType.meditation,
      MindfulnessSessionTypeDto.breathing => MindfulnessSessionType.breathing,
      MindfulnessSessionTypeDto.music => MindfulnessSessionType.music,
      MindfulnessSessionTypeDto.movement => MindfulnessSessionType.movement,
      MindfulnessSessionTypeDto.unguided => MindfulnessSessionType.unguided,
    };
  }
}
