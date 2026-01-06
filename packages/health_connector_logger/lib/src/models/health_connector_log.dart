import 'package:collection/collection.dart';
import 'package:health_connector_logger/src/models/health_connector_log_level.dart';
import 'package:meta/meta.dart' show immutable;

/// A structured log event emitted by `HealthConnectorLogger`.
///
/// Represents a single log entry with all associated metadata including
/// the log level, tag, operation, timestamp, and optional contextual data.
@immutable
final class HealthConnectorLog {
  /// The severity level of this log entry.
  final HealthConnectorLogLevel level;

  /// A tag for categorizing the log entry.
  final String tag;

  /// The operation being logged.
  final String? operation;

  /// The timestamp when this log was created.
  final DateTime dateTime;

  /// Optional descriptive message.
  final String? message;

  /// Optional contextual information as key-value pairs.
  final Map<String, dynamic>? context;

  /// Optional exception object if an error occurred.
  final Object? exception;

  /// Optional stack trace associated with the exception.
  final StackTrace? stackTrace;

  /// The JSON-like formatted output message.
  final String? structuredMessage;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HealthConnectorLog &&
          runtimeType == other.runtimeType &&
          level == other.level &&
          tag == other.tag &&
          operation == other.operation &&
          dateTime == other.dateTime &&
          message == other.message &&
          const MapEquality<String, dynamic>().equals(
            context,
            other.context,
          ) &&
          exception == other.exception &&
          stackTrace == other.stackTrace &&
          structuredMessage == other.structuredMessage;

  /// Creates a [HealthConnectorLog] with the specified properties.
  const HealthConnectorLog({
    required this.level,
    required this.tag,
    required this.dateTime,
    this.operation,
    this.message,
    this.structuredMessage,
    this.context,
    this.exception,
    this.stackTrace,
  });

  @override
  int get hashCode =>
      level.hashCode ^
      tag.hashCode ^
      operation.hashCode ^
      dateTime.hashCode ^
      message.hashCode ^
      context.hashCode ^
      exception.hashCode ^
      stackTrace.hashCode ^
      structuredMessage.hashCode;
}
