package com.phamtunglam.health_connector_hc_android.mappers.health_measurement_unit_mappers

import androidx.health.connect.client.units.Length
import com.phamtunglam.health_connector_hc_android.pigeon.LengthDto

/**
 * Converts a [LengthDto] to a Health Connect [Length] object.
 */
internal fun LengthDto.toHealthConnect(): Length = Length.meters(meters)

/**
 * Converts a Health Connect [Length] object to a [LengthDto].
 *
 * Uses meters as the transfer unit for consistency.
 */
internal fun Length.toDto(): LengthDto = LengthDto(
    meters = inMeters,
)
