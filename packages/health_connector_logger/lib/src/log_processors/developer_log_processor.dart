import 'dart:developer' as developer;
import 'dart:io';

import 'package:health_connector_logger/src/log_processors/health_connector_log_processor.dart';
import 'package:health_connector_logger/src/log_processors/print_log_processor.dart';
import 'package:health_connector_logger/src/models/health_connector_log.dart';
import 'package:health_connector_logger/src/models/health_connector_log_level.dart';

/// A log processor that uses `dart:developer` log() for DevTools integration.
///
/// This processor leverages the `dart:developer` package to provide:
/// - Integration with Flutter DevTools Timeline
/// - Better performance than print() during development
/// - Structured logging with levels and metadata
/// - Automatic stripping in release builds (no output)
///
/// ## When to Use
///
/// Use this processor during active development when you need:
/// - DevTools Timeline integration for performance analysis
/// - Structured logs with proper severity levels
/// - Zero overhead in release builds
/// - Better debugging experience in development
///
/// **Note:** This processor produces no output in release mode as
/// `dart:developer` log calls are automatically stripped by the compiler.
///
/// ## Usage Example
///
/// ```dart
/// import 'package:health_connector_logger/health_connector_logger.dart';
///
/// // Use all log levels during development
/// const devLogger = HealthConnectorLoggerConfig(
///   logProcessors: [
///     DeveloperLogProcessor(
///       levels: HealthConnectorLogLevel.values,
///     ),
///   ],
/// );
///
/// // Or filter to specific levels
/// const errorLogger = HealthConnectorLoggerConfig(
///   logProcessors: [
///     DeveloperLogProcessor(
///       levels: [
///         HealthConnectorLogLevel.warning,
///         HealthConnectorLogLevel.error,
///       ],
///     ),
///   ],
/// );
/// ```
///
/// ## Log Level Mapping
///
/// The processor maps [HealthConnectorLogLevel] to `dart:developer`
/// log level values (0-2000 range, higher = more severe):
///
/// - debug: level 500
/// - info: level 800
/// - warning: level 900
/// - error: level 1000
///
/// ## DevTools Integration
///
/// Logs appear in the DevTools Logging view with:
/// - Proper severity indicators
/// - Timestamp information
/// - Stack traces (when available)
/// - Searchable and filterable by level
///
/// See also:
/// - [PrintLogProcessor] for simple console output
/// - https://api.dart.dev/stable/dart-developer/log.html
///
/// @sinceV3_0_0
///
/// {@category Logging}
class DeveloperLogProcessor extends HealthConnectorLogProcessor {
  /// Creates a developer log processor for the specified [levels].
  ///
  /// If [levels] is not provided, defaults to handling all log levels.
  ///
  /// ## Example
  ///
  /// ```dart
  /// // Handle all levels (default)
  /// const processor = DeveloperLogProcessor();
  ///
  /// // Handle only warnings and errors
  /// const errorProcessor = DeveloperLogProcessor(
  ///   levels: [
  ///     HealthConnectorLogLevel.warning,
  ///     HealthConnectorLogLevel.error,
  ///   ],
  /// );
  /// ```
  const DeveloperLogProcessor({
    super.levels,
  });

  @override
  Future<void> process(HealthConnectorLog log) async {
    try {
      developer.log(
        log.structuredMessage,
        name: log.tag,
        level: log.level.value,
        time: log.dateTime,
        stackTrace: log.stackTrace,
      );
    } on Exception catch (e, stackTrace) {
      // Never throw from process() - log errors to stderr instead
      stderr.writeln(
        'DeveloperLogProcessor error: Failed to process log: $e\n'
        '$stackTrace',
      );
    }
  }
}
