import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show ChangeNotifier;
import 'package:health_connector/health_connector_internal.dart';

/// Manages the initialization state of the Health Connector for the home page.
final class HomeChangeNotifier extends ChangeNotifier {
  StreamSubscription<HealthConnectorLog>? _logEventSubscription;
  bool _isLoading = false;
  HealthConnector? _healthConnector;
  HealthConnectorException? _error;

  bool get isLoading => _isLoading;

  HealthConnector? get healthConnector => _healthConnector;

  HealthConnectorException? get error => _error;

  /// Initializes the Health Connector instance.
  ///
  /// Creates a new [HealthConnector] with default configuration and updates
  /// [healthConnector] on success or [error] on failure.
  Future<void> init() async {
    _isLoading = true;
    notifyListeners();

    try {
      const config = HealthConnectorConfig(
        loggerConfig: HealthConnectorLoggerConfig(
          logProcessors: [
            DeveloperLogProcessor(),
          ],
        ),
      );
      final healthConnector = await HealthConnector.create(config);

      _healthConnector = healthConnector;
    } on HealthConnectorException catch (e) {
      _error = e;
      _healthConnector = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Launches the health app page in the respective app store.
  Future<void> launchHealthAppPageInAppStore() async {
    try {
      await HealthConnector.launchHealthAppPageInAppStore();
    } on HealthConnectorException {
      rethrow;
    }
  }

  @override
  void dispose() {
    _logEventSubscription?.cancel();
    _logEventSubscription = null;
    _healthConnector = null;

    super.dispose();
  }
}
