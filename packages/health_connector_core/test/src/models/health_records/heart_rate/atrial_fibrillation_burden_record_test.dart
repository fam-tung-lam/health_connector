import 'package:health_connector_core/health_connector_core.dart';
import 'package:health_connector_core/health_connector_core_internal.dart';
import 'package:test/test.dart';

void main() {
  group('AtrialFibrillationBurdenRecord', () {
    final startTime = DateTime(2026, 1, 11, 10);
    final endTime = DateTime(2026, 1, 11, 10, 5);
    final metadata = Metadata.manualEntry();
    const validPercentage = Percentage.fromWhole(5.2);

    test('equality works correctly', () {
      final record1 = AtrialFibrillationBurdenRecord.internal(
        id: HealthRecordId.none,
        startTime: startTime,
        endTime: endTime,
        percentage: validPercentage,
        metadata: metadata,
      );

      final record2 = AtrialFibrillationBurdenRecord.internal(
        id: HealthRecordId.none,
        startTime: startTime,
        endTime: endTime,
        percentage: validPercentage,
        metadata: metadata,
      );

      final record3 = AtrialFibrillationBurdenRecord.internal(
        id: HealthRecordId.none,
        startTime: startTime,
        endTime: endTime,
        percentage: const Percentage.fromWhole(6.0),
        metadata: metadata,
      );

      expect(record1 == record2, isTrue);
      expect(record1 == record3, isFalse);
      expect(record1.hashCode == record2.hashCode, isTrue);
    });
  });
}
