import 'package:health_connector_hc_android/health_connector_hc_android.dart';
import 'package:health_connector_hc_android/src/mappers/health_connector_log_mapper.dart';
import 'package:health_connector_hc_android/src/pigeon/health_connector_hc_android_api.g.dart';
import 'package:health_connector_logger/health_connector_logger.dart';
import 'package:meta/meta.dart';

/// Flutter implementation of [HealthConnectorNativeLogApi] for Android.
///
/// This singleton class receives log events from the native Android platform
/// and forwards them to [HealthConnectorLogger] for centralized processing.
///
/// The native Android code calls [onNativeLogEvent] whenever the Health
/// Connector SDK emits a log during operations such as reading, writing, or
/// synchronizing health data.
///
/// Lifecycle:
/// - Initialize via [init] during [HealthConnectorHCClient] setup
/// - Access the singleton instance via [instance]
/// - Automatically receives log events from native code
@internal
@immutable
final class HealthConnectorHCNativeLogApi
    implements HealthConnectorNativeLogApi {
  const HealthConnectorHCNativeLogApi._();

  static HealthConnectorHCNativeLogApi? _instance;

  /// Initializes the singleton instance of [HealthConnectorHCNativeLogApi].
  ///
  /// This method should be called once during [HealthConnectorHCClient]
  /// initialization.
  static void init() {
    _instance = const HealthConnectorHCNativeLogApi._();
    HealthConnectorNativeLogApi.setUp(_instance);
  }

  /// Returns the singleton instance of [HealthConnectorHCNativeLogApi].
  ///
  /// Throws a [StateError] if [init] has not been called yet.
  static HealthConnectorHCNativeLogApi get instance {
    if (_instance == null) {
      throw StateError(
        'HealthConnectorHCNativeLogApi has not been initialized. '
        'Call init() first.',
      );
    }
    return _instance!;
  }

  /// Receives log events from the native Android platform.
  ///
  /// This method is invoked by the native Android code whenever a log event
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
