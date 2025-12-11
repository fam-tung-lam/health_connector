package com.phamtunglam.health_connector_hc_android.mappers

import androidx.health.connect.client.HealthConnectClient
import com.phamtunglam.health_connector_hc_android.pigeon.HealthPlatformStatusDto

/**
 * Converts a Health Connect SDK status code to a [HealthPlatformStatusDto].
 *
 * @receiver The Health Connect SDK status code
 * @return The corresponding [HealthPlatformStatusDto]
 */
internal fun Int.toHealthPlatformStatusDto(): HealthPlatformStatusDto = when (this) {
    HealthConnectClient.SDK_AVAILABLE -> HealthPlatformStatusDto.AVAILABLE
    HealthConnectClient.SDK_UNAVAILABLE -> HealthPlatformStatusDto.NOT_AVAILABLE
    HealthConnectClient.SDK_UNAVAILABLE_PROVIDER_UPDATE_REQUIRED ->
        HealthPlatformStatusDto.INSTALLATION_OR_UPDATE_REQUIRED
    else -> HealthPlatformStatusDto.NOT_AVAILABLE
}
