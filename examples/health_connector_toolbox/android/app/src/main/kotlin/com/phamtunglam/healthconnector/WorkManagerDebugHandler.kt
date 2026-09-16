package com.phamtunglam.healthconnector

import android.content.Context
import android.util.Log
import dev.fluttercommunity.workmanager.TaskDebugInfo
import dev.fluttercommunity.workmanager.TaskResult
import dev.fluttercommunity.workmanager.WorkmanagerDebug
import dev.fluttercommunity.workmanager.pigeon.TaskStatus

/**
 * Writes Workmanager task status updates to the Android log (logcat) through
 * the built-in [Log] API.
 *
 * Logging happens entirely on the native side, so every status update is
 * captured even when WorkManager starts the process without a Flutter engine
 * and before any Dart code runs. Filter logcat by the `WorkManagerDebug` tag
 * to follow the background sync task.
 */
class WorkManagerDebugHandler : WorkmanagerDebug() {
    override fun onTaskStatusUpdate(
        context: Context,
        taskInfo: TaskDebugInfo,
        status: TaskStatus,
        result: TaskResult?,
    ) {
        val message = buildString {
            append("Task ")
            append(status.name.lowercase())
            append(": ")
            append(taskInfo.taskName)
            taskInfo.uniqueName?.let { append(", uniqueName=").append(it) }
            result?.let {
                append(", success=").append(it.success)
                append(", duration=").append(it.duration).append("ms")
                it.error?.let { error -> append(", error=").append(error) }
            }
        }

        when (status) {
            TaskStatus.FAILED -> Log.e(TAG, message)
            TaskStatus.CANCELLED, TaskStatus.RETRYING, TaskStatus.RESCHEDULED -> Log.w(TAG, message)
            TaskStatus.SCHEDULED, TaskStatus.STARTED, TaskStatus.COMPLETED -> Log.i(TAG, message)
        }
    }

    override fun onExceptionEncountered(
        context: Context,
        taskInfo: TaskDebugInfo?,
        exception: Throwable,
    ) {
        Log.e(TAG, "Exception in task: ${taskInfo?.taskName ?: "unknown"}", exception)
    }

    private companion object {
        const val TAG = "WorkManagerDebug"
    }
}
