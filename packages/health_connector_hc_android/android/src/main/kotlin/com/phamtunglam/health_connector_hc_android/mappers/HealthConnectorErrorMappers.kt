package com.phamtunglam.health_connector_hc_android.mappers

import com.phamtunglam.health_connector_hc_android.pigeon.HealthConnectorErrorCodeDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthConnectorErrorDto

/**
 * Extension functions for creating standardized [HealthConnectorErrorDto] instances used throughout the Health Connector plugin.
 */

/**
 * Creates a [HealthConnectorErrorDto] from this error code with the appropriate message.
 *
 * @param details Additional error details such as the original exception information or
 *                suggested actions for the user.
 * @return A [HealthConnectorErrorDto] instance with the appropriate error code and message.
 */
internal fun HealthConnectorErrorCodeDto.toError(details: Any? = null): HealthConnectorErrorDto {
    val message = when (this) {
        HealthConnectorErrorCodeDto.HEALTH_PROVIDER_NOT_INSTALLED_OR_UPDATE_REQUIRED ->
            "Health Connect is required to be installed or updated"

        HealthConnectorErrorCodeDto.HEALTH_PROVIDER_UNAVAILABLE ->
            "Health Connect is unavailable"

        HealthConnectorErrorCodeDto.INVALID_CONFIGURATION ->
            "Invalid platform configuration"

        HealthConnectorErrorCodeDto.UNKNOWN ->
            "An unknown error occurred"

        HealthConnectorErrorCodeDto.NOT_AUTHORIZED ->
            "Security/permission error: Access denied or insufficient permissions"

        HealthConnectorErrorCodeDto.INVALID_ARGUMENT ->
            "Invalid argument: Input validation failed"

        HealthConnectorErrorCodeDto.UNSUPPORTED_OPERATION ->
            "Unsupported health platform API"

        HealthConnectorErrorCodeDto.REMOTE_ERROR ->
            "A transient I/O or communication error occurred"

        HealthConnectorErrorCodeDto.USER_CANCELLED ->
            "User cancelled the operation"
    }
    return HealthConnectorErrorDto(name, message, details)
}
