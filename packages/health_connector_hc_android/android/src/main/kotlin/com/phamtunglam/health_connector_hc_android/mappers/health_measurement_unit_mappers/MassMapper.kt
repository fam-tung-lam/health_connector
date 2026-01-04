package com.phamtunglam.health_connector_hc_android.mappers.health_measurement_unit_mappers

import androidx.health.connect.client.units.Mass
import com.phamtunglam.health_connector_hc_android.pigeon.MassDto

/**
 * Converts a [MassDto] to a Health Connect [Mass] object.
 */
internal fun MassDto.toHealthConnect(): Mass = Mass.kilograms(kilograms)

/**
 * Converts a Health Connect [Mass] object to a [MassDto].
 *
 * Uses kilograms as the transfer unit for consistency.
 */
internal fun Mass.toDto(): MassDto = MassDto(
    kilograms = inKilograms,
)
