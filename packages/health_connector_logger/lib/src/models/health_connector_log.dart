import 'package:collection/collection.dart';
import 'package:health_connector_logger/src/models/health_connector_log_level.dart';
import 'package:health_connector_logger/src/utils/health_connector_log_formatter.dart';
import 'package:meta/meta.dart' show immutable;

/// A structured log event emitted by `HealthConnectorLogger`.
///
/// Represents a single log entry with all associated metadata including
/// the log level, tag, operation, timestamp, and optional contextual data.
///
/// This is a sealed class hierarchy with two subclasses:
/// - [HealthConnectorDartLog]: Logs originating from Dart code.
/// - [HealthConnectorNativeLog]: Logs originating from native platform code.
@immutable
sealed class HealthConnectorLog {
  /// The severity level of this log entry.
  final HealthConnectorLogLevel level;

  /// A tag for categorizing the log entry.
  final String tag;

  /// Descriptive message.
  final String message;

  /// The operation being logged.
  final String? operation;

  /// The timestamp when this log was created.
  final DateTime dateTime;

  /// Optional contextual information as key-value pairs.
  final Map<String, dynamic>? context;

  /// Optional exception object if an error occurred.
  final Object? exception;

  /// Optional stack trace associated with the exception.
  final StackTrace? stackTrace;

  /// Creates a [HealthConnectorLog] with the specified properties.
  const HealthConnectorLog({
    required this.level,
    required this.tag,
    required this.dateTime,
    required this.message,
    this.operation,
    this.context,
    this.exception,
    this.stackTrace,
  });

  /// Formats the log entry as a structured message.
  String get structuredMessage =>
      HealthConnectorLogFormatter.formatStructuredMessage(
        tag: tag,
        level: level,
        message: message,
        dateTime: dateTime,
        operation: operation,
        context: context,
        exception: exception,
        stackTrace: stackTrace,
      );

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
          stackTrace == other.stackTrace;

  @override
  int get hashCode =>
      level.hashCode ^
      tag.hashCode ^
      operation.hashCode ^
      dateTime.hashCode ^
      message.hashCode ^
      context.hashCode ^
      exception.hashCode ^
      stackTrace.hashCode;

  @override
  String toString() => structuredMessage;
}

/// A log entry originating from Dart code.
@immutable
final class HealthConnectorDartLog extends HealthConnectorLog {
  /// Creates a [HealthConnectorDartLog] with the specified properties.
  const HealthConnectorDartLog({
    required super.level,
    required super.tag,
    required super.dateTime,
    required super.message,
    super.operation,
    super.context,
    super.exception,
    super.stackTrace,
  });
}

/// A log entry originating from native platform code (iOS or Android).
@immutable
final class HealthConnectorNativeLog extends HealthConnectorLog {
  /// The native platform that emitted this log (e.g., "iOS" or "Android").
  final String platform;

  /// Creates a [HealthConnectorNativeLog] with the specified properties.
  const HealthConnectorNativeLog({
    required super.level,
    required super.tag,
    required super.dateTime,
    required super.message,
    required this.platform,
    super.operation,
    super.context,
    super.exception,
    super.stackTrace,
  });

  @override
  String get structuredMessage =>
      HealthConnectorLogFormatter.formatStructuredMessage(
        tag: tag,
        level: level,
        message: message,
        dateTime: dateTime,
        operation: operation,
        platform: platform,
        context: context,
        exception: exception,
        stackTrace: stackTrace,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is HealthConnectorNativeLog &&
          platform == other.platform;

  @override
  int get hashCode => super.hashCode ^ platform.hashCode;
}
