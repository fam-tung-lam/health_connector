import 'package:health_connector/health_connector.dart'
    show HealthDataSyncToken;
import 'package:health_connector_toolbox/src/features/background_incremental_data_sync/models/background_sync_report.dart';
import 'package:health_connector_toolbox/src/features/background_incremental_data_sync/models/background_sync_settings.dart';
import 'package:health_connector_toolbox/src/features/background_incremental_data_sync/services/background_sync_storage.dart';

/// In-memory [BackgroundSyncStorage] double.
final class InMemoryBackgroundSyncStorage implements BackgroundSyncStorage {
  BackgroundSyncSettings settings = const BackgroundSyncSettings();
  HealthDataSyncToken? token;
  BackgroundSyncReport? report;
  int tokenWrites = 0;

  @override
  Future<BackgroundSyncSettings> loadSettings() async => settings;

  @override
  Future<void> saveSettings(BackgroundSyncSettings settings) async {
    this.settings = settings;
  }

  @override
  Future<HealthDataSyncToken?> loadToken() async => token;

  @override
  Future<void> saveToken(HealthDataSyncToken? token) async {
    tokenWrites++;
    this.token = token;
  }

  @override
  Future<BackgroundSyncReport?> loadReport() async => report;

  @override
  Future<void> saveReport(BackgroundSyncReport report) async {
    this.report = report;
  }

  @override
  Future<void> clearReport() async {
    report = null;
  }
}

/// Builds a sync token through the public JSON constructor.
HealthDataSyncToken buildToken({
  required String value,
  required List<String> dataTypeIds,
  DateTime? createdAt,
}) {
  return HealthDataSyncToken.fromJson({
    'token': value,
    'dataTypes': dataTypeIds,
    'createdAt': (createdAt ?? DateTime.utc(2026, 9)).toIso8601String(),
  });
}
