package com.phamtunglam.health_connector_hc_android.mappers.health_measurement_unit_mappers

import androidx.health.connect.client.units.Percentage
import com.phamtunglam.health_connector_hc_android.pigeon.PercentageDto

/**
 * Converts a [PercentageDto] to a Health Connect [Percentage] object.
 */
internal fun PercentageDto.toHealthConnect(): Percentage = Percentage(decimal)

/**
 * Converts a Health Connect [Percentage] object to a [PercentageDto].
 *
 * Uses decimal as the transfer unit for consistency (0.0 to 1.0).
 */
internal fun Percentage.toDto(): PercentageDto = PercentageDto(
    decimal = value,
)
