import 'dart:io';

import 'package:health_connector_logger/src/log_processors/developer_log_processor.dart';
import 'package:health_connector_logger/src/log_processors/health_connector_log_processor.dart';
import 'package:health_connector_logger/src/models/health_connector_log.dart';

/// A simple log processor that uses print() for console output.
///
/// This processor provides straightforward, readable console logging that
/// works consistently across all build modes (debug, profile, release).
///
/// ## When to Use
///
/// Use this processor when you need:
/// - Simple console output in any environment
/// - Logs visible in release builds
/// - Testing and CI/CD environments
/// - No external dependencies or complex formatting
/// - Consistent output across all platforms
///
/// ## Usage Example
///
/// ```dart
/// import 'package:health_connector_logger/health_connector_logger.dart';
///
/// // Log all levels
/// const config = HealthConnectorLoggerConfig(
///   logProcessors: [
///     PrintLogProcessor(
///       levels: HealthConnectorLogLevel.values,
///     ),
///   ],
/// );
///
/// // Log only important messages
/// const productionConfig = HealthConnectorLoggerConfig(
///   logProcessors: [
///     PrintLogProcessor(
///       levels: [
///         HealthConnectorLogLevel.info,
///         HealthConnectorLogLevel.warning,
///         HealthConnectorLogLevel.error,
///       ],
///     ),
///   ],
/// );
/// ```
///
/// ## Platform Compatibility
///
/// This processor works on all platforms:
/// - Flutter (iOS, Android, Web, Desktop)
/// - Dart VM
/// - Command-line applications
///
/// See also:
/// - [DeveloperLogProcessor] for DevTools integration
///
/// @sinceV3_0_0
class PrintLogProcessor extends HealthConnectorLogProcessor {
  /// Creates a print log processor for the specified [levels].
  ///
  /// If [levels] is not provided, defaults to handling all log levels.
  ///
  /// ## Example
  ///
  /// ```dart
  /// // Handle all levels (default)
  /// const processor = PrintLogProcessor();
  ///
  /// // Handle only errors
  /// const errorProcessor = PrintLogProcessor(
  ///   levels: [HealthConnectorLogLevel.error],
  /// );
  /// ```
  const PrintLogProcessor({
    super.levels,
  });

  @override
  Future<void> process(HealthConnectorLog log) async {
    try {
      // ignore: avoid_print
      print(log.structuredMessage);
    } on Exception catch (e, stackTrace) {
      // Never throw from process() - log errors to stderr instead
      stderr.writeln(
        'PrintLogProcessor error: Failed to process log: $e\n'
        '$stackTrace',
      );
    }
  }
}
