package com.phamtunglam.health_connector_hc_android

import android.content.Context
import androidx.activity.ComponentActivity
import androidx.health.connect.client.HealthConnectClient
import androidx.health.connect.client.records.Record
import androidx.health.connect.client.records.metadata.DataOrigin
import androidx.health.connect.client.request.AggregateRequest
import androidx.health.connect.client.request.ReadRecordsRequest
import androidx.health.connect.client.time.TimeRangeFilter
import com.phamtunglam.health_connector_hc_android.handlers.HealthConnectTypeHandlerRegistry
import com.phamtunglam.health_connector_hc_android.mappers.dataType
import com.phamtunglam.health_connector_hc_android.mappers.endTime
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.id
import com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.mappers.isFeaturePermission
import com.phamtunglam.health_connector_hc_android.mappers.startTime
import com.phamtunglam.health_connector_hc_android.mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.toError
import com.phamtunglam.health_connector_hc_android.mappers.toHealthConnectFeature
import com.phamtunglam.health_connector_hc_android.mappers.toHealthConnectRecordClass
import com.phamtunglam.health_connector_hc_android.mappers.toHealthPlatformFeatureDto
import com.phamtunglam.health_connector_hc_android.mappers.toHealthPlatformFeatureStatusDto
import com.phamtunglam.health_connector_hc_android.mappers.toHealthPlatformStatusDto
import com.phamtunglam.health_connector_hc_android.pigeon.AggregateRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.AggregateResponseDto
import com.phamtunglam.health_connector_hc_android.pigeon.DeleteRecordsByIdsRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.DeleteRecordsByTimeRangeRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthConnectorError
import com.phamtunglam.health_connector_hc_android.pigeon.HealthConnectorErrorCodeDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataPermissionRequestResultDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthPlatformFeatureDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthPlatformFeaturePermissionRequestResultDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthPlatformFeatureStatusDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthPlatformStatusDto
import com.phamtunglam.health_connector_hc_android.pigeon.PermissionStatusDto
import com.phamtunglam.health_connector_hc_android.pigeon.PermissionsRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.PermissionsRequestResponseDto
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
import com.phamtunglam.health_connector_hc_android.utils.HealthConnectorLogger
import com.phamtunglam.health_connector_hc_android.utils.PermissionUtils
import java.time.Instant

/**
 * Internal client wrapper for the Android Health Connect SDK.
 *
 * @property client The underlying Health Connect SDK client instance
 */
internal class HealthConnectorClient private constructor(private val client: HealthConnectClient) {
    companion object {
        /**
         * Tag used for logging throughout the client.
         */
        private val TAG = HealthConnectorClient::class.simpleName ?: "HealthConnectorClient"

        /**
         * Gets or creates a [HealthConnectorClient] instance.
         *
         * @param context Android application context used to access Health Connect services
         * @return A new [HealthConnectorClient] instance wrapping the Health Connect SDK client
         *
         * @throws HealthConnectorError with code `HEALTH_PLATFORM_NOT_AVAILABLE` when:
         *         - The device SDK version is too low (below API 26)
         *         - The app is running in a profile/work profile that doesn't support Health Connect
         *         - Health Connect SDK initialization fails
         */
        @Throws(HealthConnectorError::class)
        fun getOrCreate(context: Context): HealthConnectorClient {
            try {
                return HealthConnectorClient(HealthConnectClient.getOrCreate(context))
            } catch (e: UnsupportedOperationException) {
                HealthConnectorLogger.error(
                    tag = TAG,
                    operation = "getOrCreate",
                    phase = "failed",
                    message = "Failed to create Health Connect client " +
                        "due to SDK version too low or running in a profile mode",
                    exception = e,
                )
                throw HealthConnectorErrorCodeDto.INSTALLATION_OR_UPDATE_REQUIRED.toError(
                    details = e.message,
                )
            } catch (e: IllegalStateException) {
                HealthConnectorLogger.error(
                    tag = TAG,
                    operation = "getOrCreate",
                    phase = "failed",
                    message = "Failed to create Health Connect client due to service not available",
                    exception = e,
                )
                throw HealthConnectorErrorCodeDto.HEALTH_PLATFORM_UNAVAILABLE.toError(
                    details = e.message,
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
                phase = "entry",
                message = "Getting Health Connect SDK status",
            )

            val statusCode = HealthConnectClient.getSdkStatus(context)
            val statusDto = statusCode.toHealthPlatformStatusDto()

            HealthConnectorLogger.info(
                tag = TAG,
                operation = "getHealthPlatformStatus",
                phase = "completed",
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
     * @return [PermissionsRequestResponseDto] containing separate result lists for health data
     *         and feature permissions
     *
     * @throws HealthConnectorError with code `INVALID_PLATFORM_CONFIGURATION` if any requested
     *         permissions/features are not declared in AndroidManifest.xml (caught from
     *         [IllegalStateException] thrown by validation)
     * @throws HealthConnectorError with code `UNKNOWN` if an unexpected error occurs
     */
    @Throws(HealthConnectorError::class)
    suspend fun requestPermissions(
        activity: ComponentActivity,
        request: PermissionsRequestDto,
    ): PermissionsRequestResponseDto {
        HealthConnectorLogger.debug(
            tag = TAG,
            operation = "requestPermissions",
            phase = "entry",
            message = "Requesting Health Connect permissions",
            context = mapOf(
                "requested_health_data_permissions" to request.healthDataPermissions,
                "requested_feature_permissions" to request.featurePermissions,
            ),
        )

        try {
            // Validate that all requested permissions are declared in AndroidManifest
            PermissionUtils.validatePermissionsDeclaredInManifest(
                activity.applicationContext,
                request,
            )

            val grantedPermissions = PermissionUtils.requestPermissionsFromSystem(activity, request)

            val healthDataResults = PermissionUtils.buildHealthDataPermissionResults(
                request.healthDataPermissions,
                grantedPermissions,
            )
            val featureResults = PermissionUtils.buildFeaturePermissionResults(
                request.featurePermissions,
                grantedPermissions,
            )

            HealthConnectorLogger.info(
                tag = TAG,
                operation = "requestPermissions",
                phase = "completed",
                message = "Health Connect permissions requested successfully",
                context = mapOf(
                    "granted_health_data_permissions" to healthDataResults,
                    "granted_feature_permissions" to featureResults,
                ),
            )

            return PermissionsRequestResponseDto(
                healthDataPermissionResults = healthDataResults,
                featurePermissionResults = featureResults,
            )
        } catch (e: IllegalStateException) {
            HealthConnectorLogger.error(
                tag = TAG,
                operation = "requestPermissions",
                phase = "failed",
                message = e.message,
                context = mapOf(
                    "requested_permissions" to mapOf(
                        "health_data_permissions" to request.healthDataPermissions,
                        "feature_permissions" to request.featurePermissions,
                    ),
                ),
                exception = e,
            )
            throw HealthConnectorErrorCodeDto.INVALID_PLATFORM_CONFIGURATION.toError(
                details = e.message,
            )
        } catch (e: Exception) {
            HealthConnectorLogger.error(
                tag = TAG,
                operation = "requestPermissions",
                phase = "failed",
                message = "Failed to request Health Connect permissions",
                context = mapOf(
                    "requested_permissions" to mapOf(
                        "health_data_permissions" to request.healthDataPermissions,
                        "feature_permissions" to request.featurePermissions,
                    ),
                ),
                exception = e,
            )
            throw HealthConnectorErrorCodeDto.UNKNOWN.toError(
                details = "Failed to process $request : ${e.message ?: "Unknown error"}",
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
     * @throws HealthConnectorError with code `INVALID_PLATFORM_CONFIGURATION` if the feature permission
     *         is not declared in AndroidManifest.xml
     * @throws HealthConnectorError with code `UNKNOWN` if an unexpected error occurs
     */
    @Throws(HealthConnectorError::class)
    fun getFeatureStatus(
        context: Context,
        feature: HealthPlatformFeatureDto,
    ): HealthPlatformFeatureStatusDto {
        HealthConnectorLogger.debug(
            tag = TAG,
            operation = "getFeatureStatus",
            phase = "entry",
            message = "Checking Health Connect feature status",
            context = mapOf("feature" to feature),
        )

        try {
            // Validate that the feature permission is declared in AndroidManifest
            PermissionUtils.validateFeaturePermissionDeclaredInManifest(context, feature)

            // Map HealthPlatformFeatureDto to Health Connect feature constants
            val healthConnectFeature = feature.toHealthConnectFeature()

            // Check feature status using Health Connect SDK
            val statusCode = client.features.getFeatureStatus(healthConnectFeature)

            // Map Health Connect status to HealthPlatformFeatureStatusDto
            val statusDto = statusCode.toHealthPlatformFeatureStatusDto()

            HealthConnectorLogger.info(
                tag = TAG,
                operation = "getFeatureStatus",
                phase = "completed",
                message = "Health Connect feature status retrieved",
                context = mapOf(
                    "feature" to feature,
                    "status" to statusDto,
                ),
            )

            return statusDto
        } catch (e: IllegalStateException) {
            HealthConnectorLogger.error(
                tag = TAG,
                operation = "getFeatureStatus",
                phase = "failed",
                message = e.message,
                context = mapOf("feature" to feature),
                exception = e,
            )
            throw HealthConnectorErrorCodeDto.INVALID_PLATFORM_CONFIGURATION.toError(
                details = e.message,
            )
        } catch (e: Exception) {
            HealthConnectorLogger.error(
                tag = TAG,
                operation = "getFeatureStatus",
                phase = "failed",
                message = "Failed to get Health Connect feature status",
                context = mapOf("feature" to feature),
                exception = e,
            )
            throw HealthConnectorErrorCodeDto.UNKNOWN.toError(
                details = "Failed to get feature status for $feature: " +
                    (e.message ?: "Unknown error"),
            )
        }
    }

    /**
     * Reads a single health record by ID.
     *
     * @param request Contains the data type and record ID to read
     * @return ReadRecordResponseDto with the appropriate typed field populated, or null if not found
     *
     * @throws HealthConnectorError with code `SECURITY_ERROR` if permission access is denied
     * @throws HealthConnectorError with code `UNKNOWN` if an unexpected error occurs
     */
    @Throws(HealthConnectorError::class)
    suspend fun readRecord(request: ReadRecordRequestDto): ReadRecordResponseDto {
        HealthConnectorLogger.debug(
            tag = TAG,
            operation = "readRecord",
            phase = "entry",
            message = "Reading Health Connect record",
            context = mapOf("request" to request),
        )

        try {
            // Get handler for this data type
            val handler = HealthConnectTypeHandlerRegistry.getRecordHandler(request.dataType)
                ?: throw IllegalArgumentException("Unsupported data type: ${request.dataType}")

            val recordClass = handler.getRecordClass()
            val response = client.readRecord(recordClass, request.recordId)

            val recordDto = handler.toDto(response.record)
            val responseDto = ReadRecordResponseDto(record = recordDto)

            HealthConnectorLogger.info(
                tag = TAG,
                operation = "readRecord",
                phase = "completed",
                message = "Health Connect record read successfully",
                context = mapOf(
                    "request" to request,
                    "response" to responseDto,
                ),
            )

            return responseDto
        } catch (e: SecurityException) {
            HealthConnectorLogger.error(
                tag = TAG,
                operation = "readRecord",
                phase = "failed",
                message = "Failed to read Health Connect record",
                context = mapOf("request" to request),
                exception = e,
            )
            throw HealthConnectorErrorCodeDto.SECURITY_ERROR.toError(
                details = "Permission access denied while processing $request: " +
                    (e.message ?: "Access denied"),
            )
        } catch (e: Exception) {
            HealthConnectorLogger.error(
                tag = TAG,
                operation = "readRecord",
                phase = "failed",
                message = "Failed to read Health Connect record",
                context = mapOf("request" to request),
                exception = e,
            )
            throw HealthConnectorErrorCodeDto.UNKNOWN.toError(
                details = "Failed to process $request: ${e.message ?: "Unknown error"}",
            )
        }
    }

    /**
     * Reads multiple health records within a time range (paginated).
     *
     * @param request Contains data type, time range, page size, optional page token,
     *                and optional data origin package names for filtering
     * @return ReadRecordsResponseDto with the appropriate typed list populated and optional next page token
     *
     * @throws HealthConnectorError with code `SECURITY_ERROR` if permission access is denied
     * @throws HealthConnectorError with code `UNKNOWN` if an unexpected error occurs
     */
    @Throws(HealthConnectorError::class)
    suspend fun readRecords(request: ReadRecordsRequestDto): ReadRecordsResponseDto {
        HealthConnectorLogger.debug(
            tag = TAG,
            operation = "readRecords",
            phase = "entry",
            message = "Reading Health Connect records",
            context = mapOf("request" to request),
        )

        try {
            val recordClass = request.dataType.toHealthConnectRecordClass()
            val timeRangeFilter = TimeRangeFilter.between(
                Instant.ofEpochMilli(request.startTime),
                Instant.ofEpochMilli(request.endTime),
            )

            // Create data origin filter if package names are provided
            val dataOrigins = request.dataOriginPackageNames.map { packageName ->
                DataOrigin(packageName)
            }

            val readRequest = ReadRecordsRequest(
                recordType = recordClass,
                timeRangeFilter = timeRangeFilter,
                dataOriginFilter = dataOrigins.toSet(),
                pageSize = request.pageSize.toInt(),
                pageToken = request.pageToken,
            )

            // Get handler for this data type
            val handler = HealthConnectTypeHandlerRegistry.getRecordHandler(request.dataType)
                ?: throw IllegalArgumentException("Unsupported data type: ${request.dataType}")

            val response = client.readRecords(readRequest)
            val nextPageToken = if (response.pageToken.isNullOrEmpty()) {
                null
            } else {
                response.pageToken
            }

            // Convert SDK records to DTOs using handler
            val recordDtos = response.records.mapNotNull { record ->
                handler.toDto(record)
            }

            val responseDto = ReadRecordsResponseDto(
                records = recordDtos,
                nextPageToken = nextPageToken,
            )

            HealthConnectorLogger.info(
                tag = TAG,
                operation = "readRecords",
                phase = "completed",
                message = "Health Connect records read successfully",
                context = mapOf(
                    "request" to request,
                    "response" to responseDto,
                ),
            )

            return responseDto
        } catch (e: SecurityException) {
            HealthConnectorLogger.error(
                tag = TAG,
                operation = "readRecords",
                phase = "failed",
                message = "Failed to read Health Connect records",
                context = mapOf("request" to request),
                exception = e,
            )
            throw HealthConnectorErrorCodeDto.SECURITY_ERROR.toError(
                details = "Permission access denied while processing $request: " +
                    (e.message ?: "Access denied"),
            )
        } catch (e: Exception) {
            HealthConnectorLogger.error(
                tag = TAG,
                operation = "readRecords",
                phase = "failed",
                message = "Failed to read Health Connect records",
                context = mapOf("request" to request),
                exception = e,
            )
            throw HealthConnectorErrorCodeDto.UNKNOWN.toError(
                details = "Failed to process $request: ${e.message ?: "Unknown error"}",
            )
        }
    }

    /**
     * Writes a single health record.
     *
     * @param request Contains the data type and the typed record to write
     * @return WriteRecordResponseDto containing the platform-assigned record ID
     *
     * @throws HealthConnectorError with code `SECURITY_ERROR` if permission access is denied
     * @throws HealthConnectorError with code `UNKNOWN` if an unexpected error occurs
     */
    @Throws(HealthConnectorError::class)
    suspend fun writeRecord(request: WriteRecordRequestDto): WriteRecordResponseDto {
        HealthConnectorLogger.debug(
            tag = TAG,
            operation = "writeRecord",
            phase = "entry",
            message = "Writing Health Connect record",
            context = mapOf("request" to request),
        )

        try {
            // Convert record DTO to Health Connect Record using extension
            val record: Record = request.record.toHealthConnect()

            // Write to Health Connect using ACID transaction
            val response = client.insertRecords(listOf(record))
            val recordId = response.recordIdsList.first()

            HealthConnectorLogger.info(
                tag = TAG,
                operation = "writeRecord",
                phase = "completed",
                message = "Health Connect record written successfully",
                context = mapOf(
                    "request" to request,
                    "assignedRecordId" to recordId,
                ),
            )

            return WriteRecordResponseDto(recordId = recordId)
        } catch (e: SecurityException) {
            HealthConnectorLogger.error(
                tag = TAG,
                operation = "writeRecord",
                phase = "failed",
                message = "Failed to write Health Connect record",
                context = mapOf("request" to request),
                exception = e,
            )
            throw HealthConnectorErrorCodeDto.SECURITY_ERROR.toError(
                details = "Permission access denied while processing $request: " +
                    (e.message ?: "Access denied"),
            )
        } catch (e: Exception) {
            HealthConnectorLogger.error(
                tag = TAG,
                operation = "writeRecord",
                phase = "failed",
                message = "Failed to write Health Connect record",
                context = mapOf("request" to request),
                exception = e,
            )
            throw HealthConnectorErrorCodeDto.UNKNOWN.toError(
                details = "Failed to process $request: ${e.message ?: "Unknown error"}",
            )
        }
    }

    /**
     * Writes multiple health records atomically.
     *
     * @param request Contains the data type and the list of typed records to write
     * @return WriteRecordsResponseDto containing the platform-assigned record IDs
     *
     * @throws HealthConnectorError with code `SECURITY_ERROR` if permission access is denied
     * @throws HealthConnectorError with code `UNKNOWN` if an unexpected error occurs
     */
    @Throws(HealthConnectorError::class)
    suspend fun writeRecords(request: WriteRecordsRequestDto): WriteRecordsResponseDto {
        HealthConnectorLogger.debug(
            tag = TAG,
            operation = "writeRecords",
            phase = "entry",
            message = "Writing Health Connect records",
            context = mapOf("request" to request),
        )

        try {
            // Convert record DTOs to Health Connect Records using extension
            val records = request.records.map { it.toHealthConnect() }

            // Atomic batch write using Health Connect's ACID transaction
            val response = client.insertRecords(records)
            val recordIds = response.recordIdsList

            HealthConnectorLogger.info(
                tag = TAG,
                operation = "writeRecords",
                phase = "completed",
                message = "Health Connect records written successfully",
                context = mapOf(
                    "request" to request,
                    "assignedRecordIds" to recordIds,
                ),
            )

            return WriteRecordsResponseDto(recordIds = recordIds)
        } catch (e: SecurityException) {
            HealthConnectorLogger.error(
                tag = TAG,
                operation = "writeRecords",
                phase = "failed",
                message = "Failed to write Health Connect records",
                context = mapOf("request" to request),
                exception = e,
            )
            throw HealthConnectorErrorCodeDto.SECURITY_ERROR.toError(
                details = "Permission access denied while processing $request: " +
                    (e.message ?: "Access denied"),
            )
        } catch (e: Exception) {
            HealthConnectorLogger.error(
                tag = TAG,
                operation = "writeRecords",
                phase = "failed",
                message = "Failed to write Health Connect records",
                context = mapOf("request" to request),
                exception = e,
            )
            throw HealthConnectorErrorCodeDto.UNKNOWN.toError(
                details = "Failed to process $request: ${e.message ?: "Unknown error"}",
            )
        }
    }

    /**
     * Updates a single health record.
     *
     * @param request Contains the data type and the typed record to update
     * @return UpdateRecordResponseDto containing the updated record ID (same as input)
     *
     * @throws HealthConnectorError with code `INVALID_ARGUMENT` if record ID is invalid
     * @throws HealthConnectorError with code `SECURITY_ERROR` if permission access is denied
     * @throws HealthConnectorError with code `UNKNOWN` if an unexpected error occurs
     */
    @Throws(HealthConnectorError::class)
    suspend fun updateRecord(request: UpdateRecordRequestDto): UpdateRecordResponseDto {
        HealthConnectorLogger.debug(
            tag = TAG,
            operation = "updateRecord",
            phase = "entry",
            message = "Updating Health Connect record",
            context = mapOf("request" to request),
        )

        try {
            val recordDto = request.record
            if (recordDto.id.isNullOrEmpty()) {
                throw IllegalArgumentException(
                    "Record ID must be a valid existing ID for update operations. Use writeRecord() for new records.",
                )
            }

            // Convert record DTO to Health Connect Record
            val record: Record = recordDto.toHealthConnect()

            client.updateRecords(listOf(record))

            // Retrieve updated record ID from the response metadata
            val recordId = record.metadata.id

            HealthConnectorLogger.info(
                tag = TAG,
                operation = "updateRecord",
                phase = "completed",
                message = "Health Connect record updated successfully",
                context = mapOf("request" to request),
            )

            return UpdateRecordResponseDto(recordId = recordId)
        } catch (e: IllegalArgumentException) {
            HealthConnectorLogger.error(
                tag = TAG,
                operation = "updateRecord",
                phase = "failed",
                message = "Failed to update Health Connect record",
                context = mapOf("request" to request),
                exception = e,
            )
            throw HealthConnectorErrorCodeDto.INVALID_ARGUMENT.toError(
                details = "Invalid record data for update: ${e.message ?: "Invalid argument"}",
            )
        } catch (e: SecurityException) {
            HealthConnectorLogger.error(
                tag = TAG,
                operation = "updateRecord",
                phase = "failed",
                message = "Failed to update Health Connect record",
                context = mapOf("request" to request),
                exception = e,
            )
            throw HealthConnectorErrorCodeDto.SECURITY_ERROR.toError(
                details = "Permission access denied while processing $request: " +
                    (e.message ?: "Access denied"),
            )
        } catch (e: Exception) {
            HealthConnectorLogger.error(
                tag = TAG,
                operation = "updateRecord",
                phase = "failed",
                message = "Failed to update Health Connect record",
                context = mapOf("request" to request),
                exception = e,
            )
            throw HealthConnectorErrorCodeDto.UNKNOWN.toError(
                details = "Failed to process $request: ${e.message ?: "Unknown error"}",
            )
        }
    }

    /**
     * Performs an aggregation query on health records.
     *
     * @param request Contains data type, aggregation metric, and time range
     * @return AggregateResponseDto with aggregated value and data point count
     *
     * @throws HealthConnectorError with code `INVALID_ARGUMENT` if time range or metric is invalid
     * @throws HealthConnectorError with code `SECURITY_ERROR` if authorization is denied
     * @throws HealthConnectorError with code `UNKNOWN` if an unexpected error occurs
     */
    @Throws(HealthConnectorError::class)
    suspend fun aggregate(request: AggregateRequestDto): AggregateResponseDto {
        HealthConnectorLogger.debug(
            tag = TAG,
            operation = "aggregate",
            phase = "entry",
            message = "Aggregating Health Connect data",
            context = mapOf("request" to request),
        )

        try {
            // Validate time range
            if (request.startTime >= request.endTime) {
                throw IllegalArgumentException(
                    "Invalid time range: startTime must be before endTime. startTime=${request.startTime}, endTime=${request.endTime}",
                )
            }

            // Get aggregation handler for this data type
            val handler = HealthConnectTypeHandlerRegistry.getAggregationHandler(request.dataType)
                ?: throw IllegalArgumentException(
                    "Data type ${request.dataType} does not support aggregation",
                )

            val metric = handler.toAggregateMetric(request)
            val aggregateRequest = AggregateRequest(
                metrics = setOf(metric),
                timeRangeFilter = TimeRangeFilter.between(
                    Instant.ofEpochMilli(request.startTime),
                    Instant.ofEpochMilli(request.endTime),
                ),
            )

            // Execute aggregate request
            val response = client.aggregate(aggregateRequest)

            // Convert result to MeasurementUnitDto using handler
            val valueDto = handler.extractAggregateValue(response, metric)

            val responseDto = AggregateResponseDto(value = valueDto)

            HealthConnectorLogger.info(
                tag = TAG,
                operation = "aggregate",
                phase = "completed",
                message = "Health Connect data aggregated successfully",
                context = mapOf(
                    "request" to request,
                    "response" to responseDto,
                ),
            )

            return responseDto
        } catch (e: UnsupportedOperationException) {
            HealthConnectorLogger.error(
                tag = TAG,
                operation = "aggregate",
                phase = "failed",
                message = "Unsupported aggregation operation",
                context = mapOf("request" to request),
                exception = e,
            )
            throw HealthConnectorErrorCodeDto.UNSUPPORTED_HEALTH_PLATFORM_API.toError(
                details = "Unsupported aggregation metric for ${request.dataType}: " +
                    (e.message ?: "Operation not supported"),
            )
        } catch (e: IllegalStateException) {
            HealthConnectorLogger.error(
                tag = TAG,
                operation = "aggregate",
                phase = "failed",
                message = "Invalid aggregation state - null result from Health Connect",
                context = mapOf("request" to request),
                exception = e,
            )
            throw HealthConnectorErrorCodeDto.INVALID_ARGUMENT.toError(
                details = "Health Connect returned null for aggregation metric. " +
                    "This may indicate no data available for the specified time range " +
                    "or an unexpected API response: ${e.message}",
            )
        } catch (e: IllegalArgumentException) {
            HealthConnectorLogger.error(
                tag = TAG,
                operation = "aggregate",
                phase = "failed",
                message = "Failed to aggregate Health Connect data",
                context = mapOf("request" to request),
                exception = e,
            )
            throw HealthConnectorErrorCodeDto.INVALID_ARGUMENT.toError(details = e.message)
        } catch (e: SecurityException) {
            HealthConnectorLogger.error(
                tag = TAG,
                operation = "aggregate",
                phase = "failed",
                message = "Failed to aggregate Health Connect data",
                context = mapOf("request" to request),
                exception = e,
            )
            throw HealthConnectorErrorCodeDto.SECURITY_ERROR.toError(
                details = "Permission access denied while processing $request: " +
                    (e.message ?: "Access denied"),
            )
        } catch (e: Exception) {
            HealthConnectorLogger.error(
                tag = TAG,
                operation = "aggregate",
                phase = "failed",
                message = "Failed to aggregate Health Connect data",
                context = mapOf("request" to request),
                exception = e,
            )
            throw HealthConnectorErrorCodeDto.UNKNOWN.toError(
                details = "Failed to process $request: ${e.message ?: "Unknown error"}",
            )
        }
    }

    /**
     * Deletes all records of a data type within a time range.
     *
     * @param request Contains data type and time range for deletion
     * @throws HealthConnectorError with code `SECURITY_ERROR` if permission access is denied
     * @throws HealthConnectorError with code `UNKNOWN` if deletion fails
     */
    @Throws(HealthConnectorError::class)
    suspend fun deleteRecordsByTimeRange(request: DeleteRecordsByTimeRangeRequestDto) {
        HealthConnectorLogger.debug(
            tag = TAG,
            operation = "deleteRecords",
            phase = "entry",
            message = "Deleting Health Connect records by time range",
            context = mapOf("request" to request),
        )

        try {
            val recordClass = request.dataType.toHealthConnectRecordClass()
            val timeRangeFilter = TimeRangeFilter.between(
                Instant.ofEpochMilli(request.startTime),
                Instant.ofEpochMilli(request.endTime),
            )

            client.deleteRecords(
                recordType = recordClass,
                timeRangeFilter = timeRangeFilter,
            )

            HealthConnectorLogger.info(
                tag = TAG,
                operation = "deleteRecords",
                phase = "completed",
                message = "Health Connect records deleted successfully",
                context = mapOf("request" to request),
            )
        } catch (e: SecurityException) {
            HealthConnectorLogger.error(
                tag = TAG,
                operation = "deleteRecords",
                phase = "failed",
                message = "Failed to delete Health Connect records",
                context = mapOf("request" to request),
                exception = e,
            )
            throw HealthConnectorErrorCodeDto.SECURITY_ERROR.toError(
                details = "Permission access denied while processing $request: " +
                    (e.message ?: "Access denied"),
            )
        } catch (e: Exception) {
            HealthConnectorLogger.error(
                tag = TAG,
                operation = "deleteRecords",
                phase = "failed",
                message = "Failed to delete Health Connect records",
                context = mapOf("request" to request),
                exception = e,
            )
            throw HealthConnectorErrorCodeDto.UNKNOWN.toError(
                details = "Failed to process $request: ${e.message ?: "Unknown error"}",
            )
        }
    }

    /**
     * Deletes specific records by their IDs.
     *
     * @param request Contains data type and list of record IDs to delete
     * @throws HealthConnectorError with code `SECURITY_ERROR` if permission access is denied
     * @throws HealthConnectorError with code `UNKNOWN` if deletion fails
     */
    @Throws(HealthConnectorError::class)
    suspend fun deleteRecordsByIds(request: DeleteRecordsByIdsRequestDto) {
        HealthConnectorLogger.debug(
            tag = TAG,
            operation = "deleteRecordsByIds",
            phase = "entry",
            message = "Deleting Health Connect records by IDs",
            context = mapOf("request" to request),
        )

        if (request.recordIds.isEmpty()) {
            HealthConnectorLogger.warning(
                tag = TAG,
                operation = "deleteRecordsByIds",
                phase = "completed",
                message = "No records to delete (empty IDs list)",
            )
            return
        }

        try {
            val recordClass = request.dataType.toHealthConnectRecordClass()

            client.deleteRecords(
                recordType = recordClass,
                recordIdsList = request.recordIds,
                clientRecordIdsList = emptyList(),
            )

            HealthConnectorLogger.info(
                tag = TAG,
                operation = "deleteRecordsByIds",
                phase = "completed",
                message = "Health Connect records deleted successfully",
                context = mapOf("request" to request),
            )
        } catch (e: SecurityException) {
            HealthConnectorLogger.error(
                tag = TAG,
                operation = "deleteRecordsByIds",
                phase = "failed",
                message = "Failed to delete Health Connect records by IDs",
                context = mapOf("request" to request),
                exception = e,
            )
            throw HealthConnectorErrorCodeDto.SECURITY_ERROR.toError(
                details = "Permission access denied while processing $request: " +
                    (e.message ?: "Access denied"),
            )
        } catch (e: Exception) {
            HealthConnectorLogger.error(
                tag = TAG,
                operation = "deleteRecordsByIds",
                phase = "failed",
                message = "Failed to delete Health Connect records by IDs",
                context = mapOf("request" to request),
                exception = e,
            )
            throw HealthConnectorErrorCodeDto.UNKNOWN.toError(
                details = "Failed to process $request: ${e.message ?: "Unknown error"}",
            )
        }
    }

    /**
     * Gets all permissions that have been granted to the app.
     *
     * @return [PermissionsRequestResponseDto] containing separate lists for health data and feature permissions
     *         that have been granted
     *
     * @throws HealthConnectorError with code `UNKNOWN` if an unexpected error occurs
     */
    @Throws(HealthConnectorError::class)
    suspend fun getGrantedPermissions(): PermissionsRequestResponseDto {
        HealthConnectorLogger.debug(
            tag = TAG,
            operation = "getGrantedPermissions",
            phase = "entry",
            message = "Getting granted Health Connect permissions",
        )

        try {
            // Get granted permissions from Health Connect SDK
            val grantedPermissionStrings = client.permissionController.getGrantedPermissions()

            // Convert permission strings back to DTOs
            val healthDataPermissions = mutableListOf<HealthDataPermissionRequestResultDto>()
            val featurePermissions =
                mutableListOf<HealthPlatformFeaturePermissionRequestResultDto>()

            for (permissionString in grantedPermissionStrings) {
                if (permissionString.isFeaturePermission) {
                    val featurePermission = permissionString.toHealthPlatformFeatureDto()
                    featurePermissions.add(
                        HealthPlatformFeaturePermissionRequestResultDto(
                            feature = featurePermission,
                            status = PermissionStatusDto.GRANTED,
                        ),
                    )
                } else {
                    val healthDataPermission = permissionString.toDto()
                    healthDataPermissions.add(
                        HealthDataPermissionRequestResultDto(
                            permission = healthDataPermission,
                            status = PermissionStatusDto.GRANTED,
                        ),
                    )
                }
            }

            HealthConnectorLogger.info(
                tag = TAG,
                operation = "getGrantedPermissions",
                phase = "completed",
                message = "Granted Health Connect permissions retrieved",
                context = mapOf(
                    "granted_health_data_permissions" to healthDataPermissions,
                    "granted_feature_permissions" to featurePermissions,
                ),
            )

            return PermissionsRequestResponseDto(
                healthDataPermissionResults = healthDataPermissions,
                featurePermissionResults = featurePermissions,
            )
        } catch (e: Exception) {
            HealthConnectorLogger.error(
                tag = TAG,
                operation = "getGrantedPermissions",
                phase = "failed",
                message = "Failed to get granted Health Connect permissions",
                exception = e,
            )
            throw HealthConnectorErrorCodeDto.UNKNOWN.toError(
                details = "Failed to get granted permissions: ${e.message}",
            )
        }
    }

    /**
     * Revokes all permissions that have been granted to the app.
     *
     * @throws HealthConnectorError with code `UNKNOWN` if an unexpected error occurs
     */
    @Throws(HealthConnectorError::class)
    suspend fun revokeAllPermissions() {
        HealthConnectorLogger.debug(
            tag = TAG,
            operation = "revokeAllPermissions",
            phase = "entry",
            message = "Revoking all Health Connect permissions",
        )

        try {
            // Revoke all permissions using Health Connect SDK
            client.permissionController.revokeAllPermissions()

            HealthConnectorLogger.info(
                tag = TAG,
                operation = "revokeAllPermissions",
                phase = "completed",
                message = "All Health Connect permissions revoked successfully",
            )
        } catch (e: Exception) {
            HealthConnectorLogger.error(
                tag = TAG,
                operation = "revokeAllPermissions",
                phase = "failed",
                message = "Failed to revoke all Health Connect permissions",
                exception = e,
            )
            throw HealthConnectorErrorCodeDto.UNKNOWN.toError(
                details = "Failed to revoke all permissions: ${e.message}",
            )
        }
    }
}
