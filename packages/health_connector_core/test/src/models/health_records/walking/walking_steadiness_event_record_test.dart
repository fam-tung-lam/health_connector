import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('WalkingSteadinessEventRecord', () {
    final now = DateTime(2026, 1, 20);
    final metadata = Metadata.manualEntry();

    test('equality works correctly', () {
      final record1 = WalkingSteadinessEventRecord.internal(
        id: HealthRecordId.none,
        startTime: now,
        endTime: now.add(const Duration(minutes: 5)),
        metadata: metadata,
        type: WalkingSteadinessType.initialLow,
      );
      final record2 = WalkingSteadinessEventRecord.internal(
        id: HealthRecordId.none,
        startTime: now,
        endTime: now.add(const Duration(minutes: 5)),
        metadata: metadata,
        type: WalkingSteadinessType.initialLow,
      );

      expect(record1, equals(record2));
      expect(record1.hashCode, equals(record2.hashCode));
    });
  });
}
