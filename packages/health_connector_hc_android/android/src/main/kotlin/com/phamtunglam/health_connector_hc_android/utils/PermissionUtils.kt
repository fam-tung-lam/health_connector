package com.phamtunglam.health_connector_hc_android.utils

import androidx.activity.ComponentActivity
import androidx.health.connect.client.PermissionController
import com.phamtunglam.health_connector_hc_android.logger.HealthConnectorLogger
import com.phamtunglam.health_connector_hc_android.mappers.toHealthConnectPermission
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataPermissionDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataPermissionRequestResultDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthPlatformFeatureDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthPlatformFeaturePermissionRequestResultDto
import com.phamtunglam.health_connector_hc_android.pigeon.PermissionStatusDto
import com.phamtunglam.health_connector_hc_android.pigeon.PermissionsRequestDto
import kotlinx.coroutines.CompletableDeferred

/**
 * Utility object for handling Health Connect permission operations.
 *
 * This object provides helper methods for validating permissions, requesting permissions,
 * and building permission results.
 */
internal object PermissionUtils {
    /**
     * Tag used for logging throughout the permission utilities.
     */
    private val TAG = PermissionUtils::class.simpleName ?: "PermissionUtils"

    /**
     * Key used for registering the permission request activity result contract.
     */
    private const val PERMISSION_REQUEST_KEY = "health_connector_plugin"

    /**
     * Requests permissions from the Android system via Health Connect SDK.
     *
     * @param activity The activity to launch the permission request dialog
     * @param request The permissions to request
     * @return Set of granted permission strings
     */
    suspend fun requestPermissionsFromSystem(
        activity: ComponentActivity,
        request: PermissionsRequestDto,
    ): Set<String> {
        // Convert DTOs to Health Connect permission strings
        val healthDataPermissionStrings = request.healthDataPermissions.map {
            it.toHealthConnectPermission()
        }
        val featurePermissionStrings = request.featurePermissions.map {
            it.toHealthConnectPermission()
        }
        val allPermissions = healthDataPermissionStrings.union(featurePermissionStrings)

        HealthConnectorLogger.debug(
            tag = TAG,
            operation = "requestPermissionsFromSystem",
            phase = "entry",
            message = "Launching permission request",
            context = mapOf("permissions_count" to allPermissions.size),
        )

        // Launch permission request and wait for result
        val completer = CompletableDeferred<Set<String>>()
        val contract = PermissionController.createRequestPermissionResultContract()
        val launcher = activity.activityResultRegistry.register(
            PERMISSION_REQUEST_KEY,
            contract,
        ) { grantedPermissions -> completer.complete(grantedPermissions) }

        launcher.launch(allPermissions)
        val grantedPermissions = completer.await()

        HealthConnectorLogger.info(
            tag = TAG,
            operation = "requestPermissionsFromSystem",
            phase = "completed",
            message = "Permission request completed",
            context = mapOf("granted_permissions_count" to grantedPermissions.size),
        )
        return grantedPermissions
    }

    /**
     * Maps health data permission DTOs to their request results based on granted permissions.
     *
     * @param requestedPermissions The health data permissions that were requested
     * @param grantedPermissions The set of permission strings that were granted
     * @return List of health data permission results
     */
    fun buildHealthDataPermissionResults(
        requestedPermissions: List<HealthDataPermissionDto>,
        grantedPermissions: Set<String>,
    ): List<HealthDataPermissionRequestResultDto> = requestedPermissions.map { permissionDto ->
        HealthDataPermissionRequestResultDto(
            permission = permissionDto,
            status = determinePermissionStatus(
                permissionDto.toHealthConnectPermission(),
                grantedPermissions,
            ),
        )
    }

    /**
     * Maps feature DTOs to their permission request results based on granted permissions.
     *
     * @param requestedFeatures The features for which permissions were requested
     * @param grantedPermissions The set of permission strings that were granted
     * @return List of feature permission results
     */
    fun buildFeaturePermissionResults(
        requestedFeatures: List<HealthPlatformFeatureDto>,
        grantedPermissions: Set<String>,
    ): List<HealthPlatformFeaturePermissionRequestResultDto> = requestedFeatures.map { featureDto ->
        HealthPlatformFeaturePermissionRequestResultDto(
            feature = featureDto,
            status = determinePermissionStatus(
                featureDto.toHealthConnectPermission(),
                grantedPermissions,
            ),
        )
    }

    /**
     * Determines if a permission was granted based on the granted permission set.
     *
     * @param permissionString The Health Connect permission string to check
     * @param grantedPermissions The set of granted permission strings
     * @return [PermissionStatusDto.GRANTED] if the permission was granted, [PermissionStatusDto.DENIED] otherwise
     */
    fun determinePermissionStatus(
        permissionString: String,
        grantedPermissions: Set<String>,
    ): PermissionStatusDto = if (permissionString in grantedPermissions) {
        PermissionStatusDto.GRANTED
    } else {
        PermissionStatusDto.DENIED
    }
}
