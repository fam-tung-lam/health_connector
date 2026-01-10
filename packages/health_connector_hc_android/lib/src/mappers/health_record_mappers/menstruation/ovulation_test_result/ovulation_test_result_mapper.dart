import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart'
    show OvulationTestResultDto;
import 'package:meta/meta.dart' show internal;

/// Converts [OvulationTestResult] to [OvulationTestResultDto].
@sinceV2_2_0
@internal
extension OvulationTestResultToDto on OvulationTestResult {
  OvulationTestResultDto toDto() {
    switch (this) {
      case OvulationTestResult.negative:
        return OvulationTestResultDto.negative;
      case OvulationTestResult.inconclusive:
        return OvulationTestResultDto.inconclusive;
      case OvulationTestResult.high:
        return OvulationTestResultDto.high;
      case OvulationTestResult.positive:
        return OvulationTestResultDto.positive;
    }
  }
}

/// Converts [OvulationTestResultDto] to [OvulationTestResult].
@sinceV2_2_0
@internal
extension OvulationTestResultDtoToDomain on OvulationTestResultDto {
  OvulationTestResult toDomain() {
    switch (this) {
      case OvulationTestResultDto.negative:
        return OvulationTestResult.negative;
      case OvulationTestResultDto.inconclusive:
        return OvulationTestResult.inconclusive;
      case OvulationTestResultDto.high:
        return OvulationTestResult.high;
      case OvulationTestResultDto.positive:
        return OvulationTestResult.positive;
    }
  }
}
