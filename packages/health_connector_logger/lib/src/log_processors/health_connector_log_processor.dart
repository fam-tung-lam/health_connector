import 'package:health_connector_logger/src/models/health_connector_log.dart';
import 'package:health_connector_logger/src/models/health_connector_log_level.dart';
import 'package:health_connector_logger/src/models/health_connector_logger_config.dart';

/// Base class for processing health connector log records.
///
/// Extend this class to create custom log processors that handle logs in
/// specific ways (e.g., writing to console, files, or remote services).
///
/// ## Overview
///
/// Each processor receives [HealthConnectorLog] records and can:
/// - Filter logs by level using the [levels] property
/// - Process logs via the [process] method
/// - Control which logs to handle with [shouldProcess]
///
/// ## Example
///
/// ```dart
/// class ConsoleLogProcessor extends HealthConnectorLogProcessor {
///   const ConsoleLogProcessor({
///     super.levels = HealthConnectorLogLevel.values,
///   });
///
///   @override
///   Future<void> process(HealthConnectorLog log) async {
///     print('[${log.level.name.toUpperCase()}] ${log.message}');
///     if (log.error != null) {
///       print('Error: ${log.error}');
///     }
///   }
/// }
/// ```
///
/// ## Custom Filtering
///
/// Override [shouldProcess] for advanced filtering logic:
///
/// ```dart
/// class ProductionLogProcessor extends HealthConnectorLogProcessor {
///   @override
///   bool shouldProcess(HealthConnectorLog log) {
///     // Only process errors from production loggers
///     return super.shouldProcess(log) &&
///            log.loggerName.startsWith('prod.');
///   }
/// }
/// ```
///
/// See also:
/// - [HealthConnectorLog] for the log record structure
/// - [HealthConnectorLogLevel] for available log levels
/// - [HealthConnectorLoggerConfig] for configuration
///
/// @sinceV3_0_0
///
/// {@category Logging}
abstract class HealthConnectorLogProcessor {
  /// The log levels this processor will handle.
  ///
  /// Only logs with levels in this list will be passed to [process].
  /// The [shouldProcess] method checks against this list by default.
  ///
  /// Defaults to all levels ([HealthConnectorLogLevel.values]).
  ///
  /// ## Example
  ///
  /// ```dart
  /// // Handle only warnings and errors
  /// const errorProcessor = MyProcessor(
  ///   levels: [
  ///     HealthConnectorLogLevel.warning,
  ///     HealthConnectorLogLevel.error,
  ///   ],
  /// );
  /// ```
  final List<HealthConnectorLogLevel> levels;

  /// Creates a log processor that handles the specified [levels].
  ///
  /// If [levels] is not provided, defaults to handling all log levels.
  ///
  /// ## Example
  ///
  /// ```dart
  /// // Handle all levels (default)
  /// const processor = MyProcessor();
  ///
  /// // Handle only warnings and errors
  /// const errorProcessor = MyProcessor(
  ///   levels: [
  ///     HealthConnectorLogLevel.warning,
  ///     HealthConnectorLogLevel.error,
  ///   ],
  /// );
  /// ```
  const HealthConnectorLogProcessor({
    this.levels = HealthConnectorLogLevel.values,
  });

  /// Processes a log record.
  ///
  /// This method is called by the SDK for each log that passes the
  /// [shouldProcess] filter. Implementations should handle the log
  /// appropriately (write to console, file, send to remote service, etc.).
  ///
  /// This method should:
  /// - Complete quickly to avoid blocking logging pipeline
  /// - Handle errors gracefully (use try-catch internally)
  /// - Not throw exceptions (errors should be logged internally or ignored)
  ///
  /// ## Example
  ///
  /// ```dart
  /// @override
  /// Future<void> process(HealthConnectorLog log) async {
  ///   try {
  ///     final formatted = '[${log.dateTime}] ${log.level}: ${log.message}';
  ///     print(formatted);
  ///   } catch (e) {
  ///     // Handle errors gracefully - don't throw
  ///     stderr.writeln('Failed to process log: $e');
  ///   }
  /// }
  /// ```
  ///
  /// ## Performance Considerations
  ///
  /// For I/O operations (file writes, network calls), consider:
  /// - Using asynchronous operations
  /// - Batching multiple logs
  /// - Buffering logs and flushing periodically
  ///
  /// See also:
  /// - [shouldProcess] to control which logs reach this method
  Future<void> process(HealthConnectorLog log);

  /// Determines whether this processor should handle the given [log].
  ///
  /// The default implementation checks if the log's level is in [levels].
  /// Override this method to implement custom filtering logic beyond
  /// level-based filtering.
  ///
  /// Returns `true` if the log should be processed, `false` otherwise.
  ///
  /// The SDK calls this method before [process]. If this returns `false`,
  /// [process] will not be called for that log.
  ///
  /// ## Default Behavior
  ///
  /// ```dart
  /// bool shouldProcess(HealthConnectorLog log) {
  ///   return levels.contains(log.level);
  /// }
  /// ```
  ///
  /// ## Custom Filtering Examples
  ///
  /// ```dart
  /// // Filter by attribute presence
  /// @override
  /// bool shouldProcess(HealthConnectorLog log) {
  ///   return super.shouldProcess(log) && log.context?['user_id'] != null;
  /// }
  ///
  /// // Time-based filtering
  /// @override
  /// bool shouldProcess(HealthConnectorLog log) {
  ///   final isBusinessHours = log.datetime.hour >= 9 &&
  ///                          log.datetime.hour < 17;
  ///   return super.shouldProcess(log) && isBusinessHours;
  /// }
  /// ```
  ///
  /// ## Performance Note
  ///
  /// This method is called frequently. Keep the implementation efficient
  /// and avoid expensive operations (network calls, file I/O, etc.).
  bool shouldProcess(HealthConnectorLog log) {
    return levels.contains(log.level);
  }
}
