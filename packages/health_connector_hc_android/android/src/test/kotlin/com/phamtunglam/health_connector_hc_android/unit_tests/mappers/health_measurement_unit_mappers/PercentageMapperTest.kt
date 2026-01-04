package com.phamtunglam.health_connector_hc_android.unit_tests.mappers.health_measurement_unit_mappers

import com.phamtunglam.health_connector_hc_android.mappers.health_measurement_unit_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.health_measurement_unit_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.PercentageDto
import io.kotest.matchers.shouldBe
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test

/**
 * Unit tests for Percentage Mapper.
 *
 * Tests verify proper bidirectional mapping between [PercentageDto] and Health Connect
 * Percentage objects, including unit conversions between decimal (0.0-1.0) and whole (0-100).
 */
@DisplayName("PercentageMapper")
class PercentageMapperTest {

    @Test
    @DisplayName(
        "GIVEN PercentageDto in DECIMAL → " +
            "WHEN toHealthConnect called → " +
            "THEN creates Percentage with correct value",
    )
    fun whenDecimalPercentageDto_thenCreatesCorrectPercentage() {
        // Given
        val dto = PercentageDto(decimal = 0.855)

        // When
        val result = dto.toHealthConnect()

        // Then
        result.value shouldBe 0.855
    }

    @Test
    @DisplayName(
        "GIVEN Percentage object → " +
            "WHEN toDto called → " +
            "THEN converts to DTO in DECIMAL unit",
    )
    fun whenPercentageToDto_thenUsesDecimal() {
        // Given
        val percentage = androidx.health.connect.client.units.Percentage(0.75)

        // When
        val result = percentage.toDto()

        // Then
        result.decimal shouldBe 0.75
    }
}
