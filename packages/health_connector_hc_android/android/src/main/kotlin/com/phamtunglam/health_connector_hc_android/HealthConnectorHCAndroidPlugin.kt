package com.phamtunglam.health_connector_hc_android

import android.content.Context
import androidx.activity.ComponentActivity
import com.phamtunglam.health_connector_hc_android.logger.HealthConnectorLogger
import com.phamtunglam.health_connector_hc_android.logger.TAG
import com.phamtunglam.health_connector_hc_android.mappers.aggregationMetric
import com.phamtunglam.health_connector_hc_android.mappers.dataType
import com.phamtunglam.health_connector_hc_android.mappers.endTime
import com.phamtunglam.health_connector_hc_android.mappers.startTime
import com.phamtunglam.health_connector_hc_android.mappers.toError
import com.phamtunglam.health_connector_hc_android.pigeon.AggregateRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.AggregateResponseDto
import com.phamtunglam.health_connector_hc_android.pigeon.DeleteRecordsByIdsRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.DeleteRecordsByTimeRangeRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.DeleteRecordsRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthConnectorConfigDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthConnectorErrorCodeDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthConnectorErrorDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthConnectorHCAndroidApi
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
import com.phamtunglam.health_connector_hc_android.pigeon.UpdateRecordsRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.WriteRecordRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.WriteRecordResponseDto
import com.phamtunglam.health_connector_hc_android.pigeon.WriteRecordsRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.WriteRecordsResponseDto
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import kotlinx.coroutines.CoroutineExceptionHandler
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.cancel
import kotlinx.coroutines.launch
import kotlinx.coroutines.sync.Mutex
import kotlinx.coroutines.sync.withLock
import kotlinx.coroutines.withContext

/**
 * Flutter plugin for accessing Health Connect on Android devices.
 *
 * @see HealthConnectorHCAndroidApi
 * @see HealthConnectorClient
 */
class HealthConnectorHCAndroidPlugin :
    FlutterPlugin,
    ActivityAware,
    HealthConnectorHCAndroidApi {

    /**
     * Application context used for accessing Health Connect services.
     * Initialized in [onAttachedToEngine] and persists throughout the plugin lifecycle.
     */
    private lateinit var context: Context

    /**
     * The current Flutter activity, required for operations that need activity context.
     * This is nullable because the activity may be detached during configuration changes
     * or when the app is in the background.
     *
     * @see onAttachedToActivity
     * @see onDetachedFromActivity
     */
    private var activity: ComponentActivity? = null

    /**
     * Cached instance of [HealthConnectorClient].
     * Created lazily on first use and reused for subsequent operations.
     * Cleared when the engine is detached.
     */
    private lateinit var client: HealthConnectorClient

    /**
     * Mutex to ensure thread-safe initialization of [client].
     * Prevents race conditions when multiple concurrent calls to [initialize] attempt
     * to create the client simultaneously.
     */
    private val clientInitMutex: Mutex = Mutex()

    /**
     * Coroutine scope for executing asynchronous Health Connect operations.
     * Uses [Dispatchers.IO] for background execution and [SupervisorJob] to prevent
     * cancellation of sibling coroutines when one fails.
     */
    private val scope: CoroutineScope = CoroutineScope(
        SupervisorJob() + Dispatchers.IO + coroutineExceptionHandler,
    )

    private companion object {
        /**
         * Global exception handler for coroutines to catch and log unhandled exceptions.
         */
        val coroutineExceptionHandler = CoroutineExceptionHandler { _, e ->
            HealthConnectorLogger.warning(
                tag = TAG,
                operation = "coroutine_exception_handler",
                message = "Unhandled exception in coroutine scope",
                exception = e,
            )
        }
    }

    /**
     * Called when the plugin is attached to a Flutter engine.
     *
     * @param flutterPluginBinding Provides access to the Flutter engine and application context
     */
    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        context = flutterPluginBinding.applicationContext
        HealthConnectorHCAndroidApi.setUp(flutterPluginBinding.binaryMessenger, this)
    }

    /**
     * Called when the plugin is detached from the Flutter engine.
     *
     * @param binding The Flutter plugin binding being detached
     */
    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        HealthConnectorHCAndroidApi.setUp(binding.binaryMessenger, null)
        scope.cancel()
    }

    /**
     * Called when the plugin is attached to a Flutter activity.
     *
     * Validates that the activity is a [ComponentActivity] (required for Health Connect permissions request)
     * and stores it for later use in permission requests.
     *
     * @param binding Provides access to the Flutter activity
     * @throws IllegalStateException if the activity is not a [ComponentActivity]
     */
    @Throws(IllegalStateException::class)
    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        val activityInstance = binding.activity
        check(activityInstance is ComponentActivity) {
            "Activity must be a ComponentActivity."
        }
        activity = activityInstance
    }

    /**
     * Called when the activity is detached for configuration changes (e.g., screen rotation).
     *
     * Temporarily clears the activity reference. The activity will be reattached via
     * [onReattachedToActivityForConfigChanges] after the configuration change completes.
     */
    override fun onDetachedFromActivityForConfigChanges() {
        activity = null
    }

    /**
     * Called when the activity is reattached after configuration changes.
     *
     * Validates and restores the activity reference after configuration changes like screen rotation.
     *
     * @param binding Provides access to the reattached Flutter activity
     * @throws IllegalStateException if the activity is not a [ComponentActivity]
     */
    @Throws(IllegalStateException::class)
    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        val activityInstance = binding.activity
        check(activityInstance is ComponentActivity) {
            "Activity must be a ComponentActivity"
        }
        activity = activityInstance
    }

    /**
     * Called when the activity is detached from the plugin.
     *
     * This is a permanent detachment (not due to configuration changes).
     * Clears the activity reference to prevent memory leaks.
     */
    override fun onDetachedFromActivity() {
        activity = null
    }

    /**
     * Initializes the Health Connector client with the provided configuration.
     *
     * This method must be called before any other Health Connector operations
     * to properly configure the native platform code, including logger settings.
     *
     * @param config Configuration settings for the Health Connector
     * @param callback Called with a [Result] indicating success or failure
     */
    override fun initialize(config: HealthConnectorConfigDto, callback: (Result<Unit>) -> Unit) {
        scope.launch {
            HealthConnectorLogger.debug(
                tag = TAG,
                operation = "create",
                message = "Creating ${HealthConnectorClient.TAG}...",
                context = mapOf("is_logger_enabled" to config.isLoggerEnabled.toString()),
            )

            try {
                clientInitMutex.withLock {
                    if (!::client.isInitialized) {
                        client = HealthConnectorClient.getOrCreate(context)
                    }
                }

                HealthConnectorLogger.setEnabled(config.isLoggerEnabled)

                HealthConnectorLogger.debug(
                    tag = TAG,
                    operation = "create",
                    message = "${HealthConnectorClient.TAG} initialized successfully",
                    context = mapOf("is_logger_enabled" to config.isLoggerEnabled.toString()),
                )

                complete(callback, Result.success(Unit))
            } catch (e: HealthConnectorErrorDto) {
                HealthConnectorLogger.error(
                    tag = TAG,
                    operation = "create",
                    message = "Failed to create ${HealthConnectorClient.TAG}",
                    context = mapOf(
                        "error_code" to e.code,
                        "error_message" to (e.message ?: "Unknown error"),
                    ),
                    exception = e,
                )

                complete(callback, Result.failure(e))
            } catch (e: kotlinx.coroutines.CancellationException) {
                throw e
            } catch (e: Exception) {
                HealthConnectorLogger.error(
                    tag = TAG,
                    operation = "create",
                    message = "Unexpected error during initialization",
                    context = mapOf("is_logger_enabled" to config.isLoggerEnabled.toString()),
                    exception = e,
                )
                complete(
                    callback,
                    Result.failure(
                        HealthConnectorErrorCodeDto.UNKNOWN.toError(
                            "Unexpected error: ${e.message ?: "Unknown error"}",
                        ),
                    ),
                )
            }
        }
    }

    /**
     * Gets the current status of the Health Connect platform on the device.
     *
     * @param callback Called with a [Result] containing the platform status
     */
    override fun getHealthPlatformStatus(callback: (Result<HealthPlatformStatusDto>) -> Unit) {
        scope.launch {
            try {
                val statusDto = HealthConnectorClient.getHealthPlatformStatus(context)

                complete(callback, Result.success(statusDto))
            } catch (e: kotlinx.coroutines.CancellationException) {
                throw e
            } catch (e: Exception) {
                HealthConnectorLogger.error(
                    tag = TAG,
                    operation = "get_health_platform_status",
                    message = "Unexpected error while getting platform status",
                    exception = e,
                )
                complete(
                    callback,
                    Result.failure(
                        HealthConnectorErrorCodeDto.UNKNOWN.toError(
                            "Unexpected error: ${e.message ?: "Unknown error"}",
                        ),
                    ),
                )
            }
        }
    }

    /**
     * Requests permissions from the user.
     *
     * Requires an active [ComponentActivity].
     *
     * @param request The permissions request containing both health data and feature permissions
     * @param callback Called with a [Result] containing the permission request response
     */
    @Throws(HealthConnectorErrorDto::class)
    override fun requestPermissions(
        request: PermissionRequestsDto,
        callback: (Result<PermissionRequestsResponseDto>) -> Unit,
    ) {
        scope.launch {
            try {
                val currentActivity = activity
                if (currentActivity == null) {
                    HealthConnectorLogger.error(
                        tag = TAG,
                        operation = "request_permissions",
                        message = "Activity is null. " +
                            "Cannot request permissions without activity context",
                    )

                    complete(
                        callback,
                        Result.failure(
                            HealthConnectorErrorCodeDto.INVALID_CONFIGURATION.toError(
                                "Activity is unavailable. " +
                                    "The app may be in the background or " +
                                    "activity has been destroyed.",
                            ),
                        ),
                    )

                    return@launch
                }

                val responseDto = client.requestPermissions(
                    activity = currentActivity,
                    request = request,
                )

                complete(callback, Result.success(responseDto))
            } catch (e: HealthConnectorErrorDto) {
                HealthConnectorLogger.error(
                    tag = TAG,
                    operation = "request_permissions",
                    message = "Failed to request Health Connect permissions",
                    context = mapOf(
                        "error_code" to e.code,
                        "error_message" to (e.message ?: "Unknown error"),
                    ),
                    exception = e,
                )

                complete(callback, Result.failure(e))
            } catch (e: kotlinx.coroutines.CancellationException) {
                throw e
            } catch (e: Exception) {
                HealthConnectorLogger.error(
                    tag = TAG,
                    operation = "request_permissions",
                    message = "Unexpected error while requesting permissions",
                    context = mapOf("requested_permissions" to request.permissionRequests),
                    exception = e,
                )
                complete(
                    callback,
                    Result.failure(
                        HealthConnectorErrorCodeDto.UNKNOWN.toError(
                            "Unexpected error: ${e.message ?: "Unknown error"}",
                        ),
                    ),
                )
            }
        }
    }

    /**
     * Gets all permissions that have been granted to the app.
     *
     * @param callback Called with a [Result] containing the permission response
     */
    @Throws(HealthConnectorErrorDto::class)
    override fun getGrantedPermissions(callback: (Result<PermissionRequestsResponseDto>) -> Unit) {
        scope.launch {
            try {
                val responseDto = this@HealthConnectorHCAndroidPlugin.client.getGrantedPermissions()

                complete(callback, Result.success(responseDto))
            } catch (e: HealthConnectorErrorDto) {
                HealthConnectorLogger.error(
                    tag = TAG,
                    operation = "get_granted_permissions",

                    message = "Failed to get granted Health Connect permissions",
                    context = mapOf(
                        "error_code" to e.code,
                        "error_message" to (e.message ?: "Unknown error"),
                    ),
                    exception = e,
                )

                complete(callback, Result.failure(e))
            } catch (e: kotlinx.coroutines.CancellationException) {
                throw e
            } catch (e: Exception) {
                HealthConnectorLogger.error(
                    tag = TAG,
                    operation = "get_granted_permissions",
                    message = "Unexpected error while getting granted permissions",
                    exception = e,
                )
                complete(
                    callback,
                    Result.failure(
                        HealthConnectorErrorCodeDto.UNKNOWN.toError(
                            "Unexpected error: ${e.message ?: "Unknown error"}",
                        ),
                    ),
                )
            }
        }
    }

    /**
     * Revokes all permissions that have been granted to the app.
     *
     * @param callback Called with a [Result] containing the operation result
     */
    @Throws(HealthConnectorErrorDto::class)
    override fun revokeAllPermissions(callback: (Result<Unit>) -> Unit) {
        scope.launch {
            try {
                this@HealthConnectorHCAndroidPlugin.client.revokeAllPermissions()

                complete(callback, Result.success(Unit))
            } catch (e: HealthConnectorErrorDto) {
                HealthConnectorLogger.error(
                    tag = TAG,
                    operation = "revoke_all_permissions",

                    message = "Failed to revoke all Health Connect permissions",
                    context = mapOf(
                        "error_code" to e.code,
                        "error_message" to (e.message ?: "Unknown error"),
                    ),
                    exception = e,
                )

                complete(callback, Result.failure(e))
            } catch (e: kotlinx.coroutines.CancellationException) {
                throw e
            } catch (e: Exception) {
                HealthConnectorLogger.error(
                    tag = TAG,
                    operation = "revoke_all_permissions",
                    message = "Unexpected error while revoking all permissions",
                    exception = e,
                )
                complete(
                    callback,
                    Result.failure(
                        HealthConnectorErrorCodeDto.UNKNOWN.toError(
                            "Unexpected error: ${e.message ?: "Unknown error"}",
                        ),
                    ),
                )
            }
        }
    }

    /**
     * Gets the status of a specific feature on the current platform.
     *
     * @param feature The feature to check availability for
     * @param callback Called with a [Result] containing the feature status
     */
    @Throws(HealthConnectorErrorDto::class)
    override fun getFeatureStatus(
        feature: HealthPlatformFeatureDto,
        callback: (Result<HealthPlatformFeatureStatusDto>) -> Unit,
    ) {
        scope.launch {
            try {
                val featureStatusDto = client.getFeatureStatus(context, feature)

                complete(callback, Result.success(featureStatusDto))
            } catch (e: HealthConnectorErrorDto) {
                HealthConnectorLogger.error(
                    tag = TAG,
                    operation = "get_feature_status",

                    message = "Failed to get Health Connect feature status",
                    context = mapOf(
                        "feature" to feature.toString(),
                        "error_code" to e.code,
                        "error_message" to (e.message ?: "Unknown error"),
                    ),
                    exception = e,
                )

                complete(callback, Result.failure(e))
            } catch (e: kotlinx.coroutines.CancellationException) {
                throw e
            } catch (e: Exception) {
                HealthConnectorLogger.error(
                    tag = TAG,
                    operation = "get_feature_status",
                    message = "Unexpected error while getting feature status",
                    context = mapOf("feature" to feature.toString()),
                    exception = e,
                )
                complete(
                    callback,
                    Result.failure(
                        HealthConnectorErrorCodeDto.UNKNOWN.toError(
                            "Unexpected error: ${e.message ?: "Unknown error"}",
                        ),
                    ),
                )
            }
        }
    }

    /**
     * Reads a single health record by ID.
     *
     * @param request Contains the data type and record ID to read
     * @param callback Called with a [Result] containing the read record response or null if not found
     */
    @Throws(HealthConnectorErrorDto::class)
    override fun readRecord(
        request: ReadRecordRequestDto,
        callback: (Result<ReadRecordResponseDto?>) -> Unit,
    ) {
        scope.launch {
            try {
                val result = this@HealthConnectorHCAndroidPlugin.client.readRecord(request)

                complete(callback, Result.success(result))
            } catch (e: HealthConnectorErrorDto) {
                HealthConnectorLogger.error(
                    tag = TAG,
                    operation = "read_record",

                    message = "Failed to read Health Connect record",
                    context = mapOf(
                        "data_type" to request.dataType.toString(),
                        "record_id" to request.recordId,
                        "error_code" to e.code,
                        "error_message" to (e.message ?: "Unknown error"),
                    ),
                    exception = e,
                )

                complete(callback, Result.failure(e))
            } catch (e: kotlinx.coroutines.CancellationException) {
                throw e
            } catch (e: Exception) {
                HealthConnectorLogger.error(
                    tag = TAG,
                    operation = "read_record",
                    message = "Unexpected error escaped from handler",
                    context = mapOf("request" to request),
                    exception = e,
                )
                complete(
                    callback,
                    Result.failure(
                        HealthConnectorErrorCodeDto.UNKNOWN.toError(
                            "Unexpected error: ${e.message ?: "Unknown error"}",
                        ),
                    ),
                )
            }
        }
    }

    /**
     * Reads multiple health records within a time range.
     *
     * @param request Contains data type, time range, page size, and optional page token
     * @param callback Called with a [Result] containing the read records response
     */
    @Throws(HealthConnectorErrorDto::class)
    override fun readRecords(
        request: ReadRecordsRequestDto,
        callback: (Result<ReadRecordsResponseDto>) -> Unit,
    ) {
        scope.launch {
            try {
                val result = this@HealthConnectorHCAndroidPlugin.client.readRecords(request)

                complete(callback, Result.success(result))
            } catch (e: HealthConnectorErrorDto) {
                HealthConnectorLogger.error(
                    tag = TAG,
                    operation = "read_records",

                    message = "Failed to read Health Connect records",
                    context = mapOf(
                        "data_type" to request.dataType.toString(),
                        "start_time" to request.startTime,
                        "end_time" to request.endTime,
                        "page_size" to request.pageSize,
                        "error_code" to e.code,
                        "error_message" to (e.message ?: "Unknown error"),
                    ),
                    exception = e,
                )

                complete(callback, Result.failure(e))
            } catch (e: kotlinx.coroutines.CancellationException) {
                throw e
            } catch (e: Exception) {
                HealthConnectorLogger.error(
                    tag = TAG,
                    operation = "read_records",
                    message = "Unexpected error escaped from handler",
                    context = mapOf("request" to request),
                    exception = e,
                )
                complete(
                    callback,
                    Result.failure(
                        HealthConnectorErrorCodeDto.UNKNOWN.toError(
                            "Unexpected error: ${e.message ?: "Unknown error"}",
                        ),
                    ),
                )
            }
        }
    }

    /**
     * Writes a single health record.
     *
     * @param request Contains the data type and the typed record to write
     * @param callback Called with a [Result] containing the write record response
     */
    @Throws(HealthConnectorErrorDto::class)
    override fun writeRecord(
        request: WriteRecordRequestDto,
        callback: (Result<WriteRecordResponseDto>) -> Unit,
    ) {
        scope.launch {
            try {
                val result = this@HealthConnectorHCAndroidPlugin.client.writeRecord(request)

                complete(callback, Result.success(result))
            } catch (e: HealthConnectorErrorDto) {
                HealthConnectorLogger.error(
                    tag = TAG,
                    operation = "write_record",

                    message = "Failed to write Health Connect record",
                    context = mapOf(
                        "error_code" to e.code,
                        "error_message" to (e.message ?: "Unknown error"),
                    ),
                    exception = e,
                )

                complete(callback, Result.failure(e))
            } catch (e: kotlinx.coroutines.CancellationException) {
                throw e
            } catch (e: Exception) {
                HealthConnectorLogger.error(
                    tag = TAG,
                    operation = "write_record",
                    message = "Unexpected error escaped from handler",
                    context = mapOf("request" to request),
                    exception = e,
                )
                complete(
                    callback,
                    Result.failure(
                        HealthConnectorErrorCodeDto.UNKNOWN.toError(
                            "Unexpected error: ${e.message ?: "Unknown error"}",
                        ),
                    ),
                )
            }
        }
    }

    /**
     * Writes multiple health records atomically.
     *
     * @param request Contains the data type and the list of typed records to write
     * @param callback Called with a [Result] containing the write records response
     */
    @Throws(HealthConnectorErrorDto::class)
    override fun writeRecords(
        request: WriteRecordsRequestDto,
        callback: (Result<WriteRecordsResponseDto>) -> Unit,
    ) {
        scope.launch {
            try {
                val result = this@HealthConnectorHCAndroidPlugin.client.writeRecords(request)

                complete(callback, Result.success(result))
            } catch (e: HealthConnectorErrorDto) {
                HealthConnectorLogger.error(
                    tag = TAG,
                    operation = "write_records",

                    message = "Failed to write Health Connect records",
                    context = mapOf(
                        "records_count" to request.records.size,
                        "error_code" to e.code,
                        "error_message" to (e.message ?: "Unknown error"),
                    ),
                    exception = e,
                )

                complete(callback, Result.failure(e))
            } catch (e: kotlinx.coroutines.CancellationException) {
                throw e
            } catch (e: Exception) {
                HealthConnectorLogger.error(
                    tag = TAG,
                    operation = "write_records",
                    message = "Unexpected error escaped from handler",
                    context = mapOf("request" to request),
                    exception = e,
                )
                complete(
                    callback,
                    Result.failure(
                        HealthConnectorErrorCodeDto.UNKNOWN.toError(
                            "Unexpected error: ${e.message ?: "Unknown error"}",
                        ),
                    ),
                )
            }
        }
    }

    /**
     * Updates a single health record.
     *
     * @param request Contains the data type and the typed record to update
     * @param callback Called with a [Result] indicating success or failure
     */
    @Throws(HealthConnectorErrorDto::class)
    override fun updateRecord(request: UpdateRecordRequestDto, callback: (Result<Unit>) -> Unit) {
        scope.launch {
            try {
                this@HealthConnectorHCAndroidPlugin.client.updateRecord(request)

                complete(callback, Result.success(Unit))
            } catch (e: HealthConnectorErrorDto) {
                HealthConnectorLogger.error(
                    tag = TAG,
                    operation = "update_record",

                    message = "Failed to update Health Connect record",
                    context = mapOf(
                        "error_code" to e.code,
                        "error_message" to (e.message ?: "Unknown error"),
                    ),
                    exception = e,
                )

                complete(callback, Result.failure(e))
            } catch (e: kotlinx.coroutines.CancellationException) {
                throw e
            } catch (e: Exception) {
                HealthConnectorLogger.error(
                    tag = TAG,
                    operation = "update_record",
                    message = "Unexpected error escaped from handler",
                    context = mapOf("request" to request),
                    exception = e,
                )
                complete(
                    callback,
                    Result.failure(
                        HealthConnectorErrorCodeDto.UNKNOWN.toError(
                            "Unexpected error: ${e.message ?: "Unknown error"}",
                        ),
                    ),
                )
            }
        }
    }

    /**
     * Updates multiple health records atomically.
     *
     * @param request Contains the list of typed records to update
     * @param callback Called with a [Result] indicating success or failure
     */
    @Throws(HealthConnectorErrorDto::class)
    override fun updateRecords(
        request: UpdateRecordsRequestDto,
        callback: (Result<Unit>) -> Unit,
    ) {
        scope.launch {
            try {
                this@HealthConnectorHCAndroidPlugin.client.updateRecords(request)

                complete(callback, Result.success(Unit))
            } catch (e: HealthConnectorErrorDto) {
                HealthConnectorLogger.error(
                    tag = TAG,
                    operation = "update_records",
                    message = "Failed to update Health Connect records",
                    context = mapOf(
                        "records_count" to request.records.size,
                        "error_code" to e.code,
                        "error_message" to (e.message ?: "Unknown error"),
                    ),
                    exception = e,
                )

                complete(callback, Result.failure(e))
            } catch (e: kotlinx.coroutines.CancellationException) {
                throw e
            } catch (e: Exception) {
                HealthConnectorLogger.error(
                    tag = TAG,
                    operation = "update_records",
                    message = "Unexpected error escaped from handler",
                    context = mapOf("request" to request),
                    exception = e,
                )
                complete(
                    callback,
                    Result.failure(
                        HealthConnectorErrorCodeDto.UNKNOWN.toError(
                            "Unexpected error: ${e.message ?: "Unknown error"}",
                        ),
                    ),
                )
            }
        }
    }

    /**
     * Deletes health records based on the request type.
     *
     * @param request The deletion request (either by IDs or time range)
     * @param callback Called with a [Result] indicating success or failure
     */
    override fun deleteRecords(
        request: DeleteRecordsRequestDto,
        callback: (Result<Unit>) -> Unit,
    ) {
        scope.launch {
            try {
                when (request) {
                    is DeleteRecordsByIdsRequestDto -> client.deleteRecordsByIds(request)
                    is DeleteRecordsByTimeRangeRequestDto -> client.deleteRecordsByTimeRange(
                        request,
                    )
                }

                complete(callback, Result.success(Unit))
            } catch (e: HealthConnectorErrorDto) {
                HealthConnectorLogger.error(
                    tag = TAG,
                    operation = "delete_records",
                    message = "Failed to delete Health Connect records",
                    context = mapOf(
                        "request_type" to request.javaClass.simpleName,
                        "error_code" to e.code,
                        "error_message" to (e.message ?: "Unknown error"),
                    ),
                    exception = e,
                )

                complete(callback, Result.failure(e))
            } catch (e: kotlinx.coroutines.CancellationException) {
                throw e
            } catch (e: Exception) {
                HealthConnectorLogger.error(
                    tag = TAG,
                    operation = "delete_records",
                    message = "Unexpected error escaped from handler",
                    context = mapOf("request" to request.toString()),
                    exception = e,
                )
                complete(
                    callback,
                    Result.failure(
                        HealthConnectorErrorCodeDto.UNKNOWN.toError(
                            "Unexpected error: ${e.message ?: "Unknown error"}",
                        ),
                    ),
                )
            }
        }
    }

    /**
     * Performs an aggregation query on health records.
     *
     * @param request Contains data type, aggregation metric, and time range
     * @param callback Called with a [Result] containing the aggregation response
     */
    @Throws(HealthConnectorErrorDto::class)
    override fun aggregate(
        request: AggregateRequestDto,
        callback: (Result<AggregateResponseDto>) -> Unit,
    ) {
        scope.launch {
            try {
                val result = this@HealthConnectorHCAndroidPlugin.client.aggregate(request)

                complete(callback, Result.success(result))
            } catch (e: HealthConnectorErrorDto) {
                HealthConnectorLogger.error(
                    tag = TAG,
                    operation = "aggregate",

                    message = "Failed to aggregate Health Connect data",
                    context = mapOf(
                        "data_type" to request.dataType.toString(),
                        "aggregation_metric" to request.aggregationMetric.toString(),
                        "start_time" to request.startTime,
                        "end_time" to request.endTime,
                        "error_code" to e.code,
                        "error_message" to (e.message ?: "Unknown error"),
                    ),
                    exception = e,
                )

                complete(callback, Result.failure(e))
            } catch (e: kotlinx.coroutines.CancellationException) {
                throw e
            } catch (e: Exception) {
                HealthConnectorLogger.error(
                    tag = TAG,
                    operation = "aggregate",
                    message = "Unexpected error escaped from handler",
                    context = mapOf("request" to request),
                    exception = e,
                )
                complete(
                    callback,
                    Result.failure(
                        HealthConnectorErrorCodeDto.UNKNOWN.toError(
                            "Unexpected error: ${e.message ?: "Unknown error"}",
                        ),
                    ),
                )
            }
        }
    }

    /**
     * Dispatches a Pigeon callback to the main thread for execution.
     *
     * ## Why Use This Method
     *
     * This method is provided for **performance optimization**.
     * On Android, Pigeon's reply mechanism is thread-safe and internally marshals
     * responses to the main thread. However, dispatching callbacks explicitly to the main thread
     * can reduce context-switching overhead during serialization.
     *
     * **Important:** Unlike the iOS/Swift counterpart, this method is **NOT required** to prevent
     * crashes. On iOS, calling Pigeon's completion handler from a background thread causes
     * `EXC_BAD_ACCESS` due to Flutter's `FlutterStandardWriter` having UIKit thread-affinity.
     * Android's `BinaryMessenger` does not have this limitation.
     *
     * ## What It Does
     *
     * Switches the coroutine context to [Dispatchers.Main] before invoking the Pigeon callback,
     * ensuring that result serialization happens on the main thread.
     *
     * ## When To Use
     *
     * Use this method for all Pigeon callback invocations within coroutine scopes launched on
     * background dispatchers (e.g., [Dispatchers.IO]). While optional for correctness, it provides:
     * - Consistent threading behavior with the iOS implementation
     * - Potential performance benefits by reducing internal thread marshalling
     *
     * ## Example
     *
     * ```kotlin
     * scope.launch {
     *     val result = healthClient.readRecords(request)
     *     complete(callback, Result.success(result))
     * }
     * ```
     *
     * @param T The type of the result value.
     * @param callback The Pigeon-generated callback function to invoke.
     * @param result The [Result] to pass to the callback.
     */
    private suspend fun <T> complete(callback: (Result<T>) -> Unit, result: Result<T>) {
        withContext(Dispatchers.Main) {
            callback(result)
        }
    }
}
