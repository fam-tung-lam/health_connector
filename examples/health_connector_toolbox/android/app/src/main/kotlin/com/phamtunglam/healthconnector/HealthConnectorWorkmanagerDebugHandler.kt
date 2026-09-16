package com.phamtunglam.healthconnector

import android.content.Context
import com.phamtunglam.health_connector_hc_android.logger.HealthConnectorLogger
import dev.fluttercommunity.workmanager.TaskDebugInfo
import dev.fluttercommunity.workmanager.TaskResult
import dev.fluttercommunity.workmanager.WorkmanagerDebug
import dev.fluttercommunity.workmanager.pigeon.TaskStatus

/**
 * Routes Workmanager task status updates into the Health Connector native
 * logger, which relays them to the Flutter log stream as native log events.
 *
 * The SDK only forwards events after the Dart side created a `HealthConnector`
 * with native logging enabled, so the earliest events of a cold background
 * start are dropped. Once the toolbox console processor is registered, every
 * later status update shows up in the SDK Console Logs screen next to the Dart
 * logs of the same run.
 */
class HealthConnectorWorkmanagerDebugHandler : WorkmanagerDebug() {
    override fun onTaskStatusUpdate(
        context: Context,
        taskInfo: TaskDebugInfo,
        status: TaskStatus,
        result: TaskResult?,
    ) {
        val logContext =
            buildMap<String, Any?> {
                put("task_name", taskInfo.taskName)
                put("unique_name", taskInfo.uniqueName)
                put("status", status.name)
                result?.let {
                    put("success", it.success)
                    put("duration_ms", it.duration)
                    it.error?.let { error -> put("error", error) }
                }
            }
        val message = "Workmanager task ${status.name.lowercase()}: ${taskInfo.taskName}"

        when (status) {
            TaskStatus.FAILED ->
                HealthConnectorLogger.error(TAG, message, OPERATION, logContext)
            TaskStatus.CANCELLED, TaskStatus.RETRYING, TaskStatus.RESCHEDULED ->
                HealthConnectorLogger.warning(TAG, message, OPERATION, logContext)
            TaskStatus.SCHEDULED, TaskStatus.STARTED, TaskStatus.COMPLETED ->
                HealthConnectorLogger.info(TAG, message, OPERATION, logContext)
        }
    }

    override fun onExceptionEncountered(
        context: Context,
        taskInfo: TaskDebugInfo?,
        exception: Throwable,
    ) {
        HealthConnectorLogger.error(
            TAG,
            "Workmanager exception in task ${taskInfo?.taskName ?: "unknown"}",
            OPERATION,
            mapOf("task_name" to taskInfo?.taskName),
            exception,
        )
    }

    private companion object {
        const val TAG = "WorkmanagerDebug"
        const val OPERATION = "backgroundTask"
    }
}
