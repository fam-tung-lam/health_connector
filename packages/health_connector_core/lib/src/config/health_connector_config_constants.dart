import 'package:health_connector_core/src/annotations/annotations.dart'
    show sinceV1_0_0;
import 'package:meta/meta.dart';

/// Constants used throughout the Health Connector plugin.
@sinceV1_0_0
@internal
abstract final class HealthConnectorConfigConstants {
  const HealthConnectorConfigConstants._();

  /// Default page size for paginated read operations.
  static const int defaultPageSize = 100;

  /// Maximum page size for paginated read operations.
  ///
  /// This is the maximum number of records that can be requested per page.
  /// Values above this will result in an [ArgumentError].
  static const int maxPageSize = 10000;
}
