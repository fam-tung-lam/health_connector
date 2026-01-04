import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/menstruation/ovulation_test_result_type_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';
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
                OvulationTestResultType.positive,
                OvulationTestResultTypeDto.positive,
              ],
              [
                OvulationTestResultType.negative,
                OvulationTestResultTypeDto.negative,
              ],
              [
                OvulationTestResultType.inconclusive,
                OvulationTestResultTypeDto.inconclusive,
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
                OvulationTestResultTypeDto.positive,
                OvulationTestResultType.positive,
              ],
              [
                OvulationTestResultTypeDto.negative,
                OvulationTestResultType.negative,
              ],
              [
                OvulationTestResultTypeDto.inconclusive,
                OvulationTestResultType.inconclusive,
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
