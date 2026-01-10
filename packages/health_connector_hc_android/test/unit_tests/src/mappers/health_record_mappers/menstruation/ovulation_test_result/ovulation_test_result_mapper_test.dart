import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/menstruation/ovulation_test_result/ovulation_test_result_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';
import 'package:parameterized_test/parameterized_test.dart';

void main() {
  group(
    'OvulationTestResultTypeMapper',
    () {
      group(
        'OvulationTestResultToDto',
        () {
          parameterizedTest(
            'converts OvulationTestResultType to OvulationTestResultDto',
            [
              [
                OvulationTestResult.positive,
                OvulationTestResultDto.positive,
              ],
              [
                OvulationTestResult.negative,
                OvulationTestResultDto.negative,
              ],
              [
                OvulationTestResult.inconclusive,
                OvulationTestResultDto.inconclusive,
              ],
            ],
            (OvulationTestResult domain, OvulationTestResultDto dto) {
              expect(domain.toDto(), dto);
            },
          );
        },
      );

      group(
        'OvulationTestResultDtoToDomain',
        () {
          parameterizedTest(
            'converts OvulationTestResultDto to OvulationTestResultType',
            [
              [
                OvulationTestResultDto.positive,
                OvulationTestResult.positive,
              ],
              [
                OvulationTestResultDto.negative,
                OvulationTestResult.negative,
              ],
              [
                OvulationTestResultDto.inconclusive,
                OvulationTestResult.inconclusive,
              ],
            ],
            (OvulationTestResultDto dto, OvulationTestResult domain) {
              expect(dto.toDomain(), domain);
            },
          );
        },
      );
    },
  );
}
