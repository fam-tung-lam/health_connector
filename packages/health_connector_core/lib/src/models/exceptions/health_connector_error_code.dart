import 'package:health_connector_core/src/annotations/annotations.dart'
    show sinceV1_0_0, sinceV2_0_0;
import 'package:health_connector_core/src/models/exceptions/health_connector_exception.dart';

/// Error codes for [HealthConnectorException].
///
/// These codes help identify the specific type of error that occurred.
@sinceV1_0_0
enum HealthConnectorErrorCode {
  /// The health platform needs to be installed or updated.
  ///
  /// **Platform:** Android only (iOS Apple Health is pre-installed)
  ///
  /// **Causes:**
  /// - Health Connect app is not installed.
  /// - Health Connect app is outdated and requires an update.
  ///
  /// **Action:**
  /// - Prompt the user to install or update Health Connect from the Play Store.
  /// - Provide a direct link.
  ///
  /// Throws [HealthProviderNotInstalledOrUpdateRequiredException].
  healthProviderNotInstalledOrUpdateRequired(
    'HEALTH_PROVIDER_NOT_INSTALLED_OR_UPDATE_REQUIRED',
  ),

  /// The health platform is unavailable on this device.
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
  /// Throws [HealthProviderUnavailableException].
  healthProviderUnavailable('HEALTH_PROVIDER_UNAVAILABLE'),

  /// Attempted to use an API not supported by the current platform or version.
  ///
  /// **Causes:**
  /// - Calling an Android-specific API on iOS (or vice versa).
  /// - Requesting a data type unsupported by the current SDK version.
  ///
  /// **Action:**
  /// - Check platform/version before calling the API.
  /// - This error should not occur in production if properly guarded.
  ///
  /// Throws [UnsupportedOperationException].
  unsupportedOperation('UNSUPPORTED_OPERATION'),

  /// Missing or invalid app configuration.
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
  /// Throws [InvalidConfigurationException].
  invalidConfiguration('INVALID_CONFIGURATION'),

  /// Invalid argument provided to the API.
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
  /// Throws [InvalidArgumentException].
  invalidArgument('INVALID_ARGUMENT'),

  /// Access to health data was denied or not yet authorized.
  ///
  /// **Causes:**
  /// - Permissions have not been requested yet.
  /// - User denied permissions in the system dialog.
  /// - Permissions were revoked via system settings.
  ///
  /// **Action:**
  /// - If not yet requested: Trigger the permission request flow.
  /// - If denied: Explain why the feature needs access and
  ///   guide user to settings.
  /// - Respect user choice; avoid repeated prompting.
  ///
  /// Throws [NotAuthorizedException].
  notAuthorized('NOT_AUTHORIZED'),

  /// A transient I/O or communication error occurred.
  ///
  /// **Causes:**
  /// - Temporary disk I/O failure.
  /// - Inter-process communication (IPC) interrupted.
  /// - Background service temporarily unreachable.
  /// - Too many read/write operations in a short time window (Android only).
  ///
  /// **Action:**
  /// - Retry with exponential backoff (e.g., 1s → 2s → 4s, max 30s).
  /// - These issues typically resolve quickly without user intervention.
  ///
  /// Throws [RemoteErrorException].
  remoteError('REMOTE_ERROR'),

  /// User cancelled the operation.
  ///
  /// **Causes:**
  /// - User dismissed the permission dialog without making a choice.
  /// - User cancelled an in-progress action.
  ///
  /// **Action:**
  /// - Respect the user's choice; do not immediately re-prompt.
  /// - Continue app flow without health features if appropriate.
  /// - This is not an error condition requiring user notification.
  ///
  /// Throws [UserCancelledException].
  @sinceV2_0_0
  userCancelled('USER_CANCELLED'),

  /// An unknown or unexpected error occurred.
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
  /// Throws [UnknownException].
  unknown('UNKNOWN');

  const HealthConnectorErrorCode(this.code);

  /// The string representation of the error code.
  final String code;
}
