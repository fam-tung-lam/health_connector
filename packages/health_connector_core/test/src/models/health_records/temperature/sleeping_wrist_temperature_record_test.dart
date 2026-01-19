import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('SleepingWristTemperatureRecord', () {
    final now = DateTime(2026, 1, 11);
    final startTime = now.subtract(const Duration(hours: 8));
    final endTime = now;
    final metadata = Metadata.manualEntry();
    const validTemperature = Temperature.celsius(36.5);

    test('equality works correctly', () {
      final record1 = SleepingWristTemperatureRecord.internal(
        id: HealthRecordId.none,
        startTime: startTime,
        endTime: endTime,
        temperature: validTemperature,
        metadata: metadata,
      );

      final record2 = SleepingWristTemperatureRecord.internal(
        id: HealthRecordId.none,
        startTime: startTime,
        endTime: endTime,
        temperature: validTemperature,
        metadata: metadata,
      );

      final record3 = SleepingWristTemperatureRecord.internal(
        id: HealthRecordId.none,
        startTime: startTime,
        endTime: endTime,
        temperature: const Temperature.celsius(37.0),
        metadata: metadata,
      );

      expect(record1 == record2, isTrue);
      expect(record1 == record3, isFalse);
      expect(record1.hashCode == record2.hashCode, isTrue);
    });
  });
}
