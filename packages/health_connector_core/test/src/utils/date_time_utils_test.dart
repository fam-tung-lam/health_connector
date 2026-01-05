import 'package:health_connector_core/src/utils/date_time_utils.dart';
import 'package:test/test.dart';

void main() {
  group(
    'DateTimeToDto',
    () {
      group(
        'resolveZoneOffsetSeconds',
        () {
          test(
            'returns provided zoneOffsetSeconds if not null',
            () {
              // When
              final dateTime = DateTime.parse('2026-01-01T12:00:00+01:00');
              const providedOffset = 3600;

              final result = dateTime.resolveZoneOffsetSeconds(providedOffset);

              expect(result, providedOffset);
            },
          );

          test(
            'returns null if zoneOffsetSeconds is null and '
            'DateTime is UTC',
            () {
              // When
              final utcTime = DateTime.parse(
                '2026-01-01T12:00:00Z',
              );

              // Then
              // Then
              final result = utcTime.resolveZoneOffsetSeconds(null);

              // Should
              expect(result, null);
            },
          );

          test(
            'returns local offset if zoneOffsetSeconds is null and '
            'DateTime is local',
            () {
              // When
              final localTime = DateTime.parse(
                '2026-01-01T12:00:00+01:00',
              ).toLocal();

              // Then
              final result = localTime.resolveZoneOffsetSeconds(null);

              // Should
              expect(result, localTime.timeZoneOffset.inSeconds);
            },
          );
        },
      );
    },
  );
}
