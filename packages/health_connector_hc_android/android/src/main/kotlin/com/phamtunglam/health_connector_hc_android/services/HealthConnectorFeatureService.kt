package com.phamtunglam.health_connector_hc_android.services

import androidx.health.connect.client.HealthConnectFeatures
import com.phamtunglam.health_connector_hc_android.logger.HealthConnectorLogger
import com.phamtunglam.health_connector_hc_android.mappers.toHealthConnectFeature
import com.phamtunglam.health_connector_hc_android.mappers.toHealthPlatformFeatureStatusDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthPlatformFeatureDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthPlatformFeatureStatusDto

/**
 * Internal service responsible for querying the availability of specific Health Connect features.
 *
 * @property client The native client used to check feature status on the device.
 */
internal class HealthConnectorFeatureService(private val client: HealthConnectFeatures) {
    companion object {
        private const val TAG = "HealthConnectorDataSyncService"
    }

    /**
     * Retrieves the current availability status of a specific [feature] on the device.
     *
     * This method maps the input [HealthPlatformFeatureDto] to a native Health Connect feature constant,
     * checks its status via the [client] client, and returns the result as a DTO.
     *
     * @param feature The requested feature to check (e.g., background reads).
     * @return A [HealthPlatformFeatureStatusDto] indicating if the feature is available, unavailable, or unsupported.
     */
    fun getFeatureStatus(feature: HealthPlatformFeatureDto): HealthPlatformFeatureStatusDto {
        val context = mapOf(
            "feature" to feature.name,
        )
        HealthConnectorLogger.debug(
            tag = TAG,
            operation = "getFeatureStatus",
            message = "Checking feature availability",
            context = context,
        )

        val healthConnectFeature = feature.toHealthConnectFeature()

        val statusCode = client.getFeatureStatus(healthConnectFeature)

        val status = statusCode.toHealthPlatformFeatureStatusDto()

        HealthConnectorLogger.info(
            tag = TAG,
            operation = "getFeatureStatus",
            message = "Feature status retrieved successfully",
            context = context + mapOf("status" to status.name),
        )

        return status
    }
}
