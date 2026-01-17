package com.phamtunglam.health_connector_hc_android.unit_tests.mappers.permission_mappers

import com.phamtunglam.health_connector_hc_android.mappers.permission_mappers.toPermissionRequestResultDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataPermissionRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataPermissionRequestResultDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthPlatformFeatureDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthPlatformFeaturePermissionRequestResultDto
import com.phamtunglam.health_connector_hc_android.pigeon.PermissionAccessTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.PermissionStatusDto
import io.kotest.matchers.shouldBe
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Nested
import org.junit.jupiter.api.TestInstance
import org.junit.jupiter.params.ParameterizedTest
import org.junit.jupiter.params.provider.Arguments
import org.junit.jupiter.params.provider.MethodSource

/**
 * Unit tests for Permission Request Mapper.
 *
 * Tests verify proper bidirectional mapping between permission DTOs and Health Connect
 * permission strings, covering all health data types and platform features.
 */
@DisplayName("PermissionRequestMapper")
class PermissionRequestMapperTest {

    // region String.toPermissionRequestResultDto Tests

    @Nested
    @TestInstance(TestInstance.Lifecycle.PER_CLASS)
    @DisplayName("String.toPermissionRequestResultDto")
    inner class StringToPermissionRequestResultDto {

        @ParameterizedTest(name = "featurePermission={0}")
        @MethodSource("provideFeaturePermissions")
        @DisplayName(
            "GIVEN feature permission string → " +
                "WHEN toPermissionRequestResultDto called → " +
                "THEN returns HealthPlatformFeaturePermissionRequestResultDto",
        )
        fun whenFeaturePermission_thenReturnsFeaturePermissionResultDto(
            permission: String,
            expectedFeature: HealthPlatformFeatureDto,
        ) {
            // When
            val result = permission.toPermissionRequestResultDto()

            // Then
            result shouldBe HealthPlatformFeaturePermissionRequestResultDto(
                feature = expectedFeature,
                status = PermissionStatusDto.GRANTED,
            )
        }

        fun provideFeaturePermissions(): List<Arguments> = listOf(
            Arguments.of(
                "android.permission.health.READ_HEALTH_DATA_IN_BACKGROUND",
                HealthPlatformFeatureDto.READ_HEALTH_DATA_IN_BACKGROUND,
            ),
            Arguments.of(
                "android.permission.health.READ_HEALTH_DATA_HISTORY",
                HealthPlatformFeatureDto.READ_HEALTH_DATA_HISTORY,
            ),
        )

        @ParameterizedTest(name = "dataPermission={0}")
        @MethodSource("provideDataPermissions")
        @DisplayName(
            "GIVEN health data permission string → " +
                "WHEN toPermissionRequestResultDto called → " +
                "THEN returns HealthDataPermissionRequestResultDto",
        )
        fun whenDataPermission_thenReturnsDataPermissionResultDto(
            permission: String,
            expectedDto: HealthDataPermissionRequestDto,
        ) {
            // When
            val result = permission.toPermissionRequestResultDto()

            // Then
            result shouldBe HealthDataPermissionRequestResultDto(
                permission = expectedDto,
                status = PermissionStatusDto.GRANTED,
            )
        }

        fun provideDataPermissions(): List<Arguments> = listOf(
            // Activity & Fitness
            Arguments.of(
                "android.permission.health.READ_ACTIVE_CALORIES_BURNED",
                HealthDataPermissionRequestDto(
                    healthDataType = HealthDataTypeDto.ACTIVE_CALORIES_BURNED,
                    accessType = PermissionAccessTypeDto.READ,
                ),
            ),
            Arguments.of(
                "android.permission.health.WRITE_ACTIVE_CALORIES_BURNED",
                HealthDataPermissionRequestDto(
                    healthDataType = HealthDataTypeDto.ACTIVE_CALORIES_BURNED,
                    accessType = PermissionAccessTypeDto.WRITE,
                ),
            ),
            Arguments.of(
                "android.permission.health.READ_TOTAL_CALORIES_BURNED",
                HealthDataPermissionRequestDto(
                    healthDataType = HealthDataTypeDto.TOTAL_CALORIES_BURNED,
                    accessType = PermissionAccessTypeDto.READ,
                ),
            ),
            Arguments.of(
                "android.permission.health.WRITE_TOTAL_CALORIES_BURNED",
                HealthDataPermissionRequestDto(
                    healthDataType = HealthDataTypeDto.TOTAL_CALORIES_BURNED,
                    accessType = PermissionAccessTypeDto.WRITE,
                ),
            ),
            Arguments.of(
                "android.permission.health.READ_STEPS",
                HealthDataPermissionRequestDto(
                    healthDataType = HealthDataTypeDto.STEPS,
                    accessType = PermissionAccessTypeDto.READ,
                ),
            ),
            Arguments.of(
                "android.permission.health.WRITE_STEPS",
                HealthDataPermissionRequestDto(
                    healthDataType = HealthDataTypeDto.STEPS,
                    accessType = PermissionAccessTypeDto.WRITE,
                ),
            ),
            Arguments.of(
                "android.permission.health.READ_DISTANCE",
                HealthDataPermissionRequestDto(
                    healthDataType = HealthDataTypeDto.DISTANCE,
                    accessType = PermissionAccessTypeDto.READ,
                ),
            ),
            Arguments.of(
                "android.permission.health.WRITE_DISTANCE",
                HealthDataPermissionRequestDto(
                    healthDataType = HealthDataTypeDto.DISTANCE,
                    accessType = PermissionAccessTypeDto.WRITE,
                ),
            ),
            Arguments.of(
                "android.permission.health.READ_FLOORS_CLIMBED",
                HealthDataPermissionRequestDto(
                    healthDataType = HealthDataTypeDto.FLOORS_CLIMBED,
                    accessType = PermissionAccessTypeDto.READ,
                ),
            ),
            Arguments.of(
                "android.permission.health.WRITE_FLOORS_CLIMBED",
                HealthDataPermissionRequestDto(
                    healthDataType = HealthDataTypeDto.FLOORS_CLIMBED,
                    accessType = PermissionAccessTypeDto.WRITE,
                ),
            ),
            Arguments.of(
                "android.permission.health.READ_EXERCISE",
                HealthDataPermissionRequestDto(
                    healthDataType = HealthDataTypeDto.EXERCISE_SESSION,
                    accessType = PermissionAccessTypeDto.READ,
                ),
            ),
            Arguments.of(
                "android.permission.health.WRITE_EXERCISE",
                HealthDataPermissionRequestDto(
                    healthDataType = HealthDataTypeDto.EXERCISE_SESSION,
                    accessType = PermissionAccessTypeDto.WRITE,
                ),
            ),
            Arguments.of(
                "android.permission.health.READ_WHEELCHAIR_PUSHES",
                HealthDataPermissionRequestDto(
                    healthDataType = HealthDataTypeDto.WHEELCHAIR_PUSHES,
                    accessType = PermissionAccessTypeDto.READ,
                ),
            ),
            Arguments.of(
                "android.permission.health.WRITE_WHEELCHAIR_PUSHES",
                HealthDataPermissionRequestDto(
                    healthDataType = HealthDataTypeDto.WHEELCHAIR_PUSHES,
                    accessType = PermissionAccessTypeDto.WRITE,
                ),
            ),

            // Body Measurements
            Arguments.of(
                "android.permission.health.READ_WEIGHT",
                HealthDataPermissionRequestDto(
                    healthDataType = HealthDataTypeDto.WEIGHT,
                    accessType = PermissionAccessTypeDto.READ,
                ),
            ),
            Arguments.of(
                "android.permission.health.WRITE_WEIGHT",
                HealthDataPermissionRequestDto(
                    healthDataType = HealthDataTypeDto.WEIGHT,
                    accessType = PermissionAccessTypeDto.WRITE,
                ),
            ),
            Arguments.of(
                "android.permission.health.READ_HEIGHT",
                HealthDataPermissionRequestDto(
                    healthDataType = HealthDataTypeDto.HEIGHT,
                    accessType = PermissionAccessTypeDto.READ,
                ),
            ),
            Arguments.of(
                "android.permission.health.WRITE_HEIGHT",
                HealthDataPermissionRequestDto(
                    healthDataType = HealthDataTypeDto.HEIGHT,
                    accessType = PermissionAccessTypeDto.WRITE,
                ),
            ),
            Arguments.of(
                "android.permission.health.READ_BODY_FAT",
                HealthDataPermissionRequestDto(
                    healthDataType = HealthDataTypeDto.BODY_FAT_PERCENTAGE,
                    accessType = PermissionAccessTypeDto.READ,
                ),
            ),
            Arguments.of(
                "android.permission.health.WRITE_BODY_FAT",
                HealthDataPermissionRequestDto(
                    healthDataType = HealthDataTypeDto.BODY_FAT_PERCENTAGE,
                    accessType = PermissionAccessTypeDto.WRITE,
                ),
            ),
            Arguments.of(
                "android.permission.health.READ_LEAN_BODY_MASS",
                HealthDataPermissionRequestDto(
                    healthDataType = HealthDataTypeDto.LEAN_BODY_MASS,
                    accessType = PermissionAccessTypeDto.READ,
                ),
            ),
            Arguments.of(
                "android.permission.health.WRITE_LEAN_BODY_MASS",
                HealthDataPermissionRequestDto(
                    healthDataType = HealthDataTypeDto.LEAN_BODY_MASS,
                    accessType = PermissionAccessTypeDto.WRITE,
                ),
            ),
            Arguments.of(
                "android.permission.health.READ_BONE_MASS",
                HealthDataPermissionRequestDto(
                    healthDataType = HealthDataTypeDto.BONE_MASS,
                    accessType = PermissionAccessTypeDto.READ,
                ),
            ),
            Arguments.of(
                "android.permission.health.WRITE_BONE_MASS",
                HealthDataPermissionRequestDto(
                    healthDataType = HealthDataTypeDto.BONE_MASS,
                    accessType = PermissionAccessTypeDto.WRITE,
                ),
            ),
            Arguments.of(
                "android.permission.health.READ_BODY_WATER_MASS",
                HealthDataPermissionRequestDto(
                    healthDataType = HealthDataTypeDto.BODY_WATER_MASS,
                    accessType = PermissionAccessTypeDto.READ,
                ),
            ),
            Arguments.of(
                "android.permission.health.WRITE_BODY_WATER_MASS",
                HealthDataPermissionRequestDto(
                    healthDataType = HealthDataTypeDto.BODY_WATER_MASS,
                    accessType = PermissionAccessTypeDto.WRITE,
                ),
            ),

            // Vital Signs
            Arguments.of(
                "android.permission.health.READ_BODY_TEMPERATURE",
                HealthDataPermissionRequestDto(
                    healthDataType = HealthDataTypeDto.BODY_TEMPERATURE,
                    accessType = PermissionAccessTypeDto.READ,
                ),
            ),
            Arguments.of(
                "android.permission.health.WRITE_BODY_TEMPERATURE",
                HealthDataPermissionRequestDto(
                    healthDataType = HealthDataTypeDto.BODY_TEMPERATURE,
                    accessType = PermissionAccessTypeDto.WRITE,
                ),
            ),
            Arguments.of(
                "android.permission.health.READ_BASAL_BODY_TEMPERATURE",
                HealthDataPermissionRequestDto(
                    healthDataType = HealthDataTypeDto.BASAL_BODY_TEMPERATURE,
                    accessType = PermissionAccessTypeDto.READ,
                ),
            ),
            Arguments.of(
                "android.permission.health.WRITE_BASAL_BODY_TEMPERATURE",
                HealthDataPermissionRequestDto(
                    healthDataType = HealthDataTypeDto.BASAL_BODY_TEMPERATURE,
                    accessType = PermissionAccessTypeDto.WRITE,
                ),
            ),
            Arguments.of(
                "android.permission.health.READ_BLOOD_PRESSURE",
                HealthDataPermissionRequestDto(
                    healthDataType = HealthDataTypeDto.BLOOD_PRESSURE,
                    accessType = PermissionAccessTypeDto.READ,
                ),
            ),
            Arguments.of(
                "android.permission.health.WRITE_BLOOD_PRESSURE",
                HealthDataPermissionRequestDto(
                    healthDataType = HealthDataTypeDto.BLOOD_PRESSURE,
                    accessType = PermissionAccessTypeDto.WRITE,
                ),
            ),
            Arguments.of(
                "android.permission.health.READ_BLOOD_GLUCOSE",
                HealthDataPermissionRequestDto(
                    healthDataType = HealthDataTypeDto.BLOOD_GLUCOSE,
                    accessType = PermissionAccessTypeDto.READ,
                ),
            ),
            Arguments.of(
                "android.permission.health.WRITE_BLOOD_GLUCOSE",
                HealthDataPermissionRequestDto(
                    healthDataType = HealthDataTypeDto.BLOOD_GLUCOSE,
                    accessType = PermissionAccessTypeDto.WRITE,
                ),
            ),
            Arguments.of(
                "android.permission.health.READ_OXYGEN_SATURATION",
                HealthDataPermissionRequestDto(
                    healthDataType = HealthDataTypeDto.OXYGEN_SATURATION,
                    accessType = PermissionAccessTypeDto.READ,
                ),
            ),
            Arguments.of(
                "android.permission.health.WRITE_OXYGEN_SATURATION",
                HealthDataPermissionRequestDto(
                    healthDataType = HealthDataTypeDto.OXYGEN_SATURATION,
                    accessType = PermissionAccessTypeDto.WRITE,
                ),
            ),
            Arguments.of(
                "android.permission.health.READ_RESPIRATORY_RATE",
                HealthDataPermissionRequestDto(
                    healthDataType = HealthDataTypeDto.RESPIRATORY_RATE,
                    accessType = PermissionAccessTypeDto.READ,
                ),
            ),
            Arguments.of(
                "android.permission.health.WRITE_RESPIRATORY_RATE",
                HealthDataPermissionRequestDto(
                    healthDataType = HealthDataTypeDto.RESPIRATORY_RATE,
                    accessType = PermissionAccessTypeDto.WRITE,
                ),
            ),
            Arguments.of(
                "android.permission.health.READ_HEART_RATE",
                HealthDataPermissionRequestDto(
                    healthDataType = HealthDataTypeDto.HEART_RATE_SERIES_RECORD,
                    accessType = PermissionAccessTypeDto.READ,
                ),
            ),
            Arguments.of(
                "android.permission.health.WRITE_HEART_RATE",
                HealthDataPermissionRequestDto(
                    healthDataType = HealthDataTypeDto.HEART_RATE_SERIES_RECORD,
                    accessType = PermissionAccessTypeDto.WRITE,
                ),
            ),
            Arguments.of(
                "android.permission.health.READ_RESTING_HEART_RATE",
                HealthDataPermissionRequestDto(
                    healthDataType = HealthDataTypeDto.RESTING_HEART_RATE,
                    accessType = PermissionAccessTypeDto.READ,
                ),
            ),
            Arguments.of(
                "android.permission.health.WRITE_RESTING_HEART_RATE",
                HealthDataPermissionRequestDto(
                    healthDataType = HealthDataTypeDto.RESTING_HEART_RATE,
                    accessType = PermissionAccessTypeDto.WRITE,
                ),
            ),
            Arguments.of(
                "android.permission.health.READ_HEART_RATE_VARIABILITY",
                HealthDataPermissionRequestDto(
                    healthDataType = HealthDataTypeDto.HEART_RATE_VARIABILITY_RMSSD,
                    accessType = PermissionAccessTypeDto.READ,
                ),
            ),
            Arguments.of(
                "android.permission.health.WRITE_HEART_RATE_VARIABILITY",
                HealthDataPermissionRequestDto(
                    healthDataType = HealthDataTypeDto.HEART_RATE_VARIABILITY_RMSSD,
                    accessType = PermissionAccessTypeDto.WRITE,
                ),
            ),

            // Nutrition & Hydration
            Arguments.of(
                "android.permission.health.READ_HYDRATION",
                HealthDataPermissionRequestDto(
                    healthDataType = HealthDataTypeDto.HYDRATION,
                    accessType = PermissionAccessTypeDto.READ,
                ),
            ),
            Arguments.of(
                "android.permission.health.WRITE_HYDRATION",
                HealthDataPermissionRequestDto(
                    healthDataType = HealthDataTypeDto.HYDRATION,
                    accessType = PermissionAccessTypeDto.WRITE,
                ),
            ),
            Arguments.of(
                "android.permission.health.READ_NUTRITION",
                HealthDataPermissionRequestDto(
                    healthDataType = HealthDataTypeDto.NUTRITION,
                    accessType = PermissionAccessTypeDto.READ,
                ),
            ),
            Arguments.of(
                "android.permission.health.WRITE_NUTRITION",
                HealthDataPermissionRequestDto(
                    healthDataType = HealthDataTypeDto.NUTRITION,
                    accessType = PermissionAccessTypeDto.WRITE,
                ),
            ),

            // Reproductive Health
            Arguments.of(
                "android.permission.health.READ_CERVICAL_MUCUS",
                HealthDataPermissionRequestDto(
                    healthDataType = HealthDataTypeDto.CERVICAL_MUCUS,
                    accessType = PermissionAccessTypeDto.READ,
                ),
            ),
            Arguments.of(
                "android.permission.health.WRITE_CERVICAL_MUCUS",
                HealthDataPermissionRequestDto(
                    healthDataType = HealthDataTypeDto.CERVICAL_MUCUS,
                    accessType = PermissionAccessTypeDto.WRITE,
                ),
            ),
            Arguments.of(
                "android.permission.health.READ_SEXUAL_ACTIVITY",
                HealthDataPermissionRequestDto(
                    healthDataType = HealthDataTypeDto.SEXUAL_ACTIVITY,
                    accessType = PermissionAccessTypeDto.READ,
                ),
            ),
            Arguments.of(
                "android.permission.health.WRITE_SEXUAL_ACTIVITY",
                HealthDataPermissionRequestDto(
                    healthDataType = HealthDataTypeDto.SEXUAL_ACTIVITY,
                    accessType = PermissionAccessTypeDto.WRITE,
                ),
            ),
            Arguments.of(
                "android.permission.health.READ_OVULATION_TEST",
                HealthDataPermissionRequestDto(
                    healthDataType = HealthDataTypeDto.OVULATION_TEST,
                    accessType = PermissionAccessTypeDto.READ,
                ),
            ),
            Arguments.of(
                "android.permission.health.WRITE_OVULATION_TEST",
                HealthDataPermissionRequestDto(
                    healthDataType = HealthDataTypeDto.OVULATION_TEST,
                    accessType = PermissionAccessTypeDto.WRITE,
                ),
            ),
            Arguments.of(
                "android.permission.health.READ_INTERMENSTRUAL_BLEEDING",
                HealthDataPermissionRequestDto(
                    healthDataType = HealthDataTypeDto.INTERMENSTRUAL_BLEEDING,
                    accessType = PermissionAccessTypeDto.READ,
                ),
            ),
            Arguments.of(
                "android.permission.health.WRITE_INTERMENSTRUAL_BLEEDING",
                HealthDataPermissionRequestDto(
                    healthDataType = HealthDataTypeDto.INTERMENSTRUAL_BLEEDING,
                    accessType = PermissionAccessTypeDto.WRITE,
                ),
            ),
            Arguments.of(
                "android.permission.health.READ_MENSTRUATION",
                HealthDataPermissionRequestDto(
                    healthDataType = HealthDataTypeDto.MENSTRUAL_FLOW_INSTANT,
                    accessType = PermissionAccessTypeDto.READ,
                ),
            ),
            Arguments.of(
                "android.permission.health.WRITE_MENSTRUATION",
                HealthDataPermissionRequestDto(
                    healthDataType = HealthDataTypeDto.MENSTRUAL_FLOW_INSTANT,
                    accessType = PermissionAccessTypeDto.WRITE,
                ),
            ),

            // Sleep & Mindfulness
            Arguments.of(
                "android.permission.health.READ_SLEEP",
                HealthDataPermissionRequestDto(
                    healthDataType = HealthDataTypeDto.SLEEP_SESSION,
                    accessType = PermissionAccessTypeDto.READ,
                ),
            ),
            Arguments.of(
                "android.permission.health.WRITE_SLEEP",
                HealthDataPermissionRequestDto(
                    healthDataType = HealthDataTypeDto.SLEEP_SESSION,
                    accessType = PermissionAccessTypeDto.WRITE,
                ),
            ),
            Arguments.of(
                "android.permission.health.WRITE_SLEEP",
                HealthDataPermissionRequestDto(
                    healthDataType = HealthDataTypeDto.SLEEP_SESSION,
                    accessType = PermissionAccessTypeDto.WRITE,
                ),
            ),
            Arguments.of(
                "android.permission.health.READ_MINDFULNESS",
                HealthDataPermissionRequestDto(
                    healthDataType = HealthDataTypeDto.MINDFULNESS_SESSION,
                    accessType = PermissionAccessTypeDto.READ,
                ),
            ),
            Arguments.of(
                "android.permission.health.WRITE_MINDFULNESS",
                HealthDataPermissionRequestDto(
                    healthDataType = HealthDataTypeDto.MINDFULNESS_SESSION,
                    accessType = PermissionAccessTypeDto.WRITE,
                ),
            ),

            // Performance & Series Data
            Arguments.of(
                "android.permission.health.READ_VO2_MAX",
                HealthDataPermissionRequestDto(
                    healthDataType = HealthDataTypeDto.VO2MAX,
                    accessType = PermissionAccessTypeDto.READ,
                ),
            ),
            Arguments.of(
                "android.permission.health.WRITE_VO2_MAX",
                HealthDataPermissionRequestDto(
                    healthDataType = HealthDataTypeDto.VO2MAX,
                    accessType = PermissionAccessTypeDto.WRITE,
                ),
            ),
            Arguments.of(
                "android.permission.health.READ_SPEED",
                HealthDataPermissionRequestDto(
                    healthDataType = HealthDataTypeDto.SPEED_SERIES,
                    accessType = PermissionAccessTypeDto.READ,
                ),
            ),
            Arguments.of(
                "android.permission.health.WRITE_SPEED",
                HealthDataPermissionRequestDto(
                    healthDataType = HealthDataTypeDto.SPEED_SERIES,
                    accessType = PermissionAccessTypeDto.WRITE,
                ),
            ),
            Arguments.of(
                "android.permission.health.READ_POWER",
                HealthDataPermissionRequestDto(
                    healthDataType = HealthDataTypeDto.POWER_SERIES,
                    accessType = PermissionAccessTypeDto.READ,
                ),
            ),
            Arguments.of(
                "android.permission.health.WRITE_POWER",
                HealthDataPermissionRequestDto(
                    healthDataType = HealthDataTypeDto.POWER_SERIES,
                    accessType = PermissionAccessTypeDto.WRITE,
                ),
            ),
            Arguments.of(
                "android.permission.health.READ_CYCLING_PEDALING_CADENCE",
                HealthDataPermissionRequestDto(
                    healthDataType = HealthDataTypeDto.CYCLING_PEDALING_CADENCE_SERIES_RECORD,
                    accessType = PermissionAccessTypeDto.READ,
                ),
            ),
            Arguments.of(
                "android.permission.health.WRITE_CYCLING_PEDALING_CADENCE",
                HealthDataPermissionRequestDto(
                    healthDataType = HealthDataTypeDto.CYCLING_PEDALING_CADENCE_SERIES_RECORD,
                    accessType = PermissionAccessTypeDto.WRITE,
                ),
            ),
            Arguments.of(
                "android.permission.health.READ_ACTIVITY_INTENSITY",
                HealthDataPermissionRequestDto(
                    healthDataType = HealthDataTypeDto.ACTIVITY_INTENSITY,
                    accessType = PermissionAccessTypeDto.READ,
                ),
            ),
            Arguments.of(
                "android.permission.health.WRITE_ACTIVITY_INTENSITY",
                HealthDataPermissionRequestDto(
                    healthDataType = HealthDataTypeDto.ACTIVITY_INTENSITY,
                    accessType = PermissionAccessTypeDto.WRITE,
                ),
            ),
        )
    }

    // endregion
}
