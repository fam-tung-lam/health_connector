package com.phamtunglam.health_connector_hc_android

import android.content.ActivityNotFoundException
import android.content.Context
import androidx.activity.ComponentActivity
import androidx.annotation.VisibleForTesting
import androidx.health.connect.client.HealthConnectClient
import androidx.health.connect.client.records.metadata.DataOrigin
import com.phamtunglam.health_connector_hc_android.HealthConnectorClient.Companion.getHealthPlatformStatus
import com.phamtunglam.health_connector_hc_android.handlers.CustomAggregatableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.handlers.DeletableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.handlers.HealthConnectAggregatableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.handlers.HealthRecordHandlerRegistry
import com.phamtunglam.health_connector_hc_android.handlers.ReadableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.handlers.UpdatableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.handlers.WritableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.logger.HealthConnectorLogger
import com.phamtunglam.health_connector_hc_android.logger.TAG
import com.phamtunglam.health_connector_hc_android.mappers.dataType
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.dataType
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.id
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.mappers.permission_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.mappers.toError
import com.phamtunglam.health_connector_hc_android.mappers.toHealthPlatformStatusDto
import com.phamtunglam.health_connector_hc_android.pigeon.AggregateRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.DeleteRecordsByIdsRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.DeleteRecordsByTimeRangeRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthConnectorErrorCodeDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthConnectorErrorDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthPlatformFeatureDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthPlatformFeatureStatusDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthPlatformStatusDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.MeasurementUnitDto
import com.phamtunglam.health_connector_hc_android.pigeon.PermissionRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.PermissionRequestsDto
import com.phamtunglam.health_connector_hc_android.pigeon.PermissionRequestsResponseDto
import com.phamtunglam.health_connector_hc_android.pigeon.PermissionStatusDto
import com.phamtunglam.health_connector_hc_android.pigeon.ReadRecordRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.ReadRecordsRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.ReadRecordsResponseDto
import com.phamtunglam.health_connector_hc_android.services.HealthConnectorFeatureService
import com.phamtunglam.health_connector_hc_android.services.HealthConnectorManifestService
import com.phamtunglam.health_connector_hc_android.services.HealthConnectorPermissionService
import java.time.Instant

/**
 * Internal client wrapper for the Android Health Connect SDK.
 */
internal class HealthConnectorClient @VisibleForTesting internal constructor(
    private val client: HealthConnectClient,
    private val manifestService: HealthConnectorManifestService,
    private val featureService: HealthConnectorFeatureService,
    private val permissionService: HealthConnectorPermissionService,
    private val recordHandlerRegistry: HealthRecordHandlerRegistry,
) {
    companion object {
        /**
         * Gets or creates a [HealthConnectorClient] instance.
         *
         * @param context Android application context used to access Health Connect services
         * @return A new [HealthConnectorClient] instance wrapping the Health Connect SDK client
         *
         * @throws HealthConnectorErrorDto with code `HEALTH_PLATFORM_NOT_AVAILABLE` when:
         *         - The device SDK version is too low (below API 26)
         *         - The app is running in a profile/work profile that doesn't support Health Connect
         *         - Health Connect SDK initialization fails
         */
        @Throws(HealthConnectorErrorDto::class)
        fun getOrCreate(context: Context): HealthConnectorClient {
            try {
                val client = HealthConnectClient.getOrCreate(context)
                val manifestService = HealthConnectorManifestService(context)
                val featureService = HealthConnectorFeatureService(client.features)
                val permissionService = HealthConnectorPermissionService(
                    client.permissionController,
                )
                val recordHandlerRegistry = HealthRecordHandlerRegistry(client)

                return HealthConnectorClient(
                    client = client,
                    manifestService = manifestService,
                    featureService = featureService,
                    permissionService = permissionService,
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
                throw HealthConnectorErrorCodeDto
                    .HEALTH_PLATFORM_NOT_INSTALLED_OR_UPDATE_REQUIRED.toError(
                        e.message,
                    )
            } catch (e: IllegalStateException) {
                HealthConnectorLogger.error(
                    tag = TAG,
                    operation = "get_or_create",
                    message = "Failed to create Health Connect client due to service not available",
                    exception = e,
                )
                throw HealthConnectorErrorCodeDto.HEALTH_PLATFORM_UNAVAILABLE.toError(
                    e.message,
                )
            }
        }

        /**
         * Gets the current status of the Health Connect platform on the device.
         *
         * @param context Android application context used to query Health Connect status
         * @return The current platform status as a [HealthPlatformStatusDto]
         */
        fun getHealthPlatformStatus(context: Context): HealthPlatformStatusDto {
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

            return statusDto
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
         * @throws HealthConnectorErrorDto with code `UNKNOWN` if the Play Store cannot be launched
         */
        @Throws(HealthConnectorErrorDto::class)
        fun launchHealthConnectPageInGooglePlay(activity: ComponentActivity) {
            HealthConnectorLogger.debug(
                tag = TAG,
                operation = "launch_health_connect_page_in_google_play",
                message = "Launching Health Connect app page in Google Play",
            )

            try {
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
            } catch (e: Exception) {
                HealthConnectorLogger.error(
                    tag = TAG,
                    operation = "launch_health_connect_page_in_google_play",
                    message = "Unexpected error while launching Play Store",
                    exception = e,
                )

                throw HealthConnectorErrorCodeDto.UNKNOWN.toError(
                    "Failed to launch Play Store: ${e.message ?: "Unknown error"}",
                )
            }
        }
    }

    /**
     * Requests the specified permissions from the user.
     *
     * @param activity The [ComponentActivity] that will host the permission request UI
     * @param request The permissions request containing both health data and feature permissions
     * @return [PermissionRequestsResponseDto] containing separate result lists for health data
     *         and feature permissions
     *
     * @throws HealthConnectorErrorDto with code `INVALID_PLATFORM_CONFIGURATION` if any requested
     *         permissions/features are not declared in AndroidManifest.xml (caught from
     *         [IllegalStateException] thrown by validation)
     * @throws HealthConnectorErrorDto with code `UNKNOWN` if an unexpected error occurs
     */
    @Throws(HealthConnectorErrorDto::class)
    suspend fun requestPermissions(
        activity: ComponentActivity,
        request: PermissionRequestsDto,
    ): PermissionRequestsResponseDto {
        HealthConnectorLogger.debug(
            tag = TAG,
            operation = "request_permissions",
            message = "Requesting Health Connect permissions",
            context = mapOf(
                "requested_permissions" to request.permissionRequests,
            ),
        )

        try {
            val permissionStrings = request.permissionRequests.map {
                it.toHealthConnect()
            }

            manifestService.checkPermissionsDeclared(permissionStrings.toSet())

            val permissionRequestResults = permissionService.requestPermissions(activity, request)

            return PermissionRequestsResponseDto(permissionRequestResults)
        } catch (e: HealthConnectorErrorDto) {
            throw e
        }
    }

    /**
     * Gets the status of a specific permission.
     *
     * @param request The permission to check
     * @return [PermissionStatusDto.GRANTED] if granted, [PermissionStatusDto.DENIED] otherwise
     *
     * @throws HealthConnectorErrorDto with code `UNKNOWN` if an unexpected error occurs
     */
    @Throws(HealthConnectorErrorDto::class)
    suspend fun getPermissionStatus(request: PermissionRequestDto): PermissionStatusDto {
        HealthConnectorLogger.debug(
            tag = TAG,
            operation = "get_permission_status",
            message = "Checking Health Connect permission status",
            context = mapOf("permission" to request.toString()),
        )

        try {
            val status = permissionService.getPermissionStatus(request)

            HealthConnectorLogger.info(
                tag = TAG,
                operation = "get_permission_status",
                message = "Permission status retrieved",
                context = mapOf(
                    "permission" to request.toString(),
                    "status" to status,
                ),
            )

            return status
        } catch (e: HealthConnectorErrorDto) {
            throw e
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
     * @throws HealthConnectorErrorDto with code `INVALID_PLATFORM_CONFIGURATION` if the feature permission
     *         is not declared in AndroidManifest.xml
     * @throws HealthConnectorErrorDto with code `UNKNOWN` if an unexpected error occurs
     */
    @Throws(HealthConnectorErrorDto::class)
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
                operation = "get_feature_status",
                message = e.message,
                context = mapOf("feature" to feature),
                exception = e,
            )
            throw HealthConnectorErrorCodeDto.INVALID_CONFIGURATION.toError(
                e.message,
            )
        } catch (e: RuntimeException) {
            HealthConnectorLogger.error(
                tag = TAG,
                operation = "get_feature_status",
                message = "Failed to get Health Connect feature status",
                context = mapOf("feature" to feature),
                exception = e,
            )
            throw HealthConnectorErrorCodeDto.UNKNOWN.toError(
                "Failed to get feature status for $feature: " + (e.message ?: "Unknown error"),
            )
        }
    }

    /**
     * Reads a single health record by ID.
     *
     * @param request Contains the data type and record ID to read
     * @return HealthRecordDto or null if not found
     *
     * @throws HealthConnectorErrorDto with code `UNSUPPORTED_OPERATION` if handler not found or doesn't support reading
     * @throws HealthConnectorErrorDto with code `NOT_AUTHORIZED` if permission access is denied
     * @throws HealthConnectorErrorDto with code `UNKNOWN` if an unexpected error occurs
     */
    @Throws(HealthConnectorErrorDto::class)
    suspend fun readRecord(request: ReadRecordRequestDto): HealthRecordDto {
        HealthConnectorLogger.debug(
            tag = TAG,
            operation = "read_record",
            message = "Reading Health Connect record",
            context = mapOf("request" to request),
        )

        try {
            val handler = recordHandlerRegistry.getRecordHandler(request.dataType)
                ?: throw HealthConnectorErrorCodeDto.UNSUPPORTED_OPERATION.toError(
                    "No handler found for type ${request.dataType}",
                )

            if (handler !is ReadableHealthRecordHandler) {
                throw HealthConnectorErrorCodeDto.UNSUPPORTED_OPERATION.toError(
                    "Type ${request.dataType} does not support reading",
                )
            }

            val dto = handler.readRecord(request.recordId)

            HealthConnectorLogger.info(
                tag = TAG,
                operation = "read_record",
                message = "Health Connect record read successfully",
                context = mapOf("data_type" to request.dataType, "record_id" to request.recordId),
            )

            return dto
        } catch (e: HealthConnectorErrorDto) {
            throw e
        }
    }

    /**
     * Reads a collection of records based on the criteria.
     *
     * @throws HealthConnectorErrorDto with code `UNSUPPORTED_OPERATION` if handler not found or doesn't support reading
     * @throws HealthConnectorErrorDto with code `NOT_AUTHORIZED` if permission access is denied
     * @throws HealthConnectorErrorDto with code `UNKNOWN` if an unexpected error occurs
     */
    @Throws(HealthConnectorErrorDto::class)
    suspend fun readRecords(request: ReadRecordsRequestDto): ReadRecordsResponseDto {
        HealthConnectorLogger.debug(
            tag = TAG,
            operation = "read_records",
            message = "Reading Health Connect records",
            context = mapOf("request" to request),
        )

        try {
            val handler = recordHandlerRegistry.getRecordHandler(request.dataType)
                ?: throw HealthConnectorErrorCodeDto.UNSUPPORTED_OPERATION.toError(
                    "No handler found for type ${request.dataType}",
                )

            if (handler !is ReadableHealthRecordHandler) {
                throw HealthConnectorErrorCodeDto.UNSUPPORTED_OPERATION.toError(
                    "Type ${request.dataType} does not support reading",
                )
            }

            val (records, nextPageToken) = handler.readRecords(
                startTime = Instant.ofEpochMilli(request.startTime),
                endTime = Instant.ofEpochMilli(request.endTime),
                pageSize = request.pageSize.toInt(),
                pageToken = request.pageToken,
                dataOrigins = request.dataOriginPackageNames.map { DataOrigin(it) }.toSet(),
            )

            HealthConnectorLogger.info(
                tag = TAG,
                operation = "read_records",
                message = "Health Connect records read successfully",
                context = mapOf("data_type" to request.dataType, "count" to records.size),
            )

            return ReadRecordsResponseDto(
                records = records,
                nextPageToken = nextPageToken,
            )
        } catch (e: HealthConnectorErrorDto) {
            throw e
        }
    }

    /**
     * Writes a single health record.
     *
     * @param record The record to write
     * @return The platform-assigned record ID
     *
     * @throws HealthConnectorErrorDto with code `UNSUPPORTED_OPERATION` if handler not found or doesn't support writing
     * @throws HealthConnectorErrorDto with code `NOT_AUTHORIZED` if permission access is denied
     * @throws HealthConnectorErrorDto with code `UNKNOWN` if an unexpected error occurs
     */
    @Throws(HealthConnectorErrorDto::class)
    suspend fun writeRecord(record: HealthRecordDto): String {
        HealthConnectorLogger.debug(
            tag = TAG,
            operation = "write_record",
            message = "Writing Health Connect record",
            context = mapOf("record" to record),
        )

        try {
            val handler = recordHandlerRegistry.getRecordHandler(record.dataType)
                ?: throw HealthConnectorErrorCodeDto.UNSUPPORTED_OPERATION.toError(
                    "No handler found for type ${record.dataType}",
                )

            if (handler !is WritableHealthRecordHandler) {
                throw HealthConnectorErrorCodeDto.UNSUPPORTED_OPERATION.toError(
                    "Type ${record.dataType} does not support writing",
                )
            }

            val recordId = handler.writeRecord(record)

            HealthConnectorLogger.info(
                tag = TAG,
                operation = "write_record",
                message = "Health Connect record written successfully",
                context = mapOf("data_type" to record.dataType, "record_id" to recordId),
            )

            return recordId
        } catch (e: HealthConnectorErrorDto) {
            throw e
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
     * @throws HealthConnectorErrorDto with code `UNSUPPORTED_OPERATION` if any type is not writable
     * @throws HealthConnectorErrorDto with code `NOT_AUTHORIZED` if permission access is denied
     * @throws HealthConnectorErrorDto with code `UNKNOWN` if an unexpected error occurs
     */
    @Throws(HealthConnectorErrorDto::class)
    suspend fun writeRecords(records: List<HealthRecordDto>): List<String> {
        HealthConnectorLogger.debug(
            tag = TAG,
            operation = "write_records",
            message = "Writing Health Connect records atomically",
            context = mapOf(
                "total_records" to records.size,
                "records" to records,
            ),
        )

        try {
            if (records.isEmpty()) {
                HealthConnectorLogger.debug(
                    tag = TAG,
                    operation = "write_records",
                    message = "No records to write, returning empty response",
                )
                return emptyList()
            }

            // Validate all records support the write operation
            val dataTypes = records.map { record -> record.dataType }
            dataTypes.forEach { dataType ->
                val handler = recordHandlerRegistry.getRecordHandler(dataType)
                    ?: throw HealthConnectorErrorCodeDto.UNSUPPORTED_OPERATION.toError(
                        "Unsupported data type: $dataType",
                    )

                if (handler !is WritableHealthRecordHandler) {
                    throw HealthConnectorErrorCodeDto.UNSUPPORTED_OPERATION.toError(
                        "Data type does not support the write operation: $dataType",
                    )
                }
            }

            HealthConnectorLogger.debug(
                tag = TAG,
                operation = "write_records",
                message = "All records validated and converted",
                context = mapOf("record_count" to records.size),
            )

            val response = client.insertRecords(
                records.map { record -> record.toHealthConnect() },
            )

            HealthConnectorLogger.debug(
                tag = TAG,
                operation = "write_records",
                message = "Atomic insert completed successfully",
            )

            val recordIds = response.recordIdsList

            HealthConnectorLogger.info(
                tag = TAG,
                operation = "write_records",
                message = "Health Connect records written successfully",
                context = mapOf("count" to recordIds.size),
            )

            return recordIds
        } catch (e: HealthConnectorErrorDto) {
            throw e
        }
    }

    /**
     * Updates a single health record.
     *
     * @param record The record to update
     *
     * @throws HealthConnectorErrorDto with code `UNSUPPORTED_OPERATION` if handler not found or doesn't support updates
     * @throws HealthConnectorErrorDto with code `INVALID_ARGUMENT` if record ID is invalid
     * @throws HealthConnectorErrorDto with code `NOT_AUTHORIZED` if permission access is denied
     * @throws HealthConnectorErrorDto with code `UNKNOWN` if an unexpected error occurs
     */
    @Throws(HealthConnectorErrorDto::class)
    suspend fun updateRecord(record: HealthRecordDto) {
        HealthConnectorLogger.debug(
            tag = TAG,
            operation = "update_record",
            message = "Updating Health Connect record",
            context = mapOf("record" to record),
        )

        try {
            val handler = recordHandlerRegistry.getRecordHandler(record.dataType)
                ?: throw HealthConnectorErrorCodeDto.UNSUPPORTED_OPERATION.toError(
                    "No handler found for type ${record.dataType}",
                )

            if (handler !is UpdatableHealthRecordHandler) {
                throw HealthConnectorErrorCodeDto.UNSUPPORTED_OPERATION.toError(
                    "Type ${record.dataType} does not support updates",
                )
            }

            handler.updateRecord(record)

            HealthConnectorLogger.info(
                tag = TAG,
                operation = "update_record",
                message = "Health Connect record updated successfully",
                context = mapOf("data_type" to record.dataType),
            )
        } catch (e: HealthConnectorErrorDto) {
            throw e
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
     * @throws HealthConnectorErrorDto with code `UNSUPPORTED_OPERATION` if any type is not updatable
     * @throws HealthConnectorErrorDto with code `INVALID_ARGUMENT` if any record ID is invalid
     * @throws HealthConnectorErrorDto with code `NOT_AUTHORIZED` if permission access is denied
     * @throws HealthConnectorErrorDto with code `UNKNOWN` if an unexpected error occurs
     */
    @Throws(HealthConnectorErrorDto::class)
    suspend fun updateRecords(records: List<HealthRecordDto>) {
        HealthConnectorLogger.debug(
            tag = TAG,
            operation = "update_records",
            message = "Updating Health Connect records atomically",
            context = mapOf(
                "total_records" to records.size,
                "records" to records,
            ),
        )

        try {
            if (records.isEmpty()) {
                HealthConnectorLogger.debug(
                    tag = TAG,
                    operation = "update_records",
                    message = "No records to update, returning",
                )
                return
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
                    ?: throw HealthConnectorErrorCodeDto.UNSUPPORTED_OPERATION.toError(
                        "No handler found for type $dataType",
                    )

                if (handler !is UpdatableHealthRecordHandler) {
                    throw HealthConnectorErrorCodeDto.UNSUPPORTED_OPERATION.toError(
                        "Type $dataType does not support updates",
                    )
                }
            }

            client.updateRecords(
                records.map { record -> record.toHealthConnect() },
            )

            HealthConnectorLogger.info(
                tag = TAG,
                operation = "update_records",
                message = "Health Connect records updated successfully",
                context = mapOf("count" to records.size),
            )
        } catch (e: HealthConnectorErrorDto) {
            throw e
        }
    }

    /**
     * Deletes specific records by their IDs.
     *
     * @param request Contains data type and list of record IDs to delete
     * @throws HealthConnectorErrorDto with code `UNSUPPORTED_OPERATION` if handler not found or doesn't support deletion
     * @throws HealthConnectorErrorDto with code `NOT_AUTHORIZED` if permission access is denied
     * @throws HealthConnectorErrorDto with code `UNKNOWN` if deletion fails
     */
    @Throws(HealthConnectorErrorDto::class)
    suspend fun deleteRecordsByIds(request: DeleteRecordsByIdsRequestDto) {
        HealthConnectorLogger.debug(
            tag = TAG,
            operation = "delete_records_by_ids",
            message = "Deleting Health Connect records by IDs",
            context = mapOf("request" to request),
        )

        if (request.recordIds.isEmpty()) {
            HealthConnectorLogger.warning(
                tag = TAG,
                operation = "delete_records_by_ids",
                message = "No records to delete (empty IDs list)",
            )
            return
        }

        try {
            val handler = recordHandlerRegistry.getRecordHandler(request.dataType)
                ?: throw HealthConnectorErrorCodeDto.UNSUPPORTED_OPERATION.toError(
                    "No handler found for type ${request.dataType}",
                )

            if (handler !is DeletableHealthRecordHandler) {
                throw HealthConnectorErrorCodeDto.UNSUPPORTED_OPERATION.toError(
                    "Type ${request.dataType} does not support deletion",
                )
            }

            handler.deleteRecords(request.recordIds)

            HealthConnectorLogger.info(
                tag = TAG,
                operation = "delete_records_by_ids",
                message = "Health Connect records deleted successfully",
                context = mapOf("data_type" to request.dataType, "count" to request.recordIds.size),
            )
        } catch (e: HealthConnectorErrorDto) {
            throw e
        }
    }

    /**
     * Deletes all records of a data type within a time range.
     *
     * @param request Contains data type and time range for deletion
     * @throws HealthConnectorErrorDto with code `UNSUPPORTED_OPERATION` if handler not found or doesn't support deletion
     * @throws HealthConnectorErrorDto with code `NOT_AUTHORIZED` if permission access is denied
     * @throws HealthConnectorErrorDto with code `UNKNOWN` if deletion fails
     */
    @Throws(HealthConnectorErrorDto::class)
    suspend fun deleteRecordsByTimeRange(request: DeleteRecordsByTimeRangeRequestDto) {
        HealthConnectorLogger.debug(
            tag = TAG,
            operation = "delete_records_by_time_range",
            message = "Deleting Health Connect records by time range",
            context = mapOf("request" to request),
        )

        try {
            val handler = recordHandlerRegistry.getRecordHandler(request.dataType)
                ?: throw HealthConnectorErrorCodeDto.UNSUPPORTED_OPERATION.toError(
                    "No handler found for type ${request.dataType}",
                )

            if (handler !is DeletableHealthRecordHandler) {
                throw HealthConnectorErrorCodeDto.UNSUPPORTED_OPERATION.toError(
                    "Type ${request.dataType} does not support deletion",
                )
            }

            handler.deleteRecordsByTimeRange(
                startTime = Instant.ofEpochMilli(request.startTime),
                endTime = Instant.ofEpochMilli(request.endTime),
            )

            HealthConnectorLogger.info(
                tag = TAG,
                operation = "delete_records_by_time_range",
                message = "Health Connect records deleted successfully",
                context = mapOf("data_type" to request.dataType),
            )
        } catch (e: HealthConnectorErrorDto) {
            throw e
        }
    }

    /**
     * Performs an aggregation query on health records.
     *
     * @param request Contains data type, aggregation metric, and time range
     * @return MeasurementUnitDto with the aggregated value
     *
     * @throws HealthConnectorErrorDto with code `UNSUPPORTED_OPERATION` if handler not found or doesn't support aggregation
     * @throws HealthConnectorErrorDto with code `INVALID_ARGUMENT` if time range or metric is invalid
     * @throws HealthConnectorErrorDto with code `NOT_AUTHORIZED` if authorization is denied
     * @throws HealthConnectorErrorDto with code `UNKNOWN` if an unexpected error occurs
     */
    @Throws(HealthConnectorErrorDto::class)
    suspend fun aggregate(request: AggregateRequestDto): MeasurementUnitDto {
        HealthConnectorLogger.debug(
            tag = TAG,
            operation = "aggregate",
            message = "Aggregating Health Connect data",
            context = mapOf("request" to request),
        )

        try {
            val handler = recordHandlerRegistry.getRecordHandler(request.dataType)
                ?: throw HealthConnectorErrorCodeDto.UNSUPPORTED_OPERATION.toError(
                    "Data type ${request.dataType} does not support aggregation",
                )

            val responseDto = when (handler) {
                is HealthConnectAggregatableHealthRecordHandler -> handler.aggregate(request)

                is CustomAggregatableHealthRecordHandler -> handler.aggregate(request)

                else -> throw HealthConnectorErrorCodeDto.UNSUPPORTED_OPERATION.toError(
                    "Type ${request.dataType} does not support aggregation",
                )
            }

            HealthConnectorLogger.info(
                tag = TAG,
                operation = "aggregate",
                message = "Health Connect data aggregated successfully",
                context = mapOf(
                    "request" to request,
                    "response" to responseDto,
                ),
            )

            return responseDto
        } catch (e: HealthConnectorErrorDto) {
            throw e
        }
    }

    /**
     * Gets all permissions that have been granted to the app.
     *
     * @return [PermissionRequestsResponseDto] containing separate lists for health data and feature permissions
     *         that have been granted
     *
     * @throws HealthConnectorErrorDto with code `UNKNOWN` if an unexpected error occurs
     */
    @Throws(HealthConnectorErrorDto::class)
    suspend fun getGrantedPermissions(): PermissionRequestsResponseDto {
        HealthConnectorLogger.debug(
            tag = TAG,
            operation = "get_granted_permissions",
            message = "Getting granted Health Connect permissions",
        )

        try {
            return permissionService.getGrantedPermissions()
        } catch (e: HealthConnectorErrorDto) {
            throw e
        }
    }

    /**
     * Revokes all permissions that have been granted to the app.
     *
     * @throws HealthConnectorErrorDto with code `UNKNOWN` if an unexpected error occurs
     */
    @Throws(HealthConnectorErrorDto::class)
    suspend fun revokeAllPermissions() {
        HealthConnectorLogger.debug(
            tag = TAG,
            operation = "revoke_all_permissions",
            message = "Revoking all Health Connect permissions",
        )

        try {
            permissionService.revokeAllPermissions()

            HealthConnectorLogger.info(
                tag = TAG,
                operation = "revoke_all_permissions",
                message = "All Health Connect permissions revoked successfully",
            )
        } catch (e: HealthConnectorErrorDto) {
            throw e
        }
    }
}
