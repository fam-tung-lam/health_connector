import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show OvulationTestResultTypeDto;
import 'package:meta/meta.dart' show internal;

/// Converts [OvulationTestResultType] to [OvulationTestResultTypeDto].
@sinceV2_2_0
@internal
extension OvulationTestResultTypeToDto on OvulationTestResultType {
  OvulationTestResultTypeDto toDto() {
    switch (this) {
      case OvulationTestResultType.negative:
        return OvulationTestResultTypeDto.negative;
      case OvulationTestResultType.inconclusive:
        return OvulationTestResultTypeDto.inconclusive;
      case OvulationTestResultType.high:
        return OvulationTestResultTypeDto.high;
      case OvulationTestResultType.positive:
        return OvulationTestResultTypeDto.positive;
    }
  }
}

/// Converts [OvulationTestResultTypeDto] to [OvulationTestResultType].
@sinceV2_2_0
@internal
extension OvulationTestResultTypeDtoToDomain on OvulationTestResultTypeDto {
  OvulationTestResultType toDomain() {
    switch (this) {
      case OvulationTestResultTypeDto.negative:
        return OvulationTestResultType.negative;
      case OvulationTestResultTypeDto.inconclusive:
        return OvulationTestResultType.inconclusive;
      case OvulationTestResultTypeDto.high:
        return OvulationTestResultType.high;
      case OvulationTestResultTypeDto.positive:
        return OvulationTestResultType.positive;
    }
  }
}
