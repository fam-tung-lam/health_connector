package com.phamtunglam.health_connector_hc_android.mappers

import androidx.health.connect.client.HealthConnectFeatures
import com.phamtunglam.health_connector_hc_android.pigeon.HealthPlatformFeatureDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthPlatformFeatureStatusDto

/**
 * Converts a [HealthPlatformFeatureDto] to a Health Connect feature constant.
 *
 * @receiver The [HealthPlatformFeatureDto] to convert
 * @return The corresponding Health Connect feature constant
 */
internal fun HealthPlatformFeatureDto.toHealthConnectFeature(): Int = when (this) {
    HealthPlatformFeatureDto.READ_HEALTH_DATA_IN_BACKGROUND ->
        HealthConnectFeatures.FEATURE_READ_HEALTH_DATA_IN_BACKGROUND

    HealthPlatformFeatureDto.READ_HEALTH_DATA_HISTORY ->
        HealthConnectFeatures.FEATURE_READ_HEALTH_DATA_HISTORY
}

/**
 * Converts a Health Connect feature status code to a [HealthPlatformFeatureStatusDto].
 *
 * @receiver The Health Connect feature status code
 * @return The corresponding [HealthPlatformFeatureStatusDto]
 */
internal fun Int.toHealthPlatformFeatureStatusDto(): HealthPlatformFeatureStatusDto =
    if (this == HealthConnectFeatures.FEATURE_STATUS_AVAILABLE) {
        HealthPlatformFeatureStatusDto.AVAILABLE
    } else {
        HealthPlatformFeatureStatusDto.UNAVAILABLE
    }
