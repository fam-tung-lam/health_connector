package com.phamtunglam.health_connector_hc_android

import android.content.Context
import androidx.activity.ComponentActivity
import androidx.health.connect.client.HealthConnectClient
import androidx.health.connect.client.records.ActiveCaloriesBurnedRecord
import androidx.health.connect.client.records.BodyFatRecord
import androidx.health.connect.client.records.BodyTemperatureRecord
import androidx.health.connect.client.records.DistanceRecord
import androidx.health.connect.client.records.FloorsClimbedRecord
import androidx.health.connect.client.records.HeartRateRecord
import androidx.health.connect.client.records.HeightRecord
import androidx.health.connect.client.records.HydrationRecord
import androidx.health.connect.client.records.LeanBodyMassRecord
import androidx.health.connect.client.records.Record
import androidx.health.connect.client.records.StepsRecord
import androidx.health.connect.client.records.WeightRecord
import androidx.health.connect.client.records.WheelchairPushesRecord
import androidx.health.connect.client.records.metadata.DataOrigin
import androidx.health.connect.client.request.AggregateRequest
import androidx.health.connect.client.request.ReadRecordsRequest
import androidx.health.connect.client.time.TimeRangeFilter
import androidx.health.connect.client.units.Energy
import androidx.health.connect.client.units.Length
import androidx.health.connect.client.units.Mass
import androidx.health.connect.client.units.Temperature
import androidx.health.connect.client.units.Volume
import com.phamtunglam.health_connector_hc_android.mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.toError
import com.phamtunglam.health_connector_hc_android.mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.mappers.toHealthConnectFeature
import com.phamtunglam.health_connector_hc_android.mappers.toHealthConnectMetric
import com.phamtunglam.health_connector_hc_android.mappers.toHealthConnectRecordClass
import com.phamtunglam.health_connector_hc_android.mappers.toHealthDataPermissionDto
import com.phamtunglam.health_connector_hc_android.mappers.toHealthPlatformFeatureDto
import com.phamtunglam.health_connector_hc_android.mappers.toHealthPlatformFeatureStatusDto
import com.phamtunglam.health_connector_hc_android.mappers.toHealthPlatformStatusDto
import com.phamtunglam.health_connector_hc_android.mappers.toNumericDto
import com.phamtunglam.health_connector_hc_android.pigeon.AggregateRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.AggregateResponseDto
import com.phamtunglam.health_connector_hc_android.pigeon.DeleteRecordsByIdsRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.DeleteRecordsByTimeRangeRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthConnectorError
import com.phamtunglam.health_connector_hc_android.pigeon.HealthConnectorErrorCodeDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataPermissionRequestResultDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataTypeDto
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
        private val TAG = HealthConnectorClient::class.simpleName

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
                    tag = TAG ?: "HealthConnectorClient",
                    operation = "getOrCreate",
                    phase = "failed",
                    message = "Failed to create Health Connect client due to SDK version too low or running in a profile mode",
                    exception = e,
                )
                throw HealthConnectorErrorCodeDto.INSTALLATION_OR_UPDATE_REQUIRED.toError(details = e.message)
            } catch (e: IllegalStateException) {
                HealthConnectorLogger.error(
                    tag = TAG ?: "HealthConnectorClient",
                    operation = "getOrCreate",
                    phase = "failed",
                    message = "Failed to create Health Connect client due to service not available",
                    exception = e,
                )
                throw HealthConnectorErrorCodeDto.HEALTH_PLATFORM_UNAVAILABLE.toError(details = e.message)
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
                tag = TAG ?: "HealthConnectorClient",
                operation = "getHealthPlatformStatus",
                phase = "entry",
                message = "Getting Health Connect SDK status",
            )

            val statusCode = HealthConnectClient.getSdkStatus(context)
            val statusDto = statusCode.toHealthPlatformStatusDto()

            HealthConnectorLogger.info(
                tag = TAG ?: "HealthConnectorClient",
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
     *         permissions/features are not declared in AndroidManifest.xml
     * @throws HealthConnectorError with code `UNKNOWN` if an unexpected error occurs
     */
    @Throws(HealthConnectorError::class)
    suspend fun requestPermissions(
        activity: ComponentActivity,
        request: PermissionsRequestDto,
    ): PermissionsRequestResponseDto {
        HealthConnectorLogger.debug(
            tag = TAG ?: "HealthConnectorClient",
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
            PermissionUtils.validatePermissionsDeclaredInManifest(activity.applicationContext, request)

            val grantedPermissions = PermissionUtils.requestPermissionsFromSystem(activity, request)

            val healthDataResults = PermissionUtils.buildHealthDataPermissionResults(
                request.healthDataPermissions, grantedPermissions
            )
            val featureResults = PermissionUtils.buildFeaturePermissionResults(
                request.featurePermissions, grantedPermissions
            )

            HealthConnectorLogger.info(
                tag = TAG ?: "HealthConnectorClient",
                operation = "requestPermissions",
                phase = "completed",
                message = "Health Connect permissions requested successfully",
                context = mapOf(
                    "granted_health_data_permissions" to healthDataResults,
                    "granted_feature_permissions" to featureResults,
                ),
            )

            return PermissionsRequestResponseDto(
                healthDataPermissionResults = healthDataResults, featurePermissionResults = featureResults
            )
        } catch (e: Exception) {
            HealthConnectorLogger.error(
                tag = TAG ?: "HealthConnectorClient",
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
    fun getFeatureStatus(context: Context, feature: HealthPlatformFeatureDto): HealthPlatformFeatureStatusDto {
        HealthConnectorLogger.debug(
            tag = TAG ?: "HealthConnectorClient",
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
                tag = TAG ?: "HealthConnectorClient",
                operation = "getFeatureStatus",
                phase = "completed",
                message = "Health Connect feature status retrieved",
                context = mapOf(
                    "feature" to feature,
                    "status" to statusDto,
                ),
            )

            return statusDto
        } catch (e: Exception) {
            HealthConnectorLogger.error(
                tag = TAG ?: "HealthConnectorClient",
                operation = "getFeatureStatus",
                phase = "failed",
                message = "Failed to get Health Connect feature status",
                context = mapOf("feature" to feature),
                exception = e,
            )
            throw HealthConnectorErrorCodeDto.UNKNOWN.toError(
                details = "Failed to get feature status for $feature: ${e.message ?: "Unknown error"}",
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
            tag = TAG ?: "HealthConnectorClient",
            operation = "readRecord",
            phase = "entry",
            message = "Reading Health Connect record",
            context = mapOf("request" to request),
        )

        try {
            val recordClass = request.dataType.toHealthConnectRecordClass()
            val response = client.readRecord(recordClass, request.recordId)

            // Convert SDK record to DTO using typed mappers
            val responseDto = when (request.dataType) {
                HealthDataTypeDto.ACTIVE_CALORIES_BURNED -> {
                    val record = response.record as ActiveCaloriesBurnedRecord
                    ReadRecordResponseDto(
                        dataType = HealthDataTypeDto.ACTIVE_CALORIES_BURNED,
                        activeCaloriesBurnedRecord = record.toDto(),
                        bodyFatPercentageRecord = null,
                        bodyTemperatureRecord = null,
                        distanceRecord = null,
                        floorsClimbedRecord = null,
                        heightRecord = null,
                        hydrationRecord = null,
                        leanBodyMassRecord = null,
                        stepsRecord = null,
                        weightRecord = null,
                        wheelchairPushesRecord = null
                    )
                }

                HealthDataTypeDto.DISTANCE -> {
                    val record = response.record as DistanceRecord
                    ReadRecordResponseDto(
                        dataType = HealthDataTypeDto.DISTANCE,
                        activeCaloriesBurnedRecord = null,
                        bodyFatPercentageRecord = null,
                        bodyTemperatureRecord = null,
                        distanceRecord = record.toDto(),
                        floorsClimbedRecord = null,
                        heightRecord = null,
                        hydrationRecord = null,
                        leanBodyMassRecord = null,
                        stepsRecord = null,
                        weightRecord = null,
                        wheelchairPushesRecord = null
                    )
                }

                HealthDataTypeDto.FLOORS_CLIMBED -> {
                    val record = response.record as FloorsClimbedRecord
                    ReadRecordResponseDto(
                        dataType = HealthDataTypeDto.FLOORS_CLIMBED,
                        activeCaloriesBurnedRecord = null,
                        bodyFatPercentageRecord = null,
                        bodyTemperatureRecord = null,
                        distanceRecord = null,
                        floorsClimbedRecord = record.toDto(),
                        heightRecord = null,
                        hydrationRecord = null,
                        leanBodyMassRecord = null,
                        stepsRecord = null,
                        weightRecord = null,
                        wheelchairPushesRecord = null
                    )
                }

                HealthDataTypeDto.STEPS -> {
                    val record = response.record as StepsRecord
                    ReadRecordResponseDto(
                        dataType = HealthDataTypeDto.STEPS,
                        activeCaloriesBurnedRecord = null,
                        bodyFatPercentageRecord = null,
                        bodyTemperatureRecord = null,
                        distanceRecord = null,
                        floorsClimbedRecord = null,
                        heightRecord = null,
                        hydrationRecord = null,
                        leanBodyMassRecord = null,
                        stepsRecord = record.toDto(),
                        weightRecord = null,
                        wheelchairPushesRecord = null
                    )
                }

                HealthDataTypeDto.WEIGHT -> {
                    val record = response.record as WeightRecord
                    ReadRecordResponseDto(
                        dataType = HealthDataTypeDto.WEIGHT,
                        activeCaloriesBurnedRecord = null,
                        bodyFatPercentageRecord = null,
                        bodyTemperatureRecord = null,
                        distanceRecord = null,
                        floorsClimbedRecord = null,
                        heightRecord = null,
                        hydrationRecord = null,
                        leanBodyMassRecord = null,
                        stepsRecord = null,
                        weightRecord = record.toDto(),
                        wheelchairPushesRecord = null
                    )
                }

                HealthDataTypeDto.HEIGHT -> {
                    val record = response.record as HeightRecord
                    ReadRecordResponseDto(
                        dataType = HealthDataTypeDto.HEIGHT,
                        activeCaloriesBurnedRecord = null,
                        bodyFatPercentageRecord = null,
                        bodyTemperatureRecord = null,
                        distanceRecord = null,
                        floorsClimbedRecord = null,
                        heightRecord = record.toDto(),
                        hydrationRecord = null,
                        leanBodyMassRecord = null,
                        stepsRecord = null,
                        weightRecord = null,
                        wheelchairPushesRecord = null
                    )
                }

                HealthDataTypeDto.HYDRATION -> {
                    val record = response.record as HydrationRecord
                    ReadRecordResponseDto(
                        dataType = HealthDataTypeDto.HYDRATION,
                        activeCaloriesBurnedRecord = null,
                        bodyFatPercentageRecord = null,
                        bodyTemperatureRecord = null,
                        distanceRecord = null,
                        floorsClimbedRecord = null,
                        heightRecord = null,
                        hydrationRecord = record.toDto(),
                        leanBodyMassRecord = null,
                        stepsRecord = null,
                        weightRecord = null,
                        wheelchairPushesRecord = null
                    )
                }

                HealthDataTypeDto.LEAN_BODY_MASS -> {
                    val record = response.record as LeanBodyMassRecord
                    ReadRecordResponseDto(
                        dataType = HealthDataTypeDto.LEAN_BODY_MASS,
                        activeCaloriesBurnedRecord = null,
                        bodyFatPercentageRecord = null,
                        bodyTemperatureRecord = null,
                        distanceRecord = null,
                        floorsClimbedRecord = null,
                        heightRecord = null,
                        hydrationRecord = null,
                        leanBodyMassRecord = record.toDto(),
                        stepsRecord = null,
                        weightRecord = null,
                        wheelchairPushesRecord = null
                    )
                }

                HealthDataTypeDto.BODY_FAT_PERCENTAGE -> {
                    val record = response.record as BodyFatRecord
                    ReadRecordResponseDto(
                        dataType = HealthDataTypeDto.BODY_FAT_PERCENTAGE,
                        activeCaloriesBurnedRecord = null,
                        bodyFatPercentageRecord = record.toDto(),
                        bodyTemperatureRecord = null,
                        distanceRecord = null,
                        floorsClimbedRecord = null,
                        heightRecord = null,
                        hydrationRecord = null,
                        leanBodyMassRecord = null,
                        stepsRecord = null,
                        weightRecord = null,
                        wheelchairPushesRecord = null
                    )
                }

                HealthDataTypeDto.BODY_TEMPERATURE -> {
                    val record = response.record as BodyTemperatureRecord
                    ReadRecordResponseDto(
                        dataType = HealthDataTypeDto.BODY_TEMPERATURE,
                        activeCaloriesBurnedRecord = null,
                        bodyFatPercentageRecord = null,
                        bodyTemperatureRecord = record.toDto(),
                        distanceRecord = null,
                        floorsClimbedRecord = null,
                        heightRecord = null,
                        hydrationRecord = null,
                        leanBodyMassRecord = null,
                        stepsRecord = null,
                        weightRecord = null,
                        wheelchairPushesRecord = null
                    )
                }

                HealthDataTypeDto.WHEELCHAIR_PUSHES -> {
                    val record = response.record as WheelchairPushesRecord
                    ReadRecordResponseDto(
                        dataType = HealthDataTypeDto.WHEELCHAIR_PUSHES,
                        activeCaloriesBurnedRecord = null,
                        bodyFatPercentageRecord = null,
                        bodyTemperatureRecord = null,
                        distanceRecord = null,
                        floorsClimbedRecord = null,
                        heightRecord = null,
                        hydrationRecord = null,
                        leanBodyMassRecord = null,
                        stepsRecord = null,
                        weightRecord = null,
                        wheelchairPushesRecord = record.toDto(),
                        heartRateSeriesRecord = null
                    )
                }

                HealthDataTypeDto.HEART_RATE_SERIES_RECORD -> {
                    val record = response.record as HeartRateRecord
                    ReadRecordResponseDto(
                        dataType = HealthDataTypeDto.HEART_RATE_SERIES_RECORD,
                        activeCaloriesBurnedRecord = null,
                        bodyFatPercentageRecord = null,
                        bodyTemperatureRecord = null,
                        distanceRecord = null,
                        floorsClimbedRecord = null,
                        heightRecord = null,
                        hydrationRecord = null,
                        leanBodyMassRecord = null,
                        stepsRecord = null,
                        weightRecord = null,
                        wheelchairPushesRecord = null,
                        heartRateSeriesRecord = record.toDto()
                    )
                }
            }

            HealthConnectorLogger.info(
                tag = TAG ?: "HealthConnectorClient",
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
                tag = TAG ?: "HealthConnectorClient",
                operation = "readRecord",
                phase = "failed",
                message = "Failed to read Health Connect record",
                context = mapOf("request" to request),
                exception = e,
            )
            throw HealthConnectorErrorCodeDto.SECURITY_ERROR.toError(
                details = "Permission access denied while processing $request: ${e.message ?: "Access denied"}",
            )
        } catch (e: Exception) {
            HealthConnectorLogger.error(
                tag = TAG ?: "HealthConnectorClient",
                operation = "readRecord",
                phase = "failed",
                message = "Failed to read Health Connect record",
                context = mapOf("request" to request),
                exception = e,
            )
            throw HealthConnectorErrorCodeDto.UNKNOWN.toError(details = "Failed to process $request: ${e.message ?: "Unknown error"}")
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
            tag = TAG ?: "HealthConnectorClient",
            operation = "readRecords",
            phase = "entry",
            message = "Reading Health Connect records",
            context = mapOf("request" to request),
        )

        try {
            val recordClass = request.dataType.toHealthConnectRecordClass()
            val timeRangeFilter = TimeRangeFilter.between(
                Instant.ofEpochMilli(request.startTime), Instant.ofEpochMilli(request.endTime)
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
                pageToken = request.pageToken
            )

            val response = client.readRecords(readRequest)
            val nextPageToken = if (response.pageToken.isNullOrEmpty()) {
                null
            } else response.pageToken

            // Convert SDK records to DTOs using typed mappers
            val responseDto = when (request.dataType) {
                HealthDataTypeDto.ACTIVE_CALORIES_BURNED -> {
                    val activeCaloriesBurnedRecords = response.records.map { (it as ActiveCaloriesBurnedRecord).toDto() }

                    ReadRecordsResponseDto(
                        dataType = HealthDataTypeDto.ACTIVE_CALORIES_BURNED,
                        activeCaloriesBurnedRecords = activeCaloriesBurnedRecords,
                        bodyFatPercentageRecords = null,
                        bodyTemperatureRecords = null,
                        distanceRecords = null,
                        floorsClimbedRecords = null,
                        heightRecords = null,
                        hydrationRecords = null,
                        leanBodyMassRecords = null,
                        stepsRecords = null,
                        weightRecords = null,
                        wheelchairPushesRecords = null,
                        nextPageToken = nextPageToken
                    )
                }

                HealthDataTypeDto.DISTANCE -> {
                    val distanceRecords = response.records.map { (it as DistanceRecord).toDto() }

                    ReadRecordsResponseDto(
                        dataType = HealthDataTypeDto.DISTANCE,
                        activeCaloriesBurnedRecords = null,
                        bodyFatPercentageRecords = null,
                        bodyTemperatureRecords = null,
                        distanceRecords = distanceRecords,
                        floorsClimbedRecords = null,
                        heightRecords = null,
                        hydrationRecords = null,
                        leanBodyMassRecords = null,
                        stepsRecords = null,
                        weightRecords = null,
                        wheelchairPushesRecords = null,
                        nextPageToken = nextPageToken
                    )
                }

                HealthDataTypeDto.FLOORS_CLIMBED -> {
                    val floorsClimbedRecords = response.records.map { (it as FloorsClimbedRecord).toDto() }

                    ReadRecordsResponseDto(
                        dataType = HealthDataTypeDto.FLOORS_CLIMBED,
                        activeCaloriesBurnedRecords = null,
                        bodyFatPercentageRecords = null,
                        bodyTemperatureRecords = null,
                        distanceRecords = null,
                        floorsClimbedRecords = floorsClimbedRecords,
                        heightRecords = null,
                        hydrationRecords = null,
                        leanBodyMassRecords = null,
                        stepsRecords = null,
                        weightRecords = null,
                        wheelchairPushesRecords = null,
                        nextPageToken = nextPageToken
                    )
                }

                HealthDataTypeDto.STEPS -> {
                    val stepRecords = response.records.map { (it as StepsRecord).toDto() }

                    ReadRecordsResponseDto(
                        dataType = HealthDataTypeDto.STEPS,
                        activeCaloriesBurnedRecords = null,
                        bodyFatPercentageRecords = null,
                        bodyTemperatureRecords = null,
                        distanceRecords = null,
                        floorsClimbedRecords = null,
                        heightRecords = null,
                        hydrationRecords = null,
                        leanBodyMassRecords = null,
                        stepsRecords = stepRecords,
                        weightRecords = null,
                        wheelchairPushesRecords = null,
                        nextPageToken = nextPageToken
                    )
                }

                HealthDataTypeDto.WEIGHT -> {
                    val weightRecords = response.records.map { (it as WeightRecord).toDto() }

                    ReadRecordsResponseDto(
                        dataType = HealthDataTypeDto.WEIGHT,
                        activeCaloriesBurnedRecords = null,
                        bodyFatPercentageRecords = null,
                        bodyTemperatureRecords = null,
                        distanceRecords = null,
                        floorsClimbedRecords = null,
                        heightRecords = null,
                        hydrationRecords = null,
                        leanBodyMassRecords = null,
                        stepsRecords = null,
                        weightRecords = weightRecords,
                        wheelchairPushesRecords = null,
                        nextPageToken = nextPageToken
                    )
                }

                HealthDataTypeDto.HEIGHT -> {
                    val heightRecords = response.records.map { (it as HeightRecord).toDto() }

                    ReadRecordsResponseDto(
                        dataType = HealthDataTypeDto.HEIGHT,
                        activeCaloriesBurnedRecords = null,
                        bodyFatPercentageRecords = null,
                        bodyTemperatureRecords = null,
                        distanceRecords = null,
                        floorsClimbedRecords = null,
                        heightRecords = heightRecords,
                        hydrationRecords = null,
                        leanBodyMassRecords = null,
                        stepsRecords = null,
                        weightRecords = null,
                        wheelchairPushesRecords = null,
                        nextPageToken = nextPageToken
                    )
                }

                HealthDataTypeDto.HYDRATION -> {
                    val hydrationRecords = response.records.map { (it as HydrationRecord).toDto() }

                    ReadRecordsResponseDto(
                        dataType = HealthDataTypeDto.HYDRATION,
                        activeCaloriesBurnedRecords = null,
                        bodyFatPercentageRecords = null,
                        bodyTemperatureRecords = null,
                        distanceRecords = null,
                        floorsClimbedRecords = null,
                        heightRecords = null,
                        hydrationRecords = hydrationRecords,
                        leanBodyMassRecords = null,
                        stepsRecords = null,
                        weightRecords = null,
                        wheelchairPushesRecords = null,
                        nextPageToken = nextPageToken
                    )
                }

                HealthDataTypeDto.LEAN_BODY_MASS -> {
                    val leanBodyMassRecords = response.records.map { (it as LeanBodyMassRecord).toDto() }

                    ReadRecordsResponseDto(
                        dataType = HealthDataTypeDto.LEAN_BODY_MASS,
                        activeCaloriesBurnedRecords = null,
                        bodyFatPercentageRecords = null,
                        bodyTemperatureRecords = null,
                        distanceRecords = null,
                        floorsClimbedRecords = null,
                        heightRecords = null,
                        hydrationRecords = null,
                        leanBodyMassRecords = leanBodyMassRecords,
                        stepsRecords = null,
                        weightRecords = null,
                        wheelchairPushesRecords = null,
                        nextPageToken = nextPageToken
                    )
                }

                HealthDataTypeDto.BODY_FAT_PERCENTAGE -> {
                    val bodyFatPercentageRecords = response.records.map { (it as BodyFatRecord).toDto() }

                    ReadRecordsResponseDto(
                        dataType = HealthDataTypeDto.BODY_FAT_PERCENTAGE,
                        activeCaloriesBurnedRecords = null,
                        bodyFatPercentageRecords = bodyFatPercentageRecords,
                        bodyTemperatureRecords = null,
                        distanceRecords = null,
                        floorsClimbedRecords = null,
                        heightRecords = null,
                        hydrationRecords = null,
                        leanBodyMassRecords = null,
                        stepsRecords = null,
                        weightRecords = null,
                        wheelchairPushesRecords = null,
                        nextPageToken = nextPageToken
                    )
                }

                HealthDataTypeDto.BODY_TEMPERATURE -> {
                    val bodyTemperatureRecords = response.records.map { (it as BodyTemperatureRecord).toDto() }

                    ReadRecordsResponseDto(
                        dataType = HealthDataTypeDto.BODY_TEMPERATURE,
                        activeCaloriesBurnedRecords = null,
                        bodyFatPercentageRecords = null,
                        bodyTemperatureRecords = bodyTemperatureRecords,
                        distanceRecords = null,
                        floorsClimbedRecords = null,
                        heightRecords = null,
                        hydrationRecords = null,
                        leanBodyMassRecords = null,
                        stepsRecords = null,
                        weightRecords = null,
                        wheelchairPushesRecords = null,
                        nextPageToken = nextPageToken
                    )
                }

                HealthDataTypeDto.WHEELCHAIR_PUSHES -> {
                    val wheelchairPushesRecords = response.records.map { (it as WheelchairPushesRecord).toDto() }

                    ReadRecordsResponseDto(
                        dataType = HealthDataTypeDto.WHEELCHAIR_PUSHES,
                        activeCaloriesBurnedRecords = null,
                        bodyFatPercentageRecords = null,
                        bodyTemperatureRecords = null,
                        distanceRecords = null,
                        floorsClimbedRecords = null,
                        heightRecords = null,
                        hydrationRecords = null,
                        leanBodyMassRecords = null,
                        stepsRecords = null,
                        weightRecords = null,
                        wheelchairPushesRecords = wheelchairPushesRecords,
                        heartRateSeriesRecords = null,
                        nextPageToken = nextPageToken
                    )
                }

                HealthDataTypeDto.HEART_RATE_SERIES_RECORD -> {
                    val heartRateSeriesRecords = response.records.map { (it as HeartRateRecord).toDto() }

                    ReadRecordsResponseDto(
                        dataType = HealthDataTypeDto.HEART_RATE_SERIES_RECORD,
                        activeCaloriesBurnedRecords = null,
                        bodyFatPercentageRecords = null,
                        bodyTemperatureRecords = null,
                        distanceRecords = null,
                        floorsClimbedRecords = null,
                        heightRecords = null,
                        hydrationRecords = null,
                        leanBodyMassRecords = null,
                        stepsRecords = null,
                        weightRecords = null,
                        wheelchairPushesRecords = null,
                        heartRateSeriesRecords = heartRateSeriesRecords,
                        nextPageToken = nextPageToken
                    )
                }
            }

            HealthConnectorLogger.info(
                tag = TAG ?: "HealthConnectorClient",
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
                tag = TAG ?: "HealthConnectorClient",
                operation = "readRecords",
                phase = "failed",
                message = "Failed to read Health Connect records",
                context = mapOf("request" to request),
                exception = e,
            )
            throw HealthConnectorErrorCodeDto.SECURITY_ERROR.toError(
                details = "Permission access denied while processing $request: ${e.message ?: "Access denied"}",
            )
        } catch (e: Exception) {
            HealthConnectorLogger.error(
                tag = TAG ?: "HealthConnectorClient",
                operation = "readRecords",
                phase = "failed",
                message = "Failed to read Health Connect records",
                context = mapOf("request" to request),
                exception = e,
            )
            throw HealthConnectorErrorCodeDto.UNKNOWN.toError(details = "Failed to process $request: ${e.message ?: "Unknown error"}")
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
            tag = TAG ?: "HealthConnectorClient",
            operation = "writeRecord",
            phase = "entry",
            message = "Writing Health Connect record",
            context = mapOf("request" to request),
        )

        try {
            // Extract typed record from request DTO
            val record: Record = when (request.dataType) {
                HealthDataTypeDto.ACTIVE_CALORIES_BURNED -> {
                    requireNotNull(request.activeCaloriesBurnedRecord) { "activeCaloriesBurnedRecord must not be null for ACTIVE_CALORIES_BURNED type" }
                    request.activeCaloriesBurnedRecord.toHealthConnect()
                }

                HealthDataTypeDto.DISTANCE -> {
                    requireNotNull(request.distanceRecord) { "distanceRecord must not be null for DISTANCE type" }
                    request.distanceRecord.toHealthConnect()
                }

                HealthDataTypeDto.FLOORS_CLIMBED -> {
                    requireNotNull(request.floorsClimbedRecord) { "floorsClimbedRecord must not be null for FLOORS_CLIMBED type" }
                    request.floorsClimbedRecord.toHealthConnect()
                }

                HealthDataTypeDto.STEPS -> {
                    requireNotNull(request.stepsRecord) { "stepsRecord must not be null for STEPS type" }
                    request.stepsRecord.toHealthConnect()
                }

                HealthDataTypeDto.HEIGHT -> {
                    requireNotNull(request.heightRecord) { "heightRecord must not be null for HEIGHT type" }
                    request.heightRecord.toHealthConnect()
                }

                HealthDataTypeDto.HYDRATION -> {
                    requireNotNull(request.hydrationRecord) { "hydrationRecord must not be null for HYDRATION type" }
                    request.hydrationRecord.toHealthConnect()
                }

                HealthDataTypeDto.BODY_FAT_PERCENTAGE -> {
                    requireNotNull(request.bodyFatPercentageRecord) { "bodyFatPercentageRecord must not be null for BODY_FAT_PERCENTAGE type" }
                    request.bodyFatPercentageRecord.toHealthConnect()
                }

                HealthDataTypeDto.BODY_TEMPERATURE -> {
                    requireNotNull(request.bodyTemperatureRecord) { "bodyTemperatureRecord must not be null for BODY_TEMPERATURE type" }
                    request.bodyTemperatureRecord.toHealthConnect()
                }

                HealthDataTypeDto.WEIGHT -> {
                    requireNotNull(request.weightRecord) { "weightRecord must not be null for WEIGHT type" }
                    request.weightRecord.toHealthConnect()
                }

                HealthDataTypeDto.LEAN_BODY_MASS -> {
                    requireNotNull(request.leanBodyMassRecord) { "leanBodyMassRecord must not be null for LEAN_BODY_MASS type" }
                    request.leanBodyMassRecord.toHealthConnect()
                }

                HealthDataTypeDto.WHEELCHAIR_PUSHES -> {
                    requireNotNull(request.wheelchairPushesRecord) { "wheelchairPushesRecord must not be null for WHEELCHAIR_PUSHES type" }
                    request.wheelchairPushesRecord.toHealthConnect()
                }

                HealthDataTypeDto.HEART_RATE_SERIES_RECORD -> {
                    requireNotNull(request.heartRateSeriesRecord) { "heartRateSeriesRecord must not be null for HEART_RATE_SERIES_RECORD type" }
                    request.heartRateSeriesRecord.toHealthConnect()
                }
            }

            // Write to Health Connect using ACID transaction
            val response = client.insertRecords(listOf(record))
            val recordId = response.recordIdsList.first()

            HealthConnectorLogger.info(
                tag = TAG ?: "HealthConnectorClient",
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
                tag = TAG ?: "HealthConnectorClient",
                operation = "writeRecord",
                phase = "failed",
                message = "Failed to write Health Connect record",
                context = mapOf("request" to request),
                exception = e,
            )
            throw HealthConnectorErrorCodeDto.SECURITY_ERROR.toError(
                details = "Permission access denied while processing $request: ${e.message ?: "Access denied"}",
            )
        } catch (e: Exception) {
            HealthConnectorLogger.error(
                tag = TAG ?: "HealthConnectorClient",
                operation = "writeRecord",
                phase = "failed",
                message = "Failed to write Health Connect record",
                context = mapOf("request" to request),
                exception = e,
            )
            throw HealthConnectorErrorCodeDto.UNKNOWN.toError(details = "Failed to process $request: ${e.message ?: "Unknown error"}")
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
            tag = TAG ?: "HealthConnectorClient",
            operation = "writeRecords",
            phase = "entry",
            message = "Writing Health Connect records",
            context = mapOf("request" to request),
        )

        try {
            // Extract typed records from request DTO
            val records = request.dataTypes.map { dataTypeDto ->
                when (dataTypeDto) {
                    HealthDataTypeDto.ACTIVE_CALORIES_BURNED -> {
                        requireNotNull(request.activeCaloriesBurnedRecords) { "activeCaloriesBurnedRecords must not be null for ACTIVE_CALORIES_BURNED type" }
                        request.activeCaloriesBurnedRecords.map { it.toHealthConnect() }
                    }

                    HealthDataTypeDto.DISTANCE -> {
                        requireNotNull(request.distanceRecords) { "distanceRecords must not be null for DISTANCE type" }
                        request.distanceRecords.map { it.toHealthConnect() }
                    }

                    HealthDataTypeDto.FLOORS_CLIMBED -> {
                        requireNotNull(request.floorsClimbedRecords) { "floorsClimbedRecords must not be null for FLOORS_CLIMBED type" }
                        request.floorsClimbedRecords.map { it.toHealthConnect() }
                    }

                    HealthDataTypeDto.STEPS -> {
                        requireNotNull(request.stepsRecords) { "stepsRecords must not be null for STEPS type" }
                        request.stepsRecords.map { it.toHealthConnect() }
                    }

                    HealthDataTypeDto.HEIGHT -> {
                        requireNotNull(request.heightRecords) { "heightRecords must not be null for HEIGHT type" }
                        request.heightRecords.map { it.toHealthConnect() }
                    }

                    HealthDataTypeDto.HYDRATION -> {
                        requireNotNull(request.hydrationRecords) { "hydrationRecords must not be null for HYDRATION type" }
                        request.hydrationRecords.map { it.toHealthConnect() }
                    }

                    HealthDataTypeDto.BODY_FAT_PERCENTAGE -> {
                        requireNotNull(request.bodyFatPercentageRecords) { "bodyFatPercentageRecords must not be null for BODY_FAT_PERCENTAGE type" }
                        request.bodyFatPercentageRecords.map { it.toHealthConnect() }
                    }

                    HealthDataTypeDto.BODY_TEMPERATURE -> {
                        requireNotNull(request.bodyTemperatureRecords) { "bodyTemperatureRecords must not be null for BODY_TEMPERATURE type" }
                        request.bodyTemperatureRecords.map { it.toHealthConnect() }
                    }

                    HealthDataTypeDto.WEIGHT -> {
                        requireNotNull(request.weightRecords) { "weightRecords must not be null for WEIGHT type" }
                        request.weightRecords.map { it.toHealthConnect() }
                    }

                    HealthDataTypeDto.LEAN_BODY_MASS -> {
                        requireNotNull(request.leanBodyMassRecords) { "leanBodyMassRecords must not be null for LEAN_BODY_MASS type" }
                        request.leanBodyMassRecords.map { it.toHealthConnect() }
                    }

                    HealthDataTypeDto.WHEELCHAIR_PUSHES -> {
                        requireNotNull(request.wheelchairPushesRecords) { "wheelchairPushesRecords must not be null for WHEELCHAIR_PUSHES type" }
                        request.wheelchairPushesRecords.map { it.toHealthConnect() }
                    }

                    HealthDataTypeDto.HEART_RATE_SERIES_RECORD -> {
                        requireNotNull(request.heartRateSeriesRecords) { "heartRateSeriesRecords must not be null for HEART_RATE_SERIES_RECORD type" }
                        request.heartRateSeriesRecords.map { it.toHealthConnect() }
                    }
                }
            }.flatten()

            // Atomic batch write using Health Connect's ACID transaction
            val response = client.insertRecords(records)
            val recordIds = response.recordIdsList

            HealthConnectorLogger.info(
                tag = TAG ?: "HealthConnectorClient",
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
                tag = TAG ?: "HealthConnectorClient",
                operation = "writeRecords",
                phase = "failed",
                message = "Failed to write Health Connect records",
                context = mapOf("request" to request),
                exception = e,
            )
            throw HealthConnectorErrorCodeDto.SECURITY_ERROR.toError(
                details = "Permission access denied while processing $request: ${e.message ?: "Access denied"}",
            )
        } catch (e: Exception) {
            HealthConnectorLogger.error(
                tag = TAG ?: "HealthConnectorClient",
                operation = "writeRecords",
                phase = "failed",
                message = "Failed to write Health Connect records",
                context = mapOf("request" to request),
                exception = e,
            )
            throw HealthConnectorErrorCodeDto.UNKNOWN.toError(details = "Failed to process $request: ${e.message ?: "Unknown error"}")
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
            tag = TAG ?: "HealthConnectorClient",
            operation = "updateRecord",
            phase = "entry",
            message = "Updating Health Connect record",
            context = mapOf("request" to request),
        )

        try {
            // Extract typed record from request DTO
            val record = when (request.dataType) {
                HealthDataTypeDto.ACTIVE_CALORIES_BURNED -> {
                    requireNotNull(request.activeCaloriesBurnedRecord) { "activeCaloriesBurnedRecord must not be null for ACTIVE_CALORIES_BURNED type" }
                    val activeCaloriesBurnedRecord = request.activeCaloriesBurnedRecord
                    // Validate record ID is not empty or "none"
                    if (activeCaloriesBurnedRecord.id.isEmpty() || activeCaloriesBurnedRecord.id == "none") {
                        throw HealthConnectorErrorCodeDto.INVALID_ARGUMENT.toError(
                            details = "Record ID must be a valid existing ID for update operations. Use writeRecord() for new records."
                        )
                    }
                    activeCaloriesBurnedRecord.toHealthConnect()
                }

                HealthDataTypeDto.DISTANCE -> {
                    requireNotNull(request.distanceRecord) { "distanceRecord must not be null for DISTANCE type" }
                    val distanceRecord = request.distanceRecord
                    // Validate record ID is not empty or "none"
                    if (distanceRecord.id.isEmpty() || distanceRecord.id == "none") {
                        throw HealthConnectorErrorCodeDto.INVALID_ARGUMENT.toError(
                            details = "Record ID must be a valid existing ID for update operations. Use writeRecord() for new records."
                        )
                    }
                    distanceRecord.toHealthConnect()
                }

                HealthDataTypeDto.FLOORS_CLIMBED -> {
                    requireNotNull(request.floorsClimbedRecord) { "floorsClimbedRecord must not be null for FLOORS_CLIMBED type" }
                    val floorsClimbedRecord = request.floorsClimbedRecord
                    // Validate record ID is not empty or "none"
                    if (floorsClimbedRecord.id.isEmpty() || floorsClimbedRecord.id == "none") {
                        throw HealthConnectorErrorCodeDto.INVALID_ARGUMENT.toError(
                            details = "Record ID must be a valid existing ID for update operations. Use writeRecord() for new records."
                        )
                    }
                    floorsClimbedRecord.toHealthConnect()
                }

                HealthDataTypeDto.STEPS -> {
                    requireNotNull(request.stepsRecord) { "stepsRecord must not be null for STEPS type" }
                    val stepsRecord = request.stepsRecord
                    // Validate record ID is not empty or "none"
                    if (stepsRecord.id.isEmpty() || stepsRecord.id == "none") {
                        throw HealthConnectorErrorCodeDto.INVALID_ARGUMENT.toError(
                            details = "Record ID must be a valid existing ID for update operations. Use writeRecord() for new records."
                        )
                    }
                    stepsRecord.toHealthConnect()
                }

                HealthDataTypeDto.HEIGHT -> {
                    requireNotNull(request.heightRecord) { "heightRecord must not be null for HEIGHT type" }
                    val heightRecord = request.heightRecord
                    // Validate record ID is not empty or "none"
                    if (heightRecord.id.isEmpty() || heightRecord.id == "none") {
                        throw HealthConnectorErrorCodeDto.INVALID_ARGUMENT.toError(
                            details = "Record ID must be a valid existing ID for update operations. Use writeRecord() for new records."
                        )
                    }
                    heightRecord.toHealthConnect()
                }

                HealthDataTypeDto.HYDRATION -> {
                    requireNotNull(request.hydrationRecord) { "hydrationRecord must not be null for HYDRATION type" }
                    val hydrationRecord = request.hydrationRecord
                    // Validate record ID is not empty or "none"
                    if (hydrationRecord.id.isEmpty() || hydrationRecord.id == "none") {
                        throw HealthConnectorErrorCodeDto.INVALID_ARGUMENT.toError(
                            details = "Record ID must be a valid existing ID for update operations. Use writeRecord() for new records."
                        )
                    }
                    hydrationRecord.toHealthConnect()
                }

                HealthDataTypeDto.BODY_FAT_PERCENTAGE -> {
                    requireNotNull(request.bodyFatPercentageRecord) { "bodyFatPercentageRecord must not be null for BODY_FAT_PERCENTAGE type" }
                    val bodyFatPercentageRecord = request.bodyFatPercentageRecord
                    // Validate record ID is not empty or "none"
                    if (bodyFatPercentageRecord.id.isEmpty() || bodyFatPercentageRecord.id == "none") {
                        throw HealthConnectorErrorCodeDto.INVALID_ARGUMENT.toError(
                            details = "Record ID must be a valid existing ID for update operations. Use writeRecord() for new records."
                        )
                    }
                    bodyFatPercentageRecord.toHealthConnect()
                }

                HealthDataTypeDto.BODY_TEMPERATURE -> {
                    requireNotNull(request.bodyTemperatureRecord) { "bodyTemperatureRecord must not be null for BODY_TEMPERATURE type" }
                    val bodyTemperatureRecord = request.bodyTemperatureRecord
                    // Validate record ID is not empty or "none"
                    if (bodyTemperatureRecord.id.isEmpty() || bodyTemperatureRecord.id == "none") {
                        throw HealthConnectorErrorCodeDto.INVALID_ARGUMENT.toError(
                            details = "Record ID must be a valid existing ID for update operations. Use writeRecord() for new records."
                        )
                    }
                    bodyTemperatureRecord.toHealthConnect()
                }

                HealthDataTypeDto.WEIGHT -> {
                    requireNotNull(request.weightRecord) { "weightRecord must not be null for WEIGHT type" }
                    val weightRecord = request.weightRecord
                    // Validate record ID is not empty or "none"
                    if (weightRecord.id.isEmpty() || weightRecord.id == "none") {
                        throw HealthConnectorErrorCodeDto.INVALID_ARGUMENT.toError(
                            details = "Record ID must be a valid existing ID for update operations. Use writeRecord() for new records."
                        )
                    }
                    weightRecord.toHealthConnect()
                }

                HealthDataTypeDto.LEAN_BODY_MASS -> {
                    requireNotNull(request.leanBodyMassRecord) { "leanBodyMassRecord must not be null for LEAN_BODY_MASS type" }
                    val leanBodyMassRecord = request.leanBodyMassRecord
                    // Validate record ID is not empty or "none"
                    if (leanBodyMassRecord.id.isEmpty() || leanBodyMassRecord.id == "none") {
                        throw HealthConnectorErrorCodeDto.INVALID_ARGUMENT.toError(
                            details = "Record ID must be a valid existing ID for update operations. Use writeRecord() for new records."
                        )
                    }
                    leanBodyMassRecord.toHealthConnect()
                }

                HealthDataTypeDto.WHEELCHAIR_PUSHES -> {
                    requireNotNull(request.wheelchairPushesRecord) { "wheelchairPushesRecord must not be null for WHEELCHAIR_PUSHES type" }
                    val wheelchairPushesRecord = request.wheelchairPushesRecord
                    // Validate record ID is not empty or "none"
                    if (wheelchairPushesRecord.id.isEmpty() || wheelchairPushesRecord.id == "none") {
                        throw HealthConnectorErrorCodeDto.INVALID_ARGUMENT.toError(
                            details = "Record ID must be a valid existing ID for update operations. Use writeRecord() for new records."
                        )
                    }
                    wheelchairPushesRecord.toHealthConnect()
                }

                HealthDataTypeDto.HEART_RATE_SERIES_RECORD -> {
                    requireNotNull(request.heartRateSeriesRecord) { "heartRateSeriesRecord must not be null for HEART_RATE_SERIES_RECORD type" }
                    val heartRateSeriesRecord = request.heartRateSeriesRecord
                    // Validate record ID is not empty or "none"
                    if (heartRateSeriesRecord.id.isEmpty() || heartRateSeriesRecord.id == "none") {
                        throw HealthConnectorErrorCodeDto.INVALID_ARGUMENT.toError(
                            details = "Record ID must be a valid existing ID for update operations. Use writeRecord() for new records."
                        )
                    }
                    heartRateSeriesRecord.toHealthConnect()
                }
            }

            // Update record using Health Connect's updateRecords API
            client.updateRecords(listOf(record))
            val recordId = record.metadata.id

            HealthConnectorLogger.info(
                tag = TAG ?: "HealthConnectorClient",
                operation = "updateRecord",
                phase = "completed",
                message = "Health Connect record updated successfully",
                context = mapOf("request" to request),
            )

            return UpdateRecordResponseDto(recordId = recordId)
        } catch (e: IllegalArgumentException) {
            HealthConnectorLogger.error(
                tag = TAG ?: "HealthConnectorClient",
                operation = "updateRecord",
                phase = "failed",
                message = "Failed to update Health Connect record",
                context = mapOf("request" to request),
                exception = e,
            )
            throw HealthConnectorErrorCodeDto.INVALID_ARGUMENT.toError(
                details = "Invalid record data for update (dataType=${request.dataType}): ${e.message ?: "Invalid argument"}",
            )
        } catch (e: SecurityException) {
            HealthConnectorLogger.error(
                tag = TAG ?: "HealthConnectorClient",
                operation = "updateRecord",
                phase = "failed",
                message = "Failed to update Health Connect record",
                context = mapOf("request" to request),
                exception = e,
            )
            throw HealthConnectorErrorCodeDto.SECURITY_ERROR.toError(
                details = "Permission access denied while processing $request: ${e.message ?: "Access denied"}",
            )
        } catch (e: HealthConnectorError) {
            // Re-throw HealthConnectorError as-is
            throw e
        } catch (e: Exception) {
            HealthConnectorLogger.error(
                tag = TAG ?: "HealthConnectorClient",
                operation = "updateRecord",
                phase = "failed",
                message = "Failed to update Health Connect record",
                context = mapOf("request" to request),
                exception = e,
            )
            throw HealthConnectorErrorCodeDto.UNKNOWN.toError(details = "Failed to process $request: ${e.message ?: "Unknown error"}")
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
            tag = TAG ?: "HealthConnectorClient",
            operation = "aggregate",
            phase = "entry",
            message = "Aggregating Health Connect data",
            context = mapOf("request" to request),
        )

        try {
            // Validate time range
            if (request.startTime >= request.endTime) {
                throw HealthConnectorErrorCodeDto.INVALID_ARGUMENT.toError(
                    details = "Invalid time range: startTime must be before endTime. startTime=${request.startTime}, endTime=${request.endTime}"
                )
            }

            // Convert metric to Health Connect metric and create aggregate request
            val metric = request.aggregationMetric.toHealthConnectMetric(request.dataType)
            val aggregateRequest = AggregateRequest(
                metrics = setOf(metric),
                timeRangeFilter = TimeRangeFilter.between(
                    Instant.ofEpochMilli(request.startTime),
                    Instant.ofEpochMilli(request.endTime)
                ),
            )

            // Execute aggregate request
            val response = client.aggregate(aggregateRequest)

            // Extract aggregated value from response
            // The result may be null if no data is available in the time range
            val aggregatedValue = response[metric]

            // Convert result to DTO based on data type
            val responseDto = when (request.dataType) {
                HealthDataTypeDto.ACTIVE_CALORIES_BURNED -> {
                    val energy = aggregatedValue?.let { it as? Energy }
                    val energyDto = energy?.toDto()
                    AggregateResponseDto(
                        aggregationMetric = request.aggregationMetric,
                        dataType = request.dataType,
                        activeCaloriesBurnedValue = energyDto,
                        bodyTemperatureValue = null,
                        doubleValue = null,
                        hydrationValue = null,
                        leanBodyMassValue = null,
                        massValue = null,
                        lengthValue = null,
                        wheelchairPushesValue = null
                    )
                }

                HealthDataTypeDto.DISTANCE -> {
                    val length = aggregatedValue?.let { it as? Length }
                    val lengthDto = length?.toDto()
                    AggregateResponseDto(
                        aggregationMetric = request.aggregationMetric,
                        dataType = request.dataType,
                        activeCaloriesBurnedValue = null,
                        bodyTemperatureValue = null,
                        doubleValue = null,
                        hydrationValue = null,
                        leanBodyMassValue = null,
                        massValue = null,
                        lengthValue = lengthDto,
                        wheelchairPushesValue = null
                    )
                }

                HealthDataTypeDto.HEIGHT -> {
                    val length = aggregatedValue?.let { it as? Length }
                    val lengthDto = length?.toDto()
                    AggregateResponseDto(
                        aggregationMetric = request.aggregationMetric,
                        dataType = request.dataType,
                        activeCaloriesBurnedValue = null,
                        bodyTemperatureValue = null,
                        doubleValue = null,
                        hydrationValue = null,
                        leanBodyMassValue = null,
                        massValue = null,
                        lengthValue = lengthDto,
                        wheelchairPushesValue = null
                    )
                }

                HealthDataTypeDto.HYDRATION -> {
                    val volume = aggregatedValue?.let { it as? Volume }
                    val volumeDto = volume?.toDto()
                    AggregateResponseDto(
                        aggregationMetric = request.aggregationMetric,
                        dataType = request.dataType,
                        activeCaloriesBurnedValue = null,
                        bodyTemperatureValue = null,
                        doubleValue = null,
                        hydrationValue = volumeDto,
                        leanBodyMassValue = null,
                        massValue = null,
                        lengthValue = null,
                        wheelchairPushesValue = null
                    )
                }

                HealthDataTypeDto.FLOORS_CLIMBED -> {
                    val floorsCount = aggregatedValue?.let { it as? Double } ?: 0.0
                    AggregateResponseDto(
                        aggregationMetric = request.aggregationMetric,
                        dataType = request.dataType,
                        activeCaloriesBurnedValue = null,
                        bodyTemperatureValue = null,
                        doubleValue = floorsCount,
                        hydrationValue = null,
                        leanBodyMassValue = null,
                        massValue = null,
                        lengthValue = null,
                        wheelchairPushesValue = null
                    )
                }

                HealthDataTypeDto.STEPS -> {
                    val stepCount = aggregatedValue?.let { it as? Long } ?: 0L
                    val numericDto = stepCount.toNumericDto()
                    AggregateResponseDto(
                        aggregationMetric = request.aggregationMetric,
                        dataType = request.dataType,
                        activeCaloriesBurnedValue = null,
                        bodyTemperatureValue = null,
                        doubleValue = numericDto.value,
                        hydrationValue = null,
                        leanBodyMassValue = null,
                        massValue = null,
                        lengthValue = null,
                        wheelchairPushesValue = null
                    )
                }

                HealthDataTypeDto.WEIGHT -> {
                    val mass = aggregatedValue?.let { it as? Mass }
                    val massDto = mass?.toDto()
                    AggregateResponseDto(
                        aggregationMetric = request.aggregationMetric,
                        dataType = request.dataType,
                        activeCaloriesBurnedValue = null,
                        bodyTemperatureValue = null,
                        doubleValue = null,
                        hydrationValue = null,
                        leanBodyMassValue = null,
                        massValue = massDto,
                        lengthValue = null,
                        wheelchairPushesValue = null
                    )
                }

                HealthDataTypeDto.LEAN_BODY_MASS -> {
                    val mass = aggregatedValue?.let { it as? Mass }
                    val massDto = mass?.toDto()
                    AggregateResponseDto(
                        aggregationMetric = request.aggregationMetric,
                        dataType = request.dataType,
                        activeCaloriesBurnedValue = null,
                        bodyTemperatureValue = null,
                        doubleValue = null,
                        hydrationValue = null,
                        leanBodyMassValue = massDto,
                        massValue = null,
                        lengthValue = null,
                        wheelchairPushesValue = null
                    )
                }

                HealthDataTypeDto.BODY_TEMPERATURE -> {
                    val temperature = aggregatedValue?.let { it as? Temperature }
                    val temperatureDto = temperature?.toDto()
                    AggregateResponseDto(
                        aggregationMetric = request.aggregationMetric,
                        dataType = request.dataType,
                        activeCaloriesBurnedValue = null,
                        bodyTemperatureValue = temperatureDto,
                        doubleValue = null,
                        hydrationValue = null,
                        leanBodyMassValue = null,
                        massValue = null,
                        lengthValue = null,
                        wheelchairPushesValue = null
                    )
                }

                HealthDataTypeDto.WHEELCHAIR_PUSHES -> {
                    val pushesCount = aggregatedValue?.let { it as? Long } ?: 0L
                    val numericDto = pushesCount.toNumericDto()
                    AggregateResponseDto(
                        aggregationMetric = request.aggregationMetric,
                        dataType = request.dataType,
                        activeCaloriesBurnedValue = null,
                        bodyTemperatureValue = null,
                        doubleValue = null,
                        hydrationValue = null,
                        leanBodyMassValue = null,
                        massValue = null,
                        lengthValue = null,
                        wheelchairPushesValue = numericDto,
                        heartRateBeatsPerMinuteValue = null
                    )
                }

                HealthDataTypeDto.HEART_RATE_SERIES_RECORD -> {
                    val bpmValue = aggregatedValue?.let { it as? Long } ?: 0L
                    val numericDto = bpmValue.toNumericDto()
                    AggregateResponseDto(
                        aggregationMetric = request.aggregationMetric,
                        dataType = request.dataType,
                        activeCaloriesBurnedValue = null,
                        bodyTemperatureValue = null,
                        doubleValue = null,
                        hydrationValue = null,
                        leanBodyMassValue = null,
                        massValue = null,
                        lengthValue = null,
                        wheelchairPushesValue = null,
                        heartRateBeatsPerMinuteValue = numericDto
                    )
                }

                HealthDataTypeDto.BODY_FAT_PERCENTAGE -> throw IllegalArgumentException(
                    "Body fat percentage data type does not support aggregation"
                )
            }

            HealthConnectorLogger.info(
                tag = TAG ?: "HealthConnectorClient",
                operation = "aggregate",
                phase = "completed",
                message = "Health Connect data aggregated successfully",
                context = mapOf(
                    "request" to request,
                    "response" to responseDto,
                ),
            )

            return responseDto
        } catch (e: IllegalArgumentException) {
            HealthConnectorLogger.error(
                tag = TAG ?: "HealthConnectorClient",
                operation = "aggregate",
                phase = "failed",
                message = "Failed to aggregate Health Connect data",
                context = mapOf("request" to request),
                exception = e,
            )
            throw HealthConnectorErrorCodeDto.INVALID_ARGUMENT.toError(details = e.message)
        } catch (e: SecurityException) {
            HealthConnectorLogger.error(
                tag = TAG ?: "HealthConnectorClient",
                operation = "aggregate",
                phase = "failed",
                message = "Failed to aggregate Health Connect data",
                context = mapOf("request" to request),
                exception = e,
            )
            throw HealthConnectorErrorCodeDto.SECURITY_ERROR.toError(
                details = "Permission access denied while processing $request: ${e.message ?: "Access denied"}",
            )
        } catch (e: HealthConnectorError) {
            // Re-throw HealthConnectorError as-is
            throw e
        } catch (e: Exception) {
            HealthConnectorLogger.error(
                tag = TAG ?: "HealthConnectorClient",
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
            tag = TAG ?: "HealthConnectorClient",
            operation = "deleteRecords",
            phase = "entry",
            message = "Deleting Health Connect records by time range",
            context = mapOf("request" to request),
        )

        try {
            val recordClass = request.dataType.toHealthConnectRecordClass()
            val timeRangeFilter = TimeRangeFilter.between(
                Instant.ofEpochMilli(request.startTime),
                Instant.ofEpochMilli(request.endTime)
            )

            client.deleteRecords(
                recordType = recordClass,
                timeRangeFilter = timeRangeFilter,
            )

            HealthConnectorLogger.info(
                tag = TAG ?: "HealthConnectorClient",
                operation = "deleteRecords",
                phase = "completed",
                message = "Health Connect records deleted successfully",
                context = mapOf("request" to request),
            )
        } catch (e: SecurityException) {
            HealthConnectorLogger.error(
                tag = TAG ?: "HealthConnectorClient",
                operation = "deleteRecords",
                phase = "failed",
                message = "Failed to delete Health Connect records",
                context = mapOf("request" to request),
                exception = e,
            )
            throw HealthConnectorErrorCodeDto.SECURITY_ERROR.toError(
                details = "Permission access denied while processing $request: ${e.message ?: "Access denied"}",
            )
        } catch (e: Exception) {
            HealthConnectorLogger.error(
                tag = TAG ?: "HealthConnectorClient",
                operation = "deleteRecords",
                phase = "failed",
                message = "Failed to delete Health Connect records",
                context = mapOf("request" to request),
                exception = e,
            )
            throw HealthConnectorErrorCodeDto.UNKNOWN.toError(details = "Failed to process $request: ${e.message ?: "Unknown error"}")
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
            tag = TAG ?: "HealthConnectorClient",
            operation = "deleteRecordsByIds",
            phase = "entry",
            message = "Deleting Health Connect records by IDs",
            context = mapOf("request" to request),
        )

        if (request.recordIds.isEmpty()) {
            HealthConnectorLogger.warning(
                tag = TAG ?: "HealthConnectorClient",
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
                tag = TAG ?: "HealthConnectorClient",
                operation = "deleteRecordsByIds",
                phase = "completed",
                message = "Health Connect records deleted successfully",
                context = mapOf("request" to request),
            )
        } catch (e: SecurityException) {
            HealthConnectorLogger.error(
                tag = TAG ?: "HealthConnectorClient",
                operation = "deleteRecordsByIds",
                phase = "failed",
                message = "Failed to delete Health Connect records by IDs",
                context = mapOf("request" to request),
                exception = e,
            )
            throw HealthConnectorErrorCodeDto.SECURITY_ERROR.toError(
                details = "Permission access denied while processing $request: ${e.message ?: "Access denied"}",
            )
        } catch (e: Exception) {
            HealthConnectorLogger.error(
                tag = TAG ?: "HealthConnectorClient",
                operation = "deleteRecordsByIds",
                phase = "failed",
                message = "Failed to delete Health Connect records by IDs",
                context = mapOf("request" to request),
                exception = e,
            )
            throw HealthConnectorErrorCodeDto.UNKNOWN.toError(details = "Failed to process $request: ${e.message ?: "Unknown error"}")
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
            tag = TAG ?: "HealthConnectorClient",
            operation = "getGrantedPermissions",
            phase = "entry",
            message = "Getting granted Health Connect permissions",
        )

        try {
            // Get granted permissions from Health Connect SDK
            val grantedPermissionStrings = client.permissionController.getGrantedPermissions()

            // Convert permission strings back to DTOs
            val healthDataPermissions = mutableListOf<HealthDataPermissionRequestResultDto>()
            val featurePermissions = mutableListOf<HealthPlatformFeaturePermissionRequestResultDto>()

            for (permissionString in grantedPermissionStrings) {
                // Try to parse as health data permission
                val healthDataPermission = permissionString.toHealthDataPermissionDto()
                if (healthDataPermission != null) {
                    healthDataPermissions.add(
                        HealthDataPermissionRequestResultDto(
                            permission = healthDataPermission,
                            status = PermissionStatusDto.GRANTED
                        )
                    )
                    continue
                }

                // Try to parse as feature permission
                val featurePermission = permissionString.toHealthPlatformFeatureDto()
                if (featurePermission != null) {
                    featurePermissions.add(
                        HealthPlatformFeaturePermissionRequestResultDto(
                            feature = featurePermission,
                            status = PermissionStatusDto.GRANTED
                        )
                    )
                }
            }

            HealthConnectorLogger.info(
                tag = TAG ?: "HealthConnectorClient",
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
                featurePermissionResults = featurePermissions
            )
        } catch (e: Exception) {
            HealthConnectorLogger.error(
                tag = TAG ?: "HealthConnectorClient",
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
            tag = TAG ?: "HealthConnectorClient",
            operation = "revokeAllPermissions",
            phase = "entry",
            message = "Revoking all Health Connect permissions",
        )

        try {
            // Revoke all permissions using Health Connect SDK
            client.permissionController.revokeAllPermissions()

            HealthConnectorLogger.info(
                tag = TAG ?: "HealthConnectorClient",
                operation = "revokeAllPermissions",
                phase = "completed",
                message = "All Health Connect permissions revoked successfully",
            )
        } catch (e: Exception) {
            HealthConnectorLogger.error(
                tag = TAG ?: "HealthConnectorClient",
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

