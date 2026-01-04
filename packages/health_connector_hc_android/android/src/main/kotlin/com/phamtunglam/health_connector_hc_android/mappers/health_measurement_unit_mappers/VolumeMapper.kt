package com.phamtunglam.health_connector_hc_android.mappers.health_measurement_unit_mappers

import androidx.health.connect.client.units.Volume
import com.phamtunglam.health_connector_hc_android.pigeon.VolumeDto

/**
 * Converts a [VolumeDto] to a Health Connect [Volume] object.
 */
internal fun VolumeDto.toHealthConnect(): Volume = Volume.liters(liters)

/**
 * Converts a Health Connect [Volume] object to a [VolumeDto].
 *
 * Uses liters as the transfer unit for consistency.
 */
internal fun Volume.toDto(): VolumeDto = VolumeDto(
    liters = inLiters,
)
