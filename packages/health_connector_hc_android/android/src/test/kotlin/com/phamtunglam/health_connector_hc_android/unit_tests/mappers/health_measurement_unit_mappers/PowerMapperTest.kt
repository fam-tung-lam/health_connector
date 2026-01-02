package com.phamtunglam.health_connector_hc_android.unit_tests.mappers.health_measurement_unit_mappers

import androidx.health.connect.client.units.Power
import com.phamtunglam.health_connector_hc_android.mappers.health_measurement_unit_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.health_measurement_unit_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.PowerDto
import com.phamtunglam.health_connector_hc_android.pigeon.PowerUnitDto
import io.kotest.matchers.shouldBe
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test

/**
 * Unit tests for Power Mapper.
 *
 * Tests verify proper bidirectional mapping between [PowerDto] and Health Connect
 * [Power] objects.
 */
@DisplayName("PowerMapper")
class PowerMapperTest {

    @Test
    @DisplayName(
        "GIVEN PowerDto in watts → " +
            "WHEN toHealthConnect called → " +
            "THEN creates Power with correct value",
    )
    fun whenPowerDtoInWatts_thenCreatesCorrectPower() {
        // Given
        val dto = PowerDto(value = 250.0, unit = PowerUnitDto.WATTS)

        // When
        val result = dto.toHealthConnect()

        // Then
        result.inWatts shouldBe 250.0
    }

    @Test
    @DisplayName(
        "GIVEN Power object → " +
            "WHEN toDto called → " +
            "THEN converts to DTO in watts",
    )
    fun whenPowerToDto_thenUsesWatts() {
        // Given
        val power = Power.watts(250.0)

        // When
        val result = power.toDto()

        // Then
        result.value shouldBe 250.0
        result.unit shouldBe PowerUnitDto.WATTS
    }
}
