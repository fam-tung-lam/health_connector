package com.phamtunglam.health_connector_hc_android.handlers

import androidx.health.connect.client.HealthConnectClient
import com.phamtunglam.health_connector_hc_android.exceptions.HealthConnectorException
import com.phamtunglam.health_connector_hc_android.logger.HealthConnectorLogger
import com.phamtunglam.health_connector_hc_android.pigeon.HealthConnectorErrorCodeDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataTypeDto
import java.io.IOException
import kotlinx.coroutines.CoroutineDispatcher
import kotlinx.coroutines.withContext

/**
 * Base interface for all Health Connect record handlers.
 */
internal interface HealthRecordHandler {
    /**
     * The health data type this handler supports.
     */
    val dataType: HealthDataTypeDto

    /**
     * Coroutine dispatcher provider.
     */
    val dispatcher: CoroutineDispatcher

    /**
     * Health Connect SDK client for performing operations.
     */
    val client: HealthConnectClient

    /**
     * Tag used for logging.
     */
    val tag: String

    /**
     * Centralized exception handling wrapper for handler operations.
     *
     * This method wraps handler calls with consistent exception handling,
     * mapping SDK exceptions to [HealthConnectorException] with appropriate error codes.
     *
     * Exception mappings:
     * - [SecurityException] -> [HealthConnectorException.Authorization] (permissionNotGranted)
     * - [IllegalArgumentException] -> [HealthConnectorException.InvalidArgument]
     * - [IllegalStateException] -> [HealthConnectorException.InvalidArgument]
     * - [IOException] -> [HealthConnectorException.HealthService] (ioError)
     *
     * @param operation Human-readable operation name for logging (e.g., "readRecord", "writeRecords")
     * @param context Additional context for logging (e.g., recordId, time range)
     * @param block The suspending operation to execute
     * @return The result of the block if successful
     * @throws HealthConnectorException with appropriate error code
     */
    @Throws(HealthConnectorException::class)
    suspend fun <T> process(
        operation: String,
        context: Map<String, Any?>? = null,
        block: suspend () -> T,
    ): T = withContext(dispatcher) {
        try {
            return@withContext block()
        } catch (e: SecurityException) {
            HealthConnectorLogger.error(
                tag = tag,
                operation = operation,
                message = "Permission denied while $operation for $dataType",
                context = context,
                exception = e,
            )
            throw HealthConnectorException.Authorization(
                code = HealthConnectorErrorCodeDto.PERMISSION_NOT_GRANTED,
                message = "Permission not granted for $dataType: ${e.message ?: "Access denied"}",
                cause = e,
            )
        } catch (e: IllegalArgumentException) {
            HealthConnectorLogger.error(
                tag = tag,
                operation = operation,
                message = "Invalid argument while $operation for $dataType",
                context = context,
                exception = e,
            )
            throw HealthConnectorException.InvalidArgument(
                message = "Invalid argument for $dataType: ${e.message}",
                cause = e,
            )
        } catch (e: IllegalStateException) {
            HealthConnectorLogger.error(
                tag = tag,
                operation = operation,
                message = "Invalid state while $operation for $dataType",
                context = context,
                exception = e,
            )
            throw HealthConnectorException.InvalidArgument(
                message = "Invalid state for $dataType: ${e.message}",
                cause = e,
            )
        } catch (e: IOException) {
            HealthConnectorLogger.error(
                tag = tag,
                operation = operation,
                message = "I/O error while $operation for $dataType",
                context = context,
                exception = e,
            )
            throw HealthConnectorException.HealthService(
                code = HealthConnectorErrorCodeDto.IO_ERROR,
                message = "I/O error for $dataType: ${e.message ?: "I/O error"}",
                cause = e,
            )
        }
    }
}
