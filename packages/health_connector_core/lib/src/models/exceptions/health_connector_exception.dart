import 'package:health_connector_core/src/annotations/annotations.dart'
    show sinceV1_0_0, sinceV2_0_0;
import 'package:health_connector_core/src/models/exceptions/health_connector_error_code.dart'
    show HealthConnectorErrorCode;
import 'package:meta/meta.dart' show immutable;

/// Sealed exception class for all health connector plugin errors.
///
/// {@category Exceptions}
@sinceV1_0_0
@immutable
sealed class HealthConnectorException implements Exception {
  /// Creates a [HealthConnectorException].
  ///
  /// ## Parameters
  /// - [code]: The error code identifying the type of error.
  /// - [message]: A human-readable description of the error.
  /// - [cause]: The underlying cause of this exception, if any.
  const HealthConnectorException(
    this.code,
    this.message, {
    this.cause,
    this.stackTrace,
  });

  /// Creates a specific [HealthConnectorException] subclass based on the
  /// provided [code].
  ///
  /// ## Parameters
  /// - [code]: The error code identifying the type of error.
  /// - [message]: A human-readable description of the error.
  /// - [cause]: The underlying cause of this exception, if any.
  /// - [stackTrace]: The stack trace of this exception, if any.
  @sinceV2_0_0
  factory HealthConnectorException.fromCode(
    HealthConnectorErrorCode code,
    String message, {
    Object? cause,
    StackTrace? stackTrace,
  }) {
    switch (code) {
      case HealthConnectorErrorCode.healthPlatformNotInstalledOrUpdateRequired:
        return HealthPlatformNotInstalledOrUpdateRequiredException(
          message,
          cause: cause,
          stackTrace: stackTrace,
        );
      case HealthConnectorErrorCode.healthPlatformUnavailable:
        return HealthPlatformUnavailableException(
          message,
          cause: cause,
          stackTrace: stackTrace,
        );
      case HealthConnectorErrorCode.unsupportedOperation:
        return UnsupportedOperationException(
          message,
          cause: cause,
          stackTrace: stackTrace,
        );
      case HealthConnectorErrorCode.invalidConfiguration:
        return InvalidConfigurationException(
          message,
          cause: cause,
          stackTrace: stackTrace,
        );
      case HealthConnectorErrorCode.invalidArgument:
        return InvalidArgumentException(
          message,
          cause: cause,
          stackTrace: stackTrace,
        );
      case HealthConnectorErrorCode.notAuthorized:
        return NotAuthorizedException(
          message,
          cause: cause,
          stackTrace: stackTrace,
        );
      case HealthConnectorErrorCode.remoteError:
        return RemoteErrorException(
          message,
          cause: cause,
          stackTrace: stackTrace,
        );
      case HealthConnectorErrorCode.unknown:
        return UnknownException(
          message,
          cause: cause,
          stackTrace: stackTrace,
        );
    }
  }

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
      'HealthConnectorException(code=${code.code}, message=$message',
    );

    if (cause != null) {
      buffer.write(', cause=$cause');
    }

    if (stackTrace != null) {
      buffer.write(', stackTrace=$stackTrace');
    }

    buffer.write(')');

    return buffer.toString();
  }
}

/// Exception thrown when the health platform needs to be installed or updated.
///
/// ## See Also
///
/// - [HealthConnectorErrorCode.healthPlatformNotInstalledOrUpdateRequired]
///
/// {@category Exceptions}
@sinceV2_0_0
@immutable
final class HealthPlatformNotInstalledOrUpdateRequiredException
    extends HealthConnectorException {
  /// Creates a [HealthPlatformNotInstalledOrUpdateRequiredException].
  const HealthPlatformNotInstalledOrUpdateRequiredException(
    String message, {
    Object? cause,
    StackTrace? stackTrace,
  }) : super(
         HealthConnectorErrorCode.healthPlatformNotInstalledOrUpdateRequired,
         message,
         cause: cause,
         stackTrace: stackTrace,
       );
}

/// Exception thrown when the health platform is unavailable on this device.
///
/// ## See Also
///
/// - [HealthConnectorErrorCode.healthPlatformUnavailable]
///
/// {@category Exceptions}
@sinceV2_0_0
@immutable
final class HealthPlatformUnavailableException
    extends HealthConnectorException {
  /// Creates a [HealthPlatformUnavailableException].
  const HealthPlatformUnavailableException(
    String message, {
    Object? cause,
    StackTrace? stackTrace,
  }) : super(
         HealthConnectorErrorCode.healthPlatformUnavailable,
         message,
         cause: cause,
         stackTrace: stackTrace,
       );
}

/// Exception thrown when an API not supported by the current platform or
/// version is used.
///
/// ## See Also
///
/// - [HealthConnectorErrorCode.unsupportedOperation]
///
/// {@category Exceptions}
@sinceV2_0_0
@immutable
final class UnsupportedOperationException extends HealthConnectorException {
  /// Creates an [UnsupportedOperationException].
  const UnsupportedOperationException(
    String message, {
    Object? cause,
    StackTrace? stackTrace,
  }) : super(
         HealthConnectorErrorCode.unsupportedOperation,
         message,
         cause: cause,
         stackTrace: stackTrace,
       );
}

/// Exception thrown when the app configuration is missing or invalid.
///
/// ## See Also
///
/// - [HealthConnectorErrorCode.invalidConfiguration]
///
/// {@category Exceptions}
@sinceV2_0_0
@immutable
final class InvalidConfigurationException extends HealthConnectorException {
  /// Creates an [InvalidConfigurationException].
  const InvalidConfigurationException(
    String message, {
    Object? cause,
    StackTrace? stackTrace,
  }) : super(
         HealthConnectorErrorCode.invalidConfiguration,
         message,
         cause: cause,
         stackTrace: stackTrace,
       );
}

/// Exception thrown when an invalid argument is provided to the API.
///
/// ## See Also
///
/// - [HealthConnectorErrorCode.invalidArgument]
///
/// {@category Exceptions}
@sinceV2_0_0
@immutable
final class InvalidArgumentException extends HealthConnectorException {
  /// Creates an [InvalidArgumentException].
  const InvalidArgumentException(
    String message, {
    Object? cause,
    StackTrace? stackTrace,
  }) : super(
         HealthConnectorErrorCode.invalidArgument,
         message,
         cause: cause,
         stackTrace: stackTrace,
       );
}

/// Exception thrown when access to health data was denied or not yet
/// authorized.
///
/// ## See Also
///
/// - [HealthConnectorErrorCode.notAuthorized]
///
/// {@category Exceptions}
@sinceV2_0_0
@immutable
final class NotAuthorizedException extends HealthConnectorException {
  /// Creates a [NotAuthorizedException].
  const NotAuthorizedException(
    String message, {
    Object? cause,
    StackTrace? stackTrace,
  }) : super(
         HealthConnectorErrorCode.notAuthorized,
         message,
         cause: cause,
         stackTrace: stackTrace,
       );
}

/// Exception thrown when a transient I/O or communication error occurred.
///
/// ## See Also
///
/// - [HealthConnectorErrorCode.remoteError]
///
/// {@category Exceptions}
@sinceV2_0_0
@immutable
final class RemoteErrorException extends HealthConnectorException {
  /// Creates a [RemoteErrorException].
  const RemoteErrorException(
    String message, {
    Object? cause,
    StackTrace? stackTrace,
  }) : super(
         HealthConnectorErrorCode.remoteError,
         message,
         cause: cause,
         stackTrace: stackTrace,
       );
}

/// Exception thrown when an unknown or unexpected error occurred.
///
/// ## See Also
///
/// - [HealthConnectorErrorCode.unknown]
///
/// {@category Exceptions}
@sinceV2_0_0
@immutable
final class UnknownException extends HealthConnectorException {
  /// Creates an [UnknownException].
  const UnknownException(
    String message, {
    Object? cause,
    StackTrace? stackTrace,
  }) : super(
         HealthConnectorErrorCode.unknown,
         message,
         cause: cause,
         stackTrace: stackTrace,
       );
}
