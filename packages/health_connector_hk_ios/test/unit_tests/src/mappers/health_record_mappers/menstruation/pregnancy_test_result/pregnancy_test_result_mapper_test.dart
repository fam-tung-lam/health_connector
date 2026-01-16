import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/menstruation/pregnancy_test_result/pregnancy_test_result_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';

void main() {
  group('PregnancyTestResultMapper', () {
    group('toDto', () {
      test('maps positive correctly', () {
        expect(
          PregnancyTestResult.positive.toDto(),
          PregnancyTestResultDto.positive,
        );
      });

      test('maps negative correctly', () {
        expect(
          PregnancyTestResult.negative.toDto(),
          PregnancyTestResultDto.negative,
        );
      });

      test('maps inconclusive correctly', () {
        expect(
          PregnancyTestResult.inconclusive.toDto(),
          PregnancyTestResultDto.inconclusive,
        );
      });
    });

    group('toDomain', () {
      test('maps positive correctly', () {
        expect(
          PregnancyTestResultDto.positive.toDomain(),
          PregnancyTestResult.positive,
        );
      });

      test('maps negative correctly', () {
        expect(
          PregnancyTestResultDto.negative.toDomain(),
          PregnancyTestResult.negative,
        );
      });

      test('maps inconclusive correctly', () {
        expect(
          PregnancyTestResultDto.inconclusive.toDomain(),
          PregnancyTestResult.inconclusive,
        );
      });
    });
  });
}
