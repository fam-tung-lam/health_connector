import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('Vo2MaxRecord', () {
    final now = DateTime(2026, 1, 11);
    final metadata = Metadata.manualEntry();
    const validVo2 = Number(45.0);
    const testType = Vo2MaxTestType.cooperTest;

    test('can be instantiated with valid parameters', () {
      final record = Vo2MaxRecord(
        time: now,
        vo2MlPerMinPerKg: validVo2,
        testType: testType,
        metadata: metadata,
      );

      expect(record.time, now.toUtc());
      expect(record.vo2MlPerMinPerKg, validVo2);
      expect(record.testType, testType);
      expect(record.metadata, metadata);
    });

    test('can be instantiated without testType', () {
      final record = Vo2MaxRecord(
        time: now,
        vo2MlPerMinPerKg: validVo2,
        metadata: metadata,
      );
      expect(record.testType, isNull);
    });

    test('throws ArgumentError when vo2MlPerMinPerKg is below min', () {
      expect(
        () => Vo2MaxRecord(
          time: now,
          vo2MlPerMinPerKg: const Number(4.9),
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('throws ArgumentError when vo2MlPerMinPerKg is above max', () {
      expect(
        () => Vo2MaxRecord(
          time: now,
          vo2MlPerMinPerKg: const Number(100.1),
          metadata: metadata,
        ),
        throwsArgumentError,
      );
    });

    test('copyWith updates all fields correctly', () {
      final record = Vo2MaxRecord(
        time: now,
        vo2MlPerMinPerKg: validVo2,
        testType: testType,
        metadata: metadata,
      );

      final newTime = now.add(const Duration(minutes: 5));
      const newVo2 = Number(50.0);
      const newTestType = Vo2MaxTestType.rockportFitnessTest;
      final newMetadata = Metadata.manualEntry();

      final updated = record.copyWith(
        time: newTime,
        vo2MlPerMinPerKg: newVo2,
        testType: newTestType,
        metadata: newMetadata,
      );

      expect(updated.time, newTime.toUtc());
      expect(updated.vo2MlPerMinPerKg, newVo2);
      expect(updated.testType, newTestType);
      expect(updated.metadata, newMetadata);
    });

    test('equality works correctly', () {
      final record1 = Vo2MaxRecord(
        time: now,
        vo2MlPerMinPerKg: validVo2,
        testType: testType,
        metadata: metadata,
      );

      final record2 = Vo2MaxRecord(
        time: now,
        vo2MlPerMinPerKg: validVo2,
        testType: testType,
        metadata: metadata,
      );

      final record3 = Vo2MaxRecord(
        time: now,
        vo2MlPerMinPerKg: const Number(46.0),
        testType: testType,
        metadata: metadata,
      );

      expect(record1 == record2, isTrue);
      expect(record1 == record3, isFalse);
      expect(record1.hashCode == record2.hashCode, isTrue);
    });
  });
}
