import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector/health_connector.dart';
import 'package:health_connector_toolbox/src/features/background_incremental_data_sync/background_sync_worker.dart';
import 'package:health_connector_toolbox/src/features/background_incremental_data_sync/models/background_sync_report.dart';
import 'package:health_connector_toolbox/src/features/background_incremental_data_sync/models/background_sync_settings.dart';
import 'package:mocktail/mocktail.dart';

import 'utils/in_memory_background_sync_storage.dart';

class MockHealthConnector extends Mock implements HealthConnector {}

void main() {
  late MockHealthConnector healthConnector;
  late InMemoryBackgroundSyncStorage storage;
  late BackgroundSyncWorker worker;
  final now = DateTime.utc(2026, 9, 16, 10);
  final stepsIds = [HealthDataType.steps.id];

  setUpAll(() {
    registerFallbackValue(<HealthDataType>[]);
  });

  setUp(() {
    healthConnector = MockHealthConnector();
    storage = InMemoryBackgroundSyncStorage()
      ..settings = const BackgroundSyncSettings(
        dataTypes: [HealthDataType.steps],
      );
    worker = BackgroundSyncWorker(
      createHealthConnector: () async => healthConnector,
      storage: storage,
      clock: () => now,
    );
  });

  StepsRecord buildSteps(String id) => StepsRecord(
    id: HealthRecordId(id),
    startTime: now.subtract(const Duration(hours: 1)),
    endTime: now,
    count: const Number(10),
    metadata: Metadata.manualEntry(),
  );

  // The SDK only exposes an internal factory for sync results, which is the
  // sanctioned seam for test doubles of `synchronize`.
  HealthDataSyncResult buildResult({
    required String nextToken,
    List<HealthRecord> upserted = const [],
    List<String> deleted = const [],
    bool hasMore = false,
  }) => HealthDataSyncResult.internal(
    upsertedRecords: upserted,
    deletedRecordIds: deleted.map(HealthRecordId.new).toList(),
    hasMore: hasMore,
    nextSyncToken: buildToken(value: nextToken, dataTypeIds: stepsIds),
  );

  test('skips the run when no data types are selected', () async {
    // Given no selected data types.
    storage.settings = const BackgroundSyncSettings();

    // When the worker runs.
    final result = await worker.run(trigger: BackgroundSyncTrigger.scheduled);

    // Then nothing is synchronized and the report says skipped.
    expect(result.shouldRetry, isFalse);
    expect(result.report.outcome, BackgroundSyncOutcome.skipped);
    expect(storage.report, result.report);
    verifyNever(
      () => healthConnector.synchronize(
        dataTypes: any(named: 'dataTypes'),
        syncToken: any(named: 'syncToken'),
      ),
    );
  });

  test('synchronizes every page and stores the last token', () async {
    // Given a stored token and two pages of changes.
    final stored = buildToken(value: 't0', dataTypeIds: stepsIds);
    storage.token = stored;
    when(
      () => healthConnector.synchronize(
        dataTypes: [HealthDataType.steps],
        syncToken: stored,
      ),
    ).thenAnswer(
      (_) async => buildResult(
        nextToken: 't1',
        upserted: [buildSteps('a')],
        hasMore: true,
      ),
    );
    when(
      () => healthConnector.synchronize(
        dataTypes: [HealthDataType.steps],
        syncToken: buildToken(value: 't1', dataTypeIds: stepsIds),
      ),
    ).thenAnswer(
      (_) async => buildResult(nextToken: 't2', deleted: const ['gone']),
    );

    // When the worker runs.
    final result = await worker.run(trigger: BackgroundSyncTrigger.manual);

    // Then both pages are merged and the final token is persisted.
    final report = result.report;
    expect(result.shouldRetry, isFalse);
    expect(report.outcome, BackgroundSyncOutcome.succeeded);
    expect(report.trigger, BackgroundSyncTrigger.manual);
    expect(report.pageCount, 2);
    expect(report.upsertedRecordCount, 1);
    expect(report.deletedRecordCount, 1);
    expect(report.tokenBefore?.token, 't0');
    expect(report.tokenAfter?.token, 't2');
    expect(report.tokenReset, isFalse);
    expect(storage.token?.token, 't2');
    expect(storage.report, report);
  });

  test('starts from a new baseline when the token data types differ', () async {
    // Given a stored token that covers weight instead of steps.
    storage.token = buildToken(
      value: 'old',
      dataTypeIds: [HealthDataType.weight.id],
    );
    when(
      () => healthConnector.synchronize(
        dataTypes: [HealthDataType.steps],
        syncToken: null,
      ),
    ).thenAnswer((_) async => buildResult(nextToken: 'fresh'));

    // When the worker runs.
    final result = await worker.run(trigger: BackgroundSyncTrigger.scheduled);

    // Then the initial sync used no token and the reset is reported.
    expect(result.report.outcome, BackgroundSyncOutcome.succeeded);
    expect(result.report.tokenReset, isTrue);
    expect(storage.token?.token, 'fresh');
  });

  test('recovers from an expired token by re-baselining once', () async {
    // Given a stored token the platform rejects.
    final expired = buildToken(value: 'expired', dataTypeIds: stepsIds);
    storage.token = expired;
    when(
      () => healthConnector.synchronize(
        dataTypes: [HealthDataType.steps],
        syncToken: expired,
      ),
    ).thenThrow(const InvalidArgumentException('Token expired'));
    when(
      () => healthConnector.synchronize(
        dataTypes: [HealthDataType.steps],
        syncToken: null,
      ),
    ).thenAnswer((_) async => buildResult(nextToken: 'baseline'));

    // When the worker runs.
    final result = await worker.run(trigger: BackgroundSyncTrigger.scheduled);

    // Then a new baseline token is stored and the reset is flagged.
    expect(result.shouldRetry, isFalse);
    expect(result.report.outcome, BackgroundSyncOutcome.succeeded);
    expect(result.report.tokenReset, isTrue);
    expect(result.report.tokenBefore?.token, 'expired');
    expect(result.report.tokenAfter?.token, 'baseline');
    expect(storage.token?.token, 'baseline');
  });

  test(
    'reports a transient failure as retryable and keeps the token',
    () async {
      // Given a stored token and a busy platform.
      final stored = buildToken(value: 'keep', dataTypeIds: stepsIds);
      storage.token = stored;
      when(
        () => healthConnector.synchronize(
          dataTypes: any(named: 'dataTypes'),
          syncToken: any(named: 'syncToken'),
        ),
      ).thenThrow(
        const HealthServiceException(
          HealthConnectorErrorCode.rateLimitExceeded,
          'Too many requests',
        ),
      );

      // When the worker runs.
      final result = await worker.run(trigger: BackgroundSyncTrigger.scheduled);

      // Then the failure asks for a retry and the token is untouched.
      expect(result.shouldRetry, isTrue);
      expect(result.report.outcome, BackgroundSyncOutcome.failed);
      expect(result.report.error?.code, 'rateLimitExceeded');
      expect(result.report.error?.willRetry, isTrue);
      expect(storage.tokenWrites, 0);
      expect(storage.token, stored);
    },
  );

  test('reports a permission failure without retry', () async {
    // Given a connector that cannot be created for lack of permission.
    worker = BackgroundSyncWorker(
      createHealthConnector: () async => throw const AuthorizationException(
        HealthConnectorErrorCode.permissionNotGranted,
        'Missing permission',
      ),
      storage: storage,
      clock: () => now,
    );

    // When the worker runs.
    final result = await worker.run(trigger: BackgroundSyncTrigger.scheduled);

    // Then the failure is final.
    expect(result.shouldRetry, isFalse);
    expect(result.report.outcome, BackgroundSyncOutcome.failed);
    expect(result.report.error?.code, 'permissionNotGranted');
    expect(result.report.pageCount, 0);
  });

  test('shouldRetryFor only retries transient platform errors', () {
    expect(
      BackgroundSyncWorker.shouldRetryFor(
        HealthConnectorErrorCode.healthServiceDatabaseInaccessible,
      ),
      isTrue,
    );
    expect(
      BackgroundSyncWorker.shouldRetryFor(
        HealthConnectorErrorCode.dataSyncInProgress,
      ),
      isTrue,
    );
    expect(
      BackgroundSyncWorker.shouldRetryFor(
        HealthConnectorErrorCode.permissionNotDeclared,
      ),
      isFalse,
    );
    expect(
      BackgroundSyncWorker.shouldRetryFor(
        HealthConnectorErrorCode.invalidArgument,
      ),
      isFalse,
    );
  });
}
