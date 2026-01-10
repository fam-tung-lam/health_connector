import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/menstruation/cervical_mucus/cervical_mucus_sensation_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
import 'package:parameterized_test/parameterized_test.dart';

void main() {
  group(
    'CervicalMucusSensationMapper',
    () {
      group(
        'CervicalMucusSensationToDto',
        () {
          parameterizedTest(
            'converts CervicalMucusSensation to '
            'CervicalMucusSensationDto',
            [
              [
                CervicalMucusSensation.unknown,
                CervicalMucusSensationDto.unknown,
              ],
              [
                CervicalMucusSensation.light,
                CervicalMucusSensationDto.light,
              ],
              [
                CervicalMucusSensation.medium,
                CervicalMucusSensationDto.medium,
              ],
              [
                CervicalMucusSensation.heavy,
                CervicalMucusSensationDto.heavy,
              ],
            ],
            (
              CervicalMucusSensation domain,
              CervicalMucusSensationDto dto,
            ) {
              expect(domain.toDto(), dto);
            },
          );
        },
      );

      group(
        'CervicalMucusSensationDtoToDomain',
        () {
          parameterizedTest(
            'converts CervicalMucusSensationDto to '
            'CervicalMucusSensation',
            [
              [
                CervicalMucusSensationDto.unknown,
                CervicalMucusSensation.unknown,
              ],
              [
                CervicalMucusSensationDto.light,
                CervicalMucusSensation.light,
              ],
              [
                CervicalMucusSensationDto.medium,
                CervicalMucusSensation.medium,
              ],
              [
                CervicalMucusSensationDto.heavy,
                CervicalMucusSensation.heavy,
              ],
            ],
            (
              CervicalMucusSensationDto dto,
              CervicalMucusSensation domain,
            ) {
              expect(dto.toDomain(), domain);
            },
          );
        },
      );
    },
  );
}
