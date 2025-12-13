package com.phamtunglam.health_connector_hc_android

import android.content.Context
import androidx.activity.ComponentActivity
import com.phamtunglam.health_connector_hc_android.mappers.aggregationMetric
import com.phamtunglam.health_connector_hc_android.mappers.dataType
import com.phamtunglam.health_connector_hc_android.mappers.endTime
import com.phamtunglam.health_connector_hc_android.mappers.startTime
import com.phamtunglam.health_connector_hc_android.mappers.toError
import com.phamtunglam.health_connector_hc_android.pigeon.AggregateRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.AggregateResponseDto
import com.phamtunglam.health_connector_hc_android.pigeon.DeleteRecordsByIdsRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.DeleteRecordsByTimeRangeRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthConnectorErrorCodeDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthConnectorErrorDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthConnectorHCAndroidApi
import com.phamtunglam.health_connector_hc_android.pigeon.HealthPlatformFeatureDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthPlatformFeatureStatusDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthPlatformStatusDto
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
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import kotlinx.coroutines.CoroutineExceptionHandler
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.SupervisorJob
import kotlinx.coroutines.cancel
import kotlinx.coroutines.launch
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
     * Cached instance of the Health Connect client.
     * Created lazily on first use and reused for subsequent operations.
     * Cleared when the engine is detached.
     */
    private var healthClient: HealthConnectorClient? = null

    /**
     * Coroutine scope for executing asynchronous Health Connect operations.
     * Uses [Dispatchers.IO] for background execution and [SupervisorJob] to prevent
     * cancellation of sibling coroutines when one fails.
     */
    private val scope: CoroutineScope =
        CoroutineScope(SupervisorJob() + Dispatchers.IO + coroutineExceptionHandler)

    private companion object {
        /**
         * Tag used for logging throughout the plugin.
         */
        private val TAG = HealthConnectorHCAndroidPlugin::class.simpleName
            ?: "HealthConnectorHCAndroidPlugin"

        /**
         * Global exception handler for coroutines to catch and log unhandled exceptions.
         */
        val coroutineExceptionHandler = CoroutineExceptionHandler { _, e ->
            HealthConnectorLogger.warning(
                tag = TAG,
                operation = "coroutineExceptionHandler",
                phase = "unhandled_exception",
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
        healthClient = null
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
     * Gets the current status of the Health Connect platform on the device.
     *
     * @param callback Called with a [Result] containing the platform status
     */
    override fun getHealthPlatformStatus(callback: (Result<HealthPlatformStatusDto>) -> Unit) {
        scope.launch {
            val statusDto = HealthConnectorClient.getHealthPlatformStatus(context)
            complete(callback, Result.success(statusDto))
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
        request: PermissionsRequestDto,
        callback: (Result<PermissionsRequestResponseDto>) -> Unit,
    ) {
        scope.launch {
            try {
                val client = healthClient ?: HealthConnectorClient.getOrCreate(context).also {
                    healthClient = it
                }

                val currentActivity = activity
                if (currentActivity == null) {
                    HealthConnectorLogger.error(
                        tag = TAG,
                        operation = "requestPermissions",
                        phase = "failed",
                        message = "Activity is null. " +
                            "Cannot request permissions without activity context",
                    )
                    complete(
                        callback,
                        Result.failure(
                            HealthConnectorErrorCodeDto.INVALID_PLATFORM_CONFIGURATION.toError(
                                details = "Activity is unavailable. " +
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
                    operation = "requestPermissions",
                    phase = "failed",
                    message = "Failed to request Health Connect permissions",
                    context = mapOf(
                        "error_code" to e.code,
                        "error_message" to (e.message ?: "Unknown error"),
                    ),
                    exception = e,
                )
                complete(callback, Result.failure(e))
            }
        }
    }

    /**
     * Gets all permissions that have been granted to the app.
     *
     * @param callback Called with a [Result] containing the permission response
     */
    @Throws(HealthConnectorErrorDto::class)
    override fun getGrantedPermissions(callback: (Result<PermissionsRequestResponseDto>) -> Unit) {
        scope.launch {
            try {
                val client = healthClient ?: HealthConnectorClient.getOrCreate(context).also {
                    healthClient = it
                }

                val responseDto = client.getGrantedPermissions()
                complete(callback, Result.success(responseDto))
            } catch (e: HealthConnectorErrorDto) {
                HealthConnectorLogger.error(
                    tag = TAG,
                    operation = "getGrantedPermissions",
                    phase = "failed",
                    message = "Failed to get granted Health Connect permissions",
                    context = mapOf(
                        "error_code" to e.code,
                        "error_message" to (e.message ?: "Unknown error"),
                    ),
                    exception = e,
                )
                complete(callback, Result.failure(e))
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
                val client = healthClient ?: HealthConnectorClient.getOrCreate(context).also {
                    healthClient = it
                }

                client.revokeAllPermissions()
                complete(callback, Result.success(Unit))
            } catch (e: HealthConnectorErrorDto) {
                HealthConnectorLogger.error(
                    tag = TAG,
                    operation = "revokeAllPermissions",
                    phase = "failed",
                    message = "Failed to revoke all Health Connect permissions",
                    context = mapOf(
                        "error_code" to e.code,
                        "error_message" to (e.message ?: "Unknown error"),
                    ),
                    exception = e,
                )
                complete(callback, Result.failure(e))
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
                val client = healthClient ?: HealthConnectorClient.getOrCreate(context).also {
                    healthClient = it
                }

                val featureStatusDto = client.getFeatureStatus(context, feature)
                complete(callback, Result.success(featureStatusDto))
            } catch (e: HealthConnectorErrorDto) {
                HealthConnectorLogger.error(
                    tag = TAG,
                    operation = "getFeatureStatus",
                    phase = "failed",
                    message = "Failed to get Health Connect feature status",
                    context = mapOf(
                        "feature" to feature.toString(),
                        "error_code" to e.code,
                        "error_message" to (e.message ?: "Unknown error"),
                    ),
                    exception = e,
                )
                complete(callback, Result.failure(e))
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
                val client = healthClient ?: HealthConnectorClient.getOrCreate(context).also {
                    healthClient = it
                }

                val result = client.readRecord(request)
                complete(callback, Result.success(result))
            } catch (e: HealthConnectorErrorDto) {
                HealthConnectorLogger.error(
                    tag = TAG,
                    operation = "readRecord",
                    phase = "failed",
                    message = "Failed to read Health Connect record",
                    context = mapOf(
                        "dataType" to request.dataType.toString(),
                        "recordId" to request.recordId,
                        "error_code" to e.code,
                        "error_message" to (e.message ?: "Unknown error"),
                    ),
                    exception = e,
                )
                complete(callback, Result.failure(e))
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
                val client = healthClient ?: HealthConnectorClient.getOrCreate(context).also {
                    healthClient = it
                }

                val result = client.readRecords(request)
                complete(callback, Result.success(result))
            } catch (e: HealthConnectorErrorDto) {
                HealthConnectorLogger.error(
                    tag = TAG,
                    operation = "readRecords",
                    phase = "failed",
                    message = "Failed to read Health Connect records",
                    context = mapOf(
                        "dataType" to request.dataType.toString(),
                        "startTime" to request.startTime,
                        "endTime" to request.endTime,
                        "pageSize" to request.pageSize,
                        "error_code" to e.code,
                        "error_message" to (e.message ?: "Unknown error"),
                    ),
                    exception = e,
                )
                complete(callback, Result.failure(e))
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
                val client = healthClient ?: HealthConnectorClient.getOrCreate(context).also {
                    healthClient = it
                }

                val result = client.writeRecord(request)
                complete(callback, Result.success(result))
            } catch (e: HealthConnectorErrorDto) {
                HealthConnectorLogger.error(
                    tag = TAG,
                    operation = "writeRecord",
                    phase = "failed",
                    message = "Failed to write Health Connect record",
                    context = mapOf(
                        "error_code" to e.code,
                        "error_message" to (e.message ?: "Unknown error"),
                    ),
                    exception = e,
                )
                complete(callback, Result.failure(e))
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
                val client = healthClient ?: HealthConnectorClient.getOrCreate(context).also {
                    healthClient = it
                }

                val result = client.writeRecords(request)
                complete(callback, Result.success(result))
            } catch (e: HealthConnectorErrorDto) {
                HealthConnectorLogger.error(
                    tag = TAG,
                    operation = "writeRecords",
                    phase = "failed",
                    message = "Failed to write Health Connect records",
                    context = mapOf(
                        "recordsCount" to request.records.size,
                        "error_code" to e.code,
                        "error_message" to (e.message ?: "Unknown error"),
                    ),
                    exception = e,
                )
                complete(callback, Result.failure(e))
            }
        }
    }

    /**
     * Updates a single health record.
     *
     * @param request Contains the data type and the typed record to update
     * @param callback Called with a [Result] containing the update record response
     */
    @Throws(HealthConnectorErrorDto::class)
    override fun updateRecord(
        request: UpdateRecordRequestDto,
        callback: (Result<UpdateRecordResponseDto>) -> Unit,
    ) {
        scope.launch {
            try {
                val client = healthClient ?: HealthConnectorClient.getOrCreate(context).also {
                    healthClient = it
                }

                val result = client.updateRecord(request)
                complete(callback, Result.success(result))
            } catch (e: HealthConnectorErrorDto) {
                HealthConnectorLogger.error(
                    tag = TAG,
                    operation = "updateRecord",
                    phase = "failed",
                    message = "Failed to update Health Connect record",
                    context = mapOf(
                        "error_code" to e.code,
                        "error_message" to (e.message ?: "Unknown error"),
                    ),
                    exception = e,
                )
                complete(callback, Result.failure(e))
            }
        }
    }

    /**
     * Deletes specific health records by their IDs.
     *
     * @param request Contains the data type and list of record IDs to delete
     * @param callback Called with a [Result] indicating success or failure
     */
    @Throws(HealthConnectorErrorDto::class)
    override fun deleteRecordsByIds(
        request: DeleteRecordsByIdsRequestDto,
        callback: (Result<Unit>) -> Unit,
    ) {
        scope.launch {
            try {
                val client = healthClient ?: HealthConnectorClient.getOrCreate(context).also {
                    healthClient = it
                }

                client.deleteRecordsByIds(request)

                complete(callback, Result.success(Unit))
            } catch (e: HealthConnectorErrorDto) {
                HealthConnectorLogger.error(
                    tag = TAG,
                    operation = "deleteRecordsByIds",
                    phase = "failed",
                    message = "Failed to delete Health Connect records by IDs",
                    context = mapOf(
                        "dataType" to request.dataType.toString(),
                        "recordIdsCount" to request.recordIds.size,
                        "error_code" to e.code,
                        "error_message" to (e.message ?: "Unknown error"),
                    ),
                    exception = e,
                )
                complete(callback, Result.failure(e))
            }
        }
    }

    /**
     * Deletes all records of a data type within a time range.
     *
     * @param request Contains the data type and time range (start and end timestamps) for deletion
     * @param callback Called with a [Result] indicating success or failure
     */
    @Throws(HealthConnectorErrorDto::class)
    override fun deleteRecordsByTimeRange(
        request: DeleteRecordsByTimeRangeRequestDto,
        callback: (Result<Unit>) -> Unit,
    ) {
        scope.launch {
            try {
                val client = healthClient ?: HealthConnectorClient.getOrCreate(context).also {
                    healthClient = it
                }

                client.deleteRecordsByTimeRange(request)

                complete(callback, Result.success(Unit))
            } catch (e: HealthConnectorErrorDto) {
                HealthConnectorLogger.error(
                    tag = TAG,
                    operation = "deleteRecordsByTimeRange",
                    phase = "failed",
                    message = "Failed to delete Health Connect records by time range",
                    context = mapOf(
                        "dataType" to request.dataType.toString(),
                        "startTime" to request.startTime,
                        "endTime" to request.endTime,
                        "error_code" to e.code,
                        "error_message" to (e.message ?: "Unknown error"),
                    ),
                    exception = e,
                )
                complete(callback, Result.failure(e))
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
                val client = healthClient ?: HealthConnectorClient.getOrCreate(context).also {
                    healthClient = it
                }

                val result = client.aggregate(request)
                complete(callback, Result.success(result))
            } catch (e: HealthConnectorErrorDto) {
                HealthConnectorLogger.error(
                    tag = TAG,
                    operation = "aggregate",
                    phase = "failed",
                    message = "Failed to aggregate Health Connect data",
                    context = mapOf(
                        "dataType" to request.dataType.toString(),
                        "aggregationMetric" to request.aggregationMetric.toString(),
                        "startTime" to request.startTime,
                        "endTime" to request.endTime,
                        "error_code" to e.code,
                        "error_message" to (e.message ?: "Unknown error"),
                    ),
                    exception = e,
                )
                complete(callback, Result.failure(e))
            }
        }
    }

    // region Private Helpers

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
     *     val result = client.readRecords(request)
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

    // endregion
}
