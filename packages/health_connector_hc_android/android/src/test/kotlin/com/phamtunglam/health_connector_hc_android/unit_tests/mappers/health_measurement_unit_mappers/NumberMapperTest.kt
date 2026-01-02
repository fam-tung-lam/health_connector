package com.phamtunglam.health_connector_hc_android.unit_tests.mappers.health_measurement_unit_mappers

import com.phamtunglam.health_connector_hc_android.mappers.health_measurement_unit_mappers.toNumberDto
import io.kotest.matchers.shouldBe
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.params.ParameterizedTest
import org.junit.jupiter.params.provider.ValueSource

/**
 * Unit tests for Number Mapper.
 *
 * Tests verify proper conversion of numeric values (Int, Long, Double) to [NumberDto].
 */
@DisplayName("NumberMapper")
class NumberMapperTest {

    @ParameterizedTest(name = "value={0}")
    @ValueSource(ints = [0, 1, 100, -50, Int.MAX_VALUE, Int.MIN_VALUE])
    @DisplayName(
        "GIVEN various integer values → " +
            "WHEN toNumberDto called → " +
            "THEN converts to Double and wraps in NumberDto",
    )
    fun whenIntegerValue_thenConvertsToNumberDto(value: Int) {
        // When
        val result = value.toNumberDto()

        // Then
        result.value shouldBe value.toDouble()
    }

    @ParameterizedTest(name = "value={0}")
    @ValueSource(doubles = [0.0, 1.5, 100.99, -50.25, Double.MAX_VALUE])
    @DisplayName(
        "GIVEN various double values → " +
            "WHEN toNumberDto called → " +
            "THEN wraps in NumberDto",
    )
    fun whenDoubleValue_thenWrapsInNumberDto(value: Double) {
        // When
        val result = value.toNumberDto()

        // Then
        result.value shouldBe value
    }

    @ParameterizedTest(name = "value={0}")
    @ValueSource(longs = [0L, 1000L, -5000L, Long.MAX_VALUE, Long.MIN_VALUE])
    @DisplayName(
        "GIVEN various long values → " +
            "WHEN toNumberDto called → " +
            "THEN converts to Double and wraps in NumberDto",
    )
    fun whenLongValue_thenConvertsToNumberDto(value: Long) {
        // When
        val result = value.toNumberDto()

        // Then
        result.value shouldBe value.toDouble()
    }
}
