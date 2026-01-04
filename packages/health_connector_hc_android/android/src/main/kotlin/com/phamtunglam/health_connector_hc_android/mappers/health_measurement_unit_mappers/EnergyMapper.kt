package com.phamtunglam.health_connector_hc_android.mappers.health_measurement_unit_mappers

import androidx.health.connect.client.units.Energy
import com.phamtunglam.health_connector_hc_android.pigeon.EnergyDto

/**
 * Converts an [EnergyDto] to a Health Connect [Energy] object.
 */
internal fun EnergyDto.toHealthConnect(): Energy = Energy.kilocalories(kilocalories)

/**
 * Converts a Health Connect [Energy] object to an [EnergyDto].
 *
 * Uses kilocalories as the transfer unit for consistency.
 */
internal fun Energy.toDto(): EnergyDto = EnergyDto(
    kilocalories = inKilocalories,
)
