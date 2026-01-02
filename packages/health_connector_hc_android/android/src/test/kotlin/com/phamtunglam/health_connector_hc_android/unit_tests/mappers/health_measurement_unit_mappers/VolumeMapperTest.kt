package com.phamtunglam.health_connector_hc_android.unit_tests.mappers.health_measurement_unit_mappers

import androidx.health.connect.client.units.Volume
import com.phamtunglam.health_connector_hc_android.mappers.health_measurement_unit_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.health_measurement_unit_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.pigeon.VolumeDto
import com.phamtunglam.health_connector_hc_android.pigeon.VolumeUnitDto
import io.kotest.matchers.shouldBe
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test

/**
 * Unit tests for Volume Mapper.
 *
 * Tests verify proper bidirectional mapping between [VolumeDto] and Health Connect
 * [Volume] objects.
 */
@DisplayName("VolumeMapper")
class VolumeMapperTest {

    private companion object {
        const val TEST_VALUE = 100.0
    }

    @Test
    @DisplayName(
        "GIVEN VolumeDto in liters → " +
            "WHEN toHealthConnect called → " +
            "THEN creates Volume with correct value",
    )
    fun whenVolumeDtoInLiters_thenCreatesCorrectVolume() {
        // Given
        val dto = VolumeDto(value = TEST_VALUE, unit = VolumeUnitDto.LITERS)

        // When
        val result = dto.toHealthConnect()

        // Then
        result.inLiters shouldBe TEST_VALUE
    }

    @Test
    @DisplayName(
        "GIVEN Volume object → " +
            "WHEN toDto called → " +
            "THEN converts to DTO in liters",
    )
    fun whenVolumeToDto_thenUsesLiters() {
        // Given
        val volume = Volume.liters(TEST_VALUE)

        // When
        val result = volume.toDto()

        // Then
        result.value shouldBe TEST_VALUE
        result.unit shouldBe VolumeUnitDto.LITERS
    }
}
