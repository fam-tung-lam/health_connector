import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/measurement_unit_mappers/length_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';

void main() {
  group(
    'LengthMapper',
    () {
      group(
        'LengthToDto',
        () {
          test(
            'converts Length to LengthDto in meters',
            () {
              const length = Length.meters(1.75);
              final dto = length.toDto();

              expect(dto.meters, 1.75);
            },
          );

          test(
            'converts Length from centimeters to meters',
            () {
              const length = Length.centimeters(175.0);
              final dto = length.toDto();

              expect(dto.meters, 1.75);
            },
          );
        },
      );

      group(
        'LengthDtoToDomain',
        () {
          test(
            'maps LengthDto to Length',
            () {
              const value = 1.75;
              final dto = LengthDto(meters: value);
              final length = dto.toDomain();

              expect(length.inMeters, value);
            },
          );
        },
      );
    },
  );
}
