package com.phamtunglam.health_connector_hc_android.utils

import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataPermissionRequestResultDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthPlatformFeaturePermissionRequestResultDto
import com.phamtunglam.health_connector_hc_android.pigeon.PermissionRequestResultDto
import com.phamtunglam.health_connector_hc_android.pigeon.PermissionStatusDto

/**
 * Gets [PermissionStatusDto] from an [PermissionRequestResultDto].
 *
 * @return The type of aggregation to perform.
 */
internal val PermissionRequestResultDto.status: PermissionStatusDto
    get() = when (this) {
        is HealthDataPermissionRequestResultDto -> status
        is HealthPlatformFeaturePermissionRequestResultDto -> status
    }
