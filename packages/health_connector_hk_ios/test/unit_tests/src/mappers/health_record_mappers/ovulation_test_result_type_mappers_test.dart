import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/ovulation_test_result_type_mappers.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
import 'package:parameterized_test/parameterized_test.dart';
import 'package:test/test.dart';

void main() {
  group(
    'OvulationTestResultTypeMapper',
    () {
      group(
        'OvulationTestResultTypeToDto',
        () {
          parameterizedTest(
            'converts OvulationTestResultType to OvulationTestResultTypeDto',
            [
              [
                OvulationTestResultType.negative,
                OvulationTestResultTypeDto.negative,
              ],
              [
                OvulationTestResultType.inconclusive,
                OvulationTestResultTypeDto.inconclusive,
              ],
              [
                OvulationTestResultType.high,
                OvulationTestResultTypeDto.high,
              ],
              [
                OvulationTestResultType.positive,
                OvulationTestResultTypeDto.positive,
              ],
            ],
            (OvulationTestResultType domain, OvulationTestResultTypeDto dto) {
              expect(domain.toDto(), dto);
            },
          );
        },
      );

      group(
        'OvulationTestResultTypeDtoToDomain',
        () {
          parameterizedTest(
            'converts OvulationTestResultTypeDto to OvulationTestResultType',
            [
              [
                OvulationTestResultTypeDto.negative,
                OvulationTestResultType.negative,
              ],
              [
                OvulationTestResultTypeDto.inconclusive,
                OvulationTestResultType.inconclusive,
              ],
              [
                OvulationTestResultTypeDto.high,
                OvulationTestResultType.high,
              ],
              [
                OvulationTestResultTypeDto.positive,
                OvulationTestResultType.positive,
              ],
            ],
            (OvulationTestResultTypeDto dto, OvulationTestResultType domain) {
              expect(dto.toDomain(), domain);
            },
          );
        },
      );
    },
  );
}
