package com.phamtunglam.health_connector_hc_android.services

import android.content.Context
import android.content.pm.PackageManager
import com.phamtunglam.health_connector_hc_android.pigeon.HealthConnectorErrorCodeDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthConnectorErrorDto
import com.phamtunglam.health_connector_hc_android.utils.toError

/**
 * Internal service responsible for validating the application's Android Manifest configuration.
 *
 * This service ensures that the integration requirements for Health Connect (specifically
 * static permission declarations) are met before attempting to request permissions at runtime.
 */
internal class HealthConnectorManifestService(private val context: Context) {

    /**
     * Ensures that all requested [permissions] are explicitly declared in the application's `AndroidManifest.xml`.
     *
     * This check is critical because Health Connect requires permissions to be present in the manifest
     * via `<uses-permission>` tags. Requesting undeclared permissions will silently fail or cause
     * runtime issues.
     *
     * @param permissions The set of permission strings to validate (e.g., `android.permission.health.READ_STEPS`).
     * @throws HealthConnectorErrorCodeDto.INVALID_CONFIGURATION If any of the [permissions] are missing from the manifest declaration.
     */
    @Throws(HealthConnectorErrorDto::class)
    fun checkPermissionsDeclared(permissions: Set<String>) {
        val (_, missing) = partitionDeclaredPermissions(permissions)

        if (missing.isNotEmpty()) {
            throw HealthConnectorErrorCodeDto.INVALID_CONFIGURATION.toError(
                "Health Connect integration is misconfigured. " +
                    "Missing permissions in AndroidManifest.xml: $missing. " +
                    "Please add <uses-permission> tags.",
            )
        }
    }

    /**
     * Partitions the input [permissions] into two lists: those present in the Manifest and those missing.
     *
     * This looks up the app's [PackageManager.GET_PERMISSIONS] metadata to verify static declarations.
     *
     * @return A [Pair] where:
     * - `first`: List of permissions **declared** in the manifest.
     * - `second`: List of permissions **missing** from the manifest.
     */
    private fun partitionDeclaredPermissions(
        permissions: Set<String>,
    ): Pair<List<String>, List<String>> {
        val declaredPermissions = context.packageManager.getPackageInfo(
            context.packageName,
            PackageManager.GET_PERMISSIONS,
        ).requestedPermissions.orEmpty().toSet()

        return permissions.partition { permission ->
            declaredPermissions.contains(permission)
        }
    }
}
