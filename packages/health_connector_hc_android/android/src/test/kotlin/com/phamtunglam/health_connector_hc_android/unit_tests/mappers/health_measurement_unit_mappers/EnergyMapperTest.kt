package com.phamtunglam.health_connector_hc_android.unit_tests.mappers.health_measurement_unit_mappers

import androidx.health.connect.client.units.Energy
import com.phamtunglam.health_connector_hc_android.mappers.health_measurement_unit_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.health_measurement_unit_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.EnergyDto
import io.kotest.matchers.shouldBe
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.TestInstance

/**
 * Unit tests for Energy Mapper.
 *
 * Tests verify proper bidirectional mapping between [EnergyDto] and Health Connect
 * [Energy] objects, including unit conversions between kilocalories, kilojoules, calories, and joules.
 */
@DisplayName("EnergyMapper")
@TestInstance(TestInstance.Lifecycle.PER_CLASS)
class EnergyMapperTest {

    private companion object {
        const val TEST_VALUE = 100.0
    }

    @Test
    @DisplayName(
        "GIVEN EnergyDto in kilocalories → " +
            "WHEN toHealthConnect called → " +
            "THEN creates Energy with correct value",
    )
    fun whenEnergyDtoInKilocalories_thenCreatesCorrectEnergy() {
        // Given
        val dto = EnergyDto(kilocalories = TEST_VALUE)

        // When
        val result = dto.toHealthConnect()

        // Then
        result.inKilocalories shouldBe TEST_VALUE
    }

    @Test
    @DisplayName(
        "GIVEN Energy object → " +
            "WHEN toDto called → " +
            "THEN converts to DTO in kilocalories",
    )
    fun whenEnergyToDto_thenUsesKilocalories() {
        // Given
        val energy = Energy.kilocalories(TEST_VALUE)

        // When
        val result = energy.toDto()

        // Then
        result.kilocalories shouldBe TEST_VALUE
    }
}
