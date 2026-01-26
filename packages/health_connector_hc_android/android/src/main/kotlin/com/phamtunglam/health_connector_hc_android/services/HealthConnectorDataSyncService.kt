package com.phamtunglam.health_connector_hc_android.services

import android.health.connect.HealthConnectException
import android.os.Build
import androidx.health.connect.client.HealthConnectClient
import androidx.health.connect.client.changes.DeletionChange
import androidx.health.connect.client.changes.UpsertionChange
import androidx.health.connect.client.request.ChangesTokenRequest
import com.phamtunglam.health_connector_hc_android.exceptions.HealthConnectorException
import com.phamtunglam.health_connector_hc_android.logger.HealthConnectorLogger
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.toHealthConnectRecordClass
import com.phamtunglam.health_connector_hc_android.pigeon.HealthConnectorErrorCodeDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataSyncResultDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataSyncTokenDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataTypeDto
import java.io.IOException
import kotlinx.coroutines.CoroutineDispatcher
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.currentCoroutineContext
import kotlinx.coroutines.ensureActive
import kotlinx.coroutines.withContext

/**
 * Internal service responsible for managing Health Connect data synchronization.
 *
 * This service handles incremental data sync using Health Connect's ChangesToken API,
 * which tracks additions, modifications, and deletions since the last sync.
 *
 * @property client The native [HealthConnectClient] used to interact with Health Connect.
 */
internal class HealthConnectorDataSyncService(
    private val dispatcher: CoroutineDispatcher = Dispatchers.IO,
    private val client: HealthConnectClient,
) {
    companion object {
        private const val TAG = "HealthConnectorDataSyncService"

        private const val MILLIS_PER_SECOND = 1000L
        private const val SECONDS_PER_MINUTE = 60
        private const val MINUTES_PER_HOUR = 60
        private const val HOURS_PER_DAY = 24
        private const val MILLIS_PER_DAY =
            HOURS_PER_DAY * MINUTES_PER_HOUR * SECONDS_PER_MINUTE * MILLIS_PER_SECOND
    }

    /**
     * Synchronizes health data using incremental change tracking.
     *
     * ## Initial Sync (syncToken = null)
     * - Establishes a baseline by requesting a new changes token
     * - Returns empty records with a valid token for future incremental syncs
     *
     * ## Incremental Sync (syncToken provided)
     * - Fetches changes since the token was created
     * - Returns upserted records, deleted record IDs, and pagination info
     *
     * @param dataTypes The list of health data types to synchronize
     * @param syncToken The token from the previous sync, or null for initial sync
     * @return [HealthDataSyncResultDto] containing changes since last sync
     *
     * @throws HealthConnectorException.InvalidArgument if the token has expired (~30 days) or parameters are invalid
     * @throws HealthConnectorException.HealthService for IPC or I/O issues
     * @throws HealthConnectorException.HealthServiceUnavailable if service is unavailable
     */
    @Throws(HealthConnectorException::class)
    suspend fun synchronize(
        dataTypes: List<HealthDataTypeDto>,
        syncToken: HealthDataSyncTokenDto?,
    ): HealthDataSyncResultDto = withContext(dispatcher) {
        if (dataTypes.isEmpty()) {
            throw HealthConnectorException.InvalidArgument(
                message = "No data types provided for synchronization",
            )
        }

        if (syncToken == null) {
            performInitialSync(dataTypes)
        } else {
            performIncrementalSync(dataTypes, syncToken)
        }
    }

    /**
     * Performs initial sync by requesting a new changes token.
     *
     * @param dataTypes The list of health data types to track
     * @return [HealthDataSyncResultDto] with empty records and a new token
     */
    @Throws(HealthConnectorException::class)
    private suspend fun performInitialSync(
        dataTypes: List<HealthDataTypeDto>,
    ): HealthDataSyncResultDto {
        val context = mapOf(
            "data_type_count" to dataTypes.size,
            "has_sync_token" to false,
        )
        HealthConnectorLogger.debug(
            tag = TAG,
            operation = "synchronize",
            message = "Starting initial synchronization",
            context = context,
        )

        try {
            val recordTypes = dataTypes.map { it.toHealthConnectRecordClass() }.toSet()

            val token = client.getChangesToken(
                ChangesTokenRequest(recordTypes = recordTypes),
            )

            HealthConnectorLogger.info(
                tag = TAG,
                operation = "synchronize",
                message = "Initial sync completed - baseline established",
                context = context,
            )

            return HealthDataSyncResultDto(
                upsertedRecords = emptyList(),
                deletedRecordIds = emptyList(),
                hasMore = false,
                nextSyncToken = createSyncTokenDto(token, dataTypes),
            )
        } catch (e: SecurityException) {
            HealthConnectorLogger.error(
                tag = TAG,
                operation = "synchronize",
                message = "Permission not granted for Health Connect operation",
                exception = e,
                context = context,
            )
            throw HealthConnectorException.Authorization(
                code = HealthConnectorErrorCodeDto.PERMISSION_NOT_GRANTED,
                message = e.message ?: "Permission not granted for Health Connect operation",
                cause = e,
                context = context,
            )
        } catch (e: IOException) {
            HealthConnectorLogger.error(
                tag = TAG,
                operation = "synchronize",
                message = "Initial sync failed due to I/O error",
                exception = e,
                context = context,
            )
            throw HealthConnectorException.HealthService(
                code = HealthConnectorErrorCodeDto.IO_ERROR,
                message = e.message ?: "Initial sync failed due to I/O error",
                cause = e,
                context = context,
            )
        }
    }

    /**
     * Performs incremental sync using the provided token.
     *
     * @param dataTypes The list of health data types being synced
     * @param syncToken The token from the previous sync
     * @return [HealthDataSyncResultDto] with changes since last sync
     */
    @Throws(HealthConnectorException::class)
    private suspend fun performIncrementalSync(
        dataTypes: List<HealthDataTypeDto>,
        syncToken: HealthDataSyncTokenDto,
    ): HealthDataSyncResultDto {
        val tokenAgeDays =
            (System.currentTimeMillis() - syncToken.createdAtMillis) / MILLIS_PER_DAY
        val context = mapOf(
            "data_type_count" to dataTypes.size,
            "has_sync_token" to true,
            "token_age_days" to tokenAgeDays,
        )
        HealthConnectorLogger.debug(
            tag = TAG,
            operation = "synchronize",
            message = "Starting incremental synchronization",
            context = context,
        )

        try {
            val changesResponse = client.getChanges(syncToken.token)

            val upsertedRecords = changesResponse.changes
                .filterIsInstance<UpsertionChange>()
                .map { change ->
                    // Check for coroutine cancellation during processing
                    currentCoroutineContext().ensureActive()

                    change.record.toDto()
                }
            val deletedRecordIds = changesResponse.changes
                .filterIsInstance<DeletionChange>()
                .map { change ->
                    // Check for coroutine cancellation during processing
                    currentCoroutineContext().ensureActive()

                    change.recordId
                }

            HealthConnectorLogger.info(
                tag = TAG,
                operation = "synchronize",
                message = "Incremental sync completed successfully",
                context = context + mapOf(
                    "upserted_count" to upsertedRecords.size,
                    "deleted_count" to deletedRecordIds.size,
                    "has_more" to changesResponse.hasMore,
                ),
            )

            return HealthDataSyncResultDto(
                upsertedRecords = upsertedRecords,
                deletedRecordIds = deletedRecordIds,
                hasMore = changesResponse.hasMore,
                nextSyncToken = createSyncTokenDto(changesResponse.nextChangesToken, dataTypes),
            )
        } catch (e: SecurityException) {
            HealthConnectorLogger.error(
                tag = TAG,
                operation = "synchronize",
                message = "Permission not granted for Health Connect operation",
                exception = e,
                context = context,
            )
            throw HealthConnectorException.Authorization(
                code = HealthConnectorErrorCodeDto.PERMISSION_NOT_GRANTED,
                message = e.message ?: "Permission not granted for sync operation",
                cause = e,
                context = context,
            )
        } catch (e: IOException) {
            HealthConnectorLogger.error(
                tag = TAG,
                operation = "synchronize",
                message = "Incremental sync failed due to I/O error",
                exception = e,
                context = context,
            )
            throw HealthConnectorException.HealthService(
                code = HealthConnectorErrorCodeDto.IO_ERROR,
                message = e.message ?: "I/O error during incremental sync",
                cause = e,
                context = context,
            )
        } catch (e: IllegalStateException) {
            HealthConnectorLogger.error(
                tag = TAG,
                operation = "synchronize",
                message = "Incremental sync failed - Health Connect unavailable",
                exception = e,
                context = context,
            )
            throw HealthConnectorException.HealthServiceUnavailable(
                code = HealthConnectorErrorCodeDto.HEALTH_SERVICE_UNAVAILABLE,
                message = e.message ?: "Health Connect service unavailable",
                cause = e,
                context = context,
            )
        } catch (e: Exception) {
            // Check for token expiration
            // Note: androidx.health.connect.client doesn't expose error code constants,
            // so we rely on message pattern matching for token-related errors.
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.UPSIDE_DOWN_CAKE) {
                if (e is HealthConnectException &&
                    (
                        e.message?.contains("token", ignoreCase = true) == true ||
                            e.message?.contains("expired", ignoreCase = true) == true
                        )
                ) {
                    HealthConnectorLogger.error(
                        tag = TAG,
                        operation = "synchronize",
                        message = "Sync token has expired - treating as invalid argument",
                        exception = e,
                        context = context,
                    )
                    throw HealthConnectorException.InvalidArgument(
                        message = "Sync token has expired. " +
                            "Token age exceeds 30 days or was invalidated by the system. " +
                            "Perform a full backfill using readRecords() and reset sync with syncToken=null.",
                        cause = e,
                        context = context,
                    )
                }
            }

            // Fallback for unmapped exceptions
            HealthConnectorLogger.error(
                tag = TAG,
                operation = "synchronize",
                message = "Unexpected error during incremental sync",
                exception = e,
                context = context,
            )
            throw HealthConnectorException.Unknown(
                message = e.message ?: "Unexpected error during sync",
                cause = e,
                context = context,
            )
        }
    }

    /**
     * Creates a [HealthDataSyncTokenDto] from a native changes token.
     *
     * @param token The native changes token string
     * @param dataTypes The data types this token is scoped to
     * @return [HealthDataSyncTokenDto] wrapper
     */
    private fun createSyncTokenDto(
        token: String,
        dataTypes: List<HealthDataTypeDto>,
    ): HealthDataSyncTokenDto = HealthDataSyncTokenDto(
        token = token,
        dataTypes = dataTypes,
        createdAtMillis = System.currentTimeMillis(),
    )
}
