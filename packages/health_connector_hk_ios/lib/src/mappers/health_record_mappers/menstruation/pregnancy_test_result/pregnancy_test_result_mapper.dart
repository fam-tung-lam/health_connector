import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart'
    show PregnancyTestResultDto;
import 'package:meta/meta.dart' show internal;

/// Converts [PregnancyTestResult] to [PregnancyTestResultDto].
@sinceV3_1_0
@internal
extension PregnancyTestResultToDto on PregnancyTestResult {
  PregnancyTestResultDto toDto() {
    switch (this) {
      case PregnancyTestResult.positive:
        return PregnancyTestResultDto.positive;
      case PregnancyTestResult.negative:
        return PregnancyTestResultDto.negative;
      case PregnancyTestResult.inconclusive:
        return PregnancyTestResultDto.inconclusive;
    }
  }
}

/// Converts [PregnancyTestResultDto] to [PregnancyTestResult].
@sinceV3_1_0
@internal
extension PregnancyTestResultDtoToDomain on PregnancyTestResultDto {
  PregnancyTestResult toDomain() {
    switch (this) {
      case PregnancyTestResultDto.positive:
        return PregnancyTestResult.positive;
      case PregnancyTestResultDto.negative:
        return PregnancyTestResult.negative;
      case PregnancyTestResultDto.inconclusive:
        return PregnancyTestResult.inconclusive;
    }
  }
}
