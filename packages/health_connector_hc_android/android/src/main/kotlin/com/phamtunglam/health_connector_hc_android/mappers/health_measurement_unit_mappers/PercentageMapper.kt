package com.phamtunglam.health_connector_hc_android.mappers.health_measurement_unit_mappers

import androidx.health.connect.client.units.Percentage
import com.phamtunglam.health_connector_hc_android.pigeon.PercentageDto
import com.phamtunglam.health_connector_hc_android.pigeon.PercentageUnitDto

/**
 * Conversion factor from whole percentage (0-100) to decimal (0.0-1.0).
 */
private const val PERCENTAGE_WHOLE_TO_DECIMAL = 100.0

/**
 * Converts a [PercentageDto] to a Health Connect [Percentage] object.
 */
internal fun PercentageDto.toHealthConnect(): Percentage = when (unit) {
    PercentageUnitDto.DECIMAL -> Percentage(value)
    PercentageUnitDto.WHOLE -> Percentage(value / PERCENTAGE_WHOLE_TO_DECIMAL)
}

/**
 * Converts a Health Connect [Percentage] object to a [PercentageDto].
 *
 * Uses decimal as the transfer unit for consistency (0.0 to 1.0).
 */
internal fun Percentage.toDto(): PercentageDto = PercentageDto(
    value = value,
    unit = PercentageUnitDto.DECIMAL,
)
