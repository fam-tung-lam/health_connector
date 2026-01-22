package com.phamtunglam.health_connector_hc_android.unit_tests.utils

import com.phamtunglam.health_connector_hc_android.pigeon.AggregateRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.AggregationMetricDto
import com.phamtunglam.health_connector_hc_android.pigeon.BloodPressureAggregateRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.BloodPressureDataTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.StandardAggregateRequestDto
import com.phamtunglam.health_connector_hc_android.utils.dataType
import io.kotest.matchers.shouldBe
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Nested
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.TestInstance

/**
 * Unit tests for AggregateRequestDto Extensions.
 *
 * Tests verify proper extraction of common fields from [AggregateRequestDto] sealed class
 * and its subclasses ([StandardAggregateRequestDto] and [BloodPressureAggregateRequestDto]).
 * These extensions work around a Pigeon limitation where sealed classes cannot have fields.
 */
@DisplayName("AggregateRequestDtoExtensions")
class AggregateRequestDtoExtensionTest {

    private companion object {
        const val TEST_START_TIME = 1609459200000L // 2021-01-01 00:00:00 UTC
        const val TEST_END_TIME = 1609545600000L // 2021-01-02 00:00:00 UTC
    }

    // region StandardAggregateRequestDto Tests

    @Nested
    @TestInstance(TestInstance.Lifecycle.PER_CLASS)
    @DisplayName("StandardAggregateRequestDto")
    inner class CommonAggregateRequestDtoTests {

        @Test
        @DisplayName(
            "GIVEN StandardAggregateRequestDto with all fields → " +
                "WHEN all extensions accessed → " +
                "THEN returns all correct values",
        )
        fun whenCommonRequest_thenAllExtensionsWork() {
            // Given
            val request = StandardAggregateRequestDto(
                startTime = TEST_START_TIME,
                endTime = TEST_END_TIME,
                aggregationMetric = AggregationMetricDto.AVG,
                dataType = HealthDataTypeDto.HEART_RATE_SERIES,
            )

            // When & Then
            request.startTime shouldBe TEST_START_TIME
            request.endTime shouldBe TEST_END_TIME
            request.aggregationMetric shouldBe AggregationMetricDto.AVG
            request.dataType shouldBe HealthDataTypeDto.HEART_RATE_SERIES
        }
    }

    // endregion

    // region BloodPressureAggregateRequestDto Tests

    @Nested
    @DisplayName("BloodPressureAggregateRequestDto")
    inner class BloodPressureAggregateRequestDtoTests {

        @Test
        @DisplayName(
            "GIVEN BloodPressureAggregateRequestDto with all fields → " +
                "WHEN all extensions accessed → " +
                "THEN returns all correct values",
        )
        fun whenBloodPressureRequest_thenAllExtensionsWork() {
            // Given
            val request = BloodPressureAggregateRequestDto(
                aggregationMetric = AggregationMetricDto.AVG,
                bloodPressureDataType = BloodPressureDataTypeDto.DIASTOLIC,
                startTime = TEST_START_TIME,
                endTime = TEST_END_TIME,
            )

            // When & Then
            request.startTime shouldBe TEST_START_TIME
            request.endTime shouldBe TEST_END_TIME
            request.aggregationMetric shouldBe AggregationMetricDto.AVG
            request.dataType shouldBe HealthDataTypeDto.BLOOD_PRESSURE
        }
    }

    // endregion
}
