import 'package:workmanager/workmanager.dart';

/// Registers, cancels, and inspects the periodic background sync task.
///
/// The interface keeps the change notifier testable without touching the
/// platform scheduler.
abstract interface class BackgroundSyncScheduler {
  /// Registers or updates the periodic task with [frequency].
  Future<void> schedule(Duration frequency);

  /// Cancels the periodic task.
  Future<void> cancel();

  /// Returns the scheduler's view of the task, or null when it is unknown.
  Future<WorkInfo?> getWorkInfo();
}

/// [BackgroundSyncScheduler] backed by the `workmanager` plugin.
///
/// One identifier is used for both the unique name and the task name:
///
/// - Android WorkManager keys periodic work by the unique name and hands the
///   task name to the Dart callback.
/// - iOS BGTaskScheduler submits the unique name as the task identifier, which
///   therefore has to appear in `BGTaskSchedulerPermittedIdentifiers`, and
///   hands that same identifier to the Dart callback.
///
/// Using one string for both keeps the callback dispatcher platform-agnostic.
final class WorkmanagerBackgroundSyncScheduler
    implements BackgroundSyncScheduler {
  const WorkmanagerBackgroundSyncScheduler(this._workmanager);

  final Workmanager _workmanager;

  /// Identifier of the periodic task on both platforms.
  ///
  /// Must match `BGTaskSchedulerPermittedIdentifiers` in the iOS Info.plist.
  static const String taskIdentifier =
      'com.phamtunglam.healthconnector.background_sync';

  @override
  Future<void> schedule(Duration frequency) {
    return _workmanager.registerPeriodicTask(
      taskIdentifier,
      taskIdentifier,
      frequency: frequency,
      // Keep the existing schedule when re-enabling; WorkManager only
      // rewrites the request specification.
      existingWorkPolicy: ExistingPeriodicWorkPolicy.update,
      // Android retries with exponential backoff when the task returns false.
      backoffPolicy: BackoffPolicy.exponential,
      backoffPolicyDelay: const Duration(minutes: 1),
      constraints: Constraints(requiresBatteryNotLow: true),
    );
  }

  @override
  Future<void> cancel() => _workmanager.cancelByUniqueName(taskIdentifier);

  @override
  Future<WorkInfo?> getWorkInfo() => _workmanager.getWorkInfo(taskIdentifier);
}
