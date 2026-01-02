package com.phamtunglam.health_connector_hc_android.unit_tests.mappers.health_measurement_unit_mappers

import androidx.health.connect.client.units.Mass
import com.phamtunglam.health_connector_hc_android.mappers.health_measurement_unit_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.health_measurement_unit_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.MassDto
import com.phamtunglam.health_connector_hc_android.pigeon.MassUnitDto
import io.kotest.matchers.shouldBe
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.TestInstance
import org.junit.jupiter.params.ParameterizedTest
import org.junit.jupiter.params.provider.Arguments
import org.junit.jupiter.params.provider.MethodSource

/**
 * Unit tests for Mass Mapper.
 *
 * Tests verify proper bidirectional mapping between [MassDto] and Health Connect
 * [Mass] objects, including unit conversions between kilograms, grams, pounds, and ounces.
 */
@DisplayName("MassMapper")
@TestInstance(TestInstance.Lifecycle.PER_CLASS)
class MassMapperTest {

    private companion object {
        const val TEST_VALUE = 100.0
    }

    @ParameterizedTest(name = "unit={0}, value={1}")
    @MethodSource("provideMassUnits")
    @DisplayName(
        "GIVEN MassDto with various units → " +
            "WHEN toHealthConnect called → " +
            "THEN creates Mass with correct value in that unit",
    )
    fun whenMassDto_thenCreatesCorrectMass(unit: MassUnitDto, value: Double) {
        // Given
        val dto = MassDto(value = value, unit = unit)

        // When
        val result = dto.toHealthConnect()

        // Then
        when (unit) {
            MassUnitDto.KILOGRAMS -> result.inKilograms shouldBe value
            MassUnitDto.GRAMS -> result.inGrams shouldBe value
            MassUnitDto.POUNDS -> result.inPounds shouldBe value
            MassUnitDto.OUNCES -> result.inOunces shouldBe value
        }
    }

    fun provideMassUnits(): List<Arguments> = listOf(
        Arguments.of(MassUnitDto.KILOGRAMS, 70.0),
        Arguments.of(MassUnitDto.GRAMS, 70000.0),
        Arguments.of(MassUnitDto.POUNDS, 154.0),
        Arguments.of(MassUnitDto.OUNCES, 2469.0),
    )

    @Test
    @DisplayName(
        "GIVEN Mass object → " +
            "WHEN toDto called → " +
            "THEN converts to DTO in kilograms",
    )
    fun whenMassToDto_thenUsesKilograms() {
        // Given
        val mass = Mass.kilograms(TEST_VALUE)

        // When
        val result = mass.toDto()

        // Then
        result.value shouldBe TEST_VALUE
        result.unit shouldBe MassUnitDto.KILOGRAMS
    }
}
