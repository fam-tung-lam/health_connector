import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:health_connector/health_connector.dart';
import 'package:health_connector_toolbox/src/features/incremental_data_sync/services/sync_token_storage_service.dart';

/// ChangeNotifier for managing incremental data synchronization state.
///
/// Handles sync token persistence, data synchronization, and pagination for
/// the test harness UI.
final class IncrementalDataSyncChangeNotifier extends ChangeNotifier {
  final HealthConnector _healthConnector;
  final SyncTokenStorageService _storageService;

  // State variables
  bool _isLoading = false;
  HealthDataSyncToken? _syncToken;
  List<HealthDataType> _selectedDataTypes = [];

  // Sync results
  List<HealthRecord> _upsertedRecords = [];
  List<HealthRecordId> _deletedRecordIds = [];
  bool _hasMore = false;

  // Getters
  bool get isLoading => _isLoading;

  HealthDataSyncToken? get syncToken => _syncToken;

  List<HealthDataType> get selectedDataTypes => _selectedDataTypes;

  UnmodifiableListView<HealthRecord> get upsertedRecords =>
      UnmodifiableListView(_upsertedRecords);

  UnmodifiableListView<HealthRecordId> get deletedRecordIds =>
      UnmodifiableListView(_deletedRecordIds);

  bool get hasMore => _hasMore;

  IncrementalDataSyncChangeNotifier(
    this._healthConnector,
    this._storageService,
  );

  /// Initializes the notifier by loading saved token and timestamp from
  /// storage.
  Future<void> initialize() async {
    notify(() => _isLoading = true);
    try {
      final token = await _storageService.loadToken();
      notify(() {
        _syncToken = token;
        if (token != null) {
          _selectedDataTypes = List.from(token.dataTypes);
        }
      });
    } finally {
      notify(() => _isLoading = false);
    }
  }

  /// Performs synchronization with the selected data types.
  ///
  /// Throws [ArgumentError] if no data types are selected.
  Future<void> synchronize() async {
    if (_selectedDataTypes.isEmpty) {
      throw ArgumentError('Please select at least one data type');
    }

    notify(() => _isLoading = true);

    try {
      final result = await _healthConnector.synchronize(
        dataTypes: _selectedDataTypes,
        syncToken: _syncToken,
      );

      // Append results
      notify(() {
        _upsertedRecords.addAll(result.upsertedRecords);
        _deletedRecordIds.addAll(result.deletedRecordIds);
        _hasMore = result.hasMore;
        _syncToken = result.nextSyncToken;
      });

      // Save token
      await _storageService.saveToken(_syncToken);
    } finally {
      notify(() => _isLoading = false);
    }
  }

  /// Loads more results if pagination is available.
  Future<void> loadMore() async {
    if (!_hasMore || _syncToken == null) {
      return;
    }
    await synchronize();
  }

  /// Clears the sync token from storage and resets state.
  Future<void> clearToken() async {
    notify(() => _isLoading = true);
    try {
      await _storageService.clearToken();
      notify(() {
        _syncToken = null;
        _upsertedRecords = [];
        _deletedRecordIds = [];
        _hasMore = false;
      });
    } finally {
      notify(() => _isLoading = false);
    }
  }

  /// Clears the results without affecting the token.
  void clearResults() {
    notify(() {
      _upsertedRecords = [];
      _deletedRecordIds = [];
      _hasMore = false;
    });
  }

  /// Updates the selected data types for synchronization.
  void updateSelectedDataTypes(
    List<HealthDataType> dataTypes,
  ) {
    notify(() {
      _selectedDataTypes = dataTypes;
    });
  }

  /// Helper method to notify listeners after state mutation.
  void notify(void Function() fn) {
    fn();
    notifyListeners();
  }
}
