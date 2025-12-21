package com.phamtunglam.health_connector_hc_android.mappers.health_measurement_unit_mappers

import androidx.health.connect.client.units.Power
import com.phamtunglam.health_connector_hc_android.pigeon.PowerDto
import com.phamtunglam.health_connector_hc_android.pigeon.PowerUnitDto

/**
 * Conversion factor from kilowatts to watts.
 */
private const val KILOWATTS_TO_WATTS = 1000

/**
 * Converts a [PowerDto] to a Health Connect [Power] object.
 */
internal fun PowerDto.toHealthConnect(): Power = when (unit) {
    PowerUnitDto.WATTS -> Power.watts(value)
    PowerUnitDto.KILOWATTS -> Power.watts(value * KILOWATTS_TO_WATTS)
}

/**
 * Converts a Health Connect [Power] object to a [PowerDto].
 *
 * Uses watts as the transfer unit for consistency.
 */
internal fun Power.toDto(): PowerDto = PowerDto(
    value = inWatts,
    unit = PowerUnitDto.WATTS,
)
