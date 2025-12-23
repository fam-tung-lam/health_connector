import 'package:health_connector_core/health_connector_core.dart'
    show sinceV1_0_0;
import 'package:health_connector_logger/health_connector_logger.dart';
import 'package:meta/meta.dart' show immutable;

/// Configuration for Health Connector.
///
/// This immutable data class holds configuration settings for the Health
/// Connector, including logger settings.
///
/// {@category Core API}
@sinceV1_0_0
@immutable
final class HealthConnectorConfig {
  /// Creates a new [HealthConnectorConfig] instance.
  ///
  /// ## Parameters
  ///
  /// - [isLoggerEnabled]: Whether logging is enabled. Defaults to `true`.
  const HealthConnectorConfig({this.isLoggerEnabled = true});

  /// Whether [HealthConnectorLogger] is enabled.
  final bool isLoggerEnabled;
}
