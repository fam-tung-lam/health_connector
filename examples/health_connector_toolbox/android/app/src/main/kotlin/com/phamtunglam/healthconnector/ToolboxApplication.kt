package com.phamtunglam.healthconnector

import android.app.Application
import dev.fluttercommunity.workmanager.WorkmanagerDebug

/**
 * Application entry point of the Toolbox.
 *
 * Installs the Workmanager debug handler as early as possible so status
 * updates of the background sync task are captured even when WorkManager
 * starts the process without launching the main activity.
 */
class ToolboxApplication : Application() {
    override fun onCreate() {
        super.onCreate()
        WorkmanagerDebug.setCurrent(WorkManagerDebugHandler())
    }
}
