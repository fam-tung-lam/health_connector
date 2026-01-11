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

  /// Creates a logging configuration with the specified [logProcessors].
  ///
  /// If [logProcessors] is not provided or is empty, no logging will occur.
  ///
  /// ## Example
  ///
  /// ```dart
  /// // No logging (default)
  /// const noLogging = HealthConnectorLogConfig();
  ///
  /// // With processors
  /// const withLogging = HealthConnectorLogConfig(
  ///   logProcessors: [
  ///     ConsoleLogProcessor(
  ///       levels: [
  ///         HealthConnectorLogLevel.error,
  ///         HealthConnectorLogLevel.fatal,
  ///       ],
  ///     ),
  ///   ],
  /// );
  /// ```
  const HealthConnectorLoggerConfig({
    this.logProcessors = const [],
  });
}
