import 'package:health_connector_core/health_connector_core.dart';
import 'package:test/test.dart';

void main() {
  group('WalkingDoubleSupportPercentageRecord', () {
    final startTime = DateTime(2026, 1, 11, 10);
    final endTime = DateTime(2026, 1, 11, 10, 5);
    final metadata = Metadata.manualEntry();
    const validPercentage = Percentage.fromWhole(28.5);

    test('equality works correctly', () {
      final record1 = WalkingDoubleSupportPercentageRecord.internal(
        id: HealthRecordId.none,
        startTime: startTime,
        endTime: endTime,
        percentage: validPercentage,
        metadata: metadata,
        devicePlacementSide: DevicePlacementSide.unknown,
      );

      final record2 = WalkingDoubleSupportPercentageRecord.internal(
        id: HealthRecordId.none,
        startTime: startTime,
        endTime: endTime,
        percentage: validPercentage,
        metadata: metadata,
        devicePlacementSide: DevicePlacementSide.unknown,
      );

      final record3 = WalkingDoubleSupportPercentageRecord.internal(
        id: HealthRecordId.none,
        startTime: startTime,
        endTime: endTime,
        percentage: const Percentage.fromWhole(30.0),
        metadata: metadata,
        devicePlacementSide: DevicePlacementSide.unknown,
      );

      expect(record1 == record2, isTrue);
      expect(record1 == record3, isFalse);
      expect(record1.hashCode == record2.hashCode, isTrue);
    });

    test('creates record with valid percentage', () {
      final record = WalkingDoubleSupportPercentageRecord(
        startTime: startTime,
        endTime: endTime,
        percentage: validPercentage,
        metadata: metadata,
        devicePlacementSide: DevicePlacementSide.left,
      );

      expect(record.percentage, equals(validPercentage));
      expect(record.devicePlacementSide, equals(DevicePlacementSide.left));
    });

    test('throws when percentage is below minimum', () {
      expect(
        () => WalkingDoubleSupportPercentageRecord(
          startTime: startTime,
          endTime: endTime,
          percentage: const Percentage.fromWhole(-1.0), // Below 0% minimum
          metadata: metadata,
          devicePlacementSide: DevicePlacementSide.left,
        ),
        throwsArgumentError,
      );
    });

    test('throws when percentage is above maximum', () {
      expect(
        () => WalkingDoubleSupportPercentageRecord(
          startTime: startTime,
          endTime: endTime,
          percentage: const Percentage.fromWhole(101.0), // Above 100% maximum
          metadata: metadata,
          devicePlacementSide: DevicePlacementSide.left,
        ),
        throwsArgumentError,
      );
    });

    test('accepts minimum valid percentage', () {
      final record = WalkingDoubleSupportPercentageRecord(
        startTime: startTime,
        endTime: endTime,
        percentage: WalkingDoubleSupportPercentageRecord.minPercentage,
        metadata: metadata,
        devicePlacementSide: DevicePlacementSide.left,
      );

      expect(
        record.percentage,
        equals(WalkingDoubleSupportPercentageRecord.minPercentage),
      );
    });

    test('accepts maximum valid percentage', () {
      final record = WalkingDoubleSupportPercentageRecord(
        startTime: startTime,
        endTime: endTime,
        percentage: WalkingDoubleSupportPercentageRecord.maxPercentage,
        metadata: metadata,
        devicePlacementSide: DevicePlacementSide.left,
      );

      expect(
        record.percentage,
        equals(WalkingDoubleSupportPercentageRecord.maxPercentage),
      );
    });
  });
}
