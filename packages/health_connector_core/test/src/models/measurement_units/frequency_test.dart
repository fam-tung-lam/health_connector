import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:test/test.dart';

void main() {
  group(
    'Frequency',
    () {
      group(
        'perMinute constructor',
        () {
          test(
            'creates frequency from valid perMinute value',
            () {
              final frequency = Frequency.perMinute(72);
              expect(frequency.inPerMinute, 72);
            },
          );

          test(
            'throws ArgumentError for NaN value',
            () {
              expect(
                () => Frequency.perMinute(double.nan),
                throwsA(
                  isA<ArgumentError>().having(
                    (e) => e.message,
                    'message',
                    'Frequency cannot be NaN',
                  ),
                ),
              );
            },
          );

          test(
            'throws ArgumentError for infinite value',
            () {
              expect(
                () => Frequency.perMinute(double.infinity),
                throwsA(
                  isA<ArgumentError>().having(
                    (e) => e.message,
                    'message',
                    'Frequency cannot be infinite',
                  ),
                ),
              );
            },
          );

          test(
            'throws ArgumentError for negative value',
            () {
              expect(
                () => Frequency.perMinute(-10),
                throwsA(
                  isA<ArgumentError>().having(
                    (e) => e.message,
                    'message',
                    'Frequency must be non-negative',
                  ),
                ),
              );
            },
          );

          test(
            'accepts zero value',
            () {
              final frequency = Frequency.perMinute(0);
              expect(frequency.inPerMinute, 0);
            },
          );
        },
      );

      group(
        'perSecond constructor',
        () {
          test(
            'creates frequency from valid perSecond value',
            () {
              final frequency = Frequency.perSecond(1.2);
              expect(frequency.inPerMinute, 72);
            },
          );

          test(
            'converts perSecond to perMinute correctly',
            () {
              final frequency = Frequency.perSecond(2.0);
              expect(frequency.inPerMinute, 120);
              expect(frequency.inPerSecond, 2.0);
            },
          );

          test(
            'throws ArgumentError for NaN value',
            () {
              expect(
                () => Frequency.perSecond(double.nan),
                throwsA(
                  isA<ArgumentError>().having(
                    (e) => e.message,
                    'message',
                    'Frequency cannot be NaN',
                  ),
                ),
              );
            },
          );

          test(
            'throws ArgumentError for infinite value',
            () {
              expect(
                () => Frequency.perSecond(double.infinity),
                throwsA(
                  isA<ArgumentError>().having(
                    (e) => e.message,
                    'message',
                    'Frequency cannot be infinite',
                  ),
                ),
              );
            },
          );

          test(
            'throws ArgumentError for negative value',
            () {
              expect(
                () => Frequency.perSecond(-5),
                throwsA(
                  isA<ArgumentError>().having(
                    (e) => e.message,
                    'message',
                    'Frequency must be non-negative',
                  ),
                ),
              );
            },
          );
        },
      );

      group(
        'zero constant',
        () {
          test(
            'has zero value',
            () {
              expect(Frequency.zero.inPerMinute, 0);
              expect(Frequency.zero.inPerSecond, 0);
            },
          );
        },
      );

      group(
        'getters',
        () {
          test(
            'inPerMinute returns frequency in events per minute',
            () {
              final frequency = Frequency.perMinute(72);
              expect(frequency.inPerMinute, 72);
            },
          );

          test(
            'inPerSecond returns frequency in events per second',
            () {
              final frequency = Frequency.perMinute(72);
              expect(frequency.inPerSecond, 1.2);
            },
          );

          test(
            'inHertz returns same value as inPerSecond',
            () {
              final frequency = Frequency.perMinute(60);
              expect(frequency.inHertz, frequency.inPerSecond);
              expect(frequency.inHertz, 1.0);
            },
          );
        },
      );

      group(
        'arithmetic operators',
        () {
          test(
            'addition operator combines frequencies',
            () {
              final freq1 = Frequency.perMinute(60);
              final freq2 = Frequency.perMinute(12);
              final result = freq1 + freq2;

              expect(result.inPerMinute, 72);
            },
          );

          test(
            'subtraction operator subtracts frequencies',
            () {
              final freq1 = Frequency.perMinute(80);
              final freq2 = Frequency.perMinute(8);
              final result = freq1 - freq2;

              expect(result.inPerMinute, 72);
            },
          );
        },
      );

      group(
        'comparison operators',
        () {
          test(
            'greater than operator compares correctly',
            () {
              final freq1 = Frequency.perMinute(80);
              final freq2 = Frequency.perMinute(60);

              expect(freq1 > freq2, isTrue);
              expect(freq2 > freq1, isFalse);
            },
          );

          test(
            'less than operator compares correctly',
            () {
              final freq1 = Frequency.perMinute(60);
              final freq2 = Frequency.perMinute(80);

              expect(freq1 < freq2, isTrue);
              expect(freq2 < freq1, isFalse);
            },
          );

          test(
            'greater than or equal operator compares correctly',
            () {
              final freq1 = Frequency.perMinute(72);
              final freq2 = Frequency.perMinute(72);
              final freq3 = Frequency.perMinute(60);

              expect(freq1 >= freq2, isTrue);
              expect(freq1 >= freq3, isTrue);
              expect(freq3 >= freq1, isFalse);
            },
          );

          test(
            'less than or equal operator compares correctly',
            () {
              final freq1 = Frequency.perMinute(72);
              final freq2 = Frequency.perMinute(72);
              final freq3 = Frequency.perMinute(80);

              expect(freq1 <= freq2, isTrue);
              expect(freq1 <= freq3, isTrue);
              expect(freq3 <= freq1, isFalse);
            },
          );
        },
      );

      group(
        'equality',
        () {
          test(
            'equal frequencies are equal',
            () {
              final freq1 = Frequency.perMinute(72);
              final freq2 = Frequency.perMinute(72);

              expect(freq1, equals(freq2));
            },
          );

          test(
            'frequencies within tolerance are equal',
            () {
              final freq1 = Frequency.perMinute(72.0);
              final freq2 = Frequency.perMinute(72.05);

              expect(freq1, equals(freq2));
            },
          );

          test(
            'frequencies outside tolerance are not equal',
            () {
              final freq1 = Frequency.perMinute(72.0);
              final freq2 = Frequency.perMinute(72.2);

              expect(freq1, isNot(equals(freq2)));
            },
          );

          test(
            'different frequencies are not equal',
            () {
              final freq1 = Frequency.perMinute(72);
              final freq2 = Frequency.perMinute(80);

              expect(freq1, isNot(equals(freq2)));
            },
          );

          test(
            'identical instances are equal',
            () {
              final freq = Frequency.perMinute(72);

              expect(freq, equals(freq));
            },
          );
        },
      );

      group(
        'hashCode',
        () {
          test(
            'equal frequencies have same hash code',
            () {
              final freq1 = Frequency.perMinute(72);
              final freq2 = Frequency.perMinute(72);

              expect(freq1.hashCode, equals(freq2.hashCode));
            },
          );

          test(
            'frequencies within tolerance have same hash code',
            () {
              final freq1 = Frequency.perMinute(72.0);
              final freq2 = Frequency.perMinute(72.05);

              expect(freq1.hashCode, equals(freq2.hashCode));
            },
          );
        },
      );

      group(
        'compareTo',
        () {
          test(
            'returns 0 for equal frequencies',
            () {
              final freq1 = Frequency.perMinute(72);
              final freq2 = Frequency.perMinute(72);

              expect(freq1.compareTo(freq2), 0);
            },
          );

          test(
            'returns negative for smaller frequency',
            () {
              final freq1 = Frequency.perMinute(60);
              final freq2 = Frequency.perMinute(80);

              expect(freq1.compareTo(freq2), lessThan(0));
            },
          );

          test(
            'returns positive for larger frequency',
            () {
              final freq1 = Frequency.perMinute(80);
              final freq2 = Frequency.perMinute(60);

              expect(freq1.compareTo(freq2), greaterThan(0));
            },
          );
        },
      );

      group(
        'toString',
        () {
          test(
            'formats frequency with one decimal place',
            () {
              final frequency = Frequency.perMinute(72);
              expect(frequency.toString(), '72.0 per min');
            },
          );

          test(
            'formats decimal frequency with one decimal place',
            () {
              final frequency = Frequency.perSecond(1.25);
              expect(frequency.toString(), '75.0 per min');
            },
          );

          test(
            'formats zero frequency',
            () {
              expect(Frequency.zero.toString(), '0.0 per min');
            },
          );
        },
      );
    },
  );
}
