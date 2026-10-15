import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/user_characteristic_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
import 'package:parameterized_test/parameterized_test.dart';

void main() {
  group('UserCharacteristicMapper', () {
    parameterizedTest(
      'maps characteristic descriptors to wire identifiers',
      [
        [UserCharacteristicType.birthDate, UserCharacteristicTypeDto.birthDate],
        [
          UserCharacteristicType.biologicalSex,
          UserCharacteristicTypeDto.biologicalSex,
        ],
      ],
      (
        UserCharacteristicType<Object> type,
        UserCharacteristicTypeDto expected,
      ) {
        // Given a public characteristic descriptor.
        // When converting it, then its stable wire identifier is returned.
        expect(type.toDto(), expected);
      },
    );

    parameterizedTest(
      'restores canonical characteristic descriptors',
      [
        [UserCharacteristicTypeDto.birthDate, UserCharacteristicType.birthDate],
        [
          UserCharacteristicTypeDto.biologicalSex,
          UserCharacteristicType.biologicalSex,
        ],
      ],
      (UserCharacteristicTypeDto dto, UserCharacteristicType<Object> expected) {
        // Given a wire characteristic identifier.
        // When converting it, then the canonical descriptor is returned.
        expect(dto.toDomain(), same(expected));
      },
    );

    group('BirtDateDtoToDomain', () {
      test('preserves Gregorian components before the Unix epoch', () {
        // Given a date-only native payload.
        final dto = BirtDateDto(year: 1968, month: 2, day: 29);
        // When converting it to the domain.
        final date = dto.toDomain();
        // Then its components remain unchanged.
        expect(date, BirtDate(year: 1968, month: 2, day: 29));
      });

      test('rejects impossible dates instead of normalizing them', () {
        // Given an impossible native Gregorian date.
        final dto = BirtDateDto(year: 2000, month: 2, day: 30);
        // When converting it, then the payload is rejected.
        expect(dto.toDomain, throwsA(isA<InvalidArgumentException>()));
      });
    });

    parameterizedTest(
      'maps biological sex to the domain enum',
      [
        [BiologicalSexDto.female, BiologicalSex.female],
        [BiologicalSexDto.male, BiologicalSex.male],
        [BiologicalSexDto.other, BiologicalSex.other],
      ],
      (BiologicalSexDto dto, BiologicalSex expected) {
        // Given a native biological-sex value.
        // When converting it, then the corresponding domain value is returned.
        expect(dto.toDomain(), expected);
      },
    );
  });
}
