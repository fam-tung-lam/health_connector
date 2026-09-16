import 'dart:convert';

import 'package:health_connector/health_connector.dart'
    show HealthDataSyncToken;
import 'package:health_connector_toolbox/src/features/background_incremental_data_sync/models/background_sync_report.dart';
import 'package:health_connector_toolbox/src/features/background_incremental_data_sync/models/background_sync_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Persistence shared by the toolbox UI and the background sync isolate.
///
/// Stores the sync settings, the current [HealthDataSyncToken], and the
/// latest [BackgroundSyncReport]. Only the most recent report is kept.
abstract interface class BackgroundSyncStorage {
  Future<BackgroundSyncSettings> loadSettings();

  Future<void> saveSettings(BackgroundSyncSettings settings);

  Future<HealthDataSyncToken?> loadToken();

  /// Stores [token], or removes the stored token when [token] is null.
  Future<void> saveToken(HealthDataSyncToken? token);

  Future<BackgroundSyncReport?> loadReport();

  Future<void> saveReport(BackgroundSyncReport report);

  Future<void> clearReport();
}

/// [BackgroundSyncStorage] backed by [SharedPreferencesAsync].
///
/// The async API has no per-isolate cache, so values written by the
/// background isolate are visible to the next read from the UI isolate and
/// vice versa.
final class SharedPreferencesBackgroundSyncStorage
    implements BackgroundSyncStorage {
  const SharedPreferencesBackgroundSyncStorage(this._preferences);

  final SharedPreferencesAsync _preferences;

  static const String _settingsKey = 'background_sync.settings';
  static const String _tokenKey = 'background_sync.token';
  static const String _reportKey = 'background_sync.report';

  @override
  Future<BackgroundSyncSettings> loadSettings() async {
    final json = await _readJson(_settingsKey);
    return json == null
        ? const BackgroundSyncSettings()
        : BackgroundSyncSettings.fromJson(json);
  }

  @override
  Future<void> saveSettings(BackgroundSyncSettings settings) {
    return _preferences.setString(_settingsKey, jsonEncode(settings.toJson()));
  }

  @override
  Future<HealthDataSyncToken?> loadToken() async {
    final json = await _readJson(_tokenKey);
    if (json == null) {
      return null;
    }
    try {
      return HealthDataSyncToken.fromJson(json);
    } on Exception {
      // The token format changed or references an unknown data type.
      await _preferences.remove(_tokenKey);
      return null;
    }
  }

  @override
  Future<void> saveToken(HealthDataSyncToken? token) {
    if (token == null) {
      return _preferences.remove(_tokenKey);
    }
    return _preferences.setString(_tokenKey, jsonEncode(token.toJson()));
  }

  @override
  Future<BackgroundSyncReport?> loadReport() async {
    final json = await _readJson(_reportKey);
    return json == null ? null : BackgroundSyncReport.fromJson(json);
  }

  @override
  Future<void> saveReport(BackgroundSyncReport report) {
    return _preferences.setString(_reportKey, jsonEncode(report.toJson()));
  }

  @override
  Future<void> clearReport() => _preferences.remove(_reportKey);

  Future<Map<String, dynamic>?> _readJson(String key) async {
    final raw = await _preferences.getString(key);
    if (raw == null) {
      return null;
    }
    try {
      return jsonDecode(raw) as Map<String, dynamic>;
    } on Exception {
      await _preferences.remove(key);
      return null;
    }
  }
}
