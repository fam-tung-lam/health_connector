import 'package:health_connector_core/health_connector_core_internal.dart'
    show MenstrualFlowType, sinceV1_0_0;
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show MenstrualFlowTypeDto;
import 'package:meta/meta.dart' show internal;

@sinceV1_0_0
@internal
extension MenstrualFlowTypeToDto on MenstrualFlowType {
  MenstrualFlowTypeDto toDto() {
    switch (this) {
      case MenstrualFlowType.unknown:
        return MenstrualFlowTypeDto.unknown;
      case MenstrualFlowType.light:
        return MenstrualFlowTypeDto.light;
      case MenstrualFlowType.medium:
        return MenstrualFlowTypeDto.medium;
      case MenstrualFlowType.heavy:
        return MenstrualFlowTypeDto.heavy;
    }
  }
}

@sinceV1_0_0
@internal
extension MenstrualFlowTypeDtoToDomain on MenstrualFlowTypeDto {
  MenstrualFlowType toDomain() {
    switch (this) {
      case MenstrualFlowTypeDto.unknown:
        return MenstrualFlowType.unknown;
      case MenstrualFlowTypeDto.light:
        return MenstrualFlowType.light;
      case MenstrualFlowTypeDto.medium:
        return MenstrualFlowType.medium;
      case MenstrualFlowTypeDto.heavy:
        return MenstrualFlowType.heavy;
    }
  }
}
