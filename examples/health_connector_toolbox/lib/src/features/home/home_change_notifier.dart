import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show ChangeNotifier;
import 'package:health_connector/health_connector.dart';

/// Manages the initialization state of the Health Connector for the home page.
final class HomeChangeNotifier extends ChangeNotifier {
  bool _isLoading = false;
  HealthConnector? _healthConnector;
  Exception? _error;

  bool get isLoading => _isLoading;

  HealthConnector? get healthConnector => _healthConnector;

  Exception? get error => _error;

  /// Initializes the Health Connector instance.
  ///
  /// Creates a new [HealthConnector] with default configuration and updates
  /// [healthConnector] on success or [error] on failure.
  Future<void> init() async {
    _isLoading = true;
    notifyListeners();

    try {
      final healthConnector = await HealthConnector.create(
        HealthConnectorConfig(),
      );

      _healthConnector = healthConnector;
    } on HealthConnectorException catch (e) {
      _error = e;
      _healthConnector = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
