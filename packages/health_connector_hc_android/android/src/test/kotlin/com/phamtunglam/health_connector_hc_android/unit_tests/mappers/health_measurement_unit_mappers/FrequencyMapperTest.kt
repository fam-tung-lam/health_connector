package com.phamtunglam.health_connector_hc_android.unit_tests.mappers.health_measurement_unit_mappers

import com.phamtunglam.health_connector_hc_android.mappers.health_measurement_unit_mappers.toFrequencyDto
import com.phamtunglam.health_connector_hc_android.pigeon.FrequencyDto
import io.kotest.matchers.shouldBe
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.params.ParameterizedTest
import org.junit.jupiter.params.provider.ValueSource

/**
 * Unit tests for Frequency Mapper.
 *
 * Tests verify proper conversion of numeric values (Int, Long, Double) to [FrequencyDto].
 */
@DisplayName("FrequencyMapper")
class FrequencyMapperTest {

    @ParameterizedTest(name = "value={0}")
    @ValueSource(ints = [0, 1, 60, 72, 100, 120, 150, Int.MAX_VALUE])
    @DisplayName(
        "GIVEN various integer values → " +
            "WHEN toFrequencyDto called → " +
            "THEN converts to Double and wraps in FrequencyDto with perMinute",
    )
    fun whenIntegerValue_thenConvertsToFrequencyDto(value: Int) {
        // When
        val result = value.toFrequencyDto()

        // Then
        result.perMinute shouldBe value.toDouble()
    }

    @ParameterizedTest(name = "value={0}")
    @ValueSource(doubles = [0.0, 1.0, 60.5, 72.8, 100.99, 120.0, 150.5, Double.MAX_VALUE])
    @DisplayName(
        "GIVEN various double values → " +
            "WHEN toFrequencyDto called → " +
            "THEN wraps in FrequencyDto with perMinute",
    )
    fun whenDoubleValue_thenWrapsInFrequencyDto(value: Double) {
        // When
        val result = value.toFrequencyDto()

        // Then
        result.perMinute shouldBe value
    }

    @ParameterizedTest(name = "value={0}")
    @ValueSource(longs = [0L, 60L, 72L, 100L, 120L, 1000L, Long.MAX_VALUE])
    @DisplayName(
        "GIVEN various long values → " +
            "WHEN toFrequencyDto called → " +
            "THEN converts to Double and wraps in FrequencyDto with perMinute",
    )
    fun whenLongValue_thenConvertsToFrequencyDto(value: Long) {
        // When
        val result = value.toFrequencyDto()

        // Then
        result.perMinute shouldBe value.toDouble()
    }
}
