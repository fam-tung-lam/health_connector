package com.phamtunglam.health_connector_hc_android.services

import android.content.ActivityNotFoundException
import android.os.RemoteException
import androidx.activity.ComponentActivity
import androidx.health.connect.client.PermissionController
import com.phamtunglam.health_connector_hc_android.exceptions.HealthConnectorException
import com.phamtunglam.health_connector_hc_android.logger.HealthConnectorLogger
import com.phamtunglam.health_connector_hc_android.mappers.permission_mappers.toHealthConnectPermissionString
import com.phamtunglam.health_connector_hc_android.mappers.permission_mappers.toPermissionRequestResultDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthConnectorErrorCodeDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataPermissionRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataPermissionRequestResultDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthPlatformFeaturePermissionRequest
import com.phamtunglam.health_connector_hc_android.pigeon.HealthPlatformFeaturePermissionRequestResultDto
import com.phamtunglam.health_connector_hc_android.pigeon.PermissionRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.PermissionRequestResultDto
import com.phamtunglam.health_connector_hc_android.pigeon.PermissionRequestsDto
import com.phamtunglam.health_connector_hc_android.pigeon.PermissionStatusDto
import com.phamtunglam.health_connector_hc_android.utils.status
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
        private const val TAG = "HealthConnectorPermissionService"

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
        val context = mapOf(
            "permission_count" to request.permissionRequests.size,
        )
        HealthConnectorLogger.debug(
            tag = TAG,
            operation = "requestPermissions",
            message = "Requesting permissions from user",
            context = context,
        )

        val permissionStrings = request.permissionRequests.map {
            it.toHealthConnectPermissionString()
        }.toSet()

        val grantedPermissionStrings = launchPermissionRequest(activity, permissionStrings)

        val results = request.permissionRequests.map { permissionRequest ->
            val permissionString = permissionRequest.toHealthConnectPermissionString()
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

        val grantedCount = results.count { it.status == PermissionStatusDto.GRANTED }
        val deniedCount = results.count { it.status == PermissionStatusDto.DENIED }

        HealthConnectorLogger.info(
            tag = TAG,
            operation = "requestPermissions",
            message = "Permission request completed",
            context = context + mapOf(
                "granted_count" to grantedCount,
                "denied_count" to deniedCount,
            ),
        )

        return@withContext results
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
            HealthConnectorLogger.error(
                tag = TAG,
                operation = "launchPermissionRequest",
                message = "Permission request activity not found",
                exception = e,
            )
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
     * @throws HealthConnectorException.HealthService for IPC transportation and disk I/O issues.
     * @throws HealthConnectorException.HealthServiceUnavailable if service is not available.
     */
    @Throws(HealthConnectorException::class)
    suspend fun getPermissionStatus(request: PermissionRequestDto): PermissionStatusDto =
        withContext(dispatcher) {
            val permissionString = request.toHealthConnectPermissionString()
            val context = mapOf(
                "permission" to permissionString,
            )
            HealthConnectorLogger.debug(
                tag = TAG,
                operation = "getPermissionStatus",
                message = "Checking permission status",
                context = context,
            )

            val grantedPermissions = getGrantedPermissionStrings()

            val status = if (grantedPermissions.contains(permissionString)) {
                PermissionStatusDto.GRANTED
            } else {
                PermissionStatusDto.DENIED
            }

            HealthConnectorLogger.info(
                tag = TAG,
                operation = "getPermissionStatus",
                message = "Permission status retrieved",
                context = context + mapOf("status" to status.name),
            )

            return@withContext status
        }

    /**
     * Retrieves the list of permissions currently granted to this application by the user.
     *
     * @return All granted permissions.
     * @throws HealthConnectorException.HealthService for IPC transportation and disk I/O issues.
     * @throws HealthConnectorException.HealthServiceUnavailable if service is not available.
     */
    @Throws(HealthConnectorException::class)
    suspend fun getGrantedPermissions(): List<PermissionRequestResultDto> =
        withContext(dispatcher) {
            HealthConnectorLogger.debug(
                tag = TAG,
                operation = "getGrantedPermissions",
                message = "Retrieving granted permissions",
            )

            val grantedPermissionStrings = getGrantedPermissionStrings()

            val grantedPermissions = grantedPermissionStrings.map { permissionString ->
                permissionString.toPermissionRequestResultDto()
            }

            HealthConnectorLogger.info(
                tag = TAG,
                operation = "getGrantedPermissions",
                message = "Retrieved granted permissions",
                context = mapOf("granted_count" to grantedPermissions.size),
            )

            return@withContext grantedPermissions
        }

    /**
     * Revokes all previously granted permissions by the user to the calling app.
     *
     * @throws HealthConnectorException.HealthService for IPC transportation and disk I/O issues.
     * @throws HealthConnectorException.HealthServiceUnavailable if service is not available.
     */
    @Throws(HealthConnectorException::class)
    suspend fun revokeAllPermissions() = withContext(dispatcher) {
        HealthConnectorLogger.debug(
            tag = TAG,
            operation = "revokeAllPermissions",
            message = "Revoking all permissions",
        )

        try {
            permissionClient.revokeAllPermissions()

            HealthConnectorLogger.info(
                tag = TAG,
                operation = "revokeAllPermissions",
                message = "All permissions revoked successfully",
            )
        } catch (e: RemoteException) {
            HealthConnectorLogger.error(
                tag = TAG,
                operation = "revokeAllPermissions",
                message = "Remote exception during revocation",
                exception = e,
            )
            throw HealthConnectorException.HealthService(
                code = HealthConnectorErrorCodeDto.REMOTE_ERROR,
                message = e.message ?: "Remote exception",
                cause = e,
            )
        } catch (e: IOException) {
            HealthConnectorLogger.error(
                tag = TAG,
                operation = "revokeAllPermissions",
                message = "I/O error during revocation",
                exception = e,
            )
            throw HealthConnectorException.HealthService(
                code = HealthConnectorErrorCodeDto.IO_ERROR,
                message = e.message ?: "I/O error",
                cause = e,
            )
        } catch (e: IllegalStateException) {
            HealthConnectorLogger.error(
                tag = TAG,
                operation = "revokeAllPermissions",
                message = "Health platform unavailable",
                exception = e,
            )
            throw HealthConnectorException.HealthServiceUnavailable(
                code = HealthConnectorErrorCodeDto.HEALTH_SERVICE_UNAVAILABLE,
                message = e.message ?: "Health platform unavailable",
                cause = e,
            )
        }
    }

    /**
     * Retrieves the list of permission strings granted to this application by the user.
     *
     * @return A [Set<String>] containing all granted permissions.
     * @throws HealthConnectorException.HealthService for IPC transportation and disk I/O issues.
     * @throws HealthConnectorException.HealthServiceUnavailable if service is not available.
     */
    @Throws(HealthConnectorException::class)
    private suspend fun getGrantedPermissionStrings(): Set<String> {
        try {
            return permissionClient.getGrantedPermissions()
        } catch (e: RemoteException) {
            HealthConnectorLogger.error(
                tag = TAG,
                operation = "getGrantedPermissionStrings",
                message = "Remote exception retrieving permissions",
                exception = e,
            )
            throw HealthConnectorException.HealthService(
                code = HealthConnectorErrorCodeDto.REMOTE_ERROR,
                message = e.message ?: "Remote exception",
                cause = e,
            )
        } catch (e: IOException) {
            HealthConnectorLogger.error(
                tag = TAG,
                operation = "getGrantedPermissionStrings",
                message = "I/O error retrieving permissions",
                exception = e,
            )
            throw HealthConnectorException.HealthService(
                code = HealthConnectorErrorCodeDto.IO_ERROR,
                message = e.message ?: "I/O error",
                cause = e,
            )
        } catch (e: IllegalStateException) {
            HealthConnectorLogger.error(
                tag = TAG,
                operation = "getGrantedPermissionStrings",
                message = "Health platform unavailable",
                exception = e,
            )
            throw HealthConnectorException.HealthServiceUnavailable(
                code = HealthConnectorErrorCodeDto.HEALTH_SERVICE_UNAVAILABLE,
                message = e.message ?: "Health platform unavailable",
                cause = e,
            )
        }
    }
}
