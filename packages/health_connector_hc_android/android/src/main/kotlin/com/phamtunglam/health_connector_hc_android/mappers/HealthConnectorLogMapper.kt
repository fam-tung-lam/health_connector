package com.phamtunglam.health_connector_hc_android.mappers

import com.phamtunglam.health_connector_hc_android.exceptions.HealthConnectorException
import com.phamtunglam.health_connector_hc_android.logger.HealthConnectorLogger
import com.phamtunglam.health_connector_hc_android.pigeon.HealthConnectorErrorCodeDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthConnectorExceptionDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthConnectorLogLevelDto

/**
 * Converts internal [HealthConnectorLogger.LogLevel] to Pigeon-generated
 * [HealthConnectorLogLevelDto].
 */
internal fun HealthConnectorLogger.LogLevel.toDto(): HealthConnectorLogLevelDto = when (this) {
    HealthConnectorLogger.LogLevel.DEBUG -> HealthConnectorLogLevelDto.DEBUG
    HealthConnectorLogger.LogLevel.INFO -> HealthConnectorLogLevelDto.INFO
    HealthConnectorLogger.LogLevel.WARNING -> HealthConnectorLogLevelDto.WARNING
    HealthConnectorLogger.LogLevel.ERROR -> HealthConnectorLogLevelDto.ERROR
}

/**
 * Converts a [Throwable] to [HealthConnectorExceptionDto].
 *
 * If the throwable is a [HealthConnectorException], extracts the structured
 * error code and context. Otherwise, uses UNKNOWN error code.
 */
internal fun Throwable.toExceptionInfoDto(): HealthConnectorExceptionDto = when (this) {
    is HealthConnectorException -> HealthConnectorExceptionDto(
        code = this.code,
        message = this.message?.takeIf { it.isNotBlank() } ?: "Unknown error",
        cause = this.cause?.message ?: this.cause?.toString(),
    )
    else -> HealthConnectorExceptionDto(
        code = HealthConnectorErrorCodeDto.UNKNOWN,
        message = this.message?.takeIf { it.isNotBlank() } ?: "Unknown error",
        cause = this.cause?.message ?: this.cause?.toString(),
    )
}
