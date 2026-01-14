import 'package:health_connector_logger/src/log_processors/health_connector_log_processor.dart';
import 'package:health_connector_logger/src/models/health_connector_log.dart';
import 'package:health_connector_logger/src/models/health_connector_log_level.dart';
import 'package:meta/meta.dart';

/// Configuration for the HealthConnector logging system.
///
/// This class defines which log processors will receive and handle log records
/// from the health connector SDK. Processors operate independently, allowing
/// logs to be routed to multiple destinations simultaneously (console, files,
/// remote services, etc.).
///
/// Native logging can be controlled via [enableNativeLogging], which determines
/// whether logs from platform-specific code (Kotlin/Swift) are forwarded to
/// Flutter.
///
/// ## Overview
///
/// The logging configuration consists of a list of
/// [HealthConnectorLogProcessor]
///
/// ## Multiple Destinations
///
/// Route logs to different destinations based on severity:
///
/// ```dart
/// final config = HealthConnectorLogConfig(
///   logProcessors: [
///     // All logs to console during development
///     ConsoleLogProcessor(
///       levels: HealthConnectorLogLevel.values,
///     ),
///     // Info and above to local file
///     FileLogProcessor(
///       file: File('/tmp/health_connector.log'),
///       levels: [
///         HealthConnectorLogLevel.info,
///         HealthConnectorLogLevel.warning,
///         HealthConnectorLogLevel.error,
///         HealthConnectorLogLevel.fatal,
///       ],
///     ),
///     // Errors to Sentry for production monitoring
///     SentryLogProcessor(
///       dsn: 'YOUR_SENTRY_DSN',
///       levels: [
///         HealthConnectorLogLevel.error,
///         HealthConnectorLogLevel.fatal,
///       ],
///     ),
///   ],
/// );
/// ```
///
/// ## Custom Processors
///
/// Create custom processors for specific needs:
///
/// ```dart
/// class AnalyticsLogProcessor extends HealthConnectorLogProcessor {
///   final FirebaseAnalytics analytics;
///
///   AnalyticsLogProcessor(this.analytics) : super(
///     levels: [HealthConnectorLogLevel.error],
///   );
///
///   @override
///   Future<void> process(HealthConnectorLog log) async {
///     await analytics.logEvent(
///       name: 'sdk_error',
///       parameters: {
///         'error_type': log.error?.runtimeType.toString() ?? 'unknown',
///         'message': log.message,
///       },
///     );
///   }
/// }
///
/// final config = HealthConnectorLogConfig(
///   logProcessors: [
///     ConsoleLogProcessor(),
///     AnalyticsLogProcessor(FirebaseAnalytics.instance),
///   ],
/// );
/// ```
///
/// ## Performance Impact
///
/// Each processor adds overhead to logging operations. For high-performance
/// scenarios:
/// - Minimize the number of processors
/// - Use level filtering to reduce processor invocations
/// - Consider async/buffered processors for I/O operations
/// - Avoid verbose logging (trace/debug) in production
///
/// See also:
/// - [HealthConnectorLogProcessor] for creating custom processors
/// - [HealthConnectorLogLevel] for available severity levels
/// - [HealthConnectorLog] for log record structure
///
/// @sinceV3_0_0
///
/// {@category Logging}
@immutable
final class HealthConnectorLoggerConfig {
  /// The list of processors that will handle log records.
  ///
  /// Defaults to an empty list (no logging).
  ///
  /// ## Example
  ///
  /// ```dart
  /// // Single processor
  /// const config = HealthConnectorLogConfig(
  ///   logProcessors: [ConsoleLogProcessor()],
  /// );
  ///
  /// // Multiple processors
  /// final config = HealthConnectorLogConfig(
  ///   logProcessors: [
  ///     ConsoleLogProcessor(),
  ///     FileLogProcessor(file: File('app.log')),
  ///     SentryLogProcessor(dsn: 'YOUR_DSN'),
  ///   ],
  /// );
  /// ```
  ///
  /// ## Execution Order
  ///
  /// Processors are invoked sequentially in the order they appear in this
  /// list. The order matters for execution and log handling.
  final List<HealthConnectorLogProcessor> logProcessors;

  /// Controls whether native platform logs should be forwarded to Flutter.
  ///
  /// When `true` (default), logs generated from native code (Kotlin on
  /// Android, Swift on iOS) are passed to the Flutter logging system and
  /// processed by the configured [logProcessors].
  ///
  /// When `false`, native logs are suppressed and will not be forwarded to
  /// Flutter, potentially improving performance if native logging is not
  /// needed.
  ///
  /// ## Example
  ///
  /// ```dart
  /// // Enable native logging (default)
  /// const config = HealthConnectorLogConfig(
  ///   enableNativeLogging: true,
  ///   logProcessors: [ConsoleLogProcessor()],
  /// );
  ///
  /// // Disable native logging for production
  /// const config = HealthConnectorLogConfig(
  ///   enableNativeLogging: false,
  ///   logProcessors: [ConsoleLogProcessor()],
  /// );
  /// ```
  ///
  /// **Note**: This setting only affects logs originating from native platform
  /// code. Logs generated from Dart code are not affected by this flag.
  final bool enableNativeLogging;

  /// Creates a logging configuration with the specified parameters.
  ///
  /// If [logProcessors] is not provided or is empty, no logging will occur.
  ///
  /// The [enableNativeLogging] parameter controls whether native platform
  /// logs are forwarded to Flutter. Defaults to `true`.
  ///
  /// ## Example
  ///
  /// ```dart
  /// // No logging (default)
  /// const noLogging = HealthConnectorLogConfig();
  ///
  /// // With processors and native logging enabled
  /// const withLogging = HealthConnectorLogConfig(
  ///   enableNativeLogging: true,
  ///   logProcessors: [
  ///     ConsoleLogProcessor(
  ///       levels: [
  ///         HealthConnectorLogLevel.error,
  ///         HealthConnectorLogLevel.fatal,
  ///       ],
  ///     ),
  ///   ],
  /// );
  ///
  /// // Disable native logging
  /// const noNativeLogging = HealthConnectorLogConfig(
  ///   enableNativeLogging: false,
  ///   logProcessors: [ConsoleLogProcessor()],
  /// );
  /// ```
  const HealthConnectorLoggerConfig({
    this.enableNativeLogging = false,
    this.logProcessors = const [],
  });
}
