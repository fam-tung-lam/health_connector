package com.phamtunglam.health_connector_hc_android.unit_tests.mappers

import androidx.health.connect.client.HealthConnectFeatures
import com.phamtunglam.health_connector_hc_android.mappers.toHealthConnectFeature
import com.phamtunglam.health_connector_hc_android.mappers.toHealthPlatformFeatureStatusDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthPlatformFeatureDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthPlatformFeatureStatusDto
import io.kotest.matchers.shouldBe
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Nested
import org.junit.jupiter.api.TestInstance
import org.junit.jupiter.params.ParameterizedTest
import org.junit.jupiter.params.provider.Arguments
import org.junit.jupiter.params.provider.MethodSource

/**
 * Unit tests for Health Platform Feature Mappers.
 *
 * Tests verify proper bidirectional mapping between [HealthPlatformFeatureDto] and
 * Health Connect feature constants, as well as status code conversions.
 */
@DisplayName("HealthPlatformFeatureMappers")
class HealthPlatformFeatureMapperTest {

    // region toHealthConnectFeature Tests

    @Nested
    @TestInstance(TestInstance.Lifecycle.PER_CLASS)
    @DisplayName("toHealthConnectFeature")
    inner class ToHealthConnectFeature {

        @ParameterizedTest(name = "feature={0} maps to expectedConstant={1}")
        @MethodSource("provideAllFeatureMappings")
        @DisplayName(
            "GIVEN any HealthPlatformFeatureDto → " +
                "WHEN toHealthConnectFeature called → " +
                "THEN maps to correct Health Connect constant",
        )
        fun whenAnyPlatformFeature_thenMapsToCorrectConstant(
            feature: HealthPlatformFeatureDto,
            expectedConstant: Int,
        ) {
            // When
            val result = feature.toHealthConnectFeature()

            // Then
            result shouldBe expectedConstant
        }

        fun provideAllFeatureMappings(): List<Arguments> = listOf(
            Arguments.of(
                HealthPlatformFeatureDto.READ_HEALTH_DATA_IN_BACKGROUND,
                HealthConnectFeatures.FEATURE_READ_HEALTH_DATA_IN_BACKGROUND,
            ),
            Arguments.of(
                HealthPlatformFeatureDto.READ_HEALTH_DATA_HISTORY,
                HealthConnectFeatures.FEATURE_READ_HEALTH_DATA_HISTORY,
            ),
        )
    }

    // endregion

    // region toHealthPlatformFeatureStatusDto Tests

    @Nested
    @TestInstance(TestInstance.Lifecycle.PER_CLASS)
    @DisplayName("toHealthPlatformFeatureStatusDto")
    inner class ToHealthPlatformFeatureStatusDto {

        @ParameterizedTest(name = "statusCode={0} maps to expectedStatus={1}")
        @MethodSource("provideStatusCodeMappings")
        @DisplayName(
            "GIVEN various status codes → " +
                "WHEN toHealthPlatformFeatureStatusDto called → " +
                "THEN maps to expected status",
        )
        fun whenVariousStatusCodes_thenMapsToExpectedStatus(
            statusCode: Int,
            expectedStatus: HealthPlatformFeatureStatusDto,
        ) {
            // When
            val result = statusCode.toHealthPlatformFeatureStatusDto()

            // Then
            result shouldBe expectedStatus
        }

        fun provideStatusCodeMappings(): List<Arguments> = listOf(
            Arguments.of(
                HealthConnectFeatures.FEATURE_STATUS_AVAILABLE,
                HealthPlatformFeatureStatusDto.AVAILABLE,
            ),
            Arguments.of(
                HealthConnectFeatures.FEATURE_STATUS_UNAVAILABLE,
                HealthPlatformFeatureStatusDto.UNAVAILABLE,
            ),
            // Unknown/edge case status codes should default to UNAVAILABLE
            Arguments.of(-1, HealthPlatformFeatureStatusDto.UNAVAILABLE),
            Arguments.of(999, HealthPlatformFeatureStatusDto.UNAVAILABLE),
            Arguments.of(Int.MAX_VALUE, HealthPlatformFeatureStatusDto.UNAVAILABLE),
            Arguments.of(Int.MIN_VALUE, HealthPlatformFeatureStatusDto.UNAVAILABLE),
        )
    }

    // endregion
}
