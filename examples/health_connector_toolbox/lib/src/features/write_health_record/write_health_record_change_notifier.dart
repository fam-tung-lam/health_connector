import 'package:flutter/foundation.dart' show ChangeNotifier;
import 'package:health_connector/health_connector.dart'
    show HealthRecord, HealthRecordId, HealthPlatform, HealthConnector;

/// Manages state and operations for writing health records.
///
/// Handles writing health records to the health platform, tracking loading
/// state and the ID of newly created records.
final class WriteHealthRecordChangeNotifier extends ChangeNotifier {
  final HealthConnector _healthConnector;

  WriteHealthRecordChangeNotifier(this._healthConnector);

  bool _isLoading = false;

  HealthRecordId? _newRecordId;

  HealthRecordId? get newRecordId => _newRecordId;

  HealthPlatform get healthPlatform => _healthConnector.healthPlatform;

  bool get isLoading => _isLoading;

  /// Writes a health record to the health platform.
  ///
  /// Sets loading state and updates [newRecordId] on success.
  /// Exceptions are propagated to the caller for handling.
  Future<void> writeHealthRecord(HealthRecord record) async {
    _isLoading = true;
    notifyListeners();

    try {
      _newRecordId = await _healthConnector.writeRecord(record);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
