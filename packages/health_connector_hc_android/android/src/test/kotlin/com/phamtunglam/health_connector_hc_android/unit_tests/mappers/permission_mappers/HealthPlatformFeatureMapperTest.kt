package com.phamtunglam.health_connector_hc_android.unit_tests.mappers.permission_mappers

import com.phamtunglam.health_connector_hc_android.mappers.permission_mappers.isFeaturePermission
import com.phamtunglam.health_connector_hc_android.mappers.permission_mappers.toHealthConnect
import com.phamtunglam.health_connector_hc_android.mappers.permission_mappers.toHealthPlatformFeatureDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthPlatformFeatureDto
import io.kotest.assertions.throwables.shouldThrow
import io.kotest.matchers.shouldBe
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Nested
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.TestInstance
import org.junit.jupiter.params.ParameterizedTest
import org.junit.jupiter.params.provider.Arguments
import org.junit.jupiter.params.provider.MethodSource
import org.junit.jupiter.params.provider.ValueSource

/**
 * Unit tests for Health Platform Feature Mapper.
 *
 * Tests verify proper bidirectional mapping between [HealthPlatformFeatureDto] and
 * Health Connect platform feature permission strings, as well as feature permission detection.
 */
@DisplayName("HealthPlatformFeatureMapper")
class HealthPlatformFeatureMapperTest {

    // region Test Constants

    private companion object {
        const val PERMISSION_READ_HEALTH_DATA_IN_BACKGROUND =
            "android.permission.health.READ_HEALTH_DATA_IN_BACKGROUND"
        const val PERMISSION_READ_HEALTH_DATA_HISTORY =
            "android.permission.health.READ_HEALTH_DATA_HISTORY"
    }

    // endregion

    // region toHealthConnect Tests

    @Nested
    @TestInstance(TestInstance.Lifecycle.PER_CLASS)
    @DisplayName("toHealthConnect")
    inner class ToHealthConnect {

        @ParameterizedTest(name = "feature={0} maps to permission={1}")
        @MethodSource("provideFeatureToPermissionMappings")
        @DisplayName(
            "GIVEN any platform feature DTO → " +
                "WHEN toHealthConnect called → " +
                "THEN maps to correct permission string",
        )
        fun whenAnyFeature_thenMapsToCorrectPermission(
            feature: HealthPlatformFeatureDto,
            expectedPermission: String,
        ) {
            // When
            val result = feature.toHealthConnect()

            // Then
            result shouldBe expectedPermission
        }

        fun provideFeatureToPermissionMappings(): List<Arguments> = listOf(
            Arguments.of(
                HealthPlatformFeatureDto.READ_HEALTH_DATA_IN_BACKGROUND,
                PERMISSION_READ_HEALTH_DATA_IN_BACKGROUND,
            ),
            Arguments.of(
                HealthPlatformFeatureDto.READ_HEALTH_DATA_HISTORY,
                PERMISSION_READ_HEALTH_DATA_HISTORY,
            ),
        )
    }

    // endregion

    // region toHealthPlatformFeatureDto Tests

    @Nested
    @TestInstance(TestInstance.Lifecycle.PER_CLASS)
    @DisplayName("toHealthPlatformFeatureDto")
    inner class ToHealthPlatformFeatureDto {

        @ParameterizedTest(name = "permission={0} maps to feature={1}")
        @MethodSource("providePermissionToFeatureMappings")
        @DisplayName(
            "GIVEN any feature permission string → " +
                "WHEN toHealthPlatformFeatureDto called → " +
                "THEN maps to correct platform feature DTO",
        )
        fun whenAnyFeaturePermission_thenMapsToCorrectFeature(
            permission: String,
            expectedFeature: HealthPlatformFeatureDto,
        ) {
            // When
            val result = permission.toHealthPlatformFeatureDto()

            // Then
            result shouldBe expectedFeature
        }

        fun providePermissionToFeatureMappings(): List<Arguments> = listOf(
            Arguments.of(
                PERMISSION_READ_HEALTH_DATA_IN_BACKGROUND,
                HealthPlatformFeatureDto.READ_HEALTH_DATA_IN_BACKGROUND,
            ),
            Arguments.of(
                PERMISSION_READ_HEALTH_DATA_HISTORY,
                HealthPlatformFeatureDto.READ_HEALTH_DATA_HISTORY,
            ),
        )

        @Nested
        @DisplayName("Error cases")
        inner class ErrorCases {

            @Test
            @DisplayName(
                "GIVEN invalid permission string → " +
                    "WHEN toHealthPlatformFeatureDto called → " +
                    "THEN throws IllegalArgumentException",
            )
            fun whenInvalidPermission_thenThrowsException() {
                // Given
                val invalidPermission = "android.permission.health.INVALID_FEATURE"

                // When & Then
                val exception = shouldThrow<IllegalArgumentException> {
                    invalidPermission.toHealthPlatformFeatureDto()
                }

                exception.message shouldBe
                    "Invalid/unsupported/unimplemented Health Connect feature string: " +
                    "'$invalidPermission'"
            }

            @ParameterizedTest(name = "invalidPermission={0}")
            @ValueSource(
                strings = [
                    "android.permission.health.READ_STEPS",
                    "android.permission.INVALID",
                    "invalid.permission",
                    "",
                    "   ",
                ],
            )
            @DisplayName(
                "GIVEN various invalid permission strings → " +
                    "WHEN toHealthPlatformFeatureDto called → " +
                    "THEN throws IllegalArgumentException",
            )
            fun whenVariousInvalidPermissions_thenThrowsException(invalidPermission: String) {
                // When & Then
                shouldThrow<IllegalArgumentException> {
                    invalidPermission.toHealthPlatformFeatureDto()
                }
            }
        }
    }

    // endregion

    // region isFeaturePermission Tests

    @Nested
    @TestInstance(TestInstance.Lifecycle.PER_CLASS)
    @DisplayName("isFeaturePermission")
    inner class IsFeaturePermission {

        @ParameterizedTest(name = "permission={0}")
        @ValueSource(
            strings = [
                "android.permission.health.READ_HEALTH_DATA_IN_BACKGROUND",
                "android.permission.health.READ_HEALTH_DATA_HISTORY",
            ],
        )
        @DisplayName(
            "GIVEN valid feature permission → " +
                "WHEN isFeaturePermission checked → " +
                "THEN returns true",
        )
        fun whenValidFeaturePermission_thenReturnsTrue(permission: String) {
            // When
            val result = permission.isFeaturePermission

            // Then
            result shouldBe true
        }

        @ParameterizedTest(name = "permission={0}")
        @ValueSource(
            strings = [
                "android.permission.health.READ_STEPS",
                "android.permission.health.WRITE_WEIGHT",
                "android.permission.CAMERA",
                "invalid.permission",
                "",
            ],
        )
        @DisplayName(
            "GIVEN non-feature permission → " +
                "WHEN isFeaturePermission checked → " +
                "THEN returns false",
        )
        fun whenNonFeaturePermission_thenReturnsFalse(permission: String) {
            // When
            val result = permission.isFeaturePermission

            // Then
            result shouldBe false
        }
    }

    // endregion
}
