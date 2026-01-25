import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('LowCardioFitnessEventRecord', () {
    final now = DateTime(2026, 1, 22);
    final endTime = now.add(const Duration(minutes: 5));
    final metadata = Metadata.manualEntry();

    // VO2 max is in ml/(min*kg), which is a unit-less number in our Number wrapper
    // effectively, or implies the unit.
    const vo2Max = Number(35.0);
    const threshold = Number(40.0);

    test('can be instantiated with valid parameters', () {
      final record = LowCardioFitnessEventRecord.internal(
        id: HealthRecordId.none,
        startTime: now,
        endTime: endTime,
        metadata: metadata,
        vo2MlPerMinPerKg: vo2Max,
        vo2MlPerMinPerKgThreshold: threshold,
      );

      expect(record.startTime, now.toUtc());
      expect(record.endTime, endTime.toUtc());
      expect(record.metadata, metadata);
      expect(record.vo2MlPerMinPerKg, vo2Max);
      expect(record.vo2MlPerMinPerKgThreshold, threshold);
    });

    test('equality works correctly', () {
      final record1 = LowCardioFitnessEventRecord.internal(
        id: HealthRecordId.none,
        startTime: now,
        endTime: endTime,
        metadata: metadata,
        vo2MlPerMinPerKg: vo2Max,
        vo2MlPerMinPerKgThreshold: threshold,
      );
      final record2 = LowCardioFitnessEventRecord.internal(
        id: HealthRecordId.none,
        startTime: now,
        endTime: endTime,
        metadata: metadata,
        vo2MlPerMinPerKg: vo2Max,
        vo2MlPerMinPerKgThreshold: threshold,
      );

      expect(record1, equals(record2));
      expect(record1.hashCode, equals(record2.hashCode));
    });
  });
}
