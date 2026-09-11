import 'package:health_connector_core/health_connector_core.dart';
import 'package:health_connector_core/src/utils/health_record_data_type_extension.dart';
import 'package:test/test.dart';

void main() {
  group('AppleStandHourRecord', () {
    test('preserves the hourly status and maps to its data type', () {
      // Given
      final startTime = DateTime.utc(2026, 9, 11, 8);
      final endTime = DateTime.utc(2026, 9, 11, 9);
      final metadata = Metadata.manualEntry();

      // When
      final record = AppleStandHourRecord.internal(
        id: HealthRecordId('stand-hour-id'),
        startTime: startTime,
        endTime: endTime,
        metadata: metadata,
        status: AppleStandHourStatus.stood,
      );

      // Then
      expect(record.status, AppleStandHourStatus.stood);
      expect(record.startTime, startTime);
      expect(record.endTime, endTime);
      expect(record.dataType, HealthDataType.appleStandHour);
    });

    test('uses all record fields for value equality', () {
      // Given
      final startTime = DateTime.utc(2026, 9, 11, 8);
      final endTime = DateTime.utc(2026, 9, 11, 9);
      final metadata = Metadata.manualEntry();

      // When
      final first = AppleStandHourRecord.internal(
        id: HealthRecordId('stand-hour-id'),
        startTime: startTime,
        endTime: endTime,
        metadata: metadata,
        status: AppleStandHourStatus.idle,
        startZoneOffsetSeconds: 7200,
        endZoneOffsetSeconds: 7200,
      );
      final second = AppleStandHourRecord.internal(
        id: HealthRecordId('stand-hour-id'),
        startTime: startTime,
        endTime: endTime,
        metadata: metadata,
        status: AppleStandHourStatus.idle,
        startZoneOffsetSeconds: 7200,
        endZoneOffsetSeconds: 7200,
      );

      // Then
      expect(first, equals(second));
      expect(first.hashCode, equals(second.hashCode));
    });
  });
}
