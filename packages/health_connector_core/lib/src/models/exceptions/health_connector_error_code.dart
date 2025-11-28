import 'package:health_connector_annotation/health_connector_annotation.dart'
    show sinceV1_0_0;
import 'package:health_connector_core/src/models/exceptions/health_connector_exception.dart'
    show HealthConnectorException;

/// Error codes for [HealthConnectorException].
///
/// These codes help identify the specific type of error that occurred.
@sinceV1_0_0
enum HealthConnectorErrorCode {
  /// Unknown or unspecified error.
  unknown('UNKNOWN'),

  /// Health platform app installation or update is required.
  installationOrUpdateRequired('INSTALLATION_OR_UPDATE_REQUIRED'),

  /// Health platform is unavailable on this device.
  healthPlatformUnavailable('HEALTH_PLATFORM_UNAVAILABLE'),

  /// Failed to parse data from the platform.
  ///
  /// This can occur when the platform returns malformed data or when
  /// the JSON structure doesn't match the expected format.
  parsingError('PARSING_ERROR'),

  /// Attempted to use platform APIs or features that are not supported
  /// on the current health platform.
  ///
  /// This typically indicates a developer error where plugin API are being
  /// requested that aren't available on the current health platform.
  unsupportedHealthPlatformApi('UNSUPPORTED_HEALTH_PLATFORM_API'),

  /// Platform configuration is missing or invalid.
  ///
  /// This indicates platform-specific configuration is not properly set up.
  invalidPlatformConfiguration('INVALID_PLATFORM_CONFIGURATION'),

  /// Security/permission error occurred.
  ///
  /// This error occurs when a request is made without proper permissions
  /// or when access is denied by the health platform.
  securityError('SECURITY_ERROR'),

  /// I/O error occurred during data operations.
  ioError('IO_ERROR'),

  /// Remote/IPC communication error occurred.
  ///
  /// This error occurs when inter-process communication (IPC) with the health
  /// platform service fails.
  remoteError('REMOTE_ERROR'),

  /// Invalid argument provided to the operation.
  ///
  /// This error occurs when invalid parameters are passed to an operation.
  /// For example:
  /// - Invalid record IDs
  /// - Invalid time ranges
  /// - Invalid data types or values
  /// - Missing required parameters
  invalidArgument('INVALID_ARGUMENT');

  const HealthConnectorErrorCode(this.code);

  /// The error code string.
  final String code;
}
