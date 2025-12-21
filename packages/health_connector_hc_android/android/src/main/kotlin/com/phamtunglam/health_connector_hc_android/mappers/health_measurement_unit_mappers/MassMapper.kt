package com.phamtunglam.health_connector_hc_android.mappers.health_measurement_unit_mappers

import androidx.health.connect.client.units.Mass
import com.phamtunglam.health_connector_hc_android.pigeon.MassDto
import com.phamtunglam.health_connector_hc_android.pigeon.MassUnitDto

/**
 * Converts a [MassDto] to a Health Connect [Mass] object.
 */
internal fun MassDto.toHealthConnect(): Mass = when (unit) {
    MassUnitDto.KILOGRAMS -> Mass.kilograms(value)
    MassUnitDto.GRAMS -> Mass.grams(value)
    MassUnitDto.POUNDS -> Mass.pounds(value)
    MassUnitDto.OUNCES -> Mass.ounces(value)
}

/**
 * Converts a Health Connect [Mass] object to a [MassDto].
 *
 * Uses kilograms as the transfer unit for consistency.
 */
internal fun Mass.toDto(): MassDto = MassDto(
    value = inKilograms,
    unit = MassUnitDto.KILOGRAMS,
)
