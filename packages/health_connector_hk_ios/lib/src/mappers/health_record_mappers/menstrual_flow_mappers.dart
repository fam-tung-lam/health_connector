import 'package:health_connector_core/health_connector_core.dart'
    show MenstrualFlow, sinceV1_0_0;
import 'package:health_connector_hk_ios/src/pigeon/health_connector_platform_api.g.dart'
    show MenstrualFlowDto;
import 'package:meta/meta.dart' show internal;

/// Converts [MenstrualFlow] to [MenstrualFlowDto].
@sinceV1_0_0
@internal
extension MenstrualFlowDomainToDto on MenstrualFlow {
  MenstrualFlowDto toDto() {
    return switch (this) {
      MenstrualFlow.unknown => MenstrualFlowDto.unknown,
      MenstrualFlow.light => MenstrualFlowDto.light,
      MenstrualFlow.medium => MenstrualFlowDto.medium,
      MenstrualFlow.heavy => MenstrualFlowDto.heavy,
    };
  }
}

/// Converts [MenstrualFlowDto] to [MenstrualFlow].
@sinceV1_0_0
@internal
extension MenstrualFlowDtoToDomain on MenstrualFlowDto {
  MenstrualFlow toDomain() {
    return switch (this) {
      MenstrualFlowDto.unknown => MenstrualFlow.unknown,
      MenstrualFlowDto.light => MenstrualFlow.light,
      MenstrualFlowDto.medium => MenstrualFlow.medium,
      MenstrualFlowDto.heavy => MenstrualFlow.heavy,
    };
  }
}
