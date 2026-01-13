import 'dart:convert';

import 'package:health_connector/health_connector.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Service for persisting [HealthDataSyncToken] using SharedPreferences.
///
/// This service handles serialization/deserialization of sync tokens and
/// timestamps for incremental data synchronization.
final class SyncTokenStorageService {
  static const String _syncTokenKey = 'health_sync_token';

  final SharedPreferences _prefs;

  SyncTokenStorageService(this._prefs);

  /// Saves the sync token to persistent storage.
  ///
  /// If [token] is null, removes the stored token.
  Future<void> saveToken(HealthDataSyncToken? token) async {
    if (token == null) {
      await _prefs.remove(_syncTokenKey);
    } else {
      final json = jsonEncode(token.toJson());
      await _prefs.setString(_syncTokenKey, json);
    }
  }

  /// Loads the sync token from persistent storage.
  ///
  /// Returns null if no token is saved or if the saved token is corrupted.
  Future<HealthDataSyncToken?> loadToken() async {
    final json = _prefs.getString(_syncTokenKey);
    if (json == null) {
      return null;
    }

    try {
      final map = jsonDecode(json) as Map<String, dynamic>;
      return HealthDataSyncToken.fromJson(map);
    } on Exception {
      // Token format changed or corrupted, clear it
      await clearToken();
      return null;
    }
  }

  /// Clears both the sync token and last sync timestamp from storage.
  Future<void> clearToken() async {
    await _prefs.remove(_syncTokenKey);
  }
}
