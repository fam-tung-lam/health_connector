package com.phamtunglam.health_connector_hc_android.unit_tests.services

import androidx.health.connect.client.HealthConnectFeatures
import com.phamtunglam.health_connector_hc_android.mappers.toHealthConnectFeature
import com.phamtunglam.health_connector_hc_android.pigeon.HealthPlatformFeatureDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthPlatformFeatureStatusDto
import com.phamtunglam.health_connector_hc_android.services.HealthConnectorFeatureService
import io.kotest.matchers.shouldBe
import io.mockk.MockKAnnotations
import io.mockk.every
import io.mockk.impl.annotations.MockK
import io.mockk.unmockkAll
import org.junit.jupiter.api.AfterEach
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Nested
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.TestInstance
import org.junit.jupiter.params.ParameterizedTest
import org.junit.jupiter.params.provider.Arguments
import org.junit.jupiter.params.provider.MethodSource

/**
 * Unit tests for [HealthConnectorFeatureService].
 *
 * Tests verify proper handling of feature status queries for both available and unavailable features.
 */
@DisplayName("HealthConnectorFeatureService")
class HealthConnectorFeatureServiceTest {

    // region Test Fixtures

    @MockK
    private lateinit var healthConnectFeatures: HealthConnectFeatures

    private lateinit var systemUnderTest: HealthConnectorFeatureService

    // endregion

    // region Setup

    @BeforeEach
    fun setUp() {
        MockKAnnotations.init(this)
        systemUnderTest = HealthConnectorFeatureService(healthConnectFeatures)
    }

    @AfterEach
    fun tearDown() {
        unmockkAll()
    }

    // endregion

    // region Test Cases

    @Nested
    @TestInstance(TestInstance.Lifecycle.PER_CLASS)
    @DisplayName("getFeatureStatus")
    inner class GetFeatureStatus {

        @ParameterizedTest(
            name = "given feature={0}, statusCode={1}, expectedStatus={2}",
        )
        @MethodSource("provideFeatureStatusScenarios")
        @DisplayName(
            "GIVEN feature and status code → " +
                "WHEN getFeatureStatus called → " +
                "THEN returns correct status",
        )
        fun whenGetFeatureStatusCalled_thenReturnsCorrectStatus(
            feature: HealthPlatformFeatureDto,
            statusCode: Int,
            expectedStatus: HealthPlatformFeatureStatusDto,
        ) {
            // Given
            val healthConnectFeature = feature.toHealthConnectFeature()
            every {
                healthConnectFeatures.getFeatureStatus(healthConnectFeature)
            } returns statusCode

            // When
            val result = systemUnderTest.getFeatureStatus(feature)

            // Then
            result shouldBe expectedStatus
        }

        fun provideFeatureStatusScenarios(): List<Arguments> = listOf(
            // READ_HEALTH_DATA_IN_BACKGROUND - Available
            Arguments.of(
                HealthPlatformFeatureDto.READ_HEALTH_DATA_IN_BACKGROUND,
                HealthConnectFeatures.FEATURE_STATUS_AVAILABLE,
                HealthPlatformFeatureStatusDto.AVAILABLE,
            ),
            // READ_HEALTH_DATA_IN_BACKGROUND - Unavailable
            Arguments.of(
                HealthPlatformFeatureDto.READ_HEALTH_DATA_IN_BACKGROUND,
                HealthConnectFeatures.FEATURE_STATUS_UNAVAILABLE,
                HealthPlatformFeatureStatusDto.UNAVAILABLE,
            ),
            // READ_HEALTH_DATA_HISTORY - Available
            Arguments.of(
                HealthPlatformFeatureDto.READ_HEALTH_DATA_HISTORY,
                HealthConnectFeatures.FEATURE_STATUS_AVAILABLE,
                HealthPlatformFeatureStatusDto.AVAILABLE,
            ),
            // READ_HEALTH_DATA_HISTORY - Unavailable
            Arguments.of(
                HealthPlatformFeatureDto.READ_HEALTH_DATA_HISTORY,
                HealthConnectFeatures.FEATURE_STATUS_UNAVAILABLE,
                HealthPlatformFeatureStatusDto.UNAVAILABLE,
            ),
        )
    }

    @Nested
    @DisplayName("Edge Cases")
    inner class EdgeCases {

        @Test
        @DisplayName(
            "GIVEN unknown status code returned → " +
                "WHEN getFeatureStatus called → " +
                "THEN returns UNAVAILABLE",
        )
        fun whenUnknownStatusCode_thenReturnsUnavailable() {
            // Given
            val unknownStatusCode = 999
            every {
                healthConnectFeatures.getFeatureStatus(
                    HealthConnectFeatures.FEATURE_READ_HEALTH_DATA_IN_BACKGROUND,
                )
            } returns unknownStatusCode

            // When
            val result = systemUnderTest.getFeatureStatus(
                HealthPlatformFeatureDto.READ_HEALTH_DATA_IN_BACKGROUND,
            )

            // Then
            result shouldBe HealthPlatformFeatureStatusDto.UNAVAILABLE
        }

        @Test
        @DisplayName(
            "GIVEN negative status code returned → " +
                "WHEN getFeatureStatus called → " +
                "THEN returns UNAVAILABLE",
        )
        fun whenNegativeStatusCode_thenReturnsUnavailable() {
            // Given
            val negativeStatusCode = -1
            every {
                healthConnectFeatures.getFeatureStatus(
                    HealthConnectFeatures.FEATURE_READ_HEALTH_DATA_HISTORY,
                )
            } returns negativeStatusCode

            // When
            val result = systemUnderTest.getFeatureStatus(
                HealthPlatformFeatureDto.READ_HEALTH_DATA_HISTORY,
            )

            // Then
            result shouldBe HealthPlatformFeatureStatusDto.UNAVAILABLE
        }
    }

    // endregion
}
