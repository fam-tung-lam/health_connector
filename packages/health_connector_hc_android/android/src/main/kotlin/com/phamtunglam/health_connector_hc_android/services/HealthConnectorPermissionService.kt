package com.phamtunglam.health_connector_hc_android.services

import android.content.ActivityNotFoundException
import android.os.RemoteException
import androidx.activity.ComponentActivity
import androidx.health.connect.client.PermissionController
import com.phamtunglam.health_connector_hc_android.exceptions.HealthConnectorException
import com.phamtunglam.health_connector_hc_android.mappers.permission_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.mappers.permission_mappers.toPermissionRequestResultDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataPermissionRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataPermissionRequestResultDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthPlatformFeaturePermissionRequest
import com.phamtunglam.health_connector_hc_android.pigeon.HealthPlatformFeaturePermissionRequestResultDto
import com.phamtunglam.health_connector_hc_android.pigeon.PermissionRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.PermissionRequestResultDto
import com.phamtunglam.health_connector_hc_android.pigeon.PermissionRequestsDto
import com.phamtunglam.health_connector_hc_android.pigeon.PermissionStatusDto
import java.io.IOException
import java.util.UUID
import kotlinx.coroutines.CompletableDeferred
import kotlinx.coroutines.CoroutineDispatcher
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext

/**
 * Internal service responsible for managing Health Connect permissions.
 *
 * This service handles the Android Activity Result API for permissions,
 * converting the asynchronous callback-based contract into a linear coroutine-based flow.
 *
 * @property permissionClient The native [PermissionController] used to interact with the Health Connect system.
 */
internal class HealthConnectorPermissionService(
    private val dispatcher: CoroutineDispatcher = Dispatchers.IO,
    private val permissionClient: PermissionController,
) {
    companion object {
        /**
         * Key prefix used for registering the permission request activity result contract.
         */
        private const val REGISTRY_KEY_PREFIX = "health_connector_request_"
    }

    /**
     * Launches a system permission request dialog for the specified [request].
     *
     * @param activity The [ComponentActivity] required to register the result contract.
     * @param request The DTO containing the list of permissions (data or feature) to request.
     * @return A list of [PermissionRequestResultDto] indicating the status (GRANTED/DENIED) of each requested permission.
     * @throws HealthConnectorException.Unknown for [ActivityNotFoundException].
     */
    @Throws(HealthConnectorException::class)
    suspend fun requestPermissions(
        activity: ComponentActivity,
        request: PermissionRequestsDto,
    ): List<PermissionRequestResultDto> = withContext(dispatcher) {
        val permissionStrings = request.permissionRequests.map {
            it.toHealthConnect()
        }.toSet()

        val grantedPermissionStrings = launchPermissionRequest(activity, permissionStrings)

        return@withContext request.permissionRequests.map { permissionRequest ->
            val permissionString = permissionRequest.toHealthConnect()
            val isGranted = permissionString in grantedPermissionStrings
            val status = if (isGranted) PermissionStatusDto.GRANTED else PermissionStatusDto.DENIED

            when (permissionRequest) {
                is HealthDataPermissionRequestDto -> {
                    HealthDataPermissionRequestResultDto(
                        permission = permissionRequest,
                        status = status,
                    )
                }

                is HealthPlatformFeaturePermissionRequest -> {
                    HealthPlatformFeaturePermissionRequestResultDto(
                        feature = permissionRequest.feature,
                        status = status,
                    )
                }
            }
        }
    }

    /**
     * Helper to launch the Health Connect permission request contract.
     *
     * Registers a one-time activity result contract, launches the permission request,
     * and awaits the result.
     *
     * @param activity The [ComponentActivity] context for registering the result contract.
     * @param permissionStrings The set of permission strings to request.
     * @return A set of granted permission strings.
     * @throws HealthConnectorException.Unknown for [ActivityNotFoundException].
     */
    @Throws(HealthConnectorException::class)
    private suspend fun launchPermissionRequest(
        activity: ComponentActivity,
        permissionStrings: Set<String>,
    ): Set<String> = withContext(Dispatchers.Main.immediate) {
        val completer = CompletableDeferred<Set<String>>()

        // Generate a unique key for this specific request to avoid registry collisions
        val uniqueKey = REGISTRY_KEY_PREFIX + UUID.randomUUID().toString()
        val contract = PermissionController.createRequestPermissionResultContract()
        val launcher = activity.activityResultRegistry.register(
            uniqueKey,
            contract,
        ) { grantedPermissions ->
            completer.complete(grantedPermissions)
        }

        try {
            launcher.launch(permissionStrings)
            completer.await()
        } catch (e: ActivityNotFoundException) {
            throw HealthConnectorException.Unknown(
                message = e.message ?: "Activity not found",
                cause = e,
            )
        } finally {
            // Unregister the callback to prevent memory leaks and keep the registry clean.
            launcher.unregister()
        }
    }

    /**
     * Gets the current status of a specific permission.
     *
     * @param request The permission to check.
     * @return [PermissionStatusDto.GRANTED] if the permission is granted, [PermissionStatusDto.DENIED] otherwise.
     * @throws HealthConnectorException.RemoteError for IPC transportation and disk I/O issues.
     * @throws HealthConnectorException.HealthPlatformUnavailable if service is not available.
     */
    @Throws(HealthConnectorException::class)
    suspend fun getPermissionStatus(request: PermissionRequestDto): PermissionStatusDto =
        withContext(dispatcher) {
            try {
                val grantedPermissions = getGrantedPermissionStrings()

                val permissionString = request.toHealthConnect()
                return@withContext if (grantedPermissions.contains(permissionString)) {
                    PermissionStatusDto.GRANTED
                } else {
                    PermissionStatusDto.DENIED
                }
            } catch (e: HealthConnectorException) {
                throw e
            }
        }

    /**
     * Retrieves the list of permissions currently granted to this application by the user.
     *
     * @return All granted permissions.
     * @throws HealthConnectorException.RemoteError for IPC transportation and disk I/O issues.
     * @throws HealthConnectorException.HealthPlatformUnavailable if service is not available.
     */
    @Throws(HealthConnectorException::class)
    suspend fun getGrantedPermissions(): List<PermissionRequestResultDto> =
        withContext(dispatcher) {
            try {
                val grantedPermissionStrings = getGrantedPermissionStrings()

                val grantedPermissions = grantedPermissionStrings.map { permissionString ->
                    permissionString.toPermissionRequestResultDto()
                }

                return@withContext grantedPermissions
            } catch (e: HealthConnectorException) {
                throw e
            }
        }

    /**
     * Revokes all previously granted permissions by the user to the calling app.
     *
     * @throws HealthConnectorException.RemoteError for IPC transportation and disk I/O issues.
     * @throws HealthConnectorException.HealthPlatformUnavailable if service is not available.
     */
    @Throws(HealthConnectorException::class)
    suspend fun revokeAllPermissions() = withContext(dispatcher) {
        try {
            permissionClient.revokeAllPermissions()
        } catch (e: RemoteException) {
            throw HealthConnectorException.RemoteError(
                message = e.message ?: "Remote exception",
                cause = e,
            )
        } catch (e: IOException) {
            throw HealthConnectorException.RemoteError(
                message = e.message ?: "I/O error",
                cause = e,
            )
        } catch (e: IllegalStateException) {
            throw HealthConnectorException.HealthPlatformUnavailable(
                message = e.message ?: "Health platform unavailable",
                cause = e,
            )
        }
    }

    /**
     * Retrieves the list of permission strings granted to this application by the user.
     *
     * @return A [Set<String>] containing all granted permissions.
     * @throws HealthConnectorException.RemoteError for IPC transportation and disk I/O issues.
     * @throws HealthConnectorException.HealthPlatformUnavailable if service is not available.
     */
    private suspend fun getGrantedPermissionStrings(): Set<String> {
        try {
            return permissionClient.getGrantedPermissions()
        } catch (e: RemoteException) {
            throw HealthConnectorException.RemoteError(
                message = e.message ?: "Remote exception",
                cause = e,
            )
        } catch (e: IOException) {
            throw HealthConnectorException.RemoteError(
                message = e.message ?: "I/O error",
                cause = e,
            )
        } catch (e: IllegalStateException) {
            throw HealthConnectorException.HealthPlatformUnavailable(
                message = e.message ?: "Health platform unavailable",
                cause = e,
            )
        }
    }
}
