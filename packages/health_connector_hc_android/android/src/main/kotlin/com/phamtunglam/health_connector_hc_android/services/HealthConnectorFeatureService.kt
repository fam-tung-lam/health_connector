package com.phamtunglam.health_connector_hc_android.services

import androidx.health.connect.client.HealthConnectFeatures
import com.phamtunglam.health_connector_hc_android.mappers.toHealthConnectFeature
import com.phamtunglam.health_connector_hc_android.mappers.toHealthPlatformFeatureStatusDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthConnectorErrorDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthPlatformFeatureDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthPlatformFeatureStatusDto

/**
 * Internal service responsible for querying the availability of specific Health Connect features.
 *
 * @property client The native client used to check feature status on the device.
 */
internal class HealthConnectorFeatureService(private val client: HealthConnectFeatures) {

    /**
     * Retrieves the current availability status of a specific [feature] on the device.
     *
     * This method maps the input [HealthPlatformFeatureDto] to a native Health Connect feature constant,
     * checks its status via the [client] client, and returns the result as a DTO.
     *
     * @param feature The requested feature to check (e.g., background reads).
     * @return A [HealthPlatformFeatureStatusDto] indicating if the feature is available, unavailable, or unsupported.
     * @throws HealthConnectorErrorDto If the [feature] cannot be mapped to a native constant or if an underlying error occurs.
     */
    @Throws(HealthConnectorErrorDto::class)
    fun getFeatureStatus(feature: HealthPlatformFeatureDto): HealthPlatformFeatureStatusDto {
        val healthConnectFeature = feature.toHealthConnectFeature()

        val statusCode = client.getFeatureStatus(healthConnectFeature)

        return statusCode.toHealthPlatformFeatureStatusDto()
    }
}
