import 'package:health_connector_core/health_connector_core_internal.dart'
    show MenstrualFlow;
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show MenstrualFlowDto;
import 'package:meta/meta.dart' show internal;
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
