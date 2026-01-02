package com.phamtunglam.health_connector_hc_android.unit_tests.mappers.health_measurement_unit_mappers

import androidx.health.connect.client.units.Length
import com.phamtunglam.health_connector_hc_android.mappers.health_measurement_unit_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.health_measurement_unit_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.LengthDto
import com.phamtunglam.health_connector_hc_android.pigeon.LengthUnitDto
import io.kotest.matchers.shouldBe
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test

/**
 * Unit tests for Length Mapper.
 *
 * Tests verify proper bidirectional mapping between [LengthDto] and Health Connect
 * [Length] objects.
 */
@DisplayName("LengthMapper")
class LengthMapperTest {

    private companion object {
        const val TEST_VALUE = 100.0
    }

    @Test
    @DisplayName(
        "GIVEN LengthDto in meters → " +
            "WHEN toHealthConnect called → " +
            "THEN creates Length with correct value",
    )
    fun whenLengthDtoInMeters_thenCreatesCorrectLength() {
        // Given
        val dto = LengthDto(value = TEST_VALUE, unit = LengthUnitDto.METERS)

        // When
        val result = dto.toHealthConnect()

        // Then
        result.inMeters shouldBe TEST_VALUE
    }

    @Test
    @DisplayName(
        "GIVEN Length object → " +
            "WHEN toDto called → " +
            "THEN converts to DTO in meters",
    )
    fun whenLengthToDto_thenUsesMeters() {
        // Given
        val length = Length.meters(TEST_VALUE)

        // When
        val result = length.toDto()

        // Then
        result.value shouldBe TEST_VALUE
        result.unit shouldBe LengthUnitDto.METERS
    }
}
