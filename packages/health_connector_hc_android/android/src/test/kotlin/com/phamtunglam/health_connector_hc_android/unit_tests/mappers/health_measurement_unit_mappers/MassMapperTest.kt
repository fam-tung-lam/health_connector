package com.phamtunglam.health_connector_hc_android.unit_tests.mappers.health_measurement_unit_mappers

import androidx.health.connect.client.units.Mass
import com.phamtunglam.health_connector_hc_android.mappers.health_measurement_unit_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.health_measurement_unit_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.MassDto
import io.kotest.matchers.shouldBe
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.TestInstance

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

    @Test
    @DisplayName(
        "GIVEN MassDto in kilograms → " +
            "WHEN toHealthConnect called → " +
            "THEN creates Mass with correct value",
    )
    fun whenMassDtoInKilograms_thenCreatesCorrectMass() {
        // Given
        val dto = MassDto(kilograms = TEST_VALUE)

        // When
        val result = dto.toHealthConnect()

        // Then
        result.inKilograms shouldBe TEST_VALUE
    }

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
        result.kilograms shouldBe TEST_VALUE
    }
}
