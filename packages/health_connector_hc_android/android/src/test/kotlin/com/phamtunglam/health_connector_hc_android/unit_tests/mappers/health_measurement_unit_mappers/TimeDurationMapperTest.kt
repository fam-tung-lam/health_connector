package com.phamtunglam.health_connector_hc_android.unit_tests.mappers.health_measurement_unit_mappers

import com.phamtunglam.health_connector_hc_android.mappers.health_measurement_unit_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.health_measurement_unit_mappers.toDuration
import com.phamtunglam.health_connector_hc_android.pigeon.TimeDurationDto
import io.kotest.matchers.shouldBe
import kotlin.time.Duration.Companion.hours
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.TestInstance

/**
 * Unit tests for Time Duration Mapper.
 *
 * Tests verify proper bidirectional mapping between [TimeDurationDto] and Kotlin [Duration]
 * objects, including unit conversions between seconds, minutes, and hours.
 */
@DisplayName("TimeDurationMapper")
@TestInstance(TestInstance.Lifecycle.PER_CLASS)
class TimeDurationMapperTest {

    @Test
    @DisplayName(
        "GIVEN TimeDurationDto in seconds → " +
            "WHEN toDuration called → " +
            "THEN creates Duration with correct value",
    )
    fun whenTimeDurationDtoInSeconds_thenCreatesCorrectDuration() {
        // Given
        val dto = TimeDurationDto(seconds = 3600.0)

        // When
        val result = dto.toDuration()

        // Then
        result.toDouble(kotlin.time.DurationUnit.SECONDS) shouldBe 3600.0
    }

    @Test
    @DisplayName(
        "GIVEN Duration object → " +
            "WHEN toDto called → " +
            "THEN converts to DTO in seconds",
    )
    fun whenDurationToDto_thenUsesSeconds() {
        // Given
        val duration = 1.hours

        // When
        val result = duration.toDto()

        // Then
        result.seconds shouldBe 3600.0
    }
}
