package com.phamtunglam.health_connector_hc_android.mappers.health_measurement_unit_mappers

import androidx.health.connect.client.units.Velocity
import com.phamtunglam.health_connector_hc_android.pigeon.VelocityDto

/**
 * Converts a [VelocityDto] to a Health Connect [Velocity] object.
 */
internal fun VelocityDto.toHealthConnect(): Velocity = Velocity.metersPerSecond(metersPerSecond)

/**
 * Converts a Health Connect [Velocity] object to a [VelocityDto].
 *
 * Uses meters per second as the transfer unit for consistency.
 */
internal fun Velocity.toDto(): VelocityDto = VelocityDto(
    metersPerSecond = inMetersPerSecond,
)
