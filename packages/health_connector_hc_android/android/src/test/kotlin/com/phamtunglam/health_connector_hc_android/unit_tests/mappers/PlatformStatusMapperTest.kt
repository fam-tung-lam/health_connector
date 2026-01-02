package com.phamtunglam.health_connector_hc_android.unit_tests.mappers

import androidx.health.connect.client.HealthConnectClient
import com.phamtunglam.health_connector_hc_android.mappers.toHealthPlatformStatusDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthPlatformStatusDto
import io.kotest.matchers.shouldBe
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Nested
import org.junit.jupiter.api.TestInstance
import org.junit.jupiter.params.ParameterizedTest
import org.junit.jupiter.params.provider.Arguments
import org.junit.jupiter.params.provider.MethodSource

/**
 * Unit tests for Platform Status Mappers.
 *
 * Tests verify proper mapping between Health Connect SDK status codes and
 * [HealthPlatformStatusDto] values, including edge cases for unknown status codes.
 */
@DisplayName("PlatformStatusMappers")
class PlatformStatusMapperTest {

    @Nested
    @TestInstance(TestInstance.Lifecycle.PER_CLASS)
    @DisplayName("toHealthPlatformStatusDto")
    inner class ToHealthPlatformStatusDto {

        @ParameterizedTest(name = "statusCode={0} maps to expectedStatus={1}")
        @MethodSource("provideStatusCodeMappings")
        @DisplayName(
            "GIVEN various SDK status codes → " +
                "WHEN toHealthPlatformStatusDto called → " +
                "THEN maps to expected platform status",
        )
        fun whenVariousStatusCodes_thenMapsToExpectedStatus(
            statusCode: Int,
            expectedStatus: HealthPlatformStatusDto,
        ) {
            // When
            val result = statusCode.toHealthPlatformStatusDto()

            // Then
            result shouldBe expectedStatus
        }

        fun provideStatusCodeMappings(): List<Arguments> = listOf(
            Arguments.of(
                HealthConnectClient.SDK_AVAILABLE,
                HealthPlatformStatusDto.AVAILABLE,
            ),
            Arguments.of(
                HealthConnectClient.SDK_UNAVAILABLE,
                HealthPlatformStatusDto.NOT_AVAILABLE,
            ),
            Arguments.of(
                HealthConnectClient.SDK_UNAVAILABLE_PROVIDER_UPDATE_REQUIRED,
                HealthPlatformStatusDto.INSTALLATION_OR_UPDATE_REQUIRED,
            ),
            // Unknown/edge case status codes should default to NOT_AVAILABLE
            Arguments.of(-1, HealthPlatformStatusDto.NOT_AVAILABLE),
            Arguments.of(999, HealthPlatformStatusDto.NOT_AVAILABLE),
            Arguments.of(Int.MAX_VALUE, HealthPlatformStatusDto.NOT_AVAILABLE),
            Arguments.of(Int.MIN_VALUE, HealthPlatformStatusDto.NOT_AVAILABLE),
        )
    }
}
