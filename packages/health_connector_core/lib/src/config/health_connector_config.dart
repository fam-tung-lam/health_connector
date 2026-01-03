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
  /// - [isLoggerEnabled]: Whether logging is enabled. Defaults to `true`.
  const HealthConnectorConfig({this.isLoggerEnabled = true});

  /// Whether [HealthConnectorLogger] is enabled.
  final bool isLoggerEnabled;
}
