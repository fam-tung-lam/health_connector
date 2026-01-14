import 'dart:async' show unawaited;

import 'package:health_connector_logger/src/log_processors/health_connector_log_processor.dart';
import 'package:health_connector_logger/src/models/health_connector_log.dart';
import 'package:health_connector_logger/src/models/health_connector_log_level.dart';

/// Internal singleton logger providing structured, consistent logging across
/// the HealthConnector SDK.
///
/// **⚠️ INTERNAL USE ONLY**
///
/// This class is strictly for internal SDK use and is NOT part of the public
/// API. It should only be accessed within the `health_connector` library
/// ecosystem. External consumers must not depend on or reference
/// [HealthConnectorLogger] as its implementation may change without notice.
///
/// @internalUse
/// @nodoc
abstract final class HealthConnectorLogger {
  /// Private constructor to prevent instantiation.
  const HealthConnectorLogger._();

  /// List of registered log processors.
  ///
  /// Processors in this list will receive and process all log events.
  /// Use [addProcessor] and [removeProcessor] to manage the list.
  /// but won't be processed by any processors.
  static final List<HealthConnectorLogProcessor> _processors = [];

  /// Manually logs a [HealthConnectorLog] event.
  ///
  /// This method allows external sources (such as platform clients) to feed
  /// log events directly into the logger, where they will be processed by all
  /// registered [HealthConnectorLogProcessor]s.
  ///
  /// ## Parameters
  ///
  /// - [log]: The [HealthConnectorLog] event to process.
  static void internalLog(HealthConnectorLog log) {
    for (final processor in _processors) {
      if (processor.shouldProcess(log)) {
        // Fire and forget - don't await to avoid blocking
        unawaited(processor.process(log));
      }
    }
  }

  /// Adds a log processor to handle log events.
  ///
  /// The processor will receive all future log events and process them
  /// according to its [HealthConnectorLogProcessor.shouldProcess] logic.
  /// Multiple processors can be registered and will all receive log events.
  ///
  /// ## Parameters
  ///
  /// - [processor]: The [HealthConnectorLogProcessor] to add.
  ///
  /// ## Example
  ///
  /// ```dart
  /// // Add a print processor for development
  /// HealthConnectorLogger.addProcessor(
  ///   const ColorfulPrintLogProcessor(
  ///     levels: HealthConnectorLogLevel.values,
  ///   ),
  /// );
  /// ```
  ///
  /// ## See Also
  ///
  /// - [removeProcessor] to remove a processor
  /// - [HealthConnectorLogProcessor] for creating custom processors
  static void addProcessor(HealthConnectorLogProcessor processor) {
    _processors.add(processor);
  }

  /// Removes a log processor from handling log events.
  ///
  /// The processor will no longer receive log events after being removed.
  /// If the processor is not in the list, this method does nothing.
  ///
  /// ## Parameters
  ///
  /// - [processor]: The [HealthConnectorLogProcessor] to remove.
  ///
  /// ## Returns
  ///
  /// `true` if the processor was found and removed, `false` otherwise.
  ///
  /// ## Example
  ///
  /// ```dart
  /// final processor = const PrintLogProcessor();
  /// HealthConnectorLogger.addProcessor(processor);
  ///
  /// // Later, remove it
  /// final removed = HealthConnectorLogger.removeProcessor(processor);
  /// ```
  ///
  /// ## See Also
  ///
  /// - [addProcessor] to add a processor
  static bool removeProcessor(HealthConnectorLogProcessor processor) {
    return _processors.remove(processor);
  }

  /// Logs an informational message.
  ///
  /// Use this method for general informational messages that describe normal
  /// application flow.
  ///
  /// ## Parameters
  ///
  /// - [tag]: A tag for categorizing the log entry (converted to uppercase).
  /// - [operation]: Optional operation being performed.
  /// - [message]: The message to include in the log.
  /// - [context]: Optional contextual information.
  /// - [exception]: Optional exception object to include in the log.
  /// - [stackTrace]: Optional stack trace to include in the log.
  ///
  /// ## Examples
  ///
  /// ```dart
  /// HealthConnectorLogger.info(
  ///   'API',
  ///   operation: 'readRecords',
  ///   message: 'Successfully read records',
  ///   context: {'recordCount': 42, 'duration': '123ms'},
  /// );
  /// ```
  static void info(
    final String tag, {
    required final String message,
    final String? operation,
    final Map<String, dynamic>? context,
    final Object? exception,
    final StackTrace? stackTrace,
  }) {
    _log(
      HealthConnectorLogLevel.info,
      tag,
      operation: operation,
      message: message,
      context: context,
      exception: exception,
      stackTrace: stackTrace,
    );
  }

  /// Logs a debug message.
  ///
  /// Use this method for detailed diagnostic information that is typically
  /// only of interest when diagnosing problems.
  ///
  /// ## Parameters
  ///
  /// - [tag]: A tag for categorizing the log entry (converted to uppercase).
  /// - [operation]: Optional operation being performed.
  /// - [message]: The message to include in the log.
  /// - [context]: Optional contextual information.
  /// - [exception]: Optional exception object to include in the log.
  /// - [stackTrace]: Optional stack trace to include in the log.
  ///
  /// ## Examples
  ///
  /// ```dart
  /// HealthConnectorLogger.debug(
  ///   'API',
  ///   operation: 'readRecords',
  ///   message: 'Starting to read records',
  ///   context: {'dataType': 'StepsRecord', 'pageSize': 100},
  /// );
  /// ```
  static void debug(
    final String tag, {
    required final String message,
    final String? operation,
    final Map<String, dynamic>? context,
    final Object? exception,
    final StackTrace? stackTrace,
  }) {
    _log(
      HealthConnectorLogLevel.debug,
      tag,
      operation: operation,
      message: message,
      context: context,
      exception: exception,
      stackTrace: stackTrace,
    );
  }

  /// Logs a warning message.
  ///
  /// Use this method for warning messages that indicate potential problems or
  /// unexpected behavior that doesn't prevent the application from functioning.
  ///
  /// ## Parameters
  ///
  /// - [tag]: A tag for categorizing the log entry (converted to uppercase).
  /// - [operation]: Optional operation being performed.
  /// - [message]: The message to include in the log.
  /// - [context]: Optional contextual information.
  /// - [exception]: Optional exception object to include in the log.
  /// - [stackTrace]: Optional stack trace to include in the log.
  ///
  /// ## Examples
  ///
  /// ```dart
  /// HealthConnectorLogger.warning(
  ///   'API',
  ///   operation: 'readRecords',
  ///   message: 'Operation exceeded threshold',
  ///   context: {'duration': '6234ms', 'threshold': '5000ms'},
  /// );
  /// ```
  static void warning(
    final String tag, {
    required final String message,
    final String? operation,
    final Map<String, dynamic>? context,
    final Object? exception,
    final StackTrace? stackTrace,
  }) {
    _log(
      HealthConnectorLogLevel.warning,
      tag,
      operation: operation,
      message: message,
      context: context,
      exception: exception,
      stackTrace: stackTrace,
    );
  }

  /// Logs an error message.
  ///
  /// Use this method for error messages that indicate serious problems that
  /// may prevent the application from functioning correctly.
  ///
  /// ## Parameters
  ///
  /// - [tag]: A tag for categorizing the log entry (converted to uppercase).
  /// - [operation]: Optional operation being performed.
  /// - [message]: The message to include in the log.
  /// - [context]: Optional contextual information.
  /// - [exception]: Optional exception object to include in the log.
  /// - [stackTrace]: Optional stack trace to include in the log.
  ///
  /// ## Examples
  ///
  /// ```dart
  /// HealthConnectorLogger.error(
  ///   'API',
  ///   operation: 'readRecords',
  ///   message: 'Failed to read records',
  ///   context: {'dataType': 'StepsRecord', 'duration': '123ms'},
  ///   exception: e,
  ///   stackTrace: st,
  /// );
  /// ```
  static void error(
    final String tag, {
    required final String message,
    final String? operation,
    final Map<String, dynamic>? context,
    final Object? exception,
    final StackTrace? stackTrace,
  }) {
    _log(
      HealthConnectorLogLevel.error,
      tag,
      operation: operation,
      message: message,
      context: context,
      exception: exception,
      stackTrace: stackTrace,
    );
  }

  /// Internal method that formats and logs the message.
  ///
  /// Handles all logging logic including enabled check, message formatting,
  /// and output. Formats the message according to the specified format:
  /// ```
  /// [{level}]:
  /// {
  ///    datetime: {datetime},
  ///    operation: {operation},
  ///    message: {message},
  ///    exception: {
  ///      cause: {exception},
  ///      stack_trace: {stackTrace},
  ///    },
  ///    context: {
  ///      key1: value1,
  ///    },
  /// }
  /// ```
  ///
  /// ## Parameters
  ///
  /// - [level]: The log level (DEBUG, INFO, WARNING, ERROR).
  /// - [tag]: The tag for categorizing the log entry.
  /// - [operation]: Optional operation being performed.
  /// - [message]: The message to include in the log.
  /// - [context]: Optional contextual information.
  /// - [exception]: Optional exception object.
  /// - [stackTrace]: Optional stack trace.
  static void _log(
    final HealthConnectorLogLevel level,
    final String tag, {
    required final String message,
    final String? operation,
    final Map<String, dynamic>? context,
    final Object? exception,
    final StackTrace? stackTrace,
  }) {
    // Create log event
    final log = HealthConnectorDartLog(
      level: level,
      tag: tag,
      operation: operation,
      dateTime: DateTime.now(),
      message: message,
      context: context,
      exception: exception,
      stackTrace: stackTrace,
    );

    HealthConnectorLogger.internalLog(log);
  }
}
