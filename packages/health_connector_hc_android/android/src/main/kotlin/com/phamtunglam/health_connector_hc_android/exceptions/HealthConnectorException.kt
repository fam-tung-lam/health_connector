package com.phamtunglam.health_connector_hc_android.exceptions

import com.phamtunglam.health_connector_hc_android.pigeon.HealthConnectorErrorCodeDto

/**
 * Defines a standardized set of errors that can occur.
 *
 * This sealed class hierarchy provides type-safe error handling with associated context
 * and debugging information. Each error type contains relevant details for proper error
 * handling and debugging.
 */
sealed class HealthConnectorException : Throwable() {
    /**
     * Error code.
     */
    abstract val code: HealthConnectorErrorCodeDto

    /**
     * Optional additional key-value data for debugging purposes.
     */
    abstract val context: Map<String, Any>?

    /**
     * Indicates that the health platform needs to be installed or updated.
     *
     * This is Android-specific and occurs when Health Connect is not installed
     * or requires an update.
     *
     * @property message Description of why installation/update is needed.
     * @property cause Optional underlying exception.
     * @property context Additional debugging information.
     */
    data class HealthPlatformNotInstalledOrUpdateRequired(
        override val message: String,
        override val cause: Throwable? = null,
        override val context: Map<String, Any>? = null,
    ) : HealthConnectorException() {
        override val code: HealthConnectorErrorCodeDto =
            HealthConnectorErrorCodeDto.HEALTH_PLATFORM_NOT_INSTALLED_OR_UPDATE_REQUIRED
    }

    /**
     * Indicates that the underlying health service is not available on the device.
     *
     * This can occur when:
     * - Device does not support the health API
     * - Enterprise policy or parental controls block access
     * - Health service is disabled by the system
     *
     * @property message Description of why the health service is unavailable.
     * @property cause Optional underlying exception.
     * @property context Additional debugging information.
     */
    data class HealthPlatformUnavailable(
        override val message: String,
        override val cause: Throwable? = null,
        override val context: Map<String, Any>? = null,
    ) : HealthConnectorException() {
        override val code: HealthConnectorErrorCodeDto =
            HealthConnectorErrorCodeDto.HEALTH_PLATFORM_UNAVAILABLE
    }

    /**
     * Represents a configuration error, such as missing manifest permissions or Info.plist keys.
     *
     * This typically indicates a development-time issue that should be fixed before release.
     *
     * @property message Description of the configuration issue.
     * @property cause Optional underlying exception.
     * @property context Additional debugging information about the missing configuration.
     */
    data class InvalidConfiguration(
        override val message: String,
        override val cause: Throwable? = null,
        override val context: Map<String, Any>? = null,
    ) : HealthConnectorException() {
        override val code: HealthConnectorErrorCodeDto =
            HealthConnectorErrorCodeDto.INVALID_CONFIGURATION
    }

    /**
     * Signals that a method was called with an invalid argument.
     *
     * This can occur when:
     * - startTime is after endTime
     * - Value is out of valid range
     * - Record ID does not exist
     *
     * @property message Description of the invalid argument.
     * @property cause Optional underlying exception.
     * @property context Additional debugging information about the invalid argument.
     */
    data class InvalidArgument(
        override val message: String,
        override val cause: Throwable? = null,
        override val context: Map<String, Any>? = null,
    ) : HealthConnectorException() {
        override val code: HealthConnectorErrorCodeDto =
            HealthConnectorErrorCodeDto.INVALID_ARGUMENT
    }

    /**
     * Indicates that the requested operation is not supported.
     *
     * This can occur when:
     * - Calling a platform-specific API on the wrong platform
     * - Requesting a data type unsupported by the current SDK version
     *
     * @property message Description of the unsupported operation.
     * @property cause Optional underlying exception.
     * @property context Additional debugging information.
     */
    data class UnsupportedOperation(
        override val message: String,
        override val cause: Throwable? = null,
        override val context: Map<String, Any>? = null,
    ) : HealthConnectorException() {
        override val code: HealthConnectorErrorCodeDto =
            HealthConnectorErrorCodeDto.UNSUPPORTED_OPERATION
    }

    /**
     * Signals that the user has not granted the necessary permissions for the operation.
     *
     * This can occur when:
     * - Permissions have not been requested yet
     * - User denied permissions
     * - Permissions were revoked via system settings
     *
     * @property message Description of the authorization failure.
     * @property cause Optional underlying exception.
     * @property context Additional debugging information.
     */
    data class NotAuthorized(
        override val message: String,
        override val cause: Throwable? = null,
        override val context: Map<String, Any>? = null,
    ) : HealthConnectorException() {
        override val code: HealthConnectorErrorCodeDto = HealthConnectorErrorCodeDto.NOT_AUTHORIZED
    }

    /**
     * A transient I/O or communication error occurred.
     *
     * This is Android-specific and can occur when:
     * - Temporary disk I/O failure
     * - Inter-process communication interrupted
     * - Background service temporarily unreachable
     * - Too many operations in a short time window
     *
     * @property message Description of the remote error.
     * @property cause Optional underlying exception.
     * @property context Additional debugging information.
     */
    data class RemoteError(
        override val message: String,
        override val cause: Throwable? = null,
        override val context: Map<String, Any>? = null,
    ) : HealthConnectorException() {
        override val code: HealthConnectorErrorCodeDto = HealthConnectorErrorCodeDto.REMOTE_ERROR
    }

    /**
     * Indicates that a synchronization token has expired.
     *
     * This is Android-specific and occurs when:
     * - ChangesToken has not been used for more than ~30 days
     * - Health Connect database was reset or upgraded
     * - Token was invalidated by the system
     *
     * ## Recovery Strategy
     *
     * When this error occurs, clients should:
     * 1. Calculate the data gap: `now - syncToken.createdAt`
     * 2. Backfill missing data using `readRecords()` for the gap period
     * 3. Reset sync by calling `synchronize(syncToken: null)` to get a fresh token
     * 4. Log the event for monitoring sync health
     *
     * @property message Description of the token expiration.
     * @property cause Optional underlying exception (typically ChangesTokenExpiredException).
     * @property context Additional debugging information.
     */
    data class SyncTokenExpired(
        override val message: String,
        override val cause: Throwable? = null,
        override val context: Map<String, Any>? = null,
    ) : HealthConnectorException() {
        override val code: HealthConnectorErrorCodeDto = HealthConnectorErrorCodeDto.SYNC_TOKEN_EXPIRED
    }

    /**
     * A generic, unexpected error that doesn't fit other categories.
     *
     * This should be used as a fallback for unmapped error codes or unexpected situations.
     *
     * @property message Description of the unknown error.
     * @property cause Optional underlying exception.
     * @property context Additional debugging information.
     */
    data class Unknown(
        override val message: String,
        override val cause: Throwable? = null,
        override val context: Map<String, Any>? = null,
    ) : HealthConnectorException() {
        override val code: HealthConnectorErrorCodeDto = HealthConnectorErrorCodeDto.UNKNOWN
    }
}
