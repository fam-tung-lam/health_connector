package com.phamtunglam.health_connector_hc_android.unit_tests.mappers.health_measurement_unit_mappers

import androidx.health.connect.client.units.Energy
import com.phamtunglam.health_connector_hc_android.mappers.health_measurement_unit_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.health_measurement_unit_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.EnergyDto
import com.phamtunglam.health_connector_hc_android.pigeon.EnergyUnitDto
import io.kotest.matchers.shouldBe
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.TestInstance
import org.junit.jupiter.params.ParameterizedTest
import org.junit.jupiter.params.provider.Arguments
import org.junit.jupiter.params.provider.MethodSource

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

    @ParameterizedTest(name = "unit={0}, value={1}")
    @MethodSource("provideEnergyUnits")
    @DisplayName(
        "GIVEN EnergyDto with various units → " +
            "WHEN toHealthConnect called → " +
            "THEN creates Energy with correct value in that unit",
    )
    fun whenEnergyDto_thenCreatesCorrectEnergy(unit: EnergyUnitDto, value: Double) {
        // Given
        val dto = EnergyDto(value = value, unit = unit)

        // When
        val result = dto.toHealthConnect()

        // Then
        when (unit) {
            EnergyUnitDto.KILOCALORIES -> result.inKilocalories shouldBe value
            EnergyUnitDto.KILOJOULES -> result.inKilojoules shouldBe value
            EnergyUnitDto.CALORIES -> result.inCalories shouldBe value
            EnergyUnitDto.JOULES -> result.inJoules shouldBe value
        }
    }

    fun provideEnergyUnits(): List<Arguments> = listOf(
        Arguments.of(EnergyUnitDto.KILOCALORIES, 250.0),
        Arguments.of(EnergyUnitDto.KILOJOULES, 1046.0),
        Arguments.of(EnergyUnitDto.CALORIES, 250000.0),
        Arguments.of(EnergyUnitDto.JOULES, 1046000.0),
    )

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
        result.value shouldBe TEST_VALUE
        result.unit shouldBe EnergyUnitDto.KILOCALORIES
    }
}
