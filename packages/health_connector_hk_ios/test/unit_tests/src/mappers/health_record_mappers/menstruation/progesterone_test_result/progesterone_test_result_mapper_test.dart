import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/menstruation/progesterone_test_result/progesterone_test_result_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';

void main() {
  group('ProgesteroneTestResultMapper', () {
    group('toDto', () {
      test('maps positive correctly', () {
        expect(
          ProgesteroneTestResult.positive.toDto(),
          ProgesteroneTestResultDto.positive,
        );
      });

      test('maps negative correctly', () {
        expect(
          ProgesteroneTestResult.negative.toDto(),
          ProgesteroneTestResultDto.negative,
        );
      });

      test('maps inconclusive correctly', () {
        expect(
          ProgesteroneTestResult.inconclusive.toDto(),
          ProgesteroneTestResultDto.inconclusive,
        );
      });
    });

    group('toDomain', () {
      test('maps positive correctly', () {
        expect(
          ProgesteroneTestResultDto.positive.toDomain(),
          ProgesteroneTestResult.positive,
        );
      });

      test('maps negative correctly', () {
        expect(
          ProgesteroneTestResultDto.negative.toDomain(),
          ProgesteroneTestResult.negative,
        );
      });

      test('maps inconclusive correctly', () {
        expect(
          ProgesteroneTestResultDto.inconclusive.toDomain(),
          ProgesteroneTestResult.inconclusive,
        );
      });
    });
  });
}
