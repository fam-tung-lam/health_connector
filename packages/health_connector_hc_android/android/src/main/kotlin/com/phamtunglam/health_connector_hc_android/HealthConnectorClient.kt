package com.phamtunglam.health_connector_hc_android

import android.content.ActivityNotFoundException
import android.content.Context
import androidx.activity.ComponentActivity
import androidx.annotation.VisibleForTesting
import androidx.health.connect.client.HealthConnectClient
import androidx.health.connect.client.records.metadata.DataOrigin
import com.phamtunglam.health_connector_hc_android.HealthConnectorClient.Companion.getHealthPlatformStatus
import com.phamtunglam.health_connector_hc_android.exceptions.HealthConnectorException
import com.phamtunglam.health_connector_hc_android.handlers.CustomAggregatableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.handlers.DeletableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.handlers.HealthConnectAggregatableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.handlers.HealthRecordHandlerRegistry
import com.phamtunglam.health_connector_hc_android.handlers.ReadableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.handlers.UpdatableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.handlers.WritableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.logger.HealthConnectorLogger
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.dataType
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.id
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.mappers.permission_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.mappers.toHealthPlatformStatusDto
import com.phamtunglam.health_connector_hc_android.pigeon.AggregateRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.DeleteRecordsByIdsRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.DeleteRecordsByTimeRangeRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthConnectorErrorCodeDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataSyncResultDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataSyncTokenDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthPlatformFeatureDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthPlatformFeatureStatusDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthPlatformStatusDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.MeasurementUnitDto
import com.phamtunglam.health_connector_hc_android.pigeon.PermissionRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.PermissionRequestResultDto
import com.phamtunglam.health_connector_hc_android.pigeon.PermissionRequestsDto
import com.phamtunglam.health_connector_hc_android.pigeon.PermissionStatusDto
import com.phamtunglam.health_connector_hc_android.pigeon.ReadRecordRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.ReadRecordsRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.ReadRecordsResponseDto
import com.phamtunglam.health_connector_hc_android.services.HealthConnectorDataSyncService
import com.phamtunglam.health_connector_hc_android.services.HealthConnectorFeatureService
import com.phamtunglam.health_connector_hc_android.services.HealthConnectorManifestService
import com.phamtunglam.health_connector_hc_android.services.HealthConnectorPermissionService
import com.phamtunglam.health_connector_hc_android.utils.aggregationMetric
import com.phamtunglam.health_connector_hc_android.utils.dataType
import java.time.Instant
import kotlinx.coroutines.CancellationException
import kotlinx.coroutines.withContext
import org.jetbrains.annotations.ApiStatus

/**
 * Internal client wrapper for the Android Health Connect SDK.
 */
internal class HealthConnectorClient @VisibleForTesting internal constructor(
    private val dispatchers: DispatcherProvider,
    private val client: HealthConnectClient,
    private val manifestService: HealthConnectorManifestService,
    private val featureService: HealthConnectorFeatureService,
    private val permissionService: HealthConnectorPermissionService,
    private val syncService: HealthConnectorDataSyncService,
    private val recordHandlerRegistry: HealthRecordHandlerRegistry,
) {
    companion object {
        private const val TAG = "HealthConnectorClient"

        /**
         * Gets or creates a [HealthConnectorClient] instance.
         *
         * @param context Android application context used to access Health Connect services
         * @return A new [HealthConnectorClient] instance wrapping the Health Connect SDK client
         *
         * @throws HealthConnectorException.HealthServiceUnavailable when SDK version is too low, running in unsupported profile, or service is not available
         */
        @Throws(HealthConnectorException::class)
        fun getOrCreate(context: Context, dispatchers: DispatcherProvider): HealthConnectorClient =
            process("get_or_create") {
                try {
                    val client = HealthConnectClient.getOrCreate(context)
                    val manifestService = HealthConnectorManifestService(context)
                    val featureService = HealthConnectorFeatureService(client.features)
                    val permissionService = HealthConnectorPermissionService(
                        dispatcher = dispatchers.io,
                        permissionClient = client.permissionController,
                    )
                    val syncService = HealthConnectorDataSyncService(
                        dispatcher = dispatchers.io,
                        client = client,
                    )
                    val recordHandlerRegistry = HealthRecordHandlerRegistry(
                        dispatchers = dispatchers,
                        client = client,
                    )

                    HealthConnectorClient(
                        dispatchers = dispatchers,
                        client = client,
                        manifestService = manifestService,
                        featureService = featureService,
                        permissionService = permissionService,
                        syncService = syncService,
                        recordHandlerRegistry = recordHandlerRegistry,
                    )
                } catch (e: UnsupportedOperationException) {
                    HealthConnectorLogger.error(
                        tag = TAG,
                        operation = "get_or_create",
                        message = "Failed to create Health Connect client " +
                            "due to SDK version too low or running in a profile mode",
                        exception = e,
                    )
                    throw HealthConnectorException.HealthServiceUnavailable(
                        code =
                        HealthConnectorErrorCodeDto.HEALTH_SERVICE_NOT_INSTALLED_OR_UPDATE_REQUIRED,
                        message = e.message
                            ?: "SDK version too low or running in unsupported profile",
                        cause = e,
                    )
                } catch (e: IllegalStateException) {
                    HealthConnectorLogger.error(
                        tag = TAG,
                        operation = "get_or_create",
                        message =
                        "Failed to create Health Connect client due to service not available",
                        exception = e,
                    )
                    throw HealthConnectorException.HealthServiceUnavailable(
                        code = HealthConnectorErrorCodeDto.HEALTH_SERVICE_UNAVAILABLE,
                        message = e.message ?: "Health Connect service not available",
                        cause = e,
                    )
                }
            }

        /**
         * Gets the current status of the Health Connect platform on the device.
         *
         * @param context Android application context used to query Health Connect status
         * @return The current platform status as a [HealthPlatformStatusDto]
         */
        fun getHealthPlatformStatus(context: Context): HealthPlatformStatusDto =
            process("get_health_platform_status") {
                HealthConnectorLogger.debug(
                    tag = TAG,
                    operation = "get_health_platform_status",
                    message = "Getting Health Connect SDK status",
                )

                val statusCode = HealthConnectClient.getSdkStatus(context)
                val statusDto = statusCode.toHealthPlatformStatusDto()

                HealthConnectorLogger.info(
                    tag = TAG,
                    operation = "get_health_platform_status",
                    message = "Health Connect platform status retrieved",
                    context = mapOf(
                        "status_code" to statusCode,
                        "status_dto" to statusDto,
                    ),
                )

                statusDto
            }

        /**
         * Launches the Health Connect app page in the Google Play Store.
         *
         * Opens the Google Play Store application to the Health Connect app's detail page,
         * allowing users to install or update the app. This method should be called when
         * [getHealthPlatformStatus] indicates that Health Connect installation or update is required.
         *
         * ## Implementation Details
         *
         * The method attempts to open the Play Store using the `market://` URI scheme first.
         * If the Play Store app is not installed or the intent cannot be resolved, it falls back
         * to opening the web version using an HTTPS URL.
         *
         * **Package Name**: `com.google.android.apps.healthdata`
         *
         * @param activity The [ComponentActivity] used to launch the Play Store intent
         *
         * @throws HealthConnectorException.Unknown if the Play Store cannot be launched
         */
        @Throws(HealthConnectorException::class)
        fun launchHealthConnectPageInGooglePlay(activity: ComponentActivity) =
            process("launch_health_connect_page_in_google_play") {
                HealthConnectorLogger.debug(
                    tag = TAG,
                    operation = "launch_health_connect_page_in_google_play",
                    message = "Launching Health Connect app page in Google Play",
                )

                val healthConnectPackage = "com.google.android.apps.healthdata"
                val playStoreIntent =
                    android.content.Intent(android.content.Intent.ACTION_VIEW).apply {
                        data = android.net.Uri.parse("market://details?id=$healthConnectPackage")
                        setPackage("com.android.vending")
                        flags = android.content.Intent.FLAG_ACTIVITY_NEW_TASK
                    }

                try {
                    activity.startActivity(playStoreIntent)

                    HealthConnectorLogger.info(
                        tag = TAG,
                        operation = "launch_health_connect_page_in_google_play",
                        message = "Successfully launched Play Store app",
                        context = mapOf("package_name" to healthConnectPackage),
                    )
                } catch (_: ActivityNotFoundException) {
                    HealthConnectorLogger.info(
                        tag = TAG,
                        operation = "launch_health_connect_page_in_google_play",
                        message = "Play Store app not found, falling back to web browser",
                    )

                    val webIntent =
                        android.content.Intent(android.content.Intent.ACTION_VIEW).apply {
                            data = android.net.Uri.parse(
                                "https://play.google.com/store/apps/details?id=$healthConnectPackage",
                            )
                            flags = android.content.Intent.FLAG_ACTIVITY_NEW_TASK
                        }

                    activity.startActivity(webIntent)

                    HealthConnectorLogger.info(
                        tag = TAG,
                        operation = "launch_health_connect_page_in_google_play",
                        message = "Successfully launched Play Store web page",
                        context = mapOf("package_name" to healthConnectPackage),
                    )
                }
            }

        /**
         * Executes the given block and handles HealthConnectorException by re-throwing it.
         * This method encapsulates common error handling logic across all API methods.
         *
         * This inline function can handle both suspend and non-suspend blocks.
         *
         * @param operation The operation name for logging purposes
         * @param block The function to execute (can be suspend or non-suspend)
         * @return The result of the block execution
         * @throws HealthConnectorException if the block throws a HealthConnectorException
         */
        private inline fun <T> process(operation: String, block: () -> T): T {
            try {
                return block()
            } catch (e: HealthConnectorException) {
                throw e
            } catch (e: CancellationException) {
                throw e // Rethrow to preserve structured concurrency
            } catch (e: Exception) {
                HealthConnectorLogger.error(
                    tag = TAG,
                    operation = operation,
                    message = "Unexpected error while $operation",
                    exception = e,
                )

                throw HealthConnectorException.Unknown(
                    message = "Failed to $operation: ${e.message ?: "Unknown error"}",
                    cause = e,
                )
            }
        }
    }

    /**
     * Requests the specified permissions from the user.
     *
     * @param activity The [ComponentActivity] that will host the permission request UI
     * @param request The permissions request containing both health data and feature permissions
     * @return Result lists for health data and feature permissions
     *
     * @throws HealthConnectorException.Configuration if any requested
     *         permissions/features are not declared in AndroidManifest.xml
     * @throws HealthConnectorException.Unknown if an unexpected error occurs
     */
    @Throws(HealthConnectorException::class)
    suspend fun requestPermissions(
        activity: ComponentActivity,
        request: PermissionRequestsDto,
    ): List<PermissionRequestResultDto> = withContext(dispatchers.io) {
        val operation = "request_permissions"
        val context = mapOf(
            "permission_count" to request.permissionRequests.size,
        )

        HealthConnectorLogger.debug(
            tag = TAG,
            operation = operation,
            message = "Requesting Health Connect permissions",
            context = context,
        )

        return@withContext process(operation) {
            val permissionStrings = request.permissionRequests.map {
                it.toHealthConnect()
            }

            manifestService.checkPermissionsDeclared(permissionStrings.toSet())

            permissionService.requestPermissions(activity, request)
        }
    }

    /**
     * Gets the status of a specific permission.
     *
     * @param request The permission to check
     * @return [PermissionStatusDto.GRANTED] if granted, [PermissionStatusDto.DENIED] otherwise
     *
     * @throws HealthConnectorException if an unexpected error occurs
     */
    @Throws(HealthConnectorException::class)
    suspend fun getPermissionStatus(request: PermissionRequestDto): PermissionStatusDto =
        withContext(dispatchers.io) {
            val operation = "get_permission_status"
            val context = mapOf(
                "permission" to request.toString(),
            )

            HealthConnectorLogger.debug(
                tag = TAG,
                operation = operation,
                message = "Checking Health Connect permission status",
                context = context,
            )

            return@withContext process(operation) {
                val status = permissionService.getPermissionStatus(request)

                HealthConnectorLogger.info(
                    tag = TAG,
                    operation = operation,
                    message = "Permission status retrieved",
                    context = context + mapOf(
                        "status" to status,
                    ),
                )

                status
            }
        }

    /**
     * Gets the status of a specific feature on the current platform.
     *
     * @param context The Android application context
     * @param feature The feature to check availability for
     * @return [HealthPlatformFeatureStatusDto.AVAILABLE] if the feature is available,
     *         [HealthPlatformFeatureStatusDto.UNAVAILABLE] otherwise
     *
     * @throws HealthConnectorException.Configuration if the feature permission
     *         is not declared in AndroidManifest.xml
     * @throws HealthConnectorException.Unknown if an unexpected error occurs
     */
    @Throws(HealthConnectorException::class)
    fun getFeatureStatus(
        context: Context,
        feature: HealthPlatformFeatureDto,
    ): HealthPlatformFeatureStatusDto {
        HealthConnectorLogger.debug(
            tag = TAG,
            operation = "get_feature_status",
            message = "Checking Health Connect feature status",
            context = mapOf("feature" to feature),
        )

        try {
            val featurePermissionString = feature.toHealthConnect()
            manifestService.checkPermissionsDeclared(setOf(featurePermissionString))

            val featureStatus = featureService.getFeatureStatus(feature)

            HealthConnectorLogger.info(
                tag = TAG,
                operation = "get_feature_status",
                message = "Health Connect feature status retrieved",
                context = mapOf(
                    "feature" to feature,
                    "status" to featureStatus,
                ),
            )

            return featureStatus
        } catch (e: IllegalStateException) {
            HealthConnectorLogger.error(
                tag = TAG,
                message = e.message ?: "Invalid configuration",
                operation = "get_feature_status",
                context = mapOf("feature" to feature),
                exception = e,
            )
            throw HealthConnectorException.Configuration(
                message = e.message ?: "Invalid configuration",
                cause = e,
            )
        } catch (e: RuntimeException) {
            HealthConnectorLogger.error(
                tag = TAG,
                operation = "get_feature_status",
                message = "Failed to get Health Connect feature status",
                context = mapOf("feature" to feature),
                exception = e,
            )
            throw HealthConnectorException.Unknown(
                message = "Failed to get feature status for $feature: " + (
                    e.message
                        ?: "Unknown error"
                    ),
                cause = e,
            )
        }
    }

    /**
     * Reads a single health record by ID.
     *
     * @param request Contains the data type and record ID to read
     * @return HealthRecordDto or null if not found
     *
     * @throws HealthConnectorException.UnsupportedOperation if handler not found or doesn't support reading
     * @throws HealthConnectorException otherwise for any errors
     */
    @Throws(HealthConnectorException::class)
    suspend fun readRecord(request: ReadRecordRequestDto): HealthRecordDto =
        withContext(dispatchers.io) {
            val operation = "read_record"
            val context = mapOf(
                "data_type" to request.dataType,
            )

            HealthConnectorLogger.debug(
                tag = TAG,
                operation = operation,
                message = "Reading Health Connect record",
                context = context,
            )

            return@withContext process(operation) {
                val handler = recordHandlerRegistry.getRecordHandler(request.dataType)
                    ?: throw HealthConnectorException.UnsupportedOperation(
                        message = "No handler found for type ${request.dataType}",
                    )

                if (handler !is ReadableHealthRecordHandler) {
                    throw HealthConnectorException.UnsupportedOperation(
                        message = "Type ${request.dataType} does not support reading",
                    )
                }

                val dto = handler.readRecord(request.recordId)

                HealthConnectorLogger.info(
                    tag = TAG,
                    operation = operation,
                    message = "Health Connect record read successfully",
                    context = context,
                )

                dto
            }
        }

    /**
     * Reads a collection of records based on the criteria.
     *
     * @throws HealthConnectorException.UnsupportedOperation if handler not found or doesn't support reading
     * @throws HealthConnectorException otherwise for any errors
     */
    @Throws(HealthConnectorException::class)
    suspend fun readRecords(request: ReadRecordsRequestDto): ReadRecordsResponseDto =
        withContext(dispatchers.io) {
            val operation = "read_records"
            val context = mapOf(
                "data_type" to request.dataType,
                "page_size" to request.pageSize,
                "has_page_token" to (request.pageToken != null),
            )

            HealthConnectorLogger.debug(
                tag = TAG,
                operation = operation,
                message = "Reading Health Connect records",
                context = context,
            )

            return@withContext process(operation) {
                val handler = recordHandlerRegistry.getRecordHandler(request.dataType)
                    ?: throw HealthConnectorException.UnsupportedOperation(
                        message = "No handler found for type ${request.dataType}",
                    )

                if (handler !is ReadableHealthRecordHandler) {
                    throw HealthConnectorException.UnsupportedOperation(
                        message = "Type ${request.dataType} does not support reading",
                    )
                }

                val (records, nextPageToken) = handler.readRecords(
                    startTime = Instant.ofEpochMilli(request.startTime),
                    endTime = Instant.ofEpochMilli(request.endTime),
                    pageSize = request.pageSize.toInt(),
                    pageToken = request.pageToken,
                    dataOrigins = request.dataOriginPackageNames.map { DataOrigin(it) }.toSet(),
                    sortOrder = request.sortOrder,
                )

                HealthConnectorLogger.info(
                    tag = TAG,
                    operation = operation,
                    message = "Health Connect records read successfully",
                    context = context + mapOf(
                        "record_count" to records.size,
                    ),
                )

                ReadRecordsResponseDto(
                    records = records,
                    nextPageToken = nextPageToken,
                )
            }
        }

    /**
     * Writes a single health record.
     *
     * @param record The record to write
     * @return The platform-assigned record ID
     *
     * @throws HealthConnectorException.UnsupportedOperation if handler not found or doesn't support writing
     * @throws HealthConnectorException otherwise for any errors
     */
    @Throws(HealthConnectorException::class)
    suspend fun writeRecord(record: HealthRecordDto): String = withContext(dispatchers.io) {
        val operation = "write_record"
        val context = mapOf(
            "data_type" to record.dataType,
        )

        HealthConnectorLogger.debug(
            tag = TAG,
            operation = operation,
            message = "Writing Health Connect record",
            context = context,
        )

        return@withContext process(operation) {
            val handler = recordHandlerRegistry.getRecordHandler(record.dataType)
                ?: throw HealthConnectorException.UnsupportedOperation(
                    message = "No handler found for type ${record.dataType}",
                )

            if (handler !is WritableHealthRecordHandler) {
                throw HealthConnectorException.UnsupportedOperation(
                    message = "Type ${record.dataType} does not support writing",
                )
            }

            val recordId = handler.writeRecord(record)

            HealthConnectorLogger.info(
                tag = TAG,
                operation = operation,
                message = "Health Connect record written successfully",
                context = context,
            )

            recordId
        }
    }

    /**
     * Writes multiple health records atomically.
     *
     * All records are saved in a single Health Connect transaction. Either all records
     * are saved successfully, or none are saved. This ensures data consistency across
     * different record types.
     *
     * @param records The list of records to write
     * @return The record IDs in input order
     *
     * @throws HealthConnectorException.UnsupportedOperation if any type is not writable
     * @throws HealthConnectorException otherwise for any errors
     */
    @Throws(HealthConnectorException::class)
    suspend fun writeRecords(records: List<HealthRecordDto>): List<String> =
        withContext(dispatchers.io) {
            val operation = "write_records"
            val context = mapOf(
                "record_count" to records.size,
            )

            return@withContext process("write_records") {
                HealthConnectorLogger.debug(
                    tag = TAG,
                    operation = operation,
                    message = "Writing Health Connect records atomically",
                    context = context,
                )

                if (records.isEmpty()) {
                    HealthConnectorLogger.debug(
                        tag = TAG,
                        operation = operation,
                        message = "No records to write, returning empty response",
                        context = context,
                    )
                    return@process emptyList()
                }

                // Validate all records support the write operation
                val dataTypes = records.map { record -> record.dataType }
                dataTypes.forEach { dataType ->
                    val handler = recordHandlerRegistry.getRecordHandler(dataType)
                        ?: throw HealthConnectorException.UnsupportedOperation(
                            message = "Unsupported data type: $dataType",
                        )

                    if (handler !is WritableHealthRecordHandler) {
                        throw HealthConnectorException.UnsupportedOperation(
                            message = "Data type does not support the write operation: $dataType",
                        )
                    }
                }

                HealthConnectorLogger.debug(
                    tag = TAG,
                    operation = operation,
                    message = "All records validated and converted",
                    context = context,
                )

                val response = client.insertRecords(
                    records.map { record -> record.toHealthConnect() },
                )

                HealthConnectorLogger.debug(
                    tag = TAG,
                    operation = operation,
                    message = "Atomic insert completed successfully",
                    context = context,
                )

                val recordIds = response.recordIdsList

                HealthConnectorLogger.info(
                    tag = TAG,
                    operation = operation,
                    message = "Health Connect records written successfully",
                    context = context,
                )

                recordIds
            }
        }

    /**
     * Updates a single health record.
     *
     * @param record The record to update
     *
     * @throws HealthConnectorException.UnsupportedOperation if handler not found or doesn't support updates
     * @throws HealthConnectorException otherwise for any errors
     */
    @Throws(HealthConnectorException::class)
    suspend fun updateRecord(record: HealthRecordDto) = withContext(dispatchers.io) {
        val operation = "update_record"
        val context = mapOf(
            "data_type" to record.dataType,
        )

        HealthConnectorLogger.debug(
            tag = TAG,
            operation = operation,
            message = "Updating Health Connect record",
            context = context,
        )

        process(operation) {
            val handler = recordHandlerRegistry.getRecordHandler(record.dataType)
                ?: throw HealthConnectorException.UnsupportedOperation(
                    message = "No handler found for type ${record.dataType}",
                )

            if (handler !is UpdatableHealthRecordHandler) {
                throw HealthConnectorException.UnsupportedOperation(
                    message = "Type ${record.dataType} does not support updates",
                )
            }

            handler.updateRecord(record)

            HealthConnectorLogger.info(
                tag = TAG,
                operation = operation,
                message = "Health Connect record updated successfully",
                context = context,
            )
        }
    }

    /**
     * Updates multiple health records atomically.
     *
     * All records are updated in a single Health Connect transaction. Either all records
     * are updated successfully, or none are updated.
     *
     * @param records The list of health records to update (all must have valid IDs)
     *
     * @throws HealthConnectorException.UnsupportedOperation if any type is not updatable
     * @throws HealthConnectorException otherwise for any errors
     */
    @Throws(HealthConnectorException::class)
    suspend fun updateRecords(records: List<HealthRecordDto>) = withContext(dispatchers.io) {
        val operation = "update_records"
        val context = mapOf(
            "record_count" to records.size,
        )

        HealthConnectorLogger.debug(
            tag = TAG,
            operation = operation,
            message = "Updating Health Connect records atomically",
            context = context,
        )

        process(operation) {
            if (records.isEmpty()) {
                HealthConnectorLogger.debug(
                    tag = TAG,
                    operation = operation,
                    message = "No records to update, returning",
                    context = context,
                )
                return@process
            }

            val invalidRecords = records.filter { record -> record.id.isNullOrEmpty() }
            require(invalidRecords.isEmpty()) {
                "All records must have IDs for update operations. " +
                    "Found ${invalidRecords.size} record(s) without IDs."
            }

            // Validate all record data types support the update operation.
            val dataTypes = records.map { record -> record.dataType }
            dataTypes.forEach { dataType ->
                val handler = recordHandlerRegistry.getRecordHandler(dataType)
                    ?: throw HealthConnectorException.UnsupportedOperation(
                        message = "No handler found for type $dataType",
                    )

                if (handler !is UpdatableHealthRecordHandler) {
                    throw HealthConnectorException.UnsupportedOperation(
                        message = "Type $dataType does not support updates",
                    )
                }
            }

            client.updateRecords(
                records.map { record -> record.toHealthConnect() },
            )

            HealthConnectorLogger.info(
                tag = TAG,
                operation = operation,
                message = "Health Connect records updated successfully",
                context = context,
            )
        }
    }

    /**
     * Deletes specific records by their IDs.
     *
     * @param request Contains data type and list of record IDs to delete
     * @throws HealthConnectorException.UnsupportedOperation if handler not found or doesn't support deletion
     * @throws HealthConnectorException otherwise for any errors
     */
    @Throws(HealthConnectorException::class)
    suspend fun deleteRecordsByIds(request: DeleteRecordsByIdsRequestDto) =
        withContext(dispatchers.io) {
            val operation = "delete_records_by_ids"
            val context = mapOf(
                "data_type" to request.dataType,
                "record_count" to request.recordIds.size,
            )

            HealthConnectorLogger.debug(
                tag = TAG,
                operation = operation,
                message = "Deleting Health Connect records by IDs",
                context = context,
            )

            if (request.recordIds.isEmpty()) {
                HealthConnectorLogger.warning(
                    tag = TAG,
                    operation = operation,
                    message = "No records to delete (empty IDs list)",
                    context = context,
                )
                return@withContext
            }

            process(operation) {
                val handler = recordHandlerRegistry.getRecordHandler(request.dataType)
                    ?: throw HealthConnectorException.UnsupportedOperation(
                        message = "No handler found for type ${request.dataType}",
                    )

                if (handler !is DeletableHealthRecordHandler) {
                    throw HealthConnectorException.UnsupportedOperation(
                        message = "Type ${request.dataType} does not support deletion",
                    )
                }

                handler.deleteRecords(request.recordIds)

                HealthConnectorLogger.info(
                    tag = TAG,
                    operation = operation,
                    message = "Health Connect records deleted successfully",
                    context = context,
                )
            }
        }

    /**
     * Deletes all records of a data type within a time range.
     *
     * @param request Contains data type and time range for deletion
     * @throws HealthConnectorException.UnsupportedOperation if handler not found or doesn't support deletion
     * @throws HealthConnectorException otherwise for any errors
     */
    @Throws(HealthConnectorException::class)
    suspend fun deleteRecordsByTimeRange(request: DeleteRecordsByTimeRangeRequestDto) =
        withContext(dispatchers.io) {
            val operation = "delete_records_by_time_range"
            val context = mapOf(
                "data_type" to request.dataType,
            )

            HealthConnectorLogger.debug(
                tag = TAG,
                operation = operation,
                message = "Deleting Health Connect records by time range",
                context = context,
            )

            process(operation) {
                val handler = recordHandlerRegistry.getRecordHandler(request.dataType)
                    ?: throw HealthConnectorException.UnsupportedOperation(
                        message = "No handler found for type ${request.dataType}",
                    )

                if (handler !is DeletableHealthRecordHandler) {
                    throw HealthConnectorException.UnsupportedOperation(
                        message = "Type ${request.dataType} does not support deletion",
                    )
                }

                handler.deleteRecordsByTimeRange(
                    startTime = Instant.ofEpochMilli(request.startTime),
                    endTime = Instant.ofEpochMilli(request.endTime),
                )

                HealthConnectorLogger.info(
                    tag = TAG,
                    operation = operation,
                    message = "Health Connect records deleted successfully",
                    context = context,
                )
            }
        }

    /**
     * Performs an aggregation query on health records.
     *
     * @param request Contains data type, aggregation metric, and time range
     * @return MeasurementUnitDto with the aggregated value
     *
     * @throws HealthConnectorException.UnsupportedOperation if handler not found or doesn't support aggregation
     * @throws HealthConnectorException otherwise for any errors
     */
    @Throws(HealthConnectorException::class)
    suspend fun aggregate(request: AggregateRequestDto): MeasurementUnitDto =
        withContext(dispatchers.io) {
            val operation = "aggregate"
            val context = mapOf(
                "data_type" to request.dataType,
                "metric" to request.aggregationMetric,
            )

            HealthConnectorLogger.debug(
                tag = TAG,
                operation = operation,
                message = "Aggregating Health Connect data",
                context = context,
            )

            return@withContext process(operation) {
                val handler = recordHandlerRegistry.getRecordHandler(request.dataType)
                    ?: throw HealthConnectorException.UnsupportedOperation(
                        message = "Data type ${request.dataType} does not support aggregation",
                    )

                val responseDto = when (handler) {
                    is HealthConnectAggregatableHealthRecordHandler -> handler.aggregate(request)

                    is CustomAggregatableHealthRecordHandler -> handler.aggregate(request)

                    else -> throw HealthConnectorException.UnsupportedOperation(
                        message = "Type ${request.dataType} does not support aggregation",
                    )
                }

                HealthConnectorLogger.info(
                    tag = TAG,
                    operation = operation,
                    message = "Health Connect data aggregated successfully",
                    context = context + mapOf(
                        "result_type" to responseDto::class.simpleName,
                    ),
                )

                responseDto
            }
        }

    /**
     * Synchronizes health data using incremental change tracking.
     *
     * @param dataTypes The list of health data types to synchronize
     * @param syncToken The token from the previous sync, or null for initial sync
     * @return [HealthDataSyncResultDto] containing changes since last sync
     *
     * @throws HealthConnectorException.SyncTokenExpired if the token has expired
     * @throws HealthConnectorException.InvalidArgument if parameters are invalid
     * @throws HealthConnectorException.RemoteError for IPC or I/O issues
     * @throws HealthConnectorException.HealthPlatformUnavailable if service is unavailable
     */
    @Throws(HealthConnectorException::class)
    @ApiStatus.Experimental
    suspend fun synchronize(
        dataTypes: List<HealthDataTypeDto>,
        syncToken: HealthDataSyncTokenDto?,
    ): HealthDataSyncResultDto = withContext(dispatchers.io) {
        val operation = "synchronize"
        val context = mapOf(
            "data_type_count" to dataTypes.size,
            "has_sync_token" to (syncToken != null),
        )

        HealthConnectorLogger.debug(
            tag = TAG,
            operation = operation,
            message = "Synchronizing Health Connect data",
            context = context,
        )

        return@withContext process(operation) {
            val result = syncService.synchronize(
                dataTypes = dataTypes,
                syncToken = syncToken,
            )

            HealthConnectorLogger.info(
                tag = TAG,
                operation = operation,
                message = "Health Connect data synchronized successfully",
                context = context + mapOf(
                    "upserted_count" to result.upsertedRecords.size,
                    "deleted_count" to result.deletedRecordIds.size,
                    "has_more" to result.hasMore,
                ),
            )

            result
        }
    }

    /**
     * Gets all permissions that have been granted to the app.
     *
     * @return Lists for health data and feature permissions that have been granted
     *
     * @throws HealthConnectorException if an unexpected error occurs
     */
    @Throws(HealthConnectorException::class)
    suspend fun getGrantedPermissions(): List<PermissionRequestResultDto> =
        withContext(dispatchers.io) {
            val operation = "get_granted_permissions"

            HealthConnectorLogger.debug(
                tag = TAG,
                operation = operation,
                message = "Getting granted Health Connect permissions",
            )

            return@withContext process(operation) {
                val result = permissionService.getGrantedPermissions()

                HealthConnectorLogger.info(
                    tag = TAG,
                    operation = operation,
                    message = "Granted permissions retrieved successfully",
                    context = mapOf(
                        "permission_count" to result.size,
                    ),
                )

                result
            }
        }

    /**
     * Revokes all permissions that have been granted to the app.
     *
     * @throws HealthConnectorException if an unexpected error occurs
     */
    @Throws(HealthConnectorException::class)
    suspend fun revokeAllPermissions() = withContext(dispatchers.io) {
        val operation = "revoke_all_permissions"

        HealthConnectorLogger.debug(
            tag = TAG,
            operation = operation,
            message = "Revoking all Health Connect permissions",
        )

        process(operation) {
            permissionService.revokeAllPermissions()

            HealthConnectorLogger.info(
                tag = TAG,
                operation = operation,
                message = "All Health Connect permissions revoked successfully",
            )
        }
    }
}
