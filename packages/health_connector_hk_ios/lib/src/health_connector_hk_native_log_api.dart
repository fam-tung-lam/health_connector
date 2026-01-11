import 'package:health_connector_hk_ios/src/health_connector_hk_client.dart';
import 'package:health_connector_hk_ios/src/mappers/health_connector_log_mapper.dart';
import 'package:health_connector_hk_ios/src/pigeon/health_connector_hk_ios_api.g.dart';
import 'package:health_connector_logger/health_connector_logger.dart';
import 'package:meta/meta.dart';

/// Flutter implementation of [HealthConnectorNativeLogApi] for iOS.
///
/// This singleton class receives log events from the native iOS platform
/// and forwards them to [HealthConnectorLogger] for centralized processing.
///
/// The native iOS code calls [onNativeLogEvent] whenever the Health Connector
/// SDK emits a log during operations such as reading, writing, or
/// synchronizing health data.
///
/// Lifecycle:
/// - Initialize via [init] during [HealthConnectorHKClient] setup
/// - Access the singleton instance via [instance]
/// - Automatically receives log events from native code
@internal
@immutable
final class HealthConnectorHKNativeLogApi
    implements HealthConnectorNativeLogApi {
  const HealthConnectorHKNativeLogApi._();

  static HealthConnectorHKNativeLogApi? _instance;

  /// Initializes the singleton instance of [HealthConnectorHKNativeLogApi].
  ///
  /// This method should be called once during [HealthConnectorHKClient]
  /// initialization.
  static void init() {
    _instance = const HealthConnectorHKNativeLogApi._();
    HealthConnectorNativeLogApi.setUp(_instance);
  }

  /// Returns the singleton instance of [HealthConnectorHKNativeLogApi].
  ///
  /// Throws a [StateError] if [init] has not been called yet.
  static HealthConnectorHKNativeLogApi get instance {
    if (_instance == null) {
      throw StateError(
        'HealthConnectorHKNativeLogApi has not been initialized. '
        'Call init() first.',
      );
    }
    return _instance!;
  }

  /// Receives log events from the native iOS platform.
  ///
  /// This method is invoked by the native iOS code whenever a log event
  /// occurs in the Health Connector SDK. The log is converted to the domain
  /// model and forwarded to [HealthConnectorLogger.internalLog] for processing.
  ///
  /// Parameters:
  /// - [log]: The log event DTO from the native platform containing level,
  ///   message, timestamp, and optional exception information
  @override
  void onNativeLogEvent(HealthConnectorLogDto log) {
    HealthConnectorLogger.internalLog(log.toDomain());
  }
}
