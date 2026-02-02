import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:test/test.dart';

import '../../../../utils/fake_data.dart';

void main() {
  group('ExerciseRoute', () {
    late ExerciseRouteLocation location1;
    late ExerciseRouteLocation location2;
    late ExerciseRouteLocation location3;

    setUp(() {
      location1 = ExerciseRouteLocation(
        time: FakeData.fakeStartTime,
        latitude: 37.7749,
        longitude: -122.4194,
      );
      location2 = ExerciseRouteLocation(
        time: FakeData.fakeStartTime.add(const Duration(minutes: 15)),
        latitude: 37.7850,
        longitude: -122.4094,
      );
      location3 = ExerciseRouteLocation(
        time: FakeData.fakeEndTime,
        latitude: 37.7950,
        longitude: -122.3994,
      );
    });

    group('constructor', () {
      test('creates route with single location', () {
        final route = ExerciseRoute([location1]);

        expect(route.locations, hasLength(1));
        expect(route.locations[0], location1);
      });

      test('creates route with multiple locations in chronological order', () {
        final route = ExerciseRoute(
          [location1, location2, location3],
        );

        expect(route.locations, hasLength(3));
        expect(route.locations[0], location1);
        expect(route.locations[1], location2);
        expect(route.locations[2], location3);
      });

      test('allows locations with equal timestamps', () {
        final locationSameTime = ExerciseRouteLocation(
          time: location1.time,
          latitude: 37.7800,
          longitude: -122.4100,
        );

        final route = ExerciseRoute([location1, locationSameTime]);

        expect(route.locations, hasLength(2));
      });

      test('throws ArgumentError when locations is empty', () {
        expect(
          () => ExerciseRoute(const []),
          throwsA(
            isA<ArgumentError>().having(
              (e) => e.message,
              'message',
              contains('Locations must not be empty'),
            ),
          ),
        );
      });

      test(
        'throws ArgumentError when locations are not in chronological order',
        () {
          expect(
            () => ExerciseRoute([location2, location1]),
            throwsA(
              isA<ArgumentError>().having(
                (e) => e.message,
                'message',
                contains('Locations must be in chronological order'),
              ),
            ),
          );
        },
      );

      test('throws ArgumentError when middle location is out of order', () {
        expect(
          () => ExerciseRoute([location1, location3, location2]),
          throwsA(
            isA<ArgumentError>().having(
              (e) => e.message,
              'message',
              contains('Locations must be in chronological order'),
            ),
          ),
        );
      });
    });

    group('internal factory', () {
      test('creates route without validation', () {
        final route = ExerciseRoute.internal(const []);

        expect(route.locations, isEmpty);
      });

      test('creates route with out-of-order locations without throwing', () {
        final route = ExerciseRoute.internal([location2, location1]);

        expect(route.locations, hasLength(2));
        expect(route.locations[0], location2);
        expect(route.locations[1], location1);
      });
    });

    group('isEmpty', () {
      test('returns true for empty route', () {
        final route = ExerciseRoute.internal(const []);

        expect(route.isEmpty, isTrue);
      });

      test('returns false for non-empty route', () {
        final route = ExerciseRoute([location1]);

        expect(route.isEmpty, isFalse);
      });
    });

    group('isNotEmpty', () {
      test('returns false for empty route', () {
        final route = ExerciseRoute.internal(const []);

        expect(route.isNotEmpty, isFalse);
      });

      test('returns true for non-empty route', () {
        final route = ExerciseRoute([location1]);

        expect(route.isNotEmpty, isTrue);
      });
    });

    group('length', () {
      test('returns 0 for empty route', () {
        final route = ExerciseRoute.internal(const []);

        expect(route.length, 0);
      });

      test('returns correct count for non-empty route', () {
        final route = ExerciseRoute(
          [location1, location2, location3],
        );

        expect(route.length, 3);
      });
    });

    group('first', () {
      test('returns null for empty route', () {
        final route = ExerciseRoute.internal(const []);

        expect(route.first, isNull);
      });

      test('returns first location for non-empty route', () {
        final route = ExerciseRoute(
          [location1, location2, location3],
        );

        expect(route.first, location1);
      });
    });

    group('last', () {
      test('returns null for empty route', () {
        final route = ExerciseRoute.internal(const []);

        expect(route.last, isNull);
      });

      test('returns last location for non-empty route', () {
        final route = ExerciseRoute(
          [location1, location2, location3],
        );

        expect(route.last, location3);
      });
    });

    group('duration', () {
      test('returns Duration.zero for empty route', () {
        final route = ExerciseRoute.internal(const []);

        expect(route.duration, Duration.zero);
      });

      test('returns Duration.zero for single-point route', () {
        final route = ExerciseRoute([location1]);

        expect(route.duration, Duration.zero);
      });

      test('calculates duration from first to last location', () {
        final route = ExerciseRoute(
          [location1, location2, location3],
        );

        // Duration from fakeStartTime to fakeEndTime (1.5 hours)
        expect(route.duration, const Duration(hours: 1, minutes: 30));
      });
    });

    group('equality', () {
      test('two routes with same locations are equal', () {
        final route1 = ExerciseRoute([location1, location2]);
        final route2 = ExerciseRoute([location1, location2]);

        expect(route1, equals(route2));
        expect(route1.hashCode, equals(route2.hashCode));
      });

      test('two empty routes are equal', () {
        final route1 = ExerciseRoute.internal(const []);
        final route2 = ExerciseRoute.internal(const []);

        expect(route1, equals(route2));
        expect(route1.hashCode, equals(route2.hashCode));
      });

      test('routes with different locations are not equal', () {
        final route1 = ExerciseRoute([location1, location2]);
        final route2 = ExerciseRoute([location1, location3]);

        expect(route1, isNot(equals(route2)));
      });

      test('routes with different number of locations are not equal', () {
        final route1 = ExerciseRoute([location1]);
        final route2 = ExerciseRoute([location1, location2]);

        expect(route1, isNot(equals(route2)));
      });

      test('routes with same locations in different order are not equal', () {
        // Use internal factory to bypass validation for this test
        final route1 = ExerciseRoute.internal([location1, location2]);
        final route2 = ExerciseRoute.internal([location2, location1]);

        expect(route1, isNot(equals(route2)));
      });
    });

    group('supportedHealthPlatforms', () {
      test('supports both appleHealth and healthConnect', () {
        final route = ExerciseRoute([location1]);

        expect(
          route.supportedHealthPlatforms,
          containsAll([
            HealthPlatform.appleHealth,
            HealthPlatform.healthConnect,
          ]),
        );
      });
    });
  });
}
