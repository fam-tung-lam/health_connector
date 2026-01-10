import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/sexual_activity/sexual_activity_protection_used_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
import 'package:parameterized_test/parameterized_test.dart';

void main() {
  group(
    'SexualActivityProtectionUsedTypeMapper',
    () {
      group(
        'SexualActivityProtectionUsedToDto',
        () {
          parameterizedTest(
            'converts SexualActivityProtectionUsedType to '
            'SexualActivityProtectionUsedDto',
            [
              [
                SexualActivityProtectionUsed.protected,
                SexualActivityProtectionUsedDto.protected,
              ],
              [
                SexualActivityProtectionUsed.unprotected,
                SexualActivityProtectionUsedDto.unprotected,
              ],
              [
                SexualActivityProtectionUsed.unknown,
                SexualActivityProtectionUsedDto.unknown,
              ],
            ],
            (
              SexualActivityProtectionUsed domain,
              SexualActivityProtectionUsedDto dto,
            ) {
              expect(domain.toDto(), dto);
            },
          );
        },
      );

      group(
        'SexualActivityProtectionUsedDtoToDomain',
        () {
          parameterizedTest(
            'converts SexualActivityProtectionUsedDto to '
            'SexualActivityProtectionUsedType',
            [
              [
                SexualActivityProtectionUsedDto.protected,
                SexualActivityProtectionUsed.protected,
              ],
              [
                SexualActivityProtectionUsedDto.unprotected,
                SexualActivityProtectionUsed.unprotected,
              ],
              [
                SexualActivityProtectionUsedDto.unknown,
                SexualActivityProtectionUsed.unknown,
              ],
            ],
            (
              SexualActivityProtectionUsedDto dto,
              SexualActivityProtectionUsed domain,
            ) {
              expect(dto.toDomain(), domain);
            },
          );
        },
      );
    },
  );
}
