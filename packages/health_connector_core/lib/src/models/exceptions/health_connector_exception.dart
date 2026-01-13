import 'package:health_connector_core/src/annotations/annotations.dart'
    show sinceV1_0_0, sinceV2_0_0, sinceV3_0_0;
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
      // Authorization exceptions
      case HealthConnectorErrorCode.permissionNotGranted:
        return AuthorizationException(
          code,
          message,
          cause: cause,
          stackTrace: stackTrace,
        );

      // Configuration exception
      case HealthConnectorErrorCode.permissionNotDeclared:
        return ConfigurationException(
          message,
          cause: cause,
          stackTrace: stackTrace,
        );

      // Invalid argument exception
      case HealthConnectorErrorCode.invalidArgument:
        return InvalidArgumentException(
          message,
          cause: cause,
          stackTrace: stackTrace,
        );

      // Health service unavailable exceptions
      case HealthConnectorErrorCode.healthServiceUnavailable:
      case HealthConnectorErrorCode.healthServiceRestricted:
      case HealthConnectorErrorCode.healthServiceNotInstalledOrUpdateRequired:
        return HealthServiceUnavailableException(
          code,
          message,
          cause: cause,
          stackTrace: stackTrace,
        );

      // Health service exceptions
      case HealthConnectorErrorCode.healthServiceDatabaseInaccessible:
      case HealthConnectorErrorCode.ioError:
      case HealthConnectorErrorCode.remoteError:
      case HealthConnectorErrorCode.rateLimitExceeded:
      case HealthConnectorErrorCode.dataSyncInProgress:
        return HealthServiceException(
          code,
          message,
          cause: cause,
          stackTrace: stackTrace,
        );

      // Unsupported operation exception
      case HealthConnectorErrorCode.unsupportedOperation:
        return UnsupportedOperationException(
          message,
          cause: cause,
          stackTrace: stackTrace,
        );

      // Unknown exception
      case HealthConnectorErrorCode.unknownError:
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

/// Exception thrown when authorization/permission issues occur.
///
/// This exception groups all authorization-related errors:
/// - [HealthConnectorErrorCode.permissionNotGranted]

///
/// {@category Exceptions}
@sinceV3_0_0
@immutable
final class AuthorizationException extends HealthConnectorException {
  /// Creates an [AuthorizationException].
  const AuthorizationException(
    super.code,
    super.message, {
    super.cause,
    super.stackTrace,
  });
}

/// Exception thrown when app configuration is missing or invalid.
///
/// This exception is for configuration errors:
/// - [HealthConnectorErrorCode.permissionNotDeclared]
///
/// {@category Exceptions}
@sinceV3_0_0
@immutable
final class ConfigurationException extends HealthConnectorException {
  /// Creates a [ConfigurationException].
  const ConfigurationException(
    String message, {
    Object? cause,
    StackTrace? stackTrace,
  }) : super(
         HealthConnectorErrorCode.permissionNotDeclared,
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

/// Exception thrown when health service is unavailable.
///
/// This exception groups service unavailability errors:
/// - [HealthConnectorErrorCode.healthServiceUnavailable]
/// - [HealthConnectorErrorCode.healthServiceRestricted]
/// - [HealthConnectorErrorCode.healthServiceNotInstalledOrUpdateRequired]
///
/// {@category Exceptions}
@sinceV3_0_0
@immutable
final class HealthServiceUnavailableException extends HealthConnectorException {
  /// Creates a [HealthServiceUnavailableException].
  const HealthServiceUnavailableException(
    super.code,
    super.message, {
    super.cause,
    super.stackTrace,
  });
}

/// Exception thrown when health service operational errors occur.
///
/// This exception groups operational errors:
/// - [HealthConnectorErrorCode.healthServiceDatabaseInaccessible]
/// - [HealthConnectorErrorCode.ioError]
/// - [HealthConnectorErrorCode.remoteError]
/// - [HealthConnectorErrorCode.rateLimitExceeded]
/// - [HealthConnectorErrorCode.dataSyncInProgress]
///
/// {@category Exceptions}
@sinceV3_0_0
@immutable
final class HealthServiceException extends HealthConnectorException {
  /// Creates a [HealthServiceException].
  const HealthServiceException(
    super.code,
    super.message, {
    super.cause,
    super.stackTrace,
  });
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

/// Exception thrown when an unknown or unexpected error occurred.
///
/// ## See Also
///
/// - [HealthConnectorErrorCode.unknownError]
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
         HealthConnectorErrorCode.unknownError,
         message,
         cause: cause,
         stackTrace: stackTrace,
       );
}
