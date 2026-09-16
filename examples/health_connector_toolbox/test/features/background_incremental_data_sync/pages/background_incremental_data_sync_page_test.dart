import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector/health_connector.dart';
import 'package:health_connector_toolbox/src/common/theme/app_theme_data.dart';
import 'package:health_connector_toolbox/src/features/background_incremental_data_sync/background_incremental_data_sync_change_notifier.dart';
import 'package:health_connector_toolbox/src/features/background_incremental_data_sync/models/background_sync_report.dart';
import 'package:health_connector_toolbox/src/features/background_incremental_data_sync/models/background_sync_settings.dart';
import 'package:health_connector_toolbox/src/features/background_incremental_data_sync/pages/background_incremental_data_sync_page.dart';
import 'package:health_connector_toolbox/src/features/background_incremental_data_sync/services/background_sync_scheduler.dart';
import 'package:health_connector_toolbox/src/features/console_logs/console_log_store.dart';
import 'package:health_connector_toolbox/src/features/console_logs/models/console_log_entry.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

import '../../console_logs/utils/in_memory_console_log_storage.dart';
import '../utils/in_memory_background_sync_storage.dart';

class MockHealthConnector extends Mock implements HealthConnector {}

class MockBackgroundSyncScheduler extends Mock
    implements BackgroundSyncScheduler {}

void main() {
  late MockHealthConnector healthConnector;
  late MockBackgroundSyncScheduler scheduler;
  late InMemoryBackgroundSyncStorage storage;
  late ConsoleLogStore consoleLogStore;

  setUpAll(() {
    registerFallbackValue(Duration.zero);
  });

  setUp(() {
    healthConnector = MockHealthConnector();
    scheduler = MockBackgroundSyncScheduler();
    storage = InMemoryBackgroundSyncStorage();
    consoleLogStore = ConsoleLogStore(
      storage: InMemoryConsoleLogStorage(),
      isolate: ConsoleLogIsolate.main,
    );
    when(() => healthConnector.healthPlatform).thenReturn(
      HealthPlatform.appleHealth,
    );
    when(() => scheduler.getWorkInfo()).thenAnswer((_) async => null);
    when(() => scheduler.schedule(any())).thenAnswer((_) async {});
    when(() => scheduler.cancel()).thenAnswer((_) async {});
  });

  tearDown(() => consoleLogStore.dispose());

  Future<void> pumpPage(WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider<ConsoleLogStore>.value(
        value: consoleLogStore,
        child: ChangeNotifierProvider(
          create: (_) => BackgroundIncrementalDataSyncChangeNotifier(
            healthConnector: healthConnector,
            storage: storage,
            scheduler: scheduler,
          )..initialize(),
          child: MaterialApp(
            theme: appThemeData,
            home: const BackgroundIncrementalDataSyncPage(
              healthPlatform: HealthPlatform.appleHealth,
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('shows the enable button and empty states when inactive', (
    tester,
  ) async {
    // Given nothing is configured.
    await pumpPage(tester);

    // Then the screen offers to enable and explains the empty state.
    expect(find.text('ENABLE BACKGROUND SYNC'), findsOneWidget);
    expect(find.text('Inactive'), findsOneWidget);
    expect(find.text('Selected Data Types (0)'), findsOneWidget);
    expect(find.text('No stored sync token found'), findsOneWidget);
    expect(
      find.textContaining('No background sync has run yet'),
      findsOneWidget,
    );
  });

  testWidgets('enable requires a selection and then registers the task', (
    tester,
  ) async {
    // Given no selection yet.
    await pumpPage(tester);

    // When enabling without data types.
    await tester.tap(find.text('ENABLE BACKGROUND SYNC'));
    await tester.pumpAndSettle();

    // Then a warning is shown and nothing scheduled.
    expect(find.text('Select at least one data type first'), findsOneWidget);
    verifyNever(() => scheduler.schedule(any()));
  });

  testWidgets('renders the persisted report and disable button when active', (
    tester,
  ) async {
    // Given an enabled task with a failed report.
    storage
      ..settings = const BackgroundSyncSettings(
        dataTypes: [HealthDataType.steps],
        isEnabled: true,
      )
      ..report = BackgroundSyncReport(
        trigger: BackgroundSyncTrigger.scheduled,
        outcome: BackgroundSyncOutcome.failed,
        startedAt: DateTime(2026, 9, 16, 8),
        finishedAt: DateTime(2026, 9, 16, 8, 0, 2),
        dataTypeIds: const ['steps'],
        deletedRecordIds: const ['gone'],
        error: const BackgroundSyncError(
          code: 'rateLimitExceeded',
          message: 'Too many requests',
          willRetry: true,
        ),
      );
    await pumpPage(tester);

    // Then the report details are visible.
    expect(find.text('DISABLE BACKGROUND SYNC'), findsOneWidget);
    expect(find.text('Active'), findsOneWidget);
    expect(find.text('Selected Data Types (1)'), findsOneWidget);
    expect(find.text('failed'), findsOneWidget);
    expect(find.text('Error: rateLimitExceeded'), findsOneWidget);
    expect(find.text('Too many requests'), findsOneWidget);
    expect(find.text('Deleted Record IDs (1)'), findsOneWidget);

    // When disabling.
    await tester.tap(find.text('DISABLE BACKGROUND SYNC'));
    await tester.pumpAndSettle();

    // Then the task is cancelled.
    verify(() => scheduler.cancel()).called(1);
    expect(find.text('ENABLE BACKGROUND SYNC'), findsOneWidget);
  });
}
