import 'package:health_connector_logger/health_connector_logger.dart';
import 'package:meta/meta.dart';

/// Utility class for [HealthConnectorLogger] related operations.
@internal
abstract final class HealthConnectorLogFormatter {
  /// Private constructor to prevent instantiation.
  const HealthConnectorLogFormatter._();

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
  static String formatStructuredMessage({
    required final HealthConnectorLogLevel level,
    required final String message,
    final DateTime? dateTime,
    final String? operation,
    final Map<String, dynamic>? context,
    final Object? exception,
    final StackTrace? stackTrace,
  }) {
    final buffer = StringBuffer();
    final dateTimeToLog = dateTime ?? DateTime.now();

    // Always include datetime and operation
    buffer.writeln('[${level.name.toUpperCase()}]:');
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
    buffer.write('\n${_getIndent(0)}message: $message,');

    // Include operation if provided
    if (operation != null) {
      buffer.write('\n${_getIndent(0)}operation: $operation,');
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
        _formatValueTo(buffer: buffer, value: entry.value, depth: 1);
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
  static String _getIndent(final int depth) {
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
  static void _formatValueTo({
    required final StringBuffer buffer,
    required final dynamic value,
    required final int depth,
  }) {
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
        _formatValueTo(
          buffer: buffer,
          value: entry.value,
          depth: depth + 1,
        );
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
        _formatValueTo(buffer: buffer, value: element, depth: depth + 1);
        buffer.write(',');
      }
      buffer.write('\n$currentIndent]');
      return;
    }

    // Handle other types - convert to string
    buffer.write(value.toString());
  }
}
