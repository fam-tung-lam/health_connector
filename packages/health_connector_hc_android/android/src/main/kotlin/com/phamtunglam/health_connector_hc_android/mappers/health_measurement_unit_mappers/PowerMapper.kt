package com.phamtunglam.health_connector_hc_android.mappers.health_measurement_unit_mappers

import androidx.health.connect.client.units.Power
import com.phamtunglam.health_connector_hc_android.pigeon.PowerDto

/**
 * Converts a [PowerDto] to a Health Connect [Power] object.
 */
internal fun PowerDto.toHealthConnect(): Power = Power.watts(watts)

/**
 * Converts a Health Connect [Power] object to a [PowerDto].
 *
 * Uses watts as the transfer unit for consistency.
 */
internal fun Power.toDto(): PowerDto = PowerDto(
    watts = inWatts,
)
