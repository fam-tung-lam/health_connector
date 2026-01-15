import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
import 'package:meta/meta.dart' show internal;

/// Extension to convert [ProgesteroneTestResult] to
/// [ProgesteroneTestResultDto].
@sinceV3_1_0
@internal
extension ProgesteroneTestResultToDto on ProgesteroneTestResult {
  /// Converts [ProgesteroneTestResult] to [ProgesteroneTestResultDto].
  ProgesteroneTestResultDto toDto() {
    switch (this) {
      case ProgesteroneTestResult.positive:
        return ProgesteroneTestResultDto.positive;
      case ProgesteroneTestResult.negative:
        return ProgesteroneTestResultDto.negative;
      case ProgesteroneTestResult.inconclusive:
        return ProgesteroneTestResultDto.inconclusive;
    }
  }
}

/// Extension to convert [ProgesteroneTestResultDto] to
/// [ProgesteroneTestResult].
@sinceV3_1_0
@internal
extension ProgesteroneTestResultDtoToDomain on ProgesteroneTestResultDto {
  /// Converts [ProgesteroneTestResultDto] to [ProgesteroneTestResult].
  ProgesteroneTestResult toDomain() {
    switch (this) {
      case ProgesteroneTestResultDto.positive:
        return ProgesteroneTestResult.positive;
      case ProgesteroneTestResultDto.negative:
        return ProgesteroneTestResult.negative;
      case ProgesteroneTestResultDto.inconclusive:
        return ProgesteroneTestResult.inconclusive;
    }
  }
}
