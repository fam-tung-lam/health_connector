import 'dart:async' show Stream, StreamController;
import 'dart:developer' show log;import 'package:health_connector_logger/src/health_connector_log.dart';
import 'package:meta/meta.dart' show internal, visibleForTesting;

/// A singleton logger that wraps the `log` function from `dart:developer`.
///
/// This logger provides a consistent structured logging interface with

/// information:
///
/// - Level (INFO, DEBUG, WARNING, ERROR)
/// - Tag (Category)
/// - Operation (Action being performed)
/// - Timestamp
/// - Structured data (JSON-like format)
abstract final class HealthConnectorLogger {
  /// Private constructor to prevent instantiation.
  const HealthConnectorLogger._();

  /// Whether logging is enabled.
  ///
  /// When set to `false`, all logging methods will return immediately without
  /// logging any messages. Defaults to `true`.
  static bool isEnabled = true;

  /// Stream controller for broadcasting log events.
  ///
  /// Uses a broadcast stream to allow multiple simultaneous subscribers.
  static final StreamController<HealthConnectorLog> _logsController =
      StreamController<HealthConnectorLog>.broadcast();

  /// Stream of structured log events.
  ///
  /// Subscribe to this stream to receive [HealthConnectorLog] events for all
  /// logging calls made through this logger. Multiple subscribers are
  /// supported via a broadcast stream.
  ///
  /// Events are only emitted when [isEnabled] is `true`. When logging is
  /// disabled, no events will be emitted.
  ///
  /// ## Example
  ///
  /// ```dart
  /// // Subscribe to log events
  /// final subscription = HealthConnectorLogger.logs.listen((log) {
  ///   print('[${log.level.name}] ${log.operation}');
  ///   if (log.exception != null) {
  ///     // Handle exceptions
  ///     print('Exception: ${log.exception}');
  ///   }
  /// });
  ///
  /// // Generate a log
  /// HealthConnectorLogger.info(
  ///   'API',
  ///   operation: 'readRecords',
  ///   message: 'Successfully read records',
  ///   context: {'count': 42},
  /// );
  ///
  /// // Clean up when done
  /// await subscription.cancel();
  /// ```
  static Stream<HealthConnectorLog> get logs => _logsController.stream;

  /// Base indentation unit (4 spaces).
  static const String _indentation = '    ';

  /// Maximum depth for cached indentation strings.
  static const int _maxCachedIndentDepth = 10;

  /// Cached indentation strings for depths 0 to [_maxCachedIndentDepth].
  ///
  /// Pre-computed to avoid repeated string multiplication during formatting.
  static final List<String> _indentCache = List.generate(
    _maxCachedIndentDepth + 1,
    (depth) => _indentation * (depth + 1),
  );

  /// Logs an informational message.
  ///
  /// Use this method for general informational messages that describe normal
  /// application flow.
  ///
  /// ## Parameters
  ///
  /// - [tag]: A tag for categorizing the log entry (converted to uppercase).
  /// - [operation]: The operation being performed.

  /// - [message]: Optional message to include in the log.
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
    String tag, {
    required String operation,
    String? message,
    Map<String, dynamic>? context,
    Object? exception,
    StackTrace? stackTrace,
  }) {
    _log(
      LogLevel.info,
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
  /// - [operation]: The operation being performed.

  /// - [message]: Optional message to include in the log.
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
    String tag, {
    required String operation,
    String? message,
    Map<String, dynamic>? context,
    Object? exception,
    StackTrace? stackTrace,
  }) {
    _log(
      LogLevel.debug,
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
  /// - [operation]: The operation being performed.

  /// - [message]: Optional message to include in the log.
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
    String tag, {
    required String operation,
    String? message,
    Map<String, dynamic>? context,
    Object? exception,
    StackTrace? stackTrace,
  }) {
    _log(
      LogLevel.warning,
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
  /// - [operation]: The operation being performed.

  /// - [message]: Optional message to include in the log.
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
    String tag, {
    required String operation,
    String? message,
    Map<String, dynamic>? context,
    Object? exception,
    StackTrace? stackTrace,
  }) {
    _log(
      LogLevel.error,
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
  /// - [operation]: The operation being performed.
  /// - [message]: Optional message to include in the log.
  /// - [context]: Optional contextual information.
  /// - [exception]: Optional exception object.
  /// - [stackTrace]: Optional stack trace.
  static void _log(
    LogLevel level,
    String tag, {
    required String operation,
    String? message,
    Map<String, dynamic>? context,
    Object? exception,
    StackTrace? stackTrace,
  }) {
    // Early exit if logging is disabled
    if (!isEnabled) {
      return;
    }

    // Generate timestamp once for consistency
    final now = DateTime.now();

    // Format structured message with the timestamp
    // Format structured message with the timestamp
    final structuredMessage = formatStructuredMessage(
      level: level,
      operation: operation,
      dateTime: now,
      message: message,
      context: context,
      exception: exception,
      stackTrace: stackTrace,
    );

    // Create and emit log event
    // Create and emit log event
    final logEvent = HealthConnectorLog(
      level: level,
      tag: tag,
      operation: operation,
      dateTime: now,
      message: message,
      context: context,
      exception: exception,
      stackTrace: stackTrace,
      structuredMessage: structuredMessage,
    );
    _logsController.add(logEvent);

    // Existing dart:developer.log output
    final formattedMessage = '[${level.name}]: \n$structuredMessage';
    log(
      formattedMessage,
      name: tag,
      level: level.value,
    );
  }

  /// Formats a structured log message in JSON-like format.
  ///
  /// Creates a formatted message with indentation, including
  /// only non-null fields.
  ///
  /// ## Parameters
  ///
  /// - [operation]: The operation being performed (e.g., 'readRecords').
  /// - [message]: Optional message to include in the log.
  /// - [context]: Optional map of contextual information.
  /// - [exception]: Optional exception object.
  /// - [stackTrace]: Optional stack trace.
  ///
  /// ## Returns
  ///
  /// A formatted string in JSON-like format with indentation.
  @internal
  @visibleForTesting
  static String formatStructuredMessage({
    required LogLevel level,
    required String operation,
    DateTime? dateTime,
    String? message,
    Map<String, dynamic>? context,
    Object? exception,
    StackTrace? stackTrace,
  }) {
    final buffer = StringBuffer();
    final dateTimeToLog = dateTime ?? DateTime.now();

    // Always include datetime and operation
    buffer.writeln('{');
    buffer.write('${_getIndent(0)}datetime: ');
    // Format datetime: day-month-year hour:minute:second.millisecond
    buffer
      ..write(dateTimeToLog.day.toString().padLeft(2, '0'))
      ..write('-')
      ..write(dateTimeToLog.month.toString().padLeft(2, '0'))
      ..write('-')
      ..write(dateTimeToLog.year.toString())
      ..write(' ')
      ..write(dateTimeToLog.hour.toString().padLeft(2, '0'))
      ..write(':')
      ..write(dateTimeToLog.minute.toString().padLeft(2, '0'))
      ..write(':')
      ..write(dateTimeToLog.second.toString().padLeft(2, '0'))
      ..write('.')
      ..write(dateTimeToLog.millisecond.toString().padLeft(3, '0'));
    buffer.write(',');
    buffer.write('\n${_getIndent(0)}operation: $operation,');

    // Include message if provided
    if (message != null) {
      buffer.write('\n${_getIndent(0)}message: $message,');
    }

    // Include exception block if exception or stackTrace is provided
    if (exception != null || stackTrace != null) {
      buffer.write('\n${_getIndent(0)}exception: {');
      if (exception != null) {
        buffer.write('\n${_getIndent(1)}cause: $exception,');
      }
      if (stackTrace != null) {
        buffer.write('\n${_getIndent(1)}stack_trace: $stackTrace,');
      }
      buffer.write('\n${_getIndent(0)}},');
    }

    // Include context if provided and not empty
    if (context != null && context.isNotEmpty) {
      buffer.write('\n${_getIndent(0)}context: {');
      for (final entry in context.entries) {
        buffer.write('\n');
        buffer.write('${_getIndent(1)}${entry.key}: ');
        _formatValueTo(buffer, entry.value, 1);
        buffer.write(',');
      }
      buffer.write('\n${_getIndent(0)}},');
    }

    buffer.write('\n}');

    return buffer.toString();
  }

  /// Gets the indentation string for the given depth.
  ///
  /// Uses cached values for depths up to [_maxCachedIndentDepth],
  /// otherwise computes the indentation string dynamically.
  ///
  /// ## Parameters
  ///
  /// - [depth]: The nesting depth (0 for top-level).
  ///
  /// ## Returns
  ///
  /// The indentation string for the given depth.
  static String _getIndent(int depth) {
    if (depth <= _maxCachedIndentDepth) {
      return _indentCache[depth];
    }
    return _indentation * (depth + 1);
  }

  /// Recursively formats a value with proper indentation based on
  /// nesting depth, writing directly to the provided buffer.
  ///
  /// Handles maps, lists, and other types. Maps and lists are formatted with
  /// increasing indentation for each nesting level.
  ///
  /// ## Parameters
  ///
  /// - [buffer]: The StringBuffer to write the formatted value to.
  /// - [value]: The value to format (can be a map, list, or any other type).
  /// - [depth]: The current nesting depth (0 for top-level,
  ///   increases with nesting).
  static void _formatValueTo(StringBuffer buffer, dynamic value, int depth) {
    final currentIndent = _getIndent(depth);
    final nextIndent = _getIndent(depth + 1);

    // Handle maps
    if (value is Map) {
      if (value.isEmpty) {
        buffer.write('{}');
        return;
      }
      buffer.write('{\n');
      var isFirst = true;
      for (final entry in value.entries) {
        if (!isFirst) {
          buffer.write('\n');
        }
        isFirst = false;
        buffer.write('$nextIndent${entry.key}: ');
        _formatValueTo(buffer, entry.value, depth + 1);
        buffer.write(',');
      }
      buffer.write('\n$currentIndent}');
      return;
    }

    // Handle lists
    if (value is List) {
      if (value.isEmpty) {
        buffer.write('[]');
        return;
      }
      buffer.write('[\n');
      var isFirst = true;
      for (final element in value) {
        if (!isFirst) {
          buffer.write('\n');
        }
        isFirst = false;
        buffer.write(nextIndent);
        _formatValueTo(buffer, element, depth + 1);
        buffer.write(',');
      }
      buffer.write('\n$currentIndent]');
      return;
    }

    // Handle other types - convert to string
    buffer.write(value.toString());
  }
}

/// Enum representing the different log levels.
///
/// Each level has a [name] field that contains the string representation
/// of the log level and a [value] field that contains the integer value
/// for `dart:developer.log`.
@internal
enum LogLevel {
  /// Debug level for detailed diagnostic information.
  debug('DEBUG', 500),

  /// Info level for general informational messages.
  info('INFO', 800),

  /// Warning level for potential problems or unexpected behavior.
  warning('WARNING', 900),

  /// Error level for serious problems.
  error('ERROR', 1000);

  /// The string name of the log level.
  final String name;

  /// The integer value for `dart:developer.log`.
  final int value;

  /// Creates a [LogLevel] with the given [name] and [value].
  const LogLevel(this.name, this.value);
}
