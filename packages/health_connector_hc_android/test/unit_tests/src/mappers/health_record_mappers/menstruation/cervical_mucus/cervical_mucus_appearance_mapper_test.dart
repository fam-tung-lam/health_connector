import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hc_android/src/mappers/health_record_mappers/menstruation/cervical_mucus/cervical_mucus_appearance_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';
import 'package:parameterized_test/parameterized_test.dart';

void main() {
  group(
    'CervicalMucusAppearanceTypeMapper',
    () {
      group(
        'CervicalMucusAppearanceToDto',
        () {
          parameterizedTest(
            'converts CervicalMucusAppearance to '
            'CervicalMucusAppearanceDto',
            [
              [
                CervicalMucusAppearance.unknown,
                CervicalMucusAppearanceDto.unknown,
              ],
              [
                CervicalMucusAppearance.dry,
                CervicalMucusAppearanceDto.dry,
              ],
              [
                CervicalMucusAppearance.sticky,
                CervicalMucusAppearanceDto.sticky,
              ],
              [
                CervicalMucusAppearance.creamy,
                CervicalMucusAppearanceDto.creamy,
              ],
              [
                CervicalMucusAppearance.watery,
                CervicalMucusAppearanceDto.watery,
              ],
              [
                CervicalMucusAppearance.eggWhite,
                CervicalMucusAppearanceDto.eggWhite,
              ],
              [
                CervicalMucusAppearance.unusual,
                CervicalMucusAppearanceDto.unusual,
              ],
            ],
            (
              CervicalMucusAppearance domain,
              CervicalMucusAppearanceDto dto,
            ) {
              expect(domain.toDto(), dto);
            },
          );
        },
      );

      group(
        'CervicalMucusAppearanceDtoToDomain',
        () {
          parameterizedTest(
            'converts CervicalMucusAppearanceDto to '
            'CervicalMucusAppearance',
            [
              [
                CervicalMucusAppearanceDto.unknown,
                CervicalMucusAppearance.unknown,
              ],
              [
                CervicalMucusAppearanceDto.dry,
                CervicalMucusAppearance.dry,
              ],
              [
                CervicalMucusAppearanceDto.sticky,
                CervicalMucusAppearance.sticky,
              ],
              [
                CervicalMucusAppearanceDto.creamy,
                CervicalMucusAppearance.creamy,
              ],
              [
                CervicalMucusAppearanceDto.watery,
                CervicalMucusAppearance.watery,
              ],
              [
                CervicalMucusAppearanceDto.eggWhite,
                CervicalMucusAppearance.eggWhite,
              ],
              [
                CervicalMucusAppearanceDto.unusual,
                CervicalMucusAppearance.unusual,
              ],
            ],
            (
              CervicalMucusAppearanceDto dto,
              CervicalMucusAppearance domain,
            ) {
              expect(dto.toDomain(), domain);
            },
          );
        },
      );
    },
  );
}
