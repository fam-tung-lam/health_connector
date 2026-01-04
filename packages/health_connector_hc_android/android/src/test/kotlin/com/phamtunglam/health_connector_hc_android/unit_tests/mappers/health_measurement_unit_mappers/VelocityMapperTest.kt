package com.phamtunglam.health_connector_hc_android.unit_tests.mappers.health_measurement_unit_mappers

import androidx.health.connect.client.units.Velocity
import com.phamtunglam.health_connector_hc_android.mappers.health_measurement_unit_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.health_measurement_unit_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.VelocityDto
import io.kotest.matchers.shouldBe
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test

/**
 * Unit tests for Velocity Mapper.
 *
 * Tests verify proper bidirectional mapping between [VelocityDto] and Health Connect
 * [Velocity] objects.
 */
@DisplayName("VelocityMapper")
class VelocityMapperTest {

    @Test
    @DisplayName(
        "GIVEN VelocityDto in meters/second → " +
            "WHEN toHealthConnect called → " +
            "THEN creates Velocity with correct value",
    )
    fun whenVelocityDtoInMetersPerSecond_thenCreatesCorrectVelocity() {
        // Given
        val dto = VelocityDto(metersPerSecond = 10.0)

        // When
        val result = dto.toHealthConnect()

        // Then
        result.inMetersPerSecond shouldBe 10.0
    }

    @Test
    @DisplayName(
        "GIVEN Velocity object → " +
            "WHEN toDto called → " +
            "THEN converts to DTO in meters/second",
    )
    fun whenVelocityToDto_thenUsesMetersPerSecond() {
        // Given
        val velocity = Velocity.metersPerSecond(10.0)

        // When
        val result = velocity.toDto()

        // Then
        result.metersPerSecond shouldBe 10.0
    }
}
