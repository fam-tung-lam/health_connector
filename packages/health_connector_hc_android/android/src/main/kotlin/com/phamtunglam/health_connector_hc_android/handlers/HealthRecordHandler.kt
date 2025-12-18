package com.phamtunglam.health_connector_hc_android.handlers

import androidx.health.connect.client.HealthConnectClient
import com.phamtunglam.health_connector_hc_android.logger.HealthConnectorLogger
import com.phamtunglam.health_connector_hc_android.logger.TAG
import com.phamtunglam.health_connector_hc_android.mappers.toError
import com.phamtunglam.health_connector_hc_android.pigeon.HealthConnectorErrorCodeDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthConnectorErrorDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataTypeDto
import java.io.IOException

/**
 * Base interface for all Health Connect record handlers.
 */
internal interface HealthRecordHandler {
    /**
     * The health data type this handler supports.
     */
    val dataType: HealthDataTypeDto

    /**
     * Health Connect SDK client for performing operations.
     */
    val client: HealthConnectClient

    /**
     * Centralized exception handling wrapper for handler operations.
     *
     * This method wraps handler calls with consistent exception handling,
     * mapping SDK exceptions to [HealthConnectorErrorDto] with appropriate error codes.
     *
     * Exception mappings:
     * - [SecurityException] -> [HealthConnectorErrorCodeDto.NOT_AUTHORIZED]
     * - [IllegalArgumentException] -> [HealthConnectorErrorCodeDto.INVALID_ARGUMENT]
     * - [IllegalStateException] -> [HealthConnectorErrorCodeDto.INVALID_ARGUMENT]
     * - [IOException] -> [HealthConnectorErrorCodeDto.REMOTE_ERROR]
     *
     * @param operation Human-readable operation name for logging (e.g., "readRecord", "writeRecords")
     * @param context Additional context for logging (e.g., recordId, time range)
     * @param block The suspending operation to execute
     * @return The result of the block if successful
     * @throws HealthConnectorErrorDto with appropriate error code
     */
    @Throws(HealthConnectorErrorDto::class)
    suspend fun <T> process(
        operation: String,
        context: Map<String, Any?>? = null,
        block: suspend () -> T,
    ): T {
        try {
            return block()
        } catch (e: SecurityException) {
            HealthConnectorLogger.error(
                tag = TAG,
                operation = operation,
                message = "Permission denied while $operation for $dataType",
                context = context,
                exception = e,
            )
            throw HealthConnectorErrorCodeDto.NOT_AUTHORIZED.toError(
                "Permission denied for $dataType: ${e.message ?: "Access denied"}",
            )
        } catch (e: IllegalArgumentException) {
            HealthConnectorLogger.error(
                tag = TAG,
                operation = operation,
                message = "Invalid argument while $operation for $dataType",
                context = context,
                exception = e,
            )
            throw HealthConnectorErrorCodeDto.INVALID_ARGUMENT.toError(
                "Invalid argument for $dataType: ${e.message}",
            )
        } catch (e: IllegalStateException) {
            HealthConnectorLogger.error(
                tag = TAG,
                operation = operation,
                message = "Invalid state while $operation for $dataType",
                context = context,
                exception = e,
            )
            throw HealthConnectorErrorCodeDto.INVALID_ARGUMENT.toError(
                "Invalid state for $dataType: ${e.message}",
            )
        } catch (e: IOException) {
            HealthConnectorLogger.error(
                tag = TAG,
                operation = operation,
                message = "I/O error while $operation for $dataType",
                context = context,
                exception = e,
            )
            throw HealthConnectorErrorCodeDto.REMOTE_ERROR.toError(
                "I/O error for $dataType: ${e.message ?: "I/O error"}",
            )
        }
    }
}
