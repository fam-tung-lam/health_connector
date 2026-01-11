import 'package:health_connector_core/src/annotations/annotations.dart';
import 'package:health_connector_logger/health_connector_logger.dart';
import 'package:meta/meta.dart' show immutable;

/// Configuration for Health Connector.
///
/// {@category Core API}
@sinceV1_0_0
@immutable
final class HealthConnectorConfig {
  /// Creates a new [HealthConnectorConfig] instance.
  ///
  /// ## Parameters
  ///
  /// - [loggerConfig]: Configuration for the Health Connector logger.
  const HealthConnectorConfig({
    this.loggerConfig = const HealthConnectorLoggerConfig(),
  });

  /// Configuration for the Health Connector logger.
  final HealthConnectorLoggerConfig loggerConfig;
}
