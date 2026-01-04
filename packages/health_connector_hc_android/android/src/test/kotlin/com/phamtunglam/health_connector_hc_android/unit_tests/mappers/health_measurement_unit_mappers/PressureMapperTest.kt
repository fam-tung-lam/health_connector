package com.phamtunglam.health_connector_hc_android.unit_tests.mappers.health_measurement_unit_mappers

import androidx.health.connect.client.units.Pressure
import com.phamtunglam.health_connector_hc_android.mappers.health_measurement_unit_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.health_measurement_unit_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.PressureDto
import io.kotest.matchers.shouldBe
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test

/**
 * Unit tests for Pressure Mapper.
 *
 * Tests verify proper bidirectional mapping between [PressureDto] and Health Connect
 * [Pressure] objects.
 */
@DisplayName("PressureMapper")
class PressureMapperTest {

    @Test
    @DisplayName(
        "GIVEN PressureDto in mmHg → " +
            "WHEN toHealthConnect called → " +
            "THEN creates Pressure with correct value",
    )
    fun whenPressureDtoInMmHg_thenCreatesCorrectPressure() {
        // Given
        val dto = PressureDto(millimetersOfMercury = 120.0)

        // When
        val result = dto.toHealthConnect()

        // Then
        result.inMillimetersOfMercury shouldBe 120.0
    }

    @Test
    @DisplayName(
        "GIVEN Pressure object → " +
            "WHEN toDto called → " +
            "THEN converts to DTO in mmHg",
    )
    fun whenPressureToDto_thenUsesMillimetersOfMercury() {
        // Given
        val pressure = Pressure.millimetersOfMercury(120.0)

        // When
        val result = pressure.toDto()

        // Then
        result.millimetersOfMercury shouldBe 120.0
    }
}
