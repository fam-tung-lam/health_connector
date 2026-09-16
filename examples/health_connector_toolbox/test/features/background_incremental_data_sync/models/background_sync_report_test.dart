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

  test('report keeps counts but lists at most maxListedRecords', () {
    // Given a run with more records than the report lists.
    final many = List.generate(
      BackgroundSyncReport.maxListedRecords + 5,
      (i) => SyncedRecordSummary(
        recordId: 'r$i',
        typeName: 'StepsRecord',
        startTime: start,
        description: 'r$i',
      ),
    );
    final report = BackgroundSyncReport(
      trigger: BackgroundSyncTrigger.scheduled,
      outcome: BackgroundSyncOutcome.succeeded,
      startedAt: start,
      finishedAt: end,
      dataTypeIds: const ['steps'],
      upsertedRecords: many,
      deletedRecordIds: List.generate(3, (i) => 'd$i'),
    );

    // When restored from JSON.
    final restored = BackgroundSyncReport.fromJson(report.toJson());

    // Then the sample is bounded and the totals survive.
    expect(
      report.upsertedRecords,
      hasLength(
        BackgroundSyncReport.maxListedRecords,
      ),
    );
    expect(report.upsertedRecordCount, many.length);
    expect(report.deletedRecordCount, 3);
    expect(report.isTruncated, isTrue);
    expect(restored, report);
  });

  test('record description is truncated', () {
    // Given a record whose string form is long.
    final record = StepsRecord(
      id: HealthRecordId('long'),
      startTime: start,
      endTime: end,
      count: const Number(1),
      metadata: Metadata.manualEntry(),
    );

    // When summarized.
    final summary = SyncedRecordSummary.fromRecord(record);

    // Then the description never exceeds the bound plus the ellipsis.
    expect(
      summary.description.length,
      lessThanOrEqualTo(SyncedRecordSummary.maxDescriptionLength + 1),
    );
  });

  test('enum ids fall back safely', () {
    expect(
      BackgroundSyncTrigger.fromId('unknown'),
      BackgroundSyncTrigger.scheduled,
    );
    expect(BackgroundSyncOutcome.fromId(null), BackgroundSyncOutcome.failed);
  });
}
