import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/measurement_unit_mappers/number_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';

void main() {
  group(
    'NumberMapper',
    () {
      group(
        'NumberToDto',
        () {
          test(
            'converts Number to NumberDto',
            () {
              const number = Number(12345.67);
              final dto = number.toDto();

              expect(dto.value, 12345.67);
            },
          );
        },
      );

      group(
        'NumberDtoToDomain',
        () {
          test(
            'maps NumberDto to Number',
            () {
              final dto = NumberDto(value: 9876.54);
              final number = dto.toDomain();

              expect(number.value, 9876.54);
            },
          );
        },
      );
    },
  );
}
