package com.phamtunglam.health_connector_hc_android.mappers.health_measurement_unit_mappers

import androidx.health.connect.client.units.Energy
import com.phamtunglam.health_connector_hc_android.pigeon.EnergyDto
import com.phamtunglam.health_connector_hc_android.pigeon.EnergyUnitDto

/**
 * Converts an [EnergyDto] to a Health Connect [Energy] object.
 */
internal fun EnergyDto.toHealthConnect(): Energy = when (unit) {
    EnergyUnitDto.KILOCALORIES -> Energy.kilocalories(value)
    EnergyUnitDto.KILOJOULES -> Energy.kilojoules(value)
    EnergyUnitDto.CALORIES -> Energy.calories(value)
    EnergyUnitDto.JOULES -> Energy.joules(value)
}

/**
 * Converts a Health Connect [Energy] object to an [EnergyDto].
 *
 * Uses kilocalories as the transfer unit for consistency.
 */
internal fun Energy.toDto(): EnergyDto = EnergyDto(
    value = inKilocalories,
    unit = EnergyUnitDto.KILOCALORIES,
)
