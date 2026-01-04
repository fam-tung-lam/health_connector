import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/sexual_activity_protection_used_type_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
import 'package:parameterized_test/parameterized_test.dart';
import 'package:test/test.dart';

void main() {
  group(
    'SexualActivityProtectionUsedTypeMapper',
    () {
      group(
        'SexualActivityProtectionUsedTypeToDto',
        () {
          parameterizedTest(
            'converts SexualActivityProtectionUsedType to '
            'SexualActivityProtectionUsedTypeDto',
            [
              [
                SexualActivityProtectionUsedType.protected,
                SexualActivityProtectionUsedTypeDto.protected,
              ],
              [
                SexualActivityProtectionUsedType.unprotected,
                SexualActivityProtectionUsedTypeDto.unprotected,
              ],
              [
                SexualActivityProtectionUsedType.unknown,
                SexualActivityProtectionUsedTypeDto.unknown,
              ],
            ],
            (
              SexualActivityProtectionUsedType domain,
              SexualActivityProtectionUsedTypeDto dto,
            ) {
              expect(domain.toDto(), dto);
            },
          );
        },
      );

      group(
        'SexualActivityProtectionUsedTypeDtoToDomain',
        () {
          parameterizedTest(
            'converts SexualActivityProtectionUsedTypeDto to '
            'SexualActivityProtectionUsedType',
            [
              [
                SexualActivityProtectionUsedTypeDto.protected,
                SexualActivityProtectionUsedType.protected,
              ],
              [
                SexualActivityProtectionUsedTypeDto.unprotected,
                SexualActivityProtectionUsedType.unprotected,
              ],
              [
                SexualActivityProtectionUsedTypeDto.unknown,
                SexualActivityProtectionUsedType.unknown,
              ],
            ],
            (
              SexualActivityProtectionUsedTypeDto dto,
              SexualActivityProtectionUsedType domain,
            ) {
              expect(dto.toDomain(), domain);
            },
          );
        },
      );
    },
  );
}
