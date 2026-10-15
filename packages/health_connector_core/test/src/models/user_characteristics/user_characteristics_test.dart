import 'package:health_connector_core/health_connector_core.dart';
import 'package:parameterized_test/parameterized_test.dart';
import 'package:test/test.dart';

void main() {
  group('Gregorian birth dates', () {
    test('accepts leap days and compares component values', () {
      // Given a Gregorian leap day before the Unix epoch.
      final date = BirtDate(year: 1968, month: 2, day: 29);
      // When the same components are reconstructed.
      final same = date.copyWith();
      // Then date equality and hashing preserve the calendar date.
      expect(same, date);
      expect(same.hashCode, date.hashCode);
      expect([date.year, date.month, date.day], [1968, 2, 29]);
    });

    parameterizedTest(
      'rejects invalid components without exposing health values',
      [
        [1900, 2, 29],
        [2025, 2, 29],
        [2024, 2, 30],
        [2024, 0, 1],
        [2024, 13, 1],
        [2024, 1, 0],
        [0, 1, 1],
      ],
      (int year, int month, int day) {
        // Given invalid date components.
        // When constructing a date, then a redacted domain error is thrown.
        expect(
          () => BirtDate(year: year, month: month, day: day),
          throwsA(
            isA<InvalidArgumentException>().having(
              (error) => error.message,
              'message',
              'Invalid birth date components.',
            ),
          ),
        );
      },
    );
  });

  test('characteristic permissions have stable independent identities', () {
    // Given the two public descriptors.
    const birthDate = UserCharacteristicType.birthDate;
    const sex = UserCharacteristicType.biologicalSex;
    // When permissions are inserted repeatedly into a set.
    final permissions = {
      birthDate.readPermission,
      birthDate.readPermission,
      sex.readPermission,
    };
    // Then only duplicate identities collapse and support is iOS-only.
    expect(permissions, hasLength(2));
    expect(
      birthDate.healthPlatformRequirements.single,
      isA<AppleHealthRequirement>(),
    );
    expect(BiologicalSex.values, [
      BiologicalSex.female,
      BiologicalSex.male,
      BiologicalSex.other,
    ]);
  });
}
