package com.phamtunglam.health_connector_hc_android.mappers.health_measurement_unit_mappers

import androidx.health.connect.client.units.Velocity
import com.phamtunglam.health_connector_hc_android.pigeon.VelocityDto
import com.phamtunglam.health_connector_hc_android.pigeon.VelocityUnitDto

/**
 * Converts a [VelocityDto] to a Health Connect [Velocity] object.
 */
internal fun VelocityDto.toHealthConnect(): Velocity = when (unit) {
    VelocityUnitDto.METERS_PER_SECOND -> Velocity.metersPerSecond(value)
    VelocityUnitDto.KILOMETERS_PER_HOUR -> Velocity.kilometersPerHour(value)
    VelocityUnitDto.MILES_PER_HOUR -> Velocity.milesPerHour(value)
}

/**
 * Converts a Health Connect [Velocity] object to a [VelocityDto].
 *
 * Uses meters per second as the transfer unit for consistency.
 */
internal fun Velocity.toDto(): VelocityDto = VelocityDto(
    value = inMetersPerSecond,
    unit = VelocityUnitDto.METERS_PER_SECOND,
)
