package com.phamtunglam.health_connector_hc_android.mappers.health_measurement_unit_mappers

import androidx.health.connect.client.units.Pressure
import com.phamtunglam.health_connector_hc_android.pigeon.PressureDto
import com.phamtunglam.health_connector_hc_android.pigeon.PressureUnitDto

/**
 * Converts a [PressureDto] to a Health Connect [Pressure] object.
 */
internal fun PressureDto.toHealthConnect(): Pressure = when (unit) {
    PressureUnitDto.MILLIMETERS_OF_MERCURY -> Pressure.millimetersOfMercury(value)
}

/**
 * Converts a Health Connect [Pressure] object to a [PressureDto].
 *
 * Uses millimeters of mercury as the transfer unit.
 */
internal fun Pressure.toDto(): PressureDto = PressureDto(
    value = inMillimetersOfMercury,
    unit = PressureUnitDto.MILLIMETERS_OF_MERCURY,
)
