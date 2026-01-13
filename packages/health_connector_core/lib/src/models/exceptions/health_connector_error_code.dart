import 'package:health_connector_core/src/models/exceptions/health_connector_exception.dart';

/// Error codes for [HealthConnectorException].
///
/// These codes help identify the specific type of error that occurred.
///
/// {@category Exceptions}
enum HealthConnectorErrorCode {
  /// Permission to access health data was not granted.
  ///
  /// ## Platform Behaviors
  ///
  /// - **iOS HealthKit**: Maps from `errorAuthorizationDenied`,
  ///   `errorUserCanceled`, or `errorAuthorizationNotDetermined`
  /// - **Android Health Connect**: Maps from `SecurityException` (API 33-),
  ///   `HealthConnectException.ERROR_SECURITY` (API 34+)
  ///
  /// ## Causes
  ///
  /// - User explicitly denied authorization to read/write data
  /// - User dismissed the authorization prompt without granting permission
  /// - Permissions were revoked by user via system settings
  /// - App hasn't asked user for necessary authorization yet
  ///
  /// ## Action
  ///
  /// - Request authorization using `requestAuthorization()`
  /// - If already requested, guide user to Settings to enable permissions
  /// - Explain why the feature needs access
  ///
  /// Throws [AuthorizationException].
  permissionNotGranted('PERMISSION_NOT_GRANTED'),

  /// Required permission not declared in app configuration.
  ///
  /// ## Platform Behaviors
  ///
  /// - **iOS HealthKit**: Occurs when app's Info.plist is missing required
  ///   HealthKit usage descriptions or entitlements
  /// - **Android Health Connect**: Occurs when app's AndroidManifest.xml is
  ///   missing required permissions
  ///
  /// ## Causes
  ///
  /// - **iOS HealthKit**:
  ///   - Missing `NSHealthShareUsageDescription` or
  ///   `NSHealthUpdateUsageDescription` in Info.plist
  ///   - Missing `com.apple.developer.healthkit` entitlement
  /// - **Android Health Connect**:
  ///   - Missing requested Health Connect permissions in AndroidManifest.xml
  ///
  /// ## Action
  ///
  /// - **iOS HealthKit**:
  ///   - Update Info.plist with required usage descriptions
  ///   - Add HealthKit entitlement to app
  /// - **Android Health Connect**:
  ///   - Add required permissions to AndroidManifest.xml
  ///
  /// Throws [ConfigurationException].
  permissionNotDeclared('PERMISSION_NOT_DECLARED'),

  /// Invalid parameter, malformed record, or expired change token passed.
  ///
  /// ## Platform Behaviors
  ///
  /// - **iOS HealthKit**: Maps from `errorInvalidArgument`
  /// - **Android Health Connect**: Maps from `IllegalArgumentException`
  ///   (API 33-) or `HealthConnectException.ERROR_INVALID_ARGUMENT` (API 34+)
  ///
  /// ## Causes
  ///
  /// - `startTime` is after `endTime`
  /// - Value out of valid range (e.g., negative step count)
  /// - Record ID does not exist (delete/update operations)
  /// - Invalid or malformed health record data
  /// - Expired or invalid change tokens/anchors for incremental data sync
  /// - Out-of-range values or incorrect parameter types
  ///
  /// ## Action
  ///
  /// - Review API documentation; validate input parameters
  /// - For expired sync tokens, reset sync by calling
  ///   `synchronize(syncToken: null)`
  ///
  /// Throws [InvalidArgumentException].
  invalidArgument('INVALID_ARGUMENT'),

  /// Health service is not available on this device.
  ///
  /// ## Platform Behaviors
  ///
  /// - **iOS HealthKit**: Maps from `errorHealthDataUnavailable`
  /// - **Android Health Connect**: Maps from `IllegalStateException` with
  ///   "not available" message
  ///
  /// ## Causes
  ///
  /// - Device does not support health API (Android < SDK 28, unsupported iPad)
  /// - Health service is explicitly disabled by the system
  /// - Device is in a restricted profile (Android work profile)
  ///
  /// ## Action
  ///
  /// - Inform user of limitation
  /// - Gracefully disable health-related functionality
  ///
  /// Throws [HealthServiceUnavailableException].
  healthServiceUnavailable('HEALTH_SERVICE_UNAVAILABLE'),

  /// Health service usage is restricted by policy (iOS HealthKit only).
  ///
  /// ## Platform Behaviors
  ///
  /// - **iOS HealthKit**: Maps from `errorHealthDataRestricted`
  /// - **Android Health Connect**: Not commonly seen
  ///
  /// ## Causes
  ///
  /// - Enterprise policy (MDM) restricts HealthKit usage
  /// - Parental controls block access to health features
  /// - System settings prohibit HealthKit usage
  ///
  /// ## Action
  ///
  /// - Inform user that MDM/organizational policy restricts health features
  ///
  /// Throws [HealthServiceUnavailableException].
  healthServiceRestricted('HEALTH_SERVICE_RESTRICTED'),

  /// Health Connect app not installed or update required
  /// (Android Health Connect only).
  ///
  /// ## Platform Behaviors
  ///
  /// - **iOS HealthKit**: Not applicable (Health service is pre-installed)
  /// - **Android Health Connect**: Maps from `IllegalStateException` with
  ///   "not installed" message
  ///
  /// ## Causes
  ///
  /// - Health Connect app is not installed (Android 13 and lower)
  /// - Health Connect app is outdated and requires an update
  ///
  /// ## Action
  ///
  /// - Prompt user to install Health Connect from Play Store
  /// - Provide a direct link to the Play Store
  ///
  /// Throws [HealthServiceUnavailableException].
  healthServiceNotInstalledOrUpdateRequired(
    'HEALTH_SERVICE_NOT_INSTALLED_OR_UPDATE_REQUIRED',
  ),

  /// Health database is protected and inaccessible (iOS HealthKit only).
  ///
  /// ## Platform Behaviors
  ///
  /// - **iOS HealthKit**: Maps from `errorDatabaseInaccessible`
  /// - **Android Health Connect**: Not applicable
  ///
  /// ## Causes
  ///
  /// - Device is locked and data is protected
  /// - HealthKit database access requires device to be unlocked
  ///
  /// ## Action
  ///
  /// - Wait for device to be unlocked
  /// - Cache data for later sync
  /// - Data can be saved to temporary file and merged after unlock
  ///
  /// Throws [HealthServiceException].
  healthServiceDatabaseInaccessible('HEALTH_SERVICE_DATABASE_INACCESSIBLE'),

  /// Storage read/write operation failed (Android Health Connect only).
  ///
  /// ## Platform Behaviors
  ///
  /// - **iOS HealthKit**: Not applicable
  /// - **Android Health Connect**: Maps from `IOException` (API 33-) or
  ///   `HealthConnectException.ERROR_IO` (API 34+)
  ///
  /// ## Causes
  ///
  /// - Temporary storage access failure
  /// - Disk I/O problems during CRUD operations
  /// - Failed communication with Health Connect service
  ///
  /// ## Action
  ///
  /// - Retry operation with exponential backoff
  /// - May succeed if repeated
  ///
  /// Throws [HealthServiceException].
  ioError('IO_ERROR'),

  /// IPC communication with health service failed
  /// (Android Health Connect only).
  ///
  /// ## Platform Behaviors
  ///
  /// - **iOS HealthKit**: Not applicable
  /// - **Android Health Connect**: Maps from `RemoteException` (API 33-) or
  ///   `HealthConnectException.ERROR_REMOTE` (API 34+)
  ///
  /// ## Causes
  ///
  /// - Errors within Health Connect service
  /// - Communication failure between app and Health Connect
  /// - Service temporarily unavailable
  ///
  /// ## Action
  ///
  /// - Retry operation; check if health service is running
  /// - Issues typically resolve quickly
  ///
  /// Throws [HealthServiceException].
  remoteError('REMOTE_ERROR'),

  /// API rate limit has been exhausted (Android Health Connect only).
  ///
  /// ## Platform Behaviors
  ///
  /// - **iOS HealthKit**: Not applicable
  /// - **Android Health Connect**: Maps from `RemoteException` (API 33-) with
  ///   rate limit message or
  ///   `HealthConnectException.ERROR_RATE_LIMIT_EXCEEDED` (API 34+)
  ///
  /// ## Causes
  ///
  /// - Too many API calls in short time period
  /// - Health Connect is rate limiting requests
  ///
  /// ## Action
  ///
  /// - Implement exponential backoff; batch operations to reduce API calls
  /// - Wait until quota has replenished before making further requests
  ///
  /// Throws [HealthServiceException].
  rateLimitExceeded('RATE_LIMIT_EXCEEDED'),

  /// Health service is syncing data, operations blocked (Android Health
  /// Connect only).
  ///
  /// ## Platform Behaviors
  ///
  /// - **iOS HealthKit**: Not applicable
  /// - **Android Health Connect**: Maps from `IllegalStateException` or
  ///   `RemoteException` with sync message (API 33-), or
  ///   `HealthConnectException.ERROR_DATA_SYNC_IN_PROGRESS` (API 34+)
  ///
  /// ## Causes
  ///
  /// - Health Connect is syncing data
  /// - Read and write operations blocked during sync
  ///
  /// ## Action
  ///
  /// - Retry after delay; show sync status to user
  ///
  /// Throws [HealthServiceException].
  dataSyncInProgress('DATA_SYNC_IN_PROGRESS'),

  /// Operation or data type not supported on this platform.
  ///
  /// ## Platform Behaviors
  ///
  /// - **iOS HealthKit**: Occur for unsupported operations
  /// - **Android Health Connect**: Maps from `UnsupportedOperationException`
  ///   (API 33-) or `HealthConnectException.ERROR_UNSUPPORTED_OPERATION`
  ///   (API 34+)
  ///
  /// ## Causes
  ///
  /// - Calling an Android-specific API on iOS (or vice versa)
  /// - Requesting a data type unsupported by the current SDK version
  /// - Feature not yet implemented
  /// - API not available on current platform version
  ///
  /// ## Action
  ///
  /// - Check platform capabilities before calling; provide fallback
  /// - This error should not occur in production if properly guarded
  ///
  /// Throws [UnsupportedOperationException].
  unsupportedOperation('UNSUPPORTED_OPERATION'),

  /// An unclassified or internal system error occurred.
  ///
  /// ## Platform Behaviors
  ///
  /// - **iOS HealthKit**: Maps from unrecognized HKError codes
  /// - **Android Health Connect**: Maps from general `Exception` (API 33-) or
  ///   `HealthConnectException.ERROR_UNKNOWN`, or
  ///   `HealthConnectException.ERROR_INTERNAL` (API 34+)
  ///
  /// ## Causes
  ///
  /// - Unmapped native error code
  /// - Internal platform bug
  /// - New error type from SDK update
  /// - System-level issues within health service
  ///
  /// ## Action
  ///
  /// - Log error details for debugging
  /// - Show generic error message to user
  ///
  /// Throws [UnknownException].
  unknownError('UNKNOWN_ERROR');

  const HealthConnectorErrorCode(this.code);

  /// The string representation of the error code.
  final String code;
}
