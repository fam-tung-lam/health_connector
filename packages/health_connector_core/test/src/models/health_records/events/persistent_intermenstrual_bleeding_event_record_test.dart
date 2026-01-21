import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('PersistentIntermenstrualBleedingEventRecord', () {
    final now = DateTime(2026, 1, 20);
    final metadata = Metadata.manualEntry();

    test('equality works correctly', () {
      final record1 = PersistentIntermenstrualBleedingEventRecord.internal(
        id: HealthRecordId.none,
        startTime: now,
        endTime: now.add(const Duration(days: 1)),
        startZoneOffsetSeconds: 0,
        endZoneOffsetSeconds: 0,
        metadata: metadata,
      );
      final record2 = PersistentIntermenstrualBleedingEventRecord.internal(
        id: HealthRecordId.none,
        startTime: now,
        endTime: now.add(const Duration(days: 1)),
        startZoneOffsetSeconds: 0,
        endZoneOffsetSeconds: 0,
        metadata: metadata,
      );

      expect(record1, equals(record2));
      expect(record1.hashCode, equals(record2.hashCode));
    });
  });
}
