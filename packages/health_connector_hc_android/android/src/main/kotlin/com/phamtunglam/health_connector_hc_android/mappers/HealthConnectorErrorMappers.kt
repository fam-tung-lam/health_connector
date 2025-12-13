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
        HealthConnectorErrorCodeDto.INSTALLATION_OR_UPDATE_REQUIRED ->
            "Health Connect is required to be installed or updated"

        HealthConnectorErrorCodeDto.HEALTH_PLATFORM_UNAVAILABLE ->
            "Health Connect is unavailable"

        HealthConnectorErrorCodeDto.INVALID_PLATFORM_CONFIGURATION ->
            "Invalid platform configuration"

        HealthConnectorErrorCodeDto.UNKNOWN ->
            "An unknown error occurred"

        HealthConnectorErrorCodeDto.SECURITY_ERROR ->
            "Security/permission error: Access denied or insufficient permissions"

        HealthConnectorErrorCodeDto.INVALID_ARGUMENT ->
            "Invalid argument: Input validation failed"

        HealthConnectorErrorCodeDto.UNSUPPORTED_HEALTH_PLATFORM_API ->
            "Unsupported health platform API"
    }
    return HealthConnectorErrorDto(name, message, details)
}
