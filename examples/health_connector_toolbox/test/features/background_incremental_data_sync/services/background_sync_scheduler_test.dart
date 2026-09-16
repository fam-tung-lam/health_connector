import 'package:flutter_test/flutter_test.dart';
import 'package:health_connector_toolbox/src/features/background_incremental_data_sync/services/background_sync_scheduler.dart';
import 'package:mocktail/mocktail.dart';
import 'package:workmanager/workmanager.dart';

class MockWorkmanager extends Mock implements Workmanager {}

void main() {
  late MockWorkmanager workmanager;
  late WorkmanagerBackgroundSyncScheduler scheduler;
  const id = WorkmanagerBackgroundSyncScheduler.taskIdentifier;

  setUpAll(() {
    registerFallbackValue(Constraints());
  });

  setUp(() {
    workmanager = MockWorkmanager();
    scheduler = WorkmanagerBackgroundSyncScheduler(workmanager);
  });

  test('schedule registers a periodic task under one identifier', () async {
    // Given the plugin accepts the registration.
    when(
      () => workmanager.registerPeriodicTask(
        any(),
        any(),
        frequency: any(named: 'frequency'),
        existingWorkPolicy: any(named: 'existingWorkPolicy'),
        backoffPolicy: any(named: 'backoffPolicy'),
        backoffPolicyDelay: any(named: 'backoffPolicyDelay'),
        constraints: any(named: 'constraints'),
      ),
    ).thenAnswer((_) async {});

    // When the task is scheduled every 30 minutes.
    await scheduler.schedule(const Duration(minutes: 30));

    // Then unique name and task name are the shared identifier.
    final captured = verify(
      () => workmanager.registerPeriodicTask(
        captureAny(),
        captureAny(),
        frequency: captureAny(named: 'frequency'),
        existingWorkPolicy: captureAny(named: 'existingWorkPolicy'),
        backoffPolicy: any(named: 'backoffPolicy'),
        backoffPolicyDelay: any(named: 'backoffPolicyDelay'),
        constraints: any(named: 'constraints'),
      ),
    ).captured;
    expect(captured, [
      id,
      id,
      const Duration(minutes: 30),
      ExistingPeriodicWorkPolicy.update,
    ]);
  });

  test('cancel and getWorkInfo use the same identifier', () async {
    // Given the plugin knows the task.
    when(() => workmanager.cancelByUniqueName(id)).thenAnswer((_) async {});
    const info = WorkInfo(
      uniqueName: id,
      state: WorkState.scheduled,
      isPeriodic: true,
    );
    when(() => workmanager.getWorkInfo(id)).thenAnswer((_) async => info);

    // When the scheduler cancels and inspects the task.
    await scheduler.cancel();
    final result = await scheduler.getWorkInfo();

    // Then the plugin was addressed by the identifier.
    verify(() => workmanager.cancelByUniqueName(id)).called(1);
    expect(result, info);
  });
}
