import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/measurement_unit_mappers/number_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';
import 'package:parameterized_test/parameterized_test.dart';
import 'package:test/test.dart';

void main() {
  group(
    'NumberMapper',
    () {
      group(
        'NumberToDto',
        () {
          parameterizedTest(
            'maps Number to NumberDto',
            [
              [0],
              [42],
              [100],
              [1234567],
            ],
            (num value) {
              final number = Number(value);
              final dto = number.toDto();

              expect(dto.value, value.toDouble());
            },
          );
        },
      );

      group(
        'NumberDtoToDomain',
        () {
          parameterizedTest(
            'maps NumberDto to Number',
            [
              [0.0],
              [42.0],
              [100.5],
              [1234567.89],
            ],
            (double value) {
              final dto = NumberDto(value: value);
              final number = dto.toDomain();

              expect(number.value, value);
            },
          );
        },
      );
    },
  );
}
