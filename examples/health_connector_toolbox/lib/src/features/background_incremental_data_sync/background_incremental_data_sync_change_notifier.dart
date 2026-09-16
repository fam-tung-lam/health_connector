import 'package:flutter/foundation.dart' show ChangeNotifier;
import 'package:health_connector/health_connector_internal.dart'
    show
        HealthConnector,
        HealthConnectorException,
        HealthConnectorLogger,
        HealthDataSyncToken,
        HealthDataType,
        HealthPlatform,
        HealthPlatformFeature,
        HealthPlatformFeatureStatus,
        PermissionStatus;
import 'package:health_connector_toolbox/src/features/background_incremental_data_sync/background_sync_worker.dart';
import 'package:health_connector_toolbox/src/features/background_incremental_data_sync/models/background_sync_report.dart';
import 'package:health_connector_toolbox/src/features/background_incremental_data_sync/models/background_sync_settings.dart';
import 'package:health_connector_toolbox/src/features/background_incremental_data_sync/services/background_sync_scheduler.dart';
import 'package:health_connector_toolbox/src/features/background_incremental_data_sync/services/background_sync_storage.dart';
import 'package:workmanager/workmanager.dart' show WorkInfo;

/// State and actions of the background incremental data sync screen.
///
/// The notifier owns the persisted selection, the sync token, the latest run
/// report, and the scheduler registration. It never runs the sync itself in
/// the background; the scheduler starts [BackgroundSyncWorker] in a headless
/// isolate, and the notifier only observes what that run persisted.
final class BackgroundIncrementalDataSyncChangeNotifier extends ChangeNotifier {
  BackgroundIncrementalDataSyncChangeNotifier({
    required HealthConnector healthConnector,
    required BackgroundSyncStorage storage,
    required BackgroundSyncScheduler scheduler,
  }) : _healthConnector = healthConnector,
       _storage = storage,
       _scheduler = scheduler;

  static const String _tag = 'BackgroundIncrementalDataSync';

  /// Frequencies offered in the UI; 15 minutes is the Android minimum.
  static const List<Duration> frequencyOptions = [
    Duration(minutes: 15),
    Duration(minutes: 30),
    Duration(hours: 1),
    Duration(hours: 6),
  ];

  final HealthConnector _healthConnector;
  final BackgroundSyncStorage _storage;
  final BackgroundSyncScheduler _scheduler;

  bool _isDisposed = false;
  bool _isLoading = false;
  bool _isSyncing = false;
  BackgroundSyncSettings _settings = const BackgroundSyncSettings();
  HealthDataSyncToken? _syncToken;
  BackgroundSyncReport? _latestReport;
  WorkInfo? _workInfo;
  HealthPlatformFeatureStatus? _backgroundReadFeatureStatus;
  PermissionStatus? _backgroundReadPermissionStatus;

  /// Whether the initial load is in progress.
  bool get isLoading => _isLoading;

  /// Whether a manual sync run is in progress.
  bool get isSyncing => _isSyncing;

  BackgroundSyncSettings get settings => _settings;

  List<HealthDataType> get selectedDataTypes => _settings.dataTypes;

  bool get isBackgroundSyncEnabled => _settings.isEnabled;

  HealthDataSyncToken? get syncToken => _syncToken;

  BackgroundSyncReport? get latestReport => _latestReport;

  /// Scheduler view of the task, when the platform reports one.
  WorkInfo? get workInfo => _workInfo;

  /// Whether the platform needs a dedicated background read permission.
  bool get requiresBackgroundReadPermission =>
      _healthConnector.healthPlatform == HealthPlatform.healthConnect;

  HealthPlatformFeatureStatus? get backgroundReadFeatureStatus =>
      _backgroundReadFeatureStatus;

  PermissionStatus? get backgroundReadPermissionStatus =>
      _backgroundReadPermissionStatus;

  /// Loads persisted state and platform status.
  ///
  /// When background sync is enabled the periodic task is submitted again.
  /// iOS drops pending `BGAppRefreshTask` requests on reinstall or update and
  /// the plugin only re-registers launch handlers, so without this the screen
  /// would show "Active" while nothing is scheduled. On Android the update
  /// policy makes the call idempotent.
  Future<void> initialize() async {
    _notify(() => _isLoading = true);
    try {
      _settings = await _storage.loadSettings();
      if (_settings.isEnabled) {
        await _ensureScheduled();
      }
      await _loadBackgroundReadStatus();
      await refresh();
    } finally {
      _notify(() => _isLoading = false);
    }
  }

  /// Reloads the token, latest report, and scheduler state.
  ///
  /// Called periodically and on app resume so a run that finished in the
  /// background isolate becomes visible.
  Future<void> refresh() async {
    final token = await _storage.loadToken();
    final report = await _storage.loadReport();
    final workInfo = await _loadWorkInfo();
    _notify(() {
      _syncToken = token;
      _latestReport = report;
      _workInfo = workInfo;
    });
  }

  /// Persists a new selection.
  ///
  /// A stored token is only valid for the data types it was created with, so
  /// the token is cleared when the selection changes. Returns whether the
  /// token was cleared.
  Future<bool> updateSelectedDataTypes(List<HealthDataType> dataTypes) async {
    final settings = _settings.copyWith(dataTypes: dataTypes);
    await _storage.saveSettings(settings);

    final token = _syncToken;
    final tokenCleared = token != null && !_sameIds(token.dataTypes, dataTypes);
    if (tokenCleared) {
      await _storage.saveToken(null);
      HealthConnectorLogger.warning(
        _tag,
        operation: 'updateSelectedDataTypes',
        message: 'Data types changed, stored sync token cleared',
      );
    }

    HealthConnectorLogger.info(
      _tag,
      operation: 'updateSelectedDataTypes',
      message: 'Background sync data types updated',
      context: {'data_types': settings.dataTypeIds},
    );

    _notify(() {
      _settings = settings;
      if (tokenCleared) {
        _syncToken = null;
      }
    });
    return tokenCleared;
  }

  /// Persists [frequency] and re-registers the task when it is enabled.
  Future<void> updateFrequency(Duration frequency) async {
    final settings = _settings.copyWith(frequency: frequency);
    await _storage.saveSettings(settings);
    if (settings.isEnabled) {
      await _scheduler.schedule(frequency);
    }
    HealthConnectorLogger.info(
      _tag,
      operation: 'updateFrequency',
      message: 'Background sync frequency updated',
      context: {'frequency_minutes': frequency.inMinutes},
    );
    final workInfo = await _loadWorkInfo();
    _notify(() {
      _settings = settings;
      _workInfo = workInfo;
    });
  }

  /// Registers the periodic task.
  ///
  /// Throws [ArgumentError] when no data types are selected.
  Future<void> enableBackgroundSync() async {
    if (_settings.dataTypes.isEmpty) {
      throw ArgumentError('Select at least one data type first');
    }

    await _scheduler.schedule(_settings.frequency);
    final settings = _settings.copyWith(isEnabled: true);
    await _storage.saveSettings(settings);
    HealthConnectorLogger.info(
      _tag,
      operation: 'enableBackgroundSync',
      message: 'Background sync task registered',
      context: {
        'frequency_minutes': settings.frequency.inMinutes,
        'data_types': settings.dataTypeIds,
      },
    );

    final workInfo = await _loadWorkInfo();
    _notify(() {
      _settings = settings;
      _workInfo = workInfo;
    });
  }

  /// Cancels the periodic task.
  Future<void> disableBackgroundSync() async {
    await _scheduler.cancel();
    final settings = _settings.copyWith(isEnabled: false);
    await _storage.saveSettings(settings);
    HealthConnectorLogger.info(
      _tag,
      operation: 'disableBackgroundSync',
      message: 'Background sync task cancelled',
    );

    final workInfo = await _loadWorkInfo();
    _notify(() {
      _settings = settings;
      _workInfo = workInfo;
    });
  }

  /// Runs the worker once in the foreground with the connector of the UI.
  ///
  /// Uses the exact code path the scheduler executes, which is the quickest
  /// way to debug the sync logic without waiting for the platform.
  Future<BackgroundSyncRunResult> runSyncNow() async {
    _notify(() => _isSyncing = true);
    try {
      final worker = BackgroundSyncWorker(
        createHealthConnector: () async => _healthConnector,
        storage: _storage,
      );
      final result = await worker.run(trigger: BackgroundSyncTrigger.manual);
      await refresh();
      return result;
    } finally {
      _notify(() => _isSyncing = false);
    }
  }

  /// Removes the stored token so the next run starts from a new baseline.
  Future<void> clearToken() async {
    await _storage.saveToken(null);
    HealthConnectorLogger.info(
      _tag,
      operation: 'clearToken',
      message: 'Background sync token cleared',
    );
    _notify(() => _syncToken = null);
  }

  /// Requests the platform permission needed to read data in the background.
  Future<void> requestBackgroundReadPermission() async {
    final permission =
        HealthPlatformFeature.readHealthDataInBackground.permission;
    final results = await _healthConnector.requestPermissions([permission]);
    final status = results
        .where((result) => result.permission == permission)
        .map((result) => result.status)
        .firstOrNull;
    HealthConnectorLogger.info(
      _tag,
      operation: 'requestBackgroundReadPermission',
      message: 'Background read permission requested',
      context: {'status': status?.name},
    );
    _notify(() => _backgroundReadPermissionStatus = status);
  }

  Future<void> _loadBackgroundReadStatus() async {
    if (!requiresBackgroundReadPermission) {
      return;
    }
    const feature = HealthPlatformFeature.readHealthDataInBackground;
    try {
      _backgroundReadFeatureStatus = await _healthConnector.getFeatureStatus(
        feature,
      );
      final granted = await _healthConnector.getGrantedPermissions();
      _backgroundReadPermissionStatus = granted.contains(feature.permission)
          ? PermissionStatus.granted
          : PermissionStatus.unknown;
    } on HealthConnectorException catch (e, stackTrace) {
      HealthConnectorLogger.warning(
        _tag,
        operation: 'initialize',
        message: 'Could not load background read permission status',
        exception: e,
        stackTrace: stackTrace,
      );
    }
  }

  Future<void> _ensureScheduled() async {
    try {
      await _scheduler.schedule(_settings.frequency);
      HealthConnectorLogger.info(
        _tag,
        operation: 'initialize',
        message: 'Background sync task re-submitted',
        context: {'frequency_minutes': _settings.frequency.inMinutes},
      );
    } on Exception catch (e, stackTrace) {
      HealthConnectorLogger.warning(
        _tag,
        operation: 'initialize',
        message: 'Could not re-submit background sync task',
        exception: e,
        stackTrace: stackTrace,
      );
    }
  }

  Future<WorkInfo?> _loadWorkInfo() async {
    try {
      return await _scheduler.getWorkInfo();
    } on Exception catch (e, stackTrace) {
      HealthConnectorLogger.warning(
        _tag,
        operation: 'getWorkInfo',
        message: 'Scheduler work info unavailable',
        exception: e,
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  static bool _sameIds(List<HealthDataType> a, List<HealthDataType> b) {
    final aIds = a.map((type) => type.id).toSet();
    final bIds = b.map((type) => type.id).toSet();
    return aIds.length == bIds.length && aIds.containsAll(bIds);
  }

  /// Applies [mutate] and notifies listeners unless the notifier was disposed
  /// while an awaited storage or scheduler call was still pending.
  void _notify(void Function() mutate) {
    mutate();
    if (!_isDisposed) {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }
}
