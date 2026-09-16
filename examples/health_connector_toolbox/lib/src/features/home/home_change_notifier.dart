import 'package:flutter/foundation.dart' show ChangeNotifier;
import 'package:health_connector/health_connector_internal.dart';
import 'package:health_connector_toolbox/src/features/console_logs/console_log_processor.dart';
import 'package:health_connector_toolbox/src/features/console_logs/console_log_store.dart';

/// Manages the initialization state of the Health Connector for the home page.
final class HomeChangeNotifier extends ChangeNotifier {
  HomeChangeNotifier({required ConsoleLogStore consoleLogStore})
    : _consoleLogStore = consoleLogStore;

  final ConsoleLogStore _consoleLogStore;
  List<HealthConnectorLogProcessor> _registeredLogProcessors = const [];
  bool _isLoading = false;
  HealthConnector? _healthConnector;
  HealthConnectorException? _error;

  bool get isLoading => _isLoading;

  HealthConnector? get healthConnector => _healthConnector;

  HealthConnectorException? get error => _error;

  /// Initializes the Health Connector instance.
  ///
  /// Creates a new [HealthConnector] with native logging enabled and the
  /// toolbox log processors, then updates [healthConnector] on success or
  /// [error] on failure.
  Future<void> init() async {
    _isLoading = true;
    notifyListeners();

    try {
      final config = HealthConnectorConfig(
        loggerConfig: HealthConnectorLoggerConfig(
          enableNativeLogging: true,
          logProcessors: _prepareLogProcessors(),
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

  /// Builds the log processors for the next [HealthConnector.create] call.
  ///
  /// `HealthConnector.create` registers the configured processors on every
  /// call, so the processors from a previous attempt are removed first to keep
  /// a retry after an error from duplicating every log line.
  List<HealthConnectorLogProcessor> _prepareLogProcessors() {
    for (final processor in _registeredLogProcessors) {
      HealthConnectorLogger.removeProcessor(processor);
    }
    return _registeredLogProcessors = [
      const DeveloperLogProcessor(),
      ConsoleLogProcessor(_consoleLogStore),
    ];
  }

  @override
  void dispose() {
    for (final processor in _registeredLogProcessors) {
      HealthConnectorLogger.removeProcessor(processor);
    }
    _registeredLogProcessors = const [];
    _healthConnector = null;

    super.dispose();
  }
}
