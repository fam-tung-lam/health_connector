import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:test/test.dart';

import '../../../../utils/fake_data.dart';

void main() {
  group('ExerciseRouteLocation', () {
    group('constructor', () {
      test('creates location with required parameters', () {
        final location = ExerciseRouteLocation(
          time: FakeData.fakeStartTime,
          latitude: FakeData.fakeLatitude,
          longitude: FakeData.fakeLongitude,
        );

        expect(location.time, FakeData.fakeStartTime);
        expect(location.latitude, FakeData.fakeLatitude);
        expect(location.longitude, FakeData.fakeLongitude);
        expect(location.altitude, isNull);
        expect(location.horizontalAccuracy, isNull);
        expect(location.verticalAccuracy, isNull);
      });

      test('creates location with all optional parameters', () {
        const altitude = Length.meters(FakeData.fakeAltitudeInMeters);
        const horizontalAccuracy = Length.meters(
          FakeData.fakeHorizontalAccuracyInMeters,
        );
        const verticalAccuracy = Length.meters(
          FakeData.fakeVerticalAccuracyInMeters,
        );

        final location = ExerciseRouteLocation(
          time: FakeData.fakeStartTime,
          latitude: FakeData.fakeLatitude,
          longitude: FakeData.fakeLongitude,
          altitude: altitude,
          horizontalAccuracy: horizontalAccuracy,
          verticalAccuracy: verticalAccuracy,
        );

        expect(location.altitude, altitude);
        expect(location.horizontalAccuracy, horizontalAccuracy);
        expect(location.verticalAccuracy, verticalAccuracy);
      });

      group('validation', () {
        test('throws ArgumentError when latitude is below -90', () {
          expect(
            () => ExerciseRouteLocation(
              time: FakeData.fakeStartTime,
              latitude: -90.1,
              longitude: FakeData.fakeLongitude,
            ),
            throwsA(
              isA<ArgumentError>().having(
                (e) => e.name,
                'name',
                'latitude',
              ),
            ),
          );
        });

        test('throws ArgumentError when latitude is above 90', () {
          expect(
            () => ExerciseRouteLocation(
              time: FakeData.fakeStartTime,
              latitude: 90.1,
              longitude: FakeData.fakeLongitude,
            ),
            throwsA(
              isA<ArgumentError>().having(
                (e) => e.name,
                'name',
                'latitude',
              ),
            ),
          );
        });

        test('accepts latitude at boundary -90', () {
          final location = ExerciseRouteLocation(
            time: FakeData.fakeStartTime,
            latitude: -90.0,
            longitude: FakeData.fakeLongitude,
          );
          expect(location.latitude, -90.0);
        });

        test('accepts latitude at boundary 90', () {
          final location = ExerciseRouteLocation(
            time: FakeData.fakeStartTime,
            latitude: 90.0,
            longitude: FakeData.fakeLongitude,
          );
          expect(location.latitude, 90.0);
        });

        test('throws ArgumentError when longitude is below -180', () {
          expect(
            () => ExerciseRouteLocation(
              time: FakeData.fakeStartTime,
              latitude: FakeData.fakeLatitude,
              longitude: -180.1,
            ),
            throwsA(
              isA<ArgumentError>().having(
                (e) => e.name,
                'name',
                'longitude',
              ),
            ),
          );
        });

        test('throws ArgumentError when longitude is above 180', () {
          expect(
            () => ExerciseRouteLocation(
              time: FakeData.fakeStartTime,
              latitude: FakeData.fakeLatitude,
              longitude: 180.1,
            ),
            throwsA(
              isA<ArgumentError>().having(
                (e) => e.name,
                'name',
                'longitude',
              ),
            ),
          );
        });

        test('accepts longitude at boundary -180', () {
          final location = ExerciseRouteLocation(
            time: FakeData.fakeStartTime,
            latitude: FakeData.fakeLatitude,
            longitude: -180.0,
          );
          expect(location.longitude, -180.0);
        });

        test('accepts longitude at boundary 180', () {
          final location = ExerciseRouteLocation(
            time: FakeData.fakeStartTime,
            latitude: FakeData.fakeLatitude,
            longitude: 180.0,
          );
          expect(location.longitude, 180.0);
        });

        test('throws ArgumentError when horizontalAccuracy is negative', () {
          expect(
            () => ExerciseRouteLocation(
              time: FakeData.fakeStartTime,
              latitude: FakeData.fakeLatitude,
              longitude: FakeData.fakeLongitude,
              horizontalAccuracy: const Length.meters(-1),
            ),
            throwsA(
              isA<ArgumentError>().having(
                (e) => e.name,
                'name',
                'horizontalAccuracy',
              ),
            ),
          );
        });

        test('accepts horizontalAccuracy at boundary 0', () {
          final location = ExerciseRouteLocation(
            time: FakeData.fakeStartTime,
            latitude: FakeData.fakeLatitude,
            longitude: FakeData.fakeLongitude,
            horizontalAccuracy: Length.zero,
          );
          expect(location.horizontalAccuracy?.inMeters, 0.0);
        });

        test('throws ArgumentError when verticalAccuracy is negative', () {
          expect(
            () => ExerciseRouteLocation(
              time: FakeData.fakeStartTime,
              latitude: FakeData.fakeLatitude,
              longitude: FakeData.fakeLongitude,
              verticalAccuracy: const Length.meters(-1),
            ),
            throwsA(
              isA<ArgumentError>().having(
                (e) => e.name,
                'name',
                'verticalAccuracy',
              ),
            ),
          );
        });

        test('accepts verticalAccuracy at boundary 0', () {
          final location = ExerciseRouteLocation(
            time: FakeData.fakeStartTime,
            latitude: FakeData.fakeLatitude,
            longitude: FakeData.fakeLongitude,
            verticalAccuracy: Length.zero,
          );
          expect(location.verticalAccuracy?.inMeters, 0.0);
        });
      });
    });

    group('internal factory', () {
      test('creates location without validation', () {
        // The internal factory bypasses validation for data from platforms
        final location = ExerciseRouteLocation.internal(
          time: FakeData.fakeStartTime,
          latitude: FakeData.fakeLatitude,
          longitude: FakeData.fakeLongitude,
          altitude: const Length.meters(FakeData.fakeAltitudeInMeters),
          horizontalAccuracy: const Length.meters(
            FakeData.fakeHorizontalAccuracyInMeters,
          ),
          verticalAccuracy: const Length.meters(
            FakeData.fakeVerticalAccuracyInMeters,
          ),
        );

        expect(location.time, FakeData.fakeStartTime);
        expect(location.latitude, FakeData.fakeLatitude);
        expect(location.longitude, FakeData.fakeLongitude);
      });
    });

    group('equality', () {
      test('two locations with same values are equal', () {
        final location1 = ExerciseRouteLocation(
          time: FakeData.fakeStartTime,
          latitude: FakeData.fakeLatitude,
          longitude: FakeData.fakeLongitude,
          altitude: const Length.meters(10),
          horizontalAccuracy: const Length.meters(5),
          verticalAccuracy: const Length.meters(3),
        );

        final location2 = ExerciseRouteLocation(
          time: FakeData.fakeStartTime,
          latitude: FakeData.fakeLatitude,
          longitude: FakeData.fakeLongitude,
          altitude: const Length.meters(10),
          horizontalAccuracy: const Length.meters(5),
          verticalAccuracy: const Length.meters(3),
        );

        expect(location1, equals(location2));
        expect(location1.hashCode, equals(location2.hashCode));
      });

      test('two locations with different times are not equal', () {
        final location1 = ExerciseRouteLocation(
          time: FakeData.fakeStartTime,
          latitude: FakeData.fakeLatitude,
          longitude: FakeData.fakeLongitude,
        );

        final location2 = ExerciseRouteLocation(
          time: FakeData.fakeEndTime,
          latitude: FakeData.fakeLatitude,
          longitude: FakeData.fakeLongitude,
        );

        expect(location1, isNot(equals(location2)));
      });

      test('two locations with different latitudes are not equal', () {
        final location1 = ExerciseRouteLocation(
          time: FakeData.fakeStartTime,
          latitude: 37.0,
          longitude: FakeData.fakeLongitude,
        );

        final location2 = ExerciseRouteLocation(
          time: FakeData.fakeStartTime,
          latitude: 38.0,
          longitude: FakeData.fakeLongitude,
        );

        expect(location1, isNot(equals(location2)));
      });
    });

    group('supportedHealthPlatforms', () {
      test('supports both appleHealth and healthConnect', () {
        final location = ExerciseRouteLocation(
          time: FakeData.fakeStartTime,
          latitude: FakeData.fakeLatitude,
          longitude: FakeData.fakeLongitude,
        );

        expect(
          location.supportedHealthPlatforms,
          containsAll([
            HealthPlatform.appleHealth,
            HealthPlatform.healthConnect,
          ]),
        );
      });
    });
  });
}
