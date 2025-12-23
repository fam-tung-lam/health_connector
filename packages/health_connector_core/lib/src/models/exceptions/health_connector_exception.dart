import 'package:health_connector_core/src/annotations/annotations.dart'
    show sinceV1_0_0, sinceV2_0_0;
import 'package:health_connector_core/src/models/exceptions/health_connector_error_code.dart'
    show HealthConnectorErrorCode;
import 'package:meta/meta.dart' show immutable;

/// Sealed exception class for all health connector plugin errors.
///
/// Use the specific subclasses to create exceptions with the appropriate error
/// code automatically assigned. Each subclass corresponds to a specific
/// [HealthConnectorErrorCode].
///
/// Example:
/// ```dart
/// try {
///   await HealthConnector.requestPermissions([...]);
/// } on HealthPlatformNotInstalledOrUpdateRequiredException {
///   // Prompt user to install Health Connect (Android Health Connect Only)
/// } on NotAuthorizedException {
///   // Handle permission denial
/// } on HealthConnectorException catch (e) {
///   // Handle generic health connector errors
///   print('Error: ${e.message}, Code: ${e.code}');
/// } catch (e) {
///   // Handle other unknown errors
/// }
/// ```
///
/// {@category Exceptions}
@sinceV1_0_0
@immutable
sealed class HealthConnectorException implements Exception {
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

  /// Creates a specific [HealthConnectorException] subclass based on the
  /// provided [code].
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
      'HealthConnectorException [${code.code}]: $message',
    );
    if (cause != null) {
      buffer.write('\n  Caused by: $cause');
    }

    return buffer.toString();
  }
}

/// Exception thrown when the health platform needs to be installed or updated.
///
/// **Platform:** Android Health Connect Only. On iOS Apple Health is
/// pre-installed.
///
/// **Causes:**
/// - Health Connect app is not installed.
/// - Health Connect app is outdated and requires an update.
///
/// **Action:**
/// - Prompt the user to install or update Health Connect from the Play Store.
/// - Provide a direct link.
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
/// **Causes:**
/// - Device does not support health API (Android < SDK 28, unsupported iPad).
/// - Enterprise policy (MDM) or parental controls block access.
/// - Health service is explicitly disabled by the system.
/// - Device is in a restricted profile (Android work profile).
///
/// **Action:**
/// - Inform the user that health features are not available on their device.
/// - Gracefully disable health-related functionality.
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
/// **Causes:**
/// - Calling an Android-specific API on iOS (or vice versa).
/// - Requesting a data type unsupported by the current SDK version.
///
/// **Action:**
/// - Check platform/version before calling the API.
/// - This error should not occur in production if properly guarded.
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
/// **Causes:**
/// - Android: Missing permissions in `AndroidManifest.xml`.
/// - Android: Missing Play Console health data declarations.
/// - iOS: Missing HealthKit entitlement in Signing & Capabilities.
/// - iOS: Missing usage description keys in `Info.plist`.
///
/// **Action:**
/// - Check build logs and fix the app configuration.
/// - This error should not occur in production if properly configured.
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
/// **Causes:**
/// - `startTime` is after `endTime`.
/// - Value out of valid range (e.g., negative step count).
/// - Record ID does not exist (delete/update operations).
///
/// **Action:**
/// - Validate inputs before calling the plugin.
/// - Refresh local record ID cache before delete/update operations.
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
/// **Causes:**
/// - Permissions have not been requested yet.
/// - User denied permissions in the system dialog.
/// - Permissions were revoked via system settings.
///
/// **Action:**
/// - If not yet requested: Trigger the permission request flow.
/// - If denied: Explain why the feature needs access and guide user to
///   settings.
/// - Respect user choice; avoid repeated prompting.
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
/// **Causes:**
/// - Temporary disk I/O failure.
/// - Inter-process communication (IPC) interrupted.
/// - Background service temporarily unreachable.
/// - Too many read/write operations in a short time window (Android Health Connect Only).
///
/// **Action:**
/// - Retry with exponential backoff (e.g., 1s → 2s → 4s, max 30s).
/// - These issues typically resolve quickly without user intervention.
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
/// **Causes:**
/// - Unmapped native error code.
/// - Internal platform bug.
/// - New error type from SDK update.
///
/// **Action:**
/// - Log the full error details for investigation.
/// - Show a generic "Something went wrong" message to the user.
/// - Report to crash analytics.
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
