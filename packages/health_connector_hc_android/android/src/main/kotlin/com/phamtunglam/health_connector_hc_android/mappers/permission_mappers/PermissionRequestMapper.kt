package com.phamtunglam.health_connector_hc_android.mappers.permission_mappers

import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataPermissionRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataPermissionRequestResultDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthPlatformFeaturePermissionRequest
import com.phamtunglam.health_connector_hc_android.pigeon.HealthPlatformFeaturePermissionRequestResultDto
import com.phamtunglam.health_connector_hc_android.pigeon.PermissionRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.PermissionRequestResultDto
import com.phamtunglam.health_connector_hc_android.pigeon.PermissionStatusDto

/**
 * Converts a [PermissionRequestDto] to a Health Connect permission string.
 *
 * @receiver The [PermissionRequestDto] to convert
 * @return The Health Connect permission string corresponding to the DTO
 */
internal fun PermissionRequestDto.toHealthConnect(): String = when (this) {
    is HealthDataPermissionRequestDto ->
        getHealthConnectPermission(this.healthDataType, this.accessType)

    is HealthPlatformFeaturePermissionRequest ->
        this.feature.toHealthConnect()
}

/**
 * Helper to map a raw permission string to its corresponding DTO result.
 */
fun String.toPermissionRequestResultDto(): PermissionRequestResultDto =
    if (this.isFeaturePermission) {
        HealthPlatformFeaturePermissionRequestResultDto(
            feature = this.toHealthPlatformFeatureDto(),
            status = PermissionStatusDto.GRANTED,
        )
    } else {
        HealthDataPermissionRequestResultDto(
            permission = this.toHealthDataPermissionDto(),
            status = PermissionStatusDto.GRANTED,
        )
    }
