import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector/health_connector.dart';
import 'package:health_connector_toolbox/src/features/background_incremental_data_sync/models/background_sync_report.dart';

import '../utils/in_memory_background_sync_storage.dart';

void main() {
  final start = DateTime.utc(2026, 9, 16, 8);
  final end = DateTime.utc(2026, 9, 16, 9);

  group('SyncedRecordSummary.fromRecord', () {
    test('captures the interval of an interval record', () {
      // Given a steps record with an explicit id.
      final record = StepsRecord(
        id: HealthRecordId('steps-1'),
        startTime: start,
        endTime: end,
        count: const Number(1200),
        metadata: Metadata.manualEntry(),
      );

      // When summarized.
      final summary = SyncedRecordSummary.fromRecord(record);

      // Then id, type, and both bounds are kept.
      expect(summary.recordId, 'steps-1');
      expect(summary.typeName, 'StepsRecord');
      expect(summary.startTime, start);
      expect(summary.endTime, end);
      expect(summary.description, record.toString());
    });

    test('captures the instant of an instant record', () {
      // Given a weight record.
      final record = WeightRecord(
        id: HealthRecordId('weight-1'),
        time: start,
        weight: const Mass.kilograms(72),
        metadata: Metadata.manualEntry(),
      );

      // When summarized.
      final summary = SyncedRecordSummary.fromRecord(record);

      // Then only the start time is set.
      expect(summary.typeName, 'WeightRecord');
      expect(summary.startTime, start);
      expect(summary.endTime, isNull);
    });
  });

  test('BackgroundSyncReport round-trips through JSON', () {
    // Given a fully populated failed report.
    final report = BackgroundSyncReport(
      trigger: BackgroundSyncTrigger.manual,
      outcome: BackgroundSyncOutcome.failed,
      startedAt: start,
      finishedAt: end,
      dataTypeIds: const ['steps'],
      pageCount: 2,
      upsertedRecords: [
        SyncedRecordSummary(
          recordId: 'r1',
          typeName: 'StepsRecord',
          startTime: start,
          endTime: end,
          description: 'StepsRecord(...)',
        ),
      ],
      deletedRecordIds: const ['r2'],
      tokenBefore: SyncTokenSnapshot.fromToken(
        buildToken(value: 'before', dataTypeIds: const ['steps']),
      ),
      tokenReset: true,
      error: const BackgroundSyncError(
        code: 'rateLimitExceeded',
        message: 'Too many requests',
        willRetry: true,
      ),
    );

    // When serialized and restored.
    final restored = BackgroundSyncReport.fromJson(report.toJson());

    // Then the restored report equals the original.
    expect(restored, report);
    expect(restored.duration, const Duration(hours: 1));
    expect(restored.tokenAfter, isNull);
  });

  test('enum ids fall back safely', () {
    expect(
      BackgroundSyncTrigger.fromId('unknown'),
      BackgroundSyncTrigger.scheduled,
    );
    expect(BackgroundSyncOutcome.fromId(null), BackgroundSyncOutcome.failed);
  });
}
