import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:health_connector_hk_ios/src/mappers/health_record_mappers/exercise/exercise_route_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';

import '../../../../utils/fake_data.dart';

void main() {
  group('ExerciseRouteMapper', () {
    group('ExerciseRouteLocationToDto', () {
      test('converts ExerciseRouteLocation to ExerciseRouteLocationDto', () {
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

        final dto = location.toDto();

        expect(dto.time, FakeData.fakeStartTime.millisecondsSinceEpoch);
        expect(dto.latitude, FakeData.fakeLatitude);
        expect(dto.longitude, FakeData.fakeLongitude);
        expect(dto.altitudeMeters, FakeData.fakeAltitudeInMeters);
        expect(
          dto.horizontalAccuracyMeters,
          FakeData.fakeHorizontalAccuracyInMeters,
        );
        expect(
          dto.verticalAccuracyMeters,
          FakeData.fakeVerticalAccuracyInMeters,
        );
      });

      test(
        'converts ExerciseRouteLocation with null optionals to '
        'ExerciseRouteLocationDto',
        () {
          final location = ExerciseRouteLocation.internal(
            time: FakeData.fakeStartTime,
            latitude: FakeData.fakeLatitude,
            longitude: FakeData.fakeLongitude,
          );

          final dto = location.toDto();

          expect(dto.time, FakeData.fakeStartTime.millisecondsSinceEpoch);
          expect(dto.latitude, FakeData.fakeLatitude);
          expect(dto.longitude, FakeData.fakeLongitude);
          expect(dto.altitudeMeters, isNull);
          expect(dto.horizontalAccuracyMeters, isNull);
          expect(dto.verticalAccuracyMeters, isNull);
        },
      );
    });

    group('ExerciseRouteLocationFromDto', () {
      test('converts ExerciseRouteLocationDto to ExerciseRouteLocation', () {
        final dto = ExerciseRouteLocationDto(
          time: FakeData.fakeStartTime.millisecondsSinceEpoch,
          latitude: FakeData.fakeLatitude,
          longitude: FakeData.fakeLongitude,
          altitudeMeters: FakeData.fakeAltitudeInMeters,
          horizontalAccuracyMeters: FakeData.fakeHorizontalAccuracyInMeters,
          verticalAccuracyMeters: FakeData.fakeVerticalAccuracyInMeters,
        );

        final location = dto.toDomain();

        expect(location.time, FakeData.fakeStartTime);
        expect(location.latitude, FakeData.fakeLatitude);
        expect(location.longitude, FakeData.fakeLongitude);
        expect(location.altitude?.inMeters, FakeData.fakeAltitudeInMeters);
        expect(
          location.horizontalAccuracy?.inMeters,
          FakeData.fakeHorizontalAccuracyInMeters,
        );
        expect(
          location.verticalAccuracy?.inMeters,
          FakeData.fakeVerticalAccuracyInMeters,
        );
      });

      test(
        'converts ExerciseRouteLocationDto with null optionals to '
        'ExerciseRouteLocation',
        () {
          final dto = ExerciseRouteLocationDto(
            time: FakeData.fakeStartTime.millisecondsSinceEpoch,
            latitude: FakeData.fakeLatitude,
            longitude: FakeData.fakeLongitude,
          );

          final location = dto.toDomain();

          expect(location.time, FakeData.fakeStartTime);
          expect(location.latitude, FakeData.fakeLatitude);
          expect(location.longitude, FakeData.fakeLongitude);
          expect(location.altitude, isNull);
          expect(location.horizontalAccuracy, isNull);
          expect(location.verticalAccuracy, isNull);
        },
      );
    });

    group('ExerciseRouteToDto', () {
      test('converts ExerciseRoute to ExerciseRouteDto', () {
        final location1 = ExerciseRouteLocation.internal(
          time: FakeData.fakeStartTime,
          latitude: 37.7749,
          longitude: -122.4194,
        );
        final location2 = ExerciseRouteLocation.internal(
          time: FakeData.fakeEndTime,
          latitude: 37.7850,
          longitude: -122.4094,
        );
        final route = ExerciseRoute.internal([location1, location2]);

        final dto = route.toDto();

        expect(dto.locations, hasLength(2));
        expect(dto.locations[0].latitude, 37.7749);
        expect(dto.locations[1].latitude, 37.7850);
      });

      test('converts empty ExerciseRoute to ExerciseRouteDto', () {
        final route = ExerciseRoute.internal(const []);

        final dto = route.toDto();

        expect(dto.locations, isEmpty);
      });
    });

    group('ExerciseRouteFromDto', () {
      test('converts ExerciseRouteDto to ExerciseRoute', () {
        final dto = ExerciseRouteDto(
          locations: [
            ExerciseRouteLocationDto(
              time: FakeData.fakeStartTime.millisecondsSinceEpoch,
              latitude: 37.7749,
              longitude: -122.4194,
            ),
            ExerciseRouteLocationDto(
              time: FakeData.fakeEndTime.millisecondsSinceEpoch,
              latitude: 37.7850,
              longitude: -122.4094,
            ),
          ],
        );

        final route = dto.toDomain();

        expect(route.locations, hasLength(2));
        expect(route.locations[0].latitude, 37.7749);
        expect(route.locations[1].latitude, 37.7850);
      });

      test('converts empty ExerciseRouteDto to ExerciseRoute', () {
        final dto = ExerciseRouteDto(locations: []);

        final route = dto.toDomain();

        expect(route.isEmpty, isTrue);
      });
    });

    group('round-trip conversion', () {
      test('ExerciseRouteLocation survives round-trip', () {
        final original = ExerciseRouteLocation.internal(
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

        final roundTripped = original.toDto().toDomain();

        expect(roundTripped.time, original.time);
        expect(roundTripped.latitude, original.latitude);
        expect(roundTripped.longitude, original.longitude);
        expect(roundTripped.altitude?.inMeters, original.altitude?.inMeters);
        expect(
          roundTripped.horizontalAccuracy?.inMeters,
          original.horizontalAccuracy?.inMeters,
        );
        expect(
          roundTripped.verticalAccuracy?.inMeters,
          original.verticalAccuracy?.inMeters,
        );
      });

      test('ExerciseRoute survives round-trip', () {
        final original = ExerciseRoute.internal(
          [
            ExerciseRouteLocation.internal(
              time: FakeData.fakeStartTime,
              latitude: 37.7749,
              longitude: -122.4194,
            ),
            ExerciseRouteLocation.internal(
              time: FakeData.fakeEndTime,
              latitude: 37.7850,
              longitude: -122.4094,
            ),
          ],
        );

        final roundTripped = original.toDto().toDomain();

        expect(roundTripped.length, original.length);
        for (var i = 0; i < original.length; i++) {
          expect(
            roundTripped.locations[i].time,
            original.locations[i].time,
          );
          expect(
            roundTripped.locations[i].latitude,
            original.locations[i].latitude,
          );
          expect(
            roundTripped.locations[i].longitude,
            original.locations[i].longitude,
          );
        }
      });
    });
  });
}
