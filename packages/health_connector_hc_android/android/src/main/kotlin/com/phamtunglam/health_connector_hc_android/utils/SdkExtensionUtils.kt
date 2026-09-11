package com.phamtunglam.health_connector_hc_android.utils

import android.os.Build
import android.os.ext.SdkExtensions
import androidx.annotation.RequiresApi
import com.phamtunglam.health_connector_hc_android.pigeon.AndroidSDKExtensionVersionDto

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

    /**
     * Captures the SDK Extension tracks present on the device in API-level order.
     *
     * The AD_SERVICES key is omitted because it identifies an extension family rather than an
     * Android API-level track.
     */
    fun snapshotSdkExtensionVersions(): List<AndroidSDKExtensionVersionDto> {
        val apiLevel = Build.VERSION.SDK_INT
        return when {
            apiLevel < Build.VERSION_CODES.R -> buildSdkExtensionSnapshot(apiLevel)
            apiLevel < Build.VERSION_CODES.S -> buildSdkExtensionSnapshot(
                apiLevel = apiLevel,
                androidRVersion = queryAndroidRVersion(),
            )
            else -> buildSdkExtensionSnapshot(
                apiLevel = apiLevel,
                allVersions = queryAllVersions(),
            )
        }
    }

    internal fun buildSdkExtensionSnapshot(
        apiLevel: Int,
        androidRVersion: Int = 0,
        allVersions: Map<Int, Int> = emptyMap(),
    ): List<AndroidSDKExtensionVersionDto> {
        if (apiLevel < Build.VERSION_CODES.R) return emptyList()

        val versions = if (apiLevel < Build.VERSION_CODES.S) {
            mapOf(Build.VERSION_CODES.R to androidRVersion)
        } else {
            allVersions
        }

        return versions
            .filter { (extensionApiLevel, extensionVersion) ->
                extensionApiLevel in Build.VERSION_CODES.R..apiLevel && extensionVersion > 0
            }
            .toSortedMap()
            .map { (extensionApiLevel, extensionVersion) ->
                AndroidSDKExtensionVersionDto(
                    androidApiLevel = extensionApiLevel.toLong(),
                    extensionVersion = extensionVersion.toLong(),
                )
            }
    }

    @RequiresApi(Build.VERSION_CODES.R)
    private fun querySdkExtension21(): Boolean {
        val version = SdkExtensions.getExtensionVersion(Build.VERSION_CODES.UPSIDE_DOWN_CAKE)
        return version >= HEALTH_CONNECT_SDK_EXTENSION_21
    }

    @RequiresApi(Build.VERSION_CODES.R)
    private fun queryAndroidRVersion(): Int =
        SdkExtensions.getExtensionVersion(Build.VERSION_CODES.R)

    @RequiresApi(Build.VERSION_CODES.S)
    private fun queryAllVersions(): Map<Int, Int> = SdkExtensions.getAllExtensionVersions()
}
