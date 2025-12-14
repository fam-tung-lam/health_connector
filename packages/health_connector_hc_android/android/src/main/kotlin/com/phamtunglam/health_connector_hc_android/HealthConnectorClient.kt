package com.phamtunglam.health_connector_hc_android

import android.content.Context
import androidx.activity.ComponentActivity
import androidx.health.connect.client.HealthConnectClient
import androidx.health.connect.client.records.metadata.DataOrigin
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
import com.phamtunglam.health_connector_hc_android.mappers.toError
import com.phamtunglam.health_connector_hc_android.mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.mappers.toHealthPlatformStatusDto
import com.phamtunglam.health_connector_hc_android.pigeon.AggregateRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.AggregateResponseDto
import com.phamtunglam.health_connector_hc_android.pigeon.DeleteRecordsByIdsRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.DeleteRecordsByTimeRangeRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthConnectorErrorCodeDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthConnectorErrorDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthPlatformFeatureDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthPlatformFeatureStatusDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthPlatformStatusDto
import com.phamtunglam.health_connector_hc_android.pigeon.PermissionRequestsDto
import com.phamtunglam.health_connector_hc_android.pigeon.PermissionRequestsResponseDto
import com.phamtunglam.health_connector_hc_android.pigeon.ReadRecordRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.ReadRecordResponseDto
import com.phamtunglam.health_connector_hc_android.pigeon.ReadRecordsRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.ReadRecordsResponseDto
import com.phamtunglam.health_connector_hc_android.pigeon.UpdateRecordRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.UpdateRecordResponseDto
import com.phamtunglam.health_connector_hc_android.pigeon.WriteRecordRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.WriteRecordResponseDto
import com.phamtunglam.health_connector_hc_android.pigeon.WriteRecordsRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.WriteRecordsResponseDto
import com.phamtunglam.health_connector_hc_android.services.HealthConnectorFeatureService
import com.phamtunglam.health_connector_hc_android.services.HealthConnectorManifestService
import com.phamtunglam.health_connector_hc_android.services.HealthConnectorPermissionService
import java.time.Instant

/**
 * Internal client wrapper for the Android Health Connect SDK.
 */
internal class HealthConnectorClient private constructor(
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
                    manifestService = manifestService,
                    featureService = featureService,
                    permissionService = permissionService,
                    recordHandlerRegistry = recordHandlerRegistry,
                )
            } catch (e: UnsupportedOperationException) {
                HealthConnectorLogger.error(
                    tag = TAG,
                    operation = "getOrCreate",
                    message = "Failed to create Health Connect client " +
                        "due to SDK version too low or running in a profile mode",
                    exception = e,
                )
                throw HealthConnectorErrorCodeDto
                    .HEALTH_PROVIDER_NOT_INSTALLED_OR_UPDATE_REQUIRED.toError(
                        e.message,
                    )
            } catch (e: IllegalStateException) {
                HealthConnectorLogger.error(
                    tag = TAG,
                    operation = "getOrCreate",
                    message = "Failed to create Health Connect client due to service not available",
                    exception = e,
                )
                throw HealthConnectorErrorCodeDto.HEALTH_PROVIDER_UNAVAILABLE.toError(
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
                operation = "getHealthPlatformStatus",
                message = "Getting Health Connect SDK status",
            )

            val statusCode = HealthConnectClient.getSdkStatus(context)
            val statusDto = statusCode.toHealthPlatformStatusDto()

            HealthConnectorLogger.info(
                tag = TAG,
                operation = "getHealthPlatformStatus",
                message = "Health Connect platform status retrieved",
                context = mapOf(
                    "status_code" to statusCode,
                    "status_dto" to statusDto,
                ),
            )

            return statusDto
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
            operation = "requestPermissions",
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
        } catch (e: Exception) {
            HealthConnectorLogger.error(
                tag = TAG,
                operation = "requestPermissions",
                message = "Failed to request Health Connect permissions",
                context = mapOf(
                    "requested_permissions" to request.permissionRequests,
                ),
                exception = e,
            )
            throw HealthConnectorErrorCodeDto.UNKNOWN.toError(
                "Failed to process $request : ${e.message ?: "Unknown error"}",
            )
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
            operation = "getFeatureStatus",
            message = "Checking Health Connect feature status",
            context = mapOf("feature" to feature),
        )

        try {
            val featurePermissionString = feature.toHealthConnect()
            manifestService.checkPermissionsDeclared(setOf(featurePermissionString))

            val featureStatus = featureService.getFeatureStatus(feature)

            HealthConnectorLogger.info(
                tag = TAG,
                operation = "getFeatureStatus",
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
                operation = "getFeatureStatus",
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
                operation = "getFeatureStatus",
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
     * @return ReadRecordResponseDto with the appropriate typed field populated, or null if not found
     *
     * @throws HealthConnectorErrorDto with code `UNSUPPORTED_OPERATION` if handler not found or doesn't support reading
     * @throws HealthConnectorErrorDto with code `NOT_AUTHORIZED` if permission access is denied
     * @throws HealthConnectorErrorDto with code `UNKNOWN` if an unexpected error occurs
     */
    @Throws(HealthConnectorErrorDto::class)
    suspend fun readRecord(request: ReadRecordRequestDto): ReadRecordResponseDto {
        HealthConnectorLogger.debug(
            tag = TAG,
            operation = "readRecord",
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
                operation = "readRecord",
                message = "Health Connect record read successfully",
                context = mapOf("dataType" to request.dataType, "recordId" to request.recordId),
            )

            return ReadRecordResponseDto(record = dto)
        } catch (e: HealthConnectorErrorDto) {
            throw e
        } catch (e: Exception) {
            HealthConnectorLogger.error(
                tag = TAG,
                operation = "readRecord",
                message = "Unexpected error escaped from handler",
                context = mapOf("request" to request),
                exception = e,
            )
            throw HealthConnectorErrorCodeDto.UNKNOWN.toError(
                "Unexpected error: ${e.message ?: "Unknown error"}",
            )
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
            operation = "readRecords",
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
                operation = "readRecords",
                message = "Health Connect records read successfully",
                context = mapOf("dataType" to request.dataType, "count" to records.size),
            )

            return ReadRecordsResponseDto(
                records = records,
                nextPageToken = nextPageToken,
            )
        } catch (e: HealthConnectorErrorDto) {
            throw e
        } catch (e: Exception) {
            HealthConnectorLogger.error(
                tag = TAG,
                operation = "readRecords",
                message = "Unexpected error escaped from handler",
                context = mapOf("request" to request),
                exception = e,
            )
            throw HealthConnectorErrorCodeDto.UNKNOWN.toError(
                "Unexpected error: ${e.message ?: "Unknown error"}",
            )
        }
    }

    /**
     * Writes a single health record.
     *
     * @param request Contains the data type and the typed record to write
     * @return WriteRecordResponseDto containing the platform-assigned record ID
     *
     * @throws HealthConnectorErrorDto with code `UNSUPPORTED_OPERATION` if handler not found or doesn't support writing
     * @throws HealthConnectorErrorDto with code `NOT_AUTHORIZED` if permission access is denied
     * @throws HealthConnectorErrorDto with code `UNKNOWN` if an unexpected error occurs
     */
    @Throws(HealthConnectorErrorDto::class)
    suspend fun writeRecord(request: WriteRecordRequestDto): WriteRecordResponseDto {
        HealthConnectorLogger.debug(
            tag = TAG,
            operation = "writeRecord",
            message = "Writing Health Connect record",
            context = mapOf("request" to request),
        )

        try {
            val handler = recordHandlerRegistry.getRecordHandler(request.record.dataType)
                ?: throw HealthConnectorErrorCodeDto.UNSUPPORTED_OPERATION.toError(
                    "No handler found for type ${request.record.dataType}",
                )

            if (handler !is WritableHealthRecordHandler) {
                throw HealthConnectorErrorCodeDto.UNSUPPORTED_OPERATION.toError(
                    "Type ${request.record.dataType} does not support writing",
                )
            }

            val recordId = handler.writeRecord(request.record)

            HealthConnectorLogger.info(
                tag = TAG,
                operation = "writeRecord",
                message = "Health Connect record written successfully",
                context = mapOf("dataType" to request.record.dataType, "recordId" to recordId),
            )

            return WriteRecordResponseDto(recordId = recordId)
        } catch (e: HealthConnectorErrorDto) {
            throw e
        } catch (e: Exception) {
            HealthConnectorLogger.error(
                tag = TAG,
                operation = "writeRecord",
                message = "Unexpected error escaped from handler",
                context = mapOf("request" to request),
                exception = e,
            )
            throw HealthConnectorErrorCodeDto.UNKNOWN.toError(
                "Unexpected error: ${e.message ?: "Unknown error"}",
            )
        }
    }

    /**
     * Writes multiple records to Health Connect.
     *
     * @throws HealthConnectorErrorDto with code `UNSUPPORTED_OPERATION` if handler not found or doesn't support writing
     * @throws HealthConnectorErrorDto with code `NOT_AUTHORIZED` if permission access is denied
     * @throws HealthConnectorErrorDto with code `UNKNOWN` if an unexpected error occurs
     */
    @Throws(HealthConnectorErrorDto::class)
    suspend fun writeRecords(request: WriteRecordsRequestDto): WriteRecordsResponseDto {
        HealthConnectorLogger.debug(
            tag = TAG,
            operation = "writeRecords",
            message = "Writing Health Connect records",
            context = mapOf("request" to request),
        )

        try {
            if (request.records.isEmpty()) {
                return WriteRecordsResponseDto(recordIds = emptyList())
            }

            val firstRecord = request.records.first()
            val handler = recordHandlerRegistry.getRecordHandler(firstRecord.dataType)
                ?: throw HealthConnectorErrorCodeDto.UNSUPPORTED_OPERATION.toError(
                    "No handler found for type ${firstRecord.dataType}",
                )

            if (handler !is WritableHealthRecordHandler) {
                throw HealthConnectorErrorCodeDto.UNSUPPORTED_OPERATION.toError(
                    "Type ${firstRecord.dataType} does not support writing",
                )
            }

            val recordIds = handler.writeRecords(request.records)

            HealthConnectorLogger.info(
                tag = TAG,
                operation = "writeRecords",
                message = "Health Connect records written successfully",
                context = mapOf("dataType" to firstRecord.dataType, "count" to recordIds.size),
            )

            return WriteRecordsResponseDto(recordIds = recordIds)
        } catch (e: HealthConnectorErrorDto) {
            throw e
        } catch (e: Exception) {
            HealthConnectorLogger.error(
                tag = TAG,
                operation = "writeRecords",
                message = "Unexpected error escaped from handler",
                context = mapOf("request" to request),
                exception = e,
            )
            throw HealthConnectorErrorCodeDto.UNKNOWN.toError(
                "Unexpected error: ${e.message ?: "Unknown error"}",
            )
        }
    }

    /**
     * Updates a single health record.
     *
     * @param request Contains the data type and the typed record to update
     * @return UpdateRecordResponseDto containing the updated record ID (same as input)
     *
     * @throws HealthConnectorErrorDto with code `UNSUPPORTED_OPERATION` if handler not found or doesn't support updates
     * @throws HealthConnectorErrorDto with code `INVALID_ARGUMENT` if record ID is invalid
     * @throws HealthConnectorErrorDto with code `NOT_AUTHORIZED` if permission access is denied
     * @throws HealthConnectorErrorDto with code `UNKNOWN` if an unexpected error occurs
     */
    @Throws(HealthConnectorErrorDto::class)
    suspend fun updateRecord(request: UpdateRecordRequestDto): UpdateRecordResponseDto {
        HealthConnectorLogger.debug(
            tag = TAG,
            operation = "updateRecord",
            message = "Updating Health Connect record",
            context = mapOf("request" to request),
        )

        try {
            val handler = recordHandlerRegistry.getRecordHandler(request.record.dataType)
                ?: throw HealthConnectorErrorCodeDto.UNSUPPORTED_OPERATION.toError(
                    "No handler found for type ${request.record.dataType}",
                )

            if (handler !is UpdatableHealthRecordHandler) {
                throw HealthConnectorErrorCodeDto.UNSUPPORTED_OPERATION.toError(
                    "Type ${request.record.dataType} does not support updates",
                )
            }

            val recordId = handler.updateRecord(request.record)

            HealthConnectorLogger.info(
                tag = TAG,
                operation = "updateRecord",
                message = "Health Connect record updated successfully",
                context = mapOf("dataType" to request.record.dataType, "recordId" to recordId),
            )

            return UpdateRecordResponseDto(recordId = recordId)
        } catch (e: HealthConnectorErrorDto) {
            throw e
        } catch (e: Exception) {
            HealthConnectorLogger.error(
                tag = TAG,
                operation = "updateRecord",
                message = "Unexpected error escaped from handler",
                context = mapOf("request" to request),
                exception = e,
            )
            throw HealthConnectorErrorCodeDto.UNKNOWN.toError(
                "Unexpected error: ${e.message ?: "Unknown error"}",
            )
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
            operation = "deleteRecordsByIds",
            message = "Deleting Health Connect records by IDs",
            context = mapOf("request" to request),
        )

        if (request.recordIds.isEmpty()) {
            HealthConnectorLogger.warning(
                tag = TAG,
                operation = "deleteRecordsByIds",
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
                operation = "deleteRecordsByIds",
                message = "Health Connect records deleted successfully",
                context = mapOf("dataType" to request.dataType, "count" to request.recordIds.size),
            )
        } catch (e: HealthConnectorErrorDto) {
            throw e
        } catch (e: Exception) {
            HealthConnectorLogger.error(
                tag = TAG,
                operation = "deleteRecordsByIds",
                message = "Unexpected error escaped from handler",
                context = mapOf("request" to request),
                exception = e,
            )
            throw HealthConnectorErrorCodeDto.UNKNOWN.toError(
                "Unexpected error: ${e.message ?: "Unknown error"}",
            )
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
            operation = "deleteRecordsByTimeRange",
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

            handler.deleteRecordsByTimeRange(request.startTime, request.endTime)

            HealthConnectorLogger.info(
                tag = TAG,
                operation = "deleteRecordsByTimeRange",
                message = "Health Connect records deleted successfully",
                context = mapOf("dataType" to request.dataType),
            )
        } catch (e: HealthConnectorErrorDto) {
            throw e
        } catch (e: Exception) {
            HealthConnectorLogger.error(
                tag = TAG,
                operation = "deleteRecordsByTimeRange",
                message = "Unexpected error escaped from handler",
                context = mapOf("request" to request),
                exception = e,
            )
            throw HealthConnectorErrorCodeDto.UNKNOWN.toError(
                "Unexpected error: ${e.message ?: "Unknown error"}",
            )
        }
    }

    /**
     * Performs an aggregation query on health records.
     *
     * @param request Contains data type, aggregation metric, and time range
     * @return AggregateResponseDto with aggregated value and data point count
     *
     * @throws HealthConnectorErrorDto with code `UNSUPPORTED_OPERATION` if handler not found or doesn't support aggregation
     * @throws HealthConnectorErrorDto with code `INVALID_ARGUMENT` if time range or metric is invalid
     * @throws HealthConnectorErrorDto with code `NOT_AUTHORIZED` if authorization is denied
     * @throws HealthConnectorErrorDto with code `UNKNOWN` if an unexpected error occurs
     */
    @Throws(HealthConnectorErrorDto::class)
    suspend fun aggregate(request: AggregateRequestDto): AggregateResponseDto {
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
        } catch (e: Exception) {
            HealthConnectorLogger.error(
                tag = TAG,
                operation = "aggregate",
                message = "Unexpected error escaped from handler",
                context = mapOf("request" to request),
                exception = e,
            )
            throw HealthConnectorErrorCodeDto.UNKNOWN.toError(
                "Unexpected error: ${e.message ?: "Unknown error"}",
            )
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
            operation = "getGrantedPermissions",
            message = "Getting granted Health Connect permissions",
        )

        try {
            return permissionService.getGrantedPermissions()
        } catch (e: HealthConnectorErrorDto) {
            throw e
        } catch (e: Exception) {
            HealthConnectorLogger.error(
                tag = TAG,
                operation = "getGrantedPermissions",
                message = "Failed to get granted Health Connect permissions",
                exception = e,
            )
            throw HealthConnectorErrorCodeDto.UNKNOWN.toError(
                "Failed to get granted permissions: ${e.message}",
            )
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
            operation = "revokeAllPermissions",
            message = "Revoking all Health Connect permissions",
        )

        try {
            permissionService.revokeAllPermissions()

            HealthConnectorLogger.info(
                tag = TAG,
                operation = "revokeAllPermissions",
                message = "All Health Connect permissions revoked successfully",
            )
        } catch (e: HealthConnectorErrorDto) {
            throw e
        } catch (e: Exception) {
            HealthConnectorLogger.error(
                tag = TAG,
                operation = "revokeAllPermissions",
                message = "Failed to revoke all Health Connect permissions",
                exception = e,
            )
            throw HealthConnectorErrorCodeDto.UNKNOWN.toError(
                "Failed to revoke all permissions: ${e.message}",
            )
        }
    }
}
