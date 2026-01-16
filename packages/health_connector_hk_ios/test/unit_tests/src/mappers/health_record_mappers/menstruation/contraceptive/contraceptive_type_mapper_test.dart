import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/menstruation/contraceptive/contraceptive_type_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';

void main() {
  group('ContraceptiveTypeMapper', () {
    group('toDto', () {
      test('maps correctly', () {
        expect(
          ContraceptiveType.unknown.toDto(),
          ContraceptiveTypeDto.unknown,
        );
        expect(
          ContraceptiveType.implant.toDto(),
          ContraceptiveTypeDto.implant,
        );
        expect(
          ContraceptiveType.injection.toDto(),
          ContraceptiveTypeDto.injection,
        );
        expect(
          ContraceptiveType.intrauterineDevice.toDto(),
          ContraceptiveTypeDto.intrauterineDevice,
        );
        expect(
          ContraceptiveType.intravaginalRing.toDto(),
          ContraceptiveTypeDto.intravaginalRing,
        );
        expect(
          ContraceptiveType.oral.toDto(),
          ContraceptiveTypeDto.oral,
        );
        expect(
          ContraceptiveType.patch.toDto(),
          ContraceptiveTypeDto.patch,
        );
      });
    });

    group('toDomain', () {
      test('maps correctly', () {
        expect(
          ContraceptiveTypeDto.unknown.toDomain(),
          ContraceptiveType.unknown,
        );
        expect(
          ContraceptiveTypeDto.implant.toDomain(),
          ContraceptiveType.implant,
        );
        expect(
          ContraceptiveTypeDto.injection.toDomain(),
          ContraceptiveType.injection,
        );
        expect(
          ContraceptiveTypeDto.intrauterineDevice.toDomain(),
          ContraceptiveType.intrauterineDevice,
        );
        expect(
          ContraceptiveTypeDto.intravaginalRing.toDomain(),
          ContraceptiveType.intravaginalRing,
        );
        expect(
          ContraceptiveTypeDto.oral.toDomain(),
          ContraceptiveType.oral,
        );
        expect(
          ContraceptiveTypeDto.patch.toDomain(),
          ContraceptiveType.patch,
        );
      });
    });
  });
}
