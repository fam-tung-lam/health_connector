import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('ActivityIntensityRecord', () {
    final now = DateTime(2026, 1, 11);
    final startTime = now.subtract(const Duration(minutes: 60));
    final endTime = now;
    final metadata = Metadata.manualEntry();

    test('equality works correctly', () {
      final record1 = ActivityIntensityRecord.internal(
        id: HealthRecordId.none,
        startTime: startTime,
        endTime: endTime,
        activityIntensityType: ActivityIntensityType.moderate,
        title: 'Morning Walk',
        notes: 'Felt good',
        metadata: metadata,
      );

      final record2 = ActivityIntensityRecord.internal(
        id: HealthRecordId.none,
        startTime: startTime,
        endTime: endTime,
        activityIntensityType: ActivityIntensityType.moderate,
        title: 'Morning Walk',
        notes: 'Felt good',
        metadata: metadata,
      );

      final record3 = ActivityIntensityRecord.internal(
        id: HealthRecordId.none,
        startTime: startTime,
        endTime: endTime,
        activityIntensityType: ActivityIntensityType.vigorous,
        title: 'Morning Run',
        notes: 'Hard work',
        metadata: metadata,
      );

      expect(record1 == record2, isTrue);
      expect(record1 == record3, isFalse);
      expect(record1.hashCode == record2.hashCode, isTrue);
    });

    test('copyWith works correctly', () {
      final record = ActivityIntensityRecord(
        startTime: startTime,
        endTime: endTime,
        activityIntensityType: ActivityIntensityType.moderate,
        title: 'Original Title',
        metadata: metadata,
      );

      final updatedRecord = record.copyWith(
        title: 'New Title',
        activityIntensityType: ActivityIntensityType.vigorous,
      );

      expect(updatedRecord.title, equals('New Title'));
      expect(
        updatedRecord.activityIntensityType,
        equals(ActivityIntensityType.vigorous),
      );
      expect(
        updatedRecord.startTime,
        equals(startTime),
      ); // Should remain unchanged
    });
  });
}
