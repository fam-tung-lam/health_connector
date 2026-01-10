import 'package:health_connector_core/health_connector_core_internal.dart'
    show MenstrualFlow, sinceV1_0_0;
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show MenstrualFlowDto;
import 'package:meta/meta.dart' show internal;

@sinceV1_0_0
@internal
extension MenstrualFlowToDto on MenstrualFlow {
  MenstrualFlowDto toDto() {
    switch (this) {
      case MenstrualFlow.unknown:
        return MenstrualFlowDto.unknown;
      case MenstrualFlow.light:
        return MenstrualFlowDto.light;
      case MenstrualFlow.medium:
        return MenstrualFlowDto.medium;
      case MenstrualFlow.heavy:
        return MenstrualFlowDto.heavy;
    }
  }
}

@sinceV1_0_0
@internal
extension MenstrualFlowDtoToDomain on MenstrualFlowDto {
  MenstrualFlow toDomain() {
    switch (this) {
      case MenstrualFlowDto.unknown:
        return MenstrualFlow.unknown;
      case MenstrualFlowDto.light:
        return MenstrualFlow.light;
      case MenstrualFlowDto.medium:
        return MenstrualFlow.medium;
      case MenstrualFlowDto.heavy:
        return MenstrualFlow.heavy;
    }
  }
}
