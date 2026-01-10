import 'package:health_connector_core/health_connector_core_internal.dart'
    show MenstrualFlow, sinceV2_2_0;
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show MenstrualFlowDto;
import 'package:meta/meta.dart' show internal;

@sinceV2_2_0
@internal
extension MenstrualFlowToDtoExtension on MenstrualFlow {
  MenstrualFlowDto toDto() => switch (this) {
    MenstrualFlow.unknown => MenstrualFlowDto.unknown,
    MenstrualFlow.light => MenstrualFlowDto.light,
    MenstrualFlow.medium => MenstrualFlowDto.medium,
    MenstrualFlow.heavy => MenstrualFlowDto.heavy,
  };
}

@sinceV2_2_0
@internal
extension MenstrualFlowDtoToDomain on MenstrualFlowDto {
  MenstrualFlow toDomain() => switch (this) {
    MenstrualFlowDto.unknown => MenstrualFlow.unknown,
    MenstrualFlowDto.light => MenstrualFlow.light,
    MenstrualFlowDto.medium => MenstrualFlow.medium,
    MenstrualFlowDto.heavy => MenstrualFlow.heavy,
  };
}
