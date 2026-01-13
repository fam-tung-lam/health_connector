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
     * Authorization-related errors.
     *
     * Covers permission denial, not-determined state, and guest mode restrictions.
     *
     * Error codes:
     * - PERMISSION_NOT_GRANTED
     * - AUTHORIZATION_NOT_DETERMINED
     * - GUEST_MODE_NOT_PERMITTED
     *
     * @property code Specific authorization error code.
     * @property message Description of the authorization error.
     * @property cause Optional underlying exception.
     * @property context Additional debugging information.
     */
    data class Authorization(
        override val code: HealthConnectorErrorCodeDto,
        override val message: String,
        override val cause: Throwable? = null,
        override val context: Map<String, Any>? = null,
    ) : HealthConnectorException()

    /**
     * Configuration-related errors.
     *
     * Indicates missing permissions in AndroidManifest.xml or other configuration issues.
     *
     * Error codes:
     * - PERMISSION_NOT_DECLARED
     *
     * @property message Description of the configuration issue.
     * @property cause Optional underlying exception.
     * @property context Additional debugging information about the missing configuration.
     */
    data class Configuration(
        override val message: String,
        override val cause: Throwable? = null,
        override val context: Map<String, Any>? = null,
    ) : HealthConnectorException() {
        override val code: HealthConnectorErrorCodeDto =
            HealthConnectorErrorCodeDto.PERMISSION_NOT_DECLARED
    }

    /**
     * Health service unavailability errors.
     *
     * Covers cases where the health service cannot be accessed.
     *
     * Error codes:
     * - HEALTH_SERVICE_UNAVAILABLE
     * - HEALTH_SERVICE_RESTRICTED
     * - HEALTH_SERVICE_NOT_INSTALLED_OR_UPDATE_REQUIRED
     *
     * @property code Specific service unavailability error code.
     * @property message Description of why the health service is unavailable.
     * @property cause Optional underlying exception.
     * @property context Additional debugging information.
     */
    data class HealthServiceUnavailable(
        override val code: HealthConnectorErrorCodeDto,
        override val message: String,
        override val cause: Throwable? = null,
        override val context: Map<String, Any>? = null,
    ) : HealthConnectorException()

    /**
     * Health service operational errors.
     *
     * Covers transient errors during health service operations.
     *
     * Error codes:
     * - HEALTH_SERVICE_DATABASE_INACCESSIBLE
     * - IO_ERROR
     * - REMOTE_ERROR
     * - RATE_LIMIT_EXCEEDED
     * - DATA_SYNC_IN_PROGRESS
     *
     * @property code Specific service error code.
     * @property message Description of the service error.
     * @property cause Optional underlying exception.
     * @property context Additional debugging information.
     */
    data class HealthService(
        override val code: HealthConnectorErrorCodeDto,
        override val message: String,
        override val cause: Throwable? = null,
        override val context: Map<String, Any>? = null,
    ) : HealthConnectorException()

    /**
     * Invalid argument errors.
     *
     * Signals that a method was called with an invalid argument.
     *
     * This can occur when:
     * - startTime is after endTime
     * - Value is out of valid range
     * - Record ID does not exist
     * - Malformed record data
     * - Expired change token
     *
     * Error codes:
     * - INVALID_ARGUMENT
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
     * Unsupported operation errors.
     *
     * Indicates that the requested operation is not supported.
     *
     * This can occur when:
     * - Calling a platform-specific API on the wrong platform
     * - Requesting a data type unsupported by the current SDK version
     *
     * Error codes:
     * - UNSUPPORTED_OPERATION
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
     * Unknown errors.
     *
     * A generic, unexpected error that doesn't fit other categories.
     *
     * This should be used as a fallback for unmapped error codes or unexpected situations.
     *
     * Error codes:
     * - UNKNOWN_ERROR
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
        override val code: HealthConnectorErrorCodeDto = HealthConnectorErrorCodeDto.UNKNOWN_ERROR
    }
}
