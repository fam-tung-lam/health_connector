package com.phamtunglam.health_connector_hc_android.utils

import android.os.Build
import android.os.ext.SdkExtensions
import androidx.annotation.RequiresApi

/**
 * Utilities for querying Android SDK Extension versions at runtime.
 */
internal object SdkExtensionUtils {
    private const val HEALTH_CONNECT_SDK_EXTENSION_21 = 21

    /**
     * Returns `true` if the device's Health Connect Mainline module supports SDK Extension 21.
     *
     * SDK Extension 21 corresponds to Android 14 (API 34) with the Mainline update that bundles
     * Extension 21. Health Connect fields gated by this version (e.g. `ExerciseSegment.weight`)
     * are silently dropped on write and return `null` on read when the device does not meet this
     * requirement.
     */
    fun isAtLeastSdkExtension21(): Boolean {
        if (Build.VERSION.SDK_INT < Build.VERSION_CODES.R) return false
        return querySdkExtension21()
    }

    @RequiresApi(Build.VERSION_CODES.R)
    private fun querySdkExtension21(): Boolean {
        val version = SdkExtensions.getExtensionVersion(Build.VERSION_CODES.UPSIDE_DOWN_CAKE)
        return version >= HEALTH_CONNECT_SDK_EXTENSION_21
    }
}
