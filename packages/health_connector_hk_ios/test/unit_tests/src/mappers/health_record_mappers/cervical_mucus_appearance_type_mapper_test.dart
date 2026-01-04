import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/cervical_mucus_appearance_type_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
import 'package:parameterized_test/parameterized_test.dart';
import 'package:test/test.dart';

void main() {
  group(
    'CervicalMucusAppearanceTypeMapper',
    () {
      group(
        'CervicalMucusAppearanceTypeToDto',
        () {
          parameterizedTest(
            'converts CervicalMucusAppearanceType to '
            'CervicalMucusAppearanceTypeDto',
            [
              [
                CervicalMucusAppearanceType.unknown,
                CervicalMucusAppearanceTypeDto.unknown,
              ],
              [
                CervicalMucusAppearanceType.dry,
                CervicalMucusAppearanceTypeDto.dry,
              ],
              [
                CervicalMucusAppearanceType.sticky,
                CervicalMucusAppearanceTypeDto.sticky,
              ],
              [
                CervicalMucusAppearanceType.creamy,
                CervicalMucusAppearanceTypeDto.creamy,
              ],
              [
                CervicalMucusAppearanceType.watery,
                CervicalMucusAppearanceTypeDto.watery,
              ],
              [
                CervicalMucusAppearanceType.eggWhite,
                CervicalMucusAppearanceTypeDto.eggWhite,
              ],
              [
                CervicalMucusAppearanceType.unusual,
                CervicalMucusAppearanceTypeDto.unusual,
              ],
            ],
            (
              CervicalMucusAppearanceType domain,
              CervicalMucusAppearanceTypeDto dto,
            ) {
              expect(domain.toDto(), dto);
            },
          );
        },
      );

      group(
        'CervicalMucusAppearanceTypeDtoToDomain',
        () {
          parameterizedTest(
            'converts CervicalMucusAppearanceTypeDto to '
            'CervicalMucusAppearanceType',
            [
              [
                CervicalMucusAppearanceTypeDto.unknown,
                CervicalMucusAppearanceType.unknown,
              ],
              [
                CervicalMucusAppearanceTypeDto.dry,
                CervicalMucusAppearanceType.dry,
              ],
              [
                CervicalMucusAppearanceTypeDto.sticky,
                CervicalMucusAppearanceType.sticky,
              ],
              [
                CervicalMucusAppearanceTypeDto.creamy,
                CervicalMucusAppearanceType.creamy,
              ],
              [
                CervicalMucusAppearanceTypeDto.watery,
                CervicalMucusAppearanceType.watery,
              ],
              [
                CervicalMucusAppearanceTypeDto.eggWhite,
                CervicalMucusAppearanceType.eggWhite,
              ],
              [
                CervicalMucusAppearanceTypeDto.unusual,
                CervicalMucusAppearanceType.unusual,
              ],
            ],
            (
              CervicalMucusAppearanceTypeDto dto,
              CervicalMucusAppearanceType domain,
            ) {
              expect(dto.toDomain(), domain);
            },
          );
        },
      );
    },
  );
}
