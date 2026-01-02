package com.phamtunglam.health_connector_hc_android.unit_tests.mappers.health_measurement_unit_mappers

import com.phamtunglam.health_connector_hc_android.mappers.health_measurement_unit_mappers.toDto
import com.phamtunglam.health_connector_hc_android.mappers.health_measurement_unit_mappers.toDuration
import com.phamtunglam.health_connector_hc_android.pigeon.TimeDurationDto
import com.phamtunglam.health_connector_hc_android.pigeon.TimeDurationUnitDto
import io.kotest.matchers.shouldBe
import kotlin.time.Duration
import kotlin.time.Duration.Companion.hours
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.TestInstance
import org.junit.jupiter.params.ParameterizedTest
import org.junit.jupiter.params.provider.Arguments
import org.junit.jupiter.params.provider.MethodSource

/**
 * Unit tests for Time Duration Mapper.
 *
 * Tests verify proper bidirectional mapping between [TimeDurationDto] and Kotlin [Duration]
 * objects, including unit conversions between seconds, minutes, and hours.
 */
@DisplayName("TimeDurationMapper")
@TestInstance(TestInstance.Lifecycle.PER_CLASS)
class TimeDurationMapperTest {

    @ParameterizedTest(name = "unit={0}, value={1}")
    @MethodSource("provideTimeDurationUnits")
    @DisplayName(
        "GIVEN TimeDurationDto with various units → " +
            "WHEN toDuration called → " +
            "THEN creates Duration with correct value",
    )
    fun whenTimeDurationDto_thenCreatesCorrectDuration(unit: TimeDurationUnitDto, value: Double) {
        // Given
        val dto = TimeDurationDto(value = value, unit = unit)

        // When
        val result = dto.toDuration()

        // Then
        when (unit) {
            TimeDurationUnitDto.SECONDS -> result.toDouble(
                kotlin.time.DurationUnit.SECONDS,
            ) shouldBe value

            TimeDurationUnitDto.MINUTES -> result.toDouble(
                kotlin.time.DurationUnit.MINUTES,
            ) shouldBe value

            TimeDurationUnitDto.HOURS -> result.toDouble(
                kotlin.time.DurationUnit.HOURS,
            ) shouldBe value
        }
    }

    fun provideTimeDurationUnits(): List<Arguments> = listOf(
        Arguments.of(TimeDurationUnitDto.SECONDS, 3600.0),
        Arguments.of(TimeDurationUnitDto.MINUTES, 60.0),
        Arguments.of(TimeDurationUnitDto.HOURS, 1.0),
    )

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
        result.value shouldBe 3600.0
        result.unit shouldBe TimeDurationUnitDto.SECONDS
    }
}
