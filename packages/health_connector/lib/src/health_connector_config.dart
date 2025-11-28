import 'package:health_connector_annotation/health_connector_annotation.dart'
    show sinceV1_0_0;
import 'package:health_connector_hc_android/health_connector_hc_android.dart'
    show HealthConnectorHCClient;
import 'package:health_connector_hk_ios/health_connector_hk_ios.dart';
import 'package:health_connector_logger/health_connector_logger.dart';
import 'package:meta/meta.dart' show immutable, internal;

/// Configuration for Health Connector.
///
/// This immutable data class holds configuration settings for the Health
/// Connector, including logger settings and platform-specific clients.
@sinceV1_0_0
@immutable
final class HealthConnectorConfig {
  /// Creates a new [HealthConnectorConfig] instance.
  ///
  /// ## Parameters
  ///
  /// - [isLoggerEnabled]: Whether logging is enabled. Defaults to `true`.
  factory HealthConnectorConfig({bool isLoggerEnabled = true}) {
    return HealthConnectorConfig._(
      healthConnectClient: const HealthConnectorHCClient(),
      healthKitClient: const HealthConnectorHKClient(),
      isLoggerEnabled: isLoggerEnabled,
    );
  }

  /// Creates a new [HealthConnectorConfig] instance.
  ///
  /// ## Parameters
  ///
  /// - [isLoggerEnabled]: Whether logging is enabled. Defaults to `true`.
  /// - [healthConnectClient]: The Android Health Connect platform client.
  /// - [healthKitClient]: The iOS HealthKit platform client.
  const HealthConnectorConfig._({
    required this.healthConnectClient,
    required this.healthKitClient,
    this.isLoggerEnabled = true,
  });

  /// Whether [HealthConnectorLogger] is enabled.
  final bool isLoggerEnabled;

  /// The Android Health Connect platform client.
  @internal
  final HealthConnectorHCClient healthConnectClient;

  /// The iOS HealthKit platform client.
  @internal
  final HealthConnectorHKClient healthKitClient;
}
