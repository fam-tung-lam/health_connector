package com.phamtunglam.health_connector_hc_android.utils

import android.content.Context
import android.content.pm.PackageManager
import androidx.activity.ComponentActivity
import androidx.health.connect.client.PermissionController
import com.phamtunglam.health_connector_hc_android.mappers.toError
import com.phamtunglam.health_connector_hc_android.mappers.toHealthConnectPermission
import com.phamtunglam.health_connector_hc_android.pigeon.HealthConnectorError
import com.phamtunglam.health_connector_hc_android.pigeon.HealthConnectorErrorCodeDto
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
     * Validates that a single feature permission is declared in AndroidManifest.xml.
     *
     * @param context The Android application context
     * @param feature The feature to validate
     *
     * @throws HealthConnectorError with code `INVALID_PLATFORM_CONFIGURATION` if the feature permission
     *         is not declared in AndroidManifest.xml.
     */
    @Throws(HealthConnectorError::class)
    fun validateFeaturePermissionDeclaredInManifest(
        context: Context,
        feature: HealthPlatformFeatureDto,
    ) {
        HealthConnectorLogger.debug(
            tag = TAG,
            operation = "validateFeaturePermissionDeclaredInManifest",
            phase = "entry",
            message = "Validating feature permission declared in AndroidManifest",
            context = mapOf("feature" to feature),
        )

        // Get all permissions declared in AndroidManifest
        val definedPermissions = context.packageManager.getPackageInfo(
            context.packageName,
            PackageManager.GET_PERMISSIONS,
        ).requestedPermissions.orEmpty().toSet()

        // Convert feature to Health Connect permission string
        val featurePermissionString = feature.toHealthConnectPermission()

        // Check if the feature permission is declared
        if (!definedPermissions.contains(featurePermissionString)) {
            val errorMessage =
                "Feature permission '$featurePermissionString' for $feature is not declared in AndroidManifest.xml"
            HealthConnectorLogger.error(
                tag = TAG,
                operation = "validateFeaturePermissionDeclaredInManifest",
                phase = "failed",
                message = errorMessage,
                context = mapOf(
                    "feature" to feature,
                    "feature_permission_string" to featurePermissionString,
                ),
            )
            throw HealthConnectorErrorCodeDto.INVALID_PLATFORM_CONFIGURATION.toError(
                details = "Please add the permission '$featurePermissionString' " +
                    "to your AndroidManifest.xml file.",
            )
        }

        HealthConnectorLogger.debug(
            tag = TAG,
            operation = "validateFeaturePermissionDeclaredInManifest",
            phase = "completed",
            message = "Feature permission properly declared in AndroidManifest",
            context = mapOf("feature" to feature),
        )
    }

    /**
     * Validates that all requested permissions and features are declared in AndroidManifest.xml.
     *
     * This method checks if the permissions/features being requested have been properly declared
     * in the app's AndroidManifest.xml file. This is required for the permission request to succeed.
     *
     * @param context The Android application context
     * @param request The permissions request containing health data and feature permissions to validate
     *
     * @throws IllegalStateException if any requested permissions/features are not declared in
     *         AndroidManifest.xml. The error message lists all missing declarations.
     */
    @Throws(IllegalStateException::class)
    fun validatePermissionsDeclaredInManifest(context: Context, request: PermissionsRequestDto) {
        HealthConnectorLogger.debug(
            tag = TAG,
            operation = "validatePermissionsDeclaredInManifest",
            phase = "entry",
            message = "Validating permissions declared in AndroidManifest",
            context = mapOf(
                "health_data_permissions" to request.healthDataPermissions,
                "feature_permissions" to request.featurePermissions,
            ),
        )

        // Get all permissions declared in AndroidManifest
        val definedPermissions = context.packageManager.getPackageInfo(
            context.packageName,
            PackageManager.GET_PERMISSIONS,
        ).requestedPermissions.orEmpty().toSet()

        HealthConnectorLogger.debug(
            tag = TAG,
            operation = "validatePermissionsDeclaredInManifest",
            phase = "in_progress",
            message = "Found permissions declared in AndroidManifest",
            context = mapOf("declared_permissions_count" to definedPermissions.size),
        )

        // Convert DTOs to Health Connect permission strings
        val healthDataPermissionStrings = request.healthDataPermissions.map {
            it.toHealthConnectPermission()
        }
        val featurePermissionStrings = request.featurePermissions.map {
            it.toHealthConnectPermission()
        }
        val allRequestedPermissions = healthDataPermissionStrings + featurePermissionStrings

        // Partition into defined and not defined
        val (defined, notDefined) = allRequestedPermissions.partition {
            definedPermissions.contains(it)
        }

        HealthConnectorLogger.debug(
            tag = TAG,
            operation = "validatePermissionsDeclaredInManifest",
            phase = "in_progress",
            message = "Validation result",
            context = mapOf(
                "defined_count" to defined.size,
                "not_defined_count" to notDefined.size,
            ),
        )

        // Throw error if any permissions are not defined
        if (notDefined.isNotEmpty()) {
            val errorMessage = "The following permissions/features are not declared in " +
                "AndroidManifest.xml: ${notDefined.joinToString(", ")}. " +
                "Please add these permissions to your AndroidManifest.xml file."
            HealthConnectorLogger.error(
                tag = TAG,
                operation = "validatePermissionsDeclaredInManifest",
                phase = "failed",
                message = errorMessage,
                context = mapOf(
                    "not_defined" to notDefined,
                    "defined" to defined,
                ),
            )
            throw IllegalStateException(errorMessage)
        }

        HealthConnectorLogger.debug(
            tag = TAG,
            operation = "validatePermissionsDeclaredInManifest",
            phase = "completed",
            message = "All requested permissions are properly declared in AndroidManifest",
        )
    }

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
