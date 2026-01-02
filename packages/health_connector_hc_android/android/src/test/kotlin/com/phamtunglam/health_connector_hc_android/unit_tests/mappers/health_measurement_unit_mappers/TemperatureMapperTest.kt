package com.phamtunglam.health_connector_hc_android.unit_tests.mappers.health_measurement_unit_mappers

import androidx.health.connect.client.units.Temperature
import com.phamtunglam.health_connector_hc_android.mappers.health_measurement_unit_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.health_measurement_unit_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.TemperatureDto
import com.phamtunglam.health_connector_hc_android.pigeon.TemperatureUnitDto
import io.kotest.matchers.shouldBe
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test

/**
 * Unit tests for Temperature Mapper.
 *
 * Tests verify proper bidirectional mapping between [TemperatureDto] and Health Connect
 * [Temperature] objects.
 */
@DisplayName("TemperatureMapper")
class TemperatureMapperTest {

    @Test
    @DisplayName(
        "GIVEN TemperatureDto in Celsius → " +
            "WHEN toHealthConnect called → " +
            "THEN creates Temperature with correct value",
    )
    fun whenTemperatureDtoInCelsius_thenCreatesCorrectTemperature() {
        // Given
        val dto = TemperatureDto(value = 37.0, unit = TemperatureUnitDto.CELSIUS)

        // When
        val result = dto.toHealthConnect()

        // Then
        result.inCelsius shouldBe 37.0
    }

    @Test
    @DisplayName(
        "GIVEN Temperature object → " +
            "WHEN toDto called → " +
            "THEN converts to DTO in Celsius",
    )
    fun whenTemperatureToDto_thenUsesCelsius() {
        // Given
        val temperature = Temperature.celsius(37.0)

        // When
        val result = temperature.toDto()

        // Then
        result.value shouldBe 37.0
        result.unit shouldBe TemperatureUnitDto.CELSIUS
    }
}
