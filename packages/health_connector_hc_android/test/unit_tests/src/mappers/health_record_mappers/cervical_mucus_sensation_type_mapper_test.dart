import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/cervical_mucus_sensation_type_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';
import 'package:parameterized_test/parameterized_test.dart';
import 'package:test/test.dart';

void main() {
  group(
    'CervicalMucusSensationTypeMapper',
    () {
      group(
        'CervicalMucusSensationTypeToDto',
        () {
          parameterizedTest(
            'converts CervicalMucusSensationType to '
            'CervicalMucusSensationTypeDto',
            [
              [
                CervicalMucusSensationType.unknown,
                CervicalMucusSensationTypeDto.unknown,
              ],
              [
                CervicalMucusSensationType.light,
                CervicalMucusSensationTypeDto.light,
              ],
              [
                CervicalMucusSensationType.medium,
                CervicalMucusSensationTypeDto.medium,
              ],
              [
                CervicalMucusSensationType.heavy,
                CervicalMucusSensationTypeDto.heavy,
              ],
            ],
            (
              CervicalMucusSensationType domain,
              CervicalMucusSensationTypeDto dto,
            ) {
              expect(domain.toDto(), dto);
            },
          );
        },
      );

      group(
        'CervicalMucusSensationTypeDtoToDomain',
        () {
          parameterizedTest(
            'converts CervicalMucusSensationTypeDto to '
            'CervicalMucusSensationType',
            [
              [
                CervicalMucusSensationTypeDto.unknown,
                CervicalMucusSensationType.unknown,
              ],
              [
                CervicalMucusSensationTypeDto.light,
                CervicalMucusSensationType.light,
              ],
              [
                CervicalMucusSensationTypeDto.medium,
                CervicalMucusSensationType.medium,
              ],
              [
                CervicalMucusSensationTypeDto.heavy,
                CervicalMucusSensationType.heavy,
              ],
            ],
            (
              CervicalMucusSensationTypeDto dto,
              CervicalMucusSensationType domain,
            ) {
              expect(dto.toDomain(), domain);
            },
          );
        },
      );
    },
  );
}
