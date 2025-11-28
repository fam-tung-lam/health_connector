import 'package:health_connector_annotation/health_connector_annotation.dart'
    show internalUse, sinceV1_0_0;

/// Constants used throughout the Health Connector plugin.
@sinceV1_0_0
@internalUse
abstract final class HealthConnectorConfigConstants {
  const HealthConnectorConfigConstants._();

  /// Default page size for paginated read operations.
  ///
  /// This is the default number of records returned per page when reading
  /// health records. Clients can override this by specifying a custom pageSize.
  static const int defaultPageSize = 100;

  /// Maximum page size for paginated read operations.
  ///
  /// This is the maximum number of records that can be requested per page.
  /// Values above this will result in an [ArgumentError].
  static const int maxPageSize = 10000;
}
