package com.phamtunglam.health_connector_hc_android.mappers.health_measurement_unit_mappers

import androidx.health.connect.client.units.Temperature
import com.phamtunglam.health_connector_hc_android.pigeon.TemperatureDto

/**
 * Converts a [TemperatureDto] to a Health Connect [Temperature] object.
 */
internal fun TemperatureDto.toHealthConnect(): Temperature = Temperature.celsius(celsius)

/**
 * Converts a Health Connect [Temperature] object to a [TemperatureDto].
 *
 * Uses celsius as the transfer unit for consistency.
 */
internal fun Temperature.toDto(): TemperatureDto = TemperatureDto(
    celsius = inCelsius,
)

/**
 * Converts a temperature value (Double in Celsius) to a [TemperatureDto].
 *
 * Uses celsius as the transfer unit for consistency.
 */
internal fun Double.toTemperatureDto(): TemperatureDto = TemperatureDto(
    celsius = this,
)
