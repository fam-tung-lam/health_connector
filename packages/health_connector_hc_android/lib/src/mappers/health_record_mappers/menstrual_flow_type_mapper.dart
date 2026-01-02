import 'package:health_connector_core/health_connector_core_internal.dart'
    show MenstrualFlowType, sinceV2_2_0;
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show MenstrualFlowTypeDto;
import 'package:meta/meta.dart' show internal;

@sinceV2_2_0
@internal
extension MenstrualFlowTypeToDtoExtension on MenstrualFlowType {
  MenstrualFlowTypeDto toDto() => switch (this) {
    MenstrualFlowType.unknown => MenstrualFlowTypeDto.unknown,
    MenstrualFlowType.light => MenstrualFlowTypeDto.light,
    MenstrualFlowType.medium => MenstrualFlowTypeDto.medium,
    MenstrualFlowType.heavy => MenstrualFlowTypeDto.heavy,
  };
}

@sinceV2_2_0
@internal
extension MenstrualFlowTypeDtoToDomain on MenstrualFlowTypeDto {
  MenstrualFlowType toDomain() => switch (this) {
    MenstrualFlowTypeDto.unknown => MenstrualFlowType.unknown,
    MenstrualFlowTypeDto.light => MenstrualFlowType.light,
    MenstrualFlowTypeDto.medium => MenstrualFlowType.medium,
    MenstrualFlowTypeDto.heavy => MenstrualFlowType.heavy,
  };
}
