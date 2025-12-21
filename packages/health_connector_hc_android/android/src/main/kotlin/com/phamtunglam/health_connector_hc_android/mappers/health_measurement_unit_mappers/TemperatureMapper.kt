package com.phamtunglam.health_connector_hc_android.mappers.health_measurement_unit_mappers

import androidx.health.connect.client.units.Temperature
import com.phamtunglam.health_connector_hc_android.pigeon.TemperatureDto
import com.phamtunglam.health_connector_hc_android.pigeon.TemperatureUnitDto

/**
 * Kelvin to Celsius conversion constant.
 */
private const val KELVIN_TO_CELSIUS_OFFSET = 273.15

/**
 * Converts a [TemperatureDto] to a Health Connect [Temperature] object.
 */
internal fun TemperatureDto.toHealthConnect(): Temperature = when (unit) {
    TemperatureUnitDto.CELSIUS -> Temperature.celsius(value)
    TemperatureUnitDto.FAHRENHEIT -> Temperature.fahrenheit(value)
    TemperatureUnitDto.KELVIN -> Temperature.celsius(value - KELVIN_TO_CELSIUS_OFFSET)
}

/**
 * Converts a Health Connect [Temperature] object to a [TemperatureDto].
 *
 * Uses celsius as the transfer unit for consistency.
 */
internal fun Temperature.toDto(): TemperatureDto = TemperatureDto(
    value = inCelsius,
    unit = TemperatureUnitDto.CELSIUS,
)

/**
 * Converts a temperature value (Double in Celsius) to a [TemperatureDto].
 *
 * Uses celsius as the transfer unit for consistency.
 */
internal fun Double.toTemperatureDto(): TemperatureDto = TemperatureDto(
    value = this,
    unit = TemperatureUnitDto.CELSIUS,
)
