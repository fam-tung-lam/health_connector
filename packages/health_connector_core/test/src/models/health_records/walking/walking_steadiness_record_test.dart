import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('WalkingSteadinessRecord', () {
    final now = DateTime(2026, 1, 11);
    final startTime = now.subtract(const Duration(minutes: 30));
    final endTime = now;
    final metadata = Metadata.manualEntry();
    const validPercentage = Percentage.fromWhole(50);

    test('equality works correctly', () {
      final record1 = WalkingSteadinessRecord.internal(
        id: HealthRecordId.none,
        startTime: startTime,
        endTime: endTime,
        percentage: validPercentage,
        metadata: metadata,
      );

      final record2 = WalkingSteadinessRecord.internal(
        id: HealthRecordId.none,
        startTime: startTime,
        endTime: endTime,
        percentage: validPercentage,
        metadata: metadata,
      );

      final record3 = WalkingSteadinessRecord.internal(
        id: HealthRecordId.none,
        startTime: startTime,
        endTime: endTime,
        percentage: const Percentage.fromWhole(60),
        metadata: metadata,
      );

      expect(record1 == record2, isTrue);
      expect(record1 == record3, isFalse);
      expect(record1.hashCode == record2.hashCode, isTrue);
    });
  });
}
