package com.phamtunglam.health_connector_hc_android.mappers.health_measurement_unit_mappers

import androidx.health.connect.client.units.Volume
import com.phamtunglam.health_connector_hc_android.pigeon.VolumeDto
import com.phamtunglam.health_connector_hc_android.pigeon.VolumeUnitDto

/**
 * Converts a [VolumeDto] to a Health Connect [Volume] object.
 */
internal fun VolumeDto.toHealthConnect(): Volume = when (unit) {
    VolumeUnitDto.LITERS -> Volume.liters(value)
    VolumeUnitDto.MILLILITERS -> Volume.milliliters(value)
    VolumeUnitDto.FLUID_OUNCES_US -> Volume.fluidOuncesUs(value)
}

/**
 * Converts a Health Connect [Volume] object to a [VolumeDto].
 *
 * Uses liters as the transfer unit for consistency.
 */
internal fun Volume.toDto(): VolumeDto = VolumeDto(
    value = inLiters,
    unit = VolumeUnitDto.LITERS,
)
