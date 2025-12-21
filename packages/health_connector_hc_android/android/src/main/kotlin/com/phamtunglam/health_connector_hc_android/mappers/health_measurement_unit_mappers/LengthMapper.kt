package com.phamtunglam.health_connector_hc_android.mappers.health_measurement_unit_mappers

import androidx.health.connect.client.units.Length
import com.phamtunglam.health_connector_hc_android.pigeon.LengthDto
import com.phamtunglam.health_connector_hc_android.pigeon.LengthUnitDto

/**
 * Converts a [LengthDto] to a Health Connect [Length] object.
 */
internal fun LengthDto.toHealthConnect(): Length = when (unit) {
    LengthUnitDto.METERS -> Length.meters(value)
    LengthUnitDto.KILOMETERS -> Length.kilometers(value)
    LengthUnitDto.MILES -> Length.miles(value)
    LengthUnitDto.FEET -> Length.feet(value)
    LengthUnitDto.INCHES -> Length.inches(value)
}

/**
 * Converts a Health Connect [Length] object to a [LengthDto].
 *
 * Uses meters as the transfer unit for consistency.
 */
internal fun Length.toDto(): LengthDto = LengthDto(
    value = inMeters,
    unit = LengthUnitDto.METERS,
)
