package com.phamtunglam.health_connector_hc_android.mappers

import com.phamtunglam.health_connector_hc_android.pigeon.HealthConnectorErrorCodeDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthConnectorErrorDto

/**
 * Creates a [HealthConnectorErrorDto] from this error code with the appropriate message.
 *
 * @param message Error message.
 * @param details Additional error details.
 *
 * @return A [HealthConnectorErrorDto] instance with the appropriate error code and message.
 */
internal fun HealthConnectorErrorCodeDto.toError(
    message: String? = null,
    details: Map<String, Any>? = null,
): HealthConnectorErrorDto = HealthConnectorErrorDto(name, message, details)
