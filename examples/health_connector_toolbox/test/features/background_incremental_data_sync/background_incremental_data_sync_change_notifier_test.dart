import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/features/background_incremental_data_sync/background_incremental_data_sync_change_notifier.dart';
import 'package:health_connector_toolbox/src/features/background_incremental_data_sync/models/background_sync_report.dart';
import 'package:health_connector_toolbox/src/features/background_incremental_data_sync/models/background_sync_settings.dart';
import 'package:health_connector_toolbox/src/features/background_incremental_data_sync/services/background_sync_scheduler.dart';
import 'package:mocktail/mocktail.dart';
import 'package:workmanager/workmanager.dart' show WorkInfo, WorkState;

import 'utils/in_memory_background_sync_storage.dart';

class MockHealthConnector extends Mock implements HealthConnector {}

class MockBackgroundSyncScheduler extends Mock
    implements BackgroundSyncScheduler {}

void main() {
  late MockHealthConnector healthConnector;
  late MockBackgroundSyncScheduler scheduler;
  late InMemoryBackgroundSyncStorage storage;
  late BackgroundIncrementalDataSyncChangeNotifier notifier;
  final stepsIds = [HealthDataType.steps.id];

  setUpAll(() {
    registerFallbackValue(Duration.zero);
    registerFallbackValue(<HealthDataType>[]);
    registerFallbackValue(<Permission>[]);
    registerFallbackValue(HealthPlatformFeature.readHealthDataHistory);
  });

  setUp(() {
    healthConnector = MockHealthConnector();
    scheduler = MockBackgroundSyncScheduler();
    storage = InMemoryBackgroundSyncStorage();
    when(() => healthConnector.healthPlatform).thenReturn(
      HealthPlatform.appleHealth,
    );
    when(() => scheduler.getWorkInfo()).thenAnswer((_) async => null);
    when(() => scheduler.schedule(any())).thenAnswer((_) async {});
    when(() => scheduler.cancel()).thenAnswer((_) async {});
    notifier = BackgroundIncrementalDataSyncChangeNotifier(
      healthConnector: healthConnector,
      storage: storage,
      scheduler: scheduler,
    );
  });

  tearDown(() => notifier.dispose());

  test('initialize loads settings, token, report and work info', () async {
    // Given persisted state from a previous session.
    storage
      ..settings = const BackgroundSyncSettings(
        dataTypes: [HealthDataType.steps],
        isEnabled: true,
      )
      ..token = buildToken(value: 't', dataTypeIds: stepsIds)
      ..report = BackgroundSyncReport(
        trigger: BackgroundSyncTrigger.scheduled,
        outcome: BackgroundSyncOutcome.succeeded,
        startedAt: DateTime.utc(2026, 9, 16),
        finishedAt: DateTime.utc(2026, 9, 16),
        dataTypeIds: stepsIds,
      );
    const info = WorkInfo(
      uniqueName: WorkmanagerBackgroundSyncScheduler.taskIdentifier,
      state: WorkState.scheduled,
      isPeriodic: true,
    );
    when(() => scheduler.getWorkInfo()).thenAnswer((_) async => info);

    // When the notifier initializes.
    await notifier.initialize();

    // Then every piece of state is exposed.
    expect(notifier.isLoading, isFalse);
    expect(notifier.selectedDataTypes, [HealthDataType.steps]);
    expect(notifier.isBackgroundSyncEnabled, isTrue);
    expect(notifier.syncToken?.token, 't');
    expect(notifier.latestReport?.outcome, BackgroundSyncOutcome.succeeded);
    expect(notifier.workInfo, info);
    expect(notifier.requiresBackgroundReadPermission, isFalse);
  });

  test('enableBackgroundSync rejects an empty selection', () async {
    // Given no selected data types.
    await notifier.initialize();

    // When enabling.
    // Then the call fails and nothing is scheduled.
    await expectLater(notifier.enableBackgroundSync(), throwsArgumentError);
    verifyNever(() => scheduler.schedule(any()));
    expect(storage.settings.isEnabled, isFalse);
  });

  test('enable and disable drive the scheduler and persist the flag', () async {
    // Given a selection with a 30 minute frequency.
    storage.settings = const BackgroundSyncSettings(
      dataTypes: [HealthDataType.steps],
      frequency: Duration(minutes: 30),
    );
    await notifier.initialize();

    // When the task is enabled and then disabled.
    await notifier.enableBackgroundSync();
    expect(notifier.isBackgroundSyncEnabled, isTrue);
    expect(storage.settings.isEnabled, isTrue);
    await notifier.disableBackgroundSync();

    // Then the scheduler saw both calls and the flag is persisted.
    verify(() => scheduler.schedule(const Duration(minutes: 30))).called(1);
    verify(() => scheduler.cancel()).called(1);
    expect(notifier.isBackgroundSyncEnabled, isFalse);
    expect(storage.settings.isEnabled, isFalse);
  });

  test('updateSelectedDataTypes clears a token for other data types', () async {
    // Given a stored steps token.
    storage
      ..settings = const BackgroundSyncSettings(
        dataTypes: [HealthDataType.steps],
      )
      ..token = buildToken(value: 't', dataTypeIds: stepsIds);
    await notifier.initialize();

    // When the selection switches to weight.
    final cleared = await notifier.updateSelectedDataTypes([
      HealthDataType.weight,
    ]);

    // Then the token is gone and the selection persisted.
    expect(cleared, isTrue);
    expect(notifier.syncToken, isNull);
    expect(storage.token, isNull);
    expect(storage.settings.dataTypes, [HealthDataType.weight]);
  });

  test(
    'updateSelectedDataTypes keeps a token for the same data types',
    () async {
      // Given a stored steps token.
      storage
        ..settings = const BackgroundSyncSettings(
          dataTypes: [HealthDataType.steps],
        )
        ..token = buildToken(value: 't', dataTypeIds: stepsIds);
      await notifier.initialize();

      // When the same selection is saved again.
      final cleared = await notifier.updateSelectedDataTypes([
        HealthDataType.steps,
      ]);

      // Then the token survives.
      expect(cleared, isFalse);
      expect(notifier.syncToken?.token, 't');
    },
  );

  test('updateFrequency reschedules only while enabled', () async {
    // Given an enabled task.
    storage.settings = const BackgroundSyncSettings(
      dataTypes: [HealthDataType.steps],
      isEnabled: true,
    );
    await notifier.initialize();

    // When the frequency changes.
    await notifier.updateFrequency(const Duration(hours: 1));

    // Then the scheduler is updated and the setting persisted.
    verify(() => scheduler.schedule(const Duration(hours: 1))).called(1);
    expect(storage.settings.frequency, const Duration(hours: 1));
  });

  test('runSyncNow runs the worker with the UI connector', () async {
    // Given a selection and a connector that returns one change.
    storage.settings = const BackgroundSyncSettings(
      dataTypes: [HealthDataType.steps],
    );
    when(
      () => healthConnector.synchronize(
        dataTypes: any(named: 'dataTypes'),
        syncToken: any(named: 'syncToken'),
      ),
    ).thenAnswer(
      (_) async => HealthDataSyncResult.internal(
        upsertedRecords: const [],
        deletedRecordIds: [HealthRecordId('gone')],
        hasMore: false,
        nextSyncToken: buildToken(value: 'next', dataTypeIds: stepsIds),
      ),
    );
    await notifier.initialize();

    // When the run is triggered manually.
    final result = await notifier.runSyncNow();

    // Then the report and token are refreshed from storage.
    expect(result.report.trigger, BackgroundSyncTrigger.manual);
    expect(notifier.latestReport?.deletedRecordIds, ['gone']);
    expect(notifier.syncToken?.token, 'next');
    expect(notifier.isSyncing, isFalse);
  });

  test('clearToken removes the stored token', () async {
    // Given a stored token.
    storage.token = buildToken(value: 't', dataTypeIds: stepsIds);
    await notifier.initialize();

    // When cleared.
    await notifier.clearToken();

    // Then both memory and storage are empty.
    expect(notifier.syncToken, isNull);
    expect(storage.token, isNull);
  });

  test(
    'loads and requests the background read permission on Health Connect',
    () async {
      // Given a Health Connect platform without the permission granted.
      const feature = HealthPlatformFeature.readHealthDataInBackground;
      when(() => healthConnector.healthPlatform).thenReturn(
        HealthPlatform.healthConnect,
      );
      when(() => healthConnector.getFeatureStatus(feature)).thenAnswer(
        (_) async => HealthPlatformFeatureStatus.available,
      );
      when(() => healthConnector.getGrantedPermissions()).thenAnswer(
        (_) async => const [],
      );
      when(() => healthConnector.requestPermissions(any())).thenAnswer(
        (_) async => const [
          PermissionRequestResult(
            permission: HealthPlatformFeaturePermission(feature),
            status: PermissionStatus.granted,
          ),
        ],
      );
      await notifier.initialize();
      expect(notifier.requiresBackgroundReadPermission, isTrue);
      expect(
        notifier.backgroundReadFeatureStatus,
        HealthPlatformFeatureStatus.available,
      );
      expect(notifier.backgroundReadPermissionStatus, PermissionStatus.unknown);

      // When the permission is requested.
      await notifier.requestBackgroundReadPermission();

      // Then the granted status is exposed.
      expect(notifier.backgroundReadPermissionStatus, PermissionStatus.granted);
    },
  );
}
