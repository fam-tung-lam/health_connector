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
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataSyncResultDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataSyncTokenDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataTypeDto
import com.phamtunglam.health_connector_hc_android.utils.TAG
import java.io.IOException

/**
 * Internal service responsible for managing Health Connect data synchronization.
 *
 * This service handles incremental data sync using Health Connect's ChangesToken API,
 * which tracks additions, modifications, and deletions since the last sync.
 *
 * @property client The native [HealthConnectClient] used to interact with Health Connect.
 */
internal class HealthConnectorDataSyncService(private val client: HealthConnectClient) {
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
     * @throws HealthConnectorException.SyncTokenExpired if the token has expired (~30 days)
     * @throws HealthConnectorException.InvalidArgument if parameters are invalid
     * @throws HealthConnectorException.RemoteError for IPC or I/O issues
     * @throws HealthConnectorException.HealthPlatformUnavailable if service is unavailable
     */
    @Throws(HealthConnectorException::class)
    suspend fun synchronize(
        dataTypes: List<HealthDataTypeDto>,
        syncToken: HealthDataSyncTokenDto?,
    ): HealthDataSyncResultDto = if (syncToken == null) {
        performInitialSync(dataTypes)
    } else {
        performIncrementalSync(dataTypes, syncToken)
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
        HealthConnectorLogger.debug(
            tag = TAG,
            operation = "synchronize",
            message = "Starting initial synchronization",
            context = mapOf(
                "data_type_count" to dataTypes.size,
                "has_sync_token" to false,
            ),
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
                context = mapOf(
                    "data_type_count" to dataTypes.size,
                    "has_token" to true,
                ),
            )

            return HealthDataSyncResultDto(
                upsertedRecords = emptyList(),
                deletedRecordIds = emptyList(),
                hasMore = false,
                nextSyncToken = createSyncTokenDto(token, dataTypes),
            )
        } catch (e: IOException) {
            HealthConnectorLogger.error(
                tag = TAG,
                operation = "synchronize",
                message = "Initial sync failed due to I/O error",
                exception = e,
            )
            throw HealthConnectorException.RemoteError(
                message = e.message ?: "I/O error during initial sync",
                cause = e,
            )
        } catch (e: IllegalStateException) {
            HealthConnectorLogger.error(
                tag = TAG,
                operation = "synchronize",
                message = "Initial sync failed - Health Connect unavailable",
                exception = e,
            )
            throw HealthConnectorException.HealthPlatformUnavailable(
                message = e.message ?: "Health Connect service unavailable",
                cause = e,
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
        HealthConnectorLogger.debug(
            tag = TAG,
            operation = "synchronize",
            message = "Starting incremental synchronization",
            context = mapOf(
                "data_type_count" to dataTypes.size,
                "has_sync_token" to true,
            ),
        )

        try {
            val changesResponse = client.getChanges(syncToken.token)

            // Process changes into upserted records and deleted IDs
            val upsertedRecords =
                mutableListOf<com.phamtunglam.health_connector_hc_android.pigeon.HealthRecordDto>()
            val deletedRecordIds = mutableListOf<String>()
            for (change in changesResponse.changes) {
                when (change) {
                    is UpsertionChange -> {
                        val recordDto = change.record.toDto()
                        upsertedRecords.add(recordDto)
                    }

                    is DeletionChange -> {
                        deletedRecordIds.add(change.recordId)
                    }
                }
            }

            HealthConnectorLogger.info(
                tag = TAG,
                operation = "synchronize",
                message = "Incremental sync completed successfully",
                context = mapOf(
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
        } catch (e: IOException) {
            HealthConnectorLogger.error(
                tag = TAG,
                operation = "synchronize",
                message = "Incremental sync failed due to I/O error",
                exception = e,
            )
            throw HealthConnectorException.RemoteError(
                message = e.message ?: "I/O error during incremental sync",
                cause = e,
            )
        } catch (e: IllegalStateException) {
            HealthConnectorLogger.error(
                tag = TAG,
                operation = "synchronize",
                message = "Incremental sync failed - Health Connect unavailable",
                exception = e,
            )
            throw HealthConnectorException.HealthPlatformUnavailable(
                message = e.message ?: "Health Connect service unavailable",
                cause = e,
            )
        } catch (e: Exception) {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.UPSIDE_DOWN_CAKE) {
                if (e is HealthConnectException && e.message?.contains("token") ?: false) {
                    HealthConnectorLogger.error(
                        tag = TAG,
                        operation = "synchronize",
                        message = "Sync token has expired",
                        exception = e,
                    )
                    throw HealthConnectorException.SyncTokenExpired(
                        message = "Sync token has expired. " +
                            "Token age exceeds 30 days or was invalidated by the system. " +
                            "Perform a full backfill using readRecords() and reset sync with syncToken=null.",
                        cause = e,
                    )
                }
            }

            throw e
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
