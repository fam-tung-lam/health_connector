import 'package:health_connector_annotation/health_connector_annotation.dart'
    show sinceV1_0_0;
import 'package:health_connector_core/src/models/exceptions/health_connector_error_code.dart'
    show HealthConnectorErrorCode;
import 'package:meta/meta.dart' show immutable;

/// Exception class for all health connector plugin errors.
@sinceV1_0_0
@immutable
final class HealthConnectorException implements Exception {
  /// Creates a [HealthConnectorException] with the given [code], [message],
  /// optional [cause] and [stackTrace].
  ///
  /// The [code] identifies the type of error.
  /// The [message] should describe what went wrong in user-friendly terms.
  /// The [cause] contains the underlying error that triggered this exception.
  const HealthConnectorException(
    this.code,
    this.message, {
    this.cause,
    this.stackTrace,
  });

  /// The error code identifying the type of error.
  final HealthConnectorErrorCode code;

  /// A human-readable description of the error.
  final String message;

  /// The underlying cause of this exception, if any.
  final Object? cause;

  /// The stack trace of this exception, if any.
  final StackTrace? stackTrace;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HealthConnectorException &&
          runtimeType == other.runtimeType &&
          code == other.code &&
          message == other.message &&
          cause == other.cause &&
          stackTrace == other.stackTrace;

  @override
  int get hashCode =>
      code.hashCode ^
      message.hashCode ^
      (cause?.hashCode ?? 0) ^
      (stackTrace?.hashCode ?? 0);

  @override
  String toString() {
    final buffer = StringBuffer(
      'HealthConnectorException [${code.code}]: $message',
    );
    if (cause != null) {
      buffer.write('\n  Caused by: $cause');
    }

    return buffer.toString();
  }
}
