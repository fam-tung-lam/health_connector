package com.phamtunglam.health_connector_hc_android.mappers.permission_mappers

import androidx.health.connect.client.permission.HealthPermission
import androidx.health.connect.client.records.ActiveCaloriesBurnedRecord
import androidx.health.connect.client.records.ActivityIntensityRecord
import androidx.health.connect.client.records.BasalBodyTemperatureRecord
import androidx.health.connect.client.records.BasalMetabolicRateRecord
import androidx.health.connect.client.records.BloodGlucoseRecord
import androidx.health.connect.client.records.BloodPressureRecord
import androidx.health.connect.client.records.BodyFatRecord
import androidx.health.connect.client.records.BodyTemperatureRecord
import androidx.health.connect.client.records.BodyWaterMassRecord
import androidx.health.connect.client.records.BoneMassRecord
import androidx.health.connect.client.records.CervicalMucusRecord
import androidx.health.connect.client.records.CyclingPedalingCadenceRecord
import androidx.health.connect.client.records.DistanceRecord
import androidx.health.connect.client.records.ElevationGainedRecord
import androidx.health.connect.client.records.ExerciseSessionRecord
import androidx.health.connect.client.records.FloorsClimbedRecord
import androidx.health.connect.client.records.HeartRateRecord
import androidx.health.connect.client.records.HeartRateVariabilityRmssdRecord
import androidx.health.connect.client.records.HeightRecord
import androidx.health.connect.client.records.HydrationRecord
import androidx.health.connect.client.records.IntermenstrualBleedingRecord
import androidx.health.connect.client.records.LeanBodyMassRecord
import androidx.health.connect.client.records.MenstruationFlowRecord
import androidx.health.connect.client.records.MenstruationPeriodRecord
import androidx.health.connect.client.records.MindfulnessSessionRecord
import androidx.health.connect.client.records.NutritionRecord
import androidx.health.connect.client.records.OvulationTestRecord
import androidx.health.connect.client.records.OxygenSaturationRecord
import androidx.health.connect.client.records.PowerRecord
import androidx.health.connect.client.records.RespiratoryRateRecord
import androidx.health.connect.client.records.RestingHeartRateRecord
import androidx.health.connect.client.records.SexualActivityRecord
import androidx.health.connect.client.records.SkinTemperatureRecord
import androidx.health.connect.client.records.SleepSessionRecord
import androidx.health.connect.client.records.SpeedRecord
import androidx.health.connect.client.records.StepsCadenceRecord
import androidx.health.connect.client.records.StepsRecord
import androidx.health.connect.client.records.TotalCaloriesBurnedRecord
import androidx.health.connect.client.records.Vo2MaxRecord
import androidx.health.connect.client.records.WeightRecord
import androidx.health.connect.client.records.WheelchairPushesRecord
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataPermissionRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataPermissionRequestResultDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthPlatformFeaturePermissionRequest
import com.phamtunglam.health_connector_hc_android.pigeon.HealthPlatformFeaturePermissionRequestResultDto
import com.phamtunglam.health_connector_hc_android.pigeon.PermissionAccessTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.PermissionRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.PermissionRequestResultDto
import com.phamtunglam.health_connector_hc_android.pigeon.PermissionStatusDto

/**
 * Converts a [PermissionRequestDto] to a Health Connect permission string.
 *
 * @receiver The [PermissionRequestDto] to convert
 * @return The Health Connect permission string corresponding to the DTO
 */
internal fun PermissionRequestDto.toHealthConnectPermissionString(): String = when (this) {
    is HealthDataPermissionRequestDto -> toHealthConnectPermissionString()

    is HealthPlatformFeaturePermissionRequest -> feature.toHealthConnectPermissionString()
}

/**
 * Helper to map a raw permission string to its corresponding DTO result.
 */
fun String.toPermissionRequestResultDto(): PermissionRequestResultDto = if (isFeaturePermission) {
    HealthPlatformFeaturePermissionRequestResultDto(
        feature = toHealthPlatformFeatureDto(),
        status = PermissionStatusDto.GRANTED,
    )
} else {
    HealthDataPermissionRequestResultDto(
        permission = toHealthDataPermissionDto(),
        status = PermissionStatusDto.GRANTED,
    )
}

/**
 * Helper function to map data type and access type to Health Connect permission string.
 */
// Suppressed because handles 50+ health data types in a single `when` expression
// to leverage Kotlin's exhaustiveness checking, ensuring compile-time safety when new data types
// are added. Splitting into smaller methods would scatter the mapping logic without improving
// readability or maintainability.
@Suppress("LongMethod", "CognitiveComplexMethod", "CyclomaticComplexMethod")
private fun HealthDataPermissionRequestDto.toHealthConnectPermissionString(): String =
    when (healthDataType) {
        HealthDataTypeDto.ACTIVE_CALORIES_BURNED -> {
            when (accessType) {
                PermissionAccessTypeDto.READ -> HealthPermission.getReadPermission(
                    ActiveCaloriesBurnedRecord::class,
                )

                PermissionAccessTypeDto.WRITE -> HealthPermission.getWritePermission(
                    ActiveCaloriesBurnedRecord::class,
                )
            }
        }

        HealthDataTypeDto.TOTAL_CALORIES_BURNED -> {
            when (accessType) {
                PermissionAccessTypeDto.READ -> HealthPermission.getReadPermission(
                    TotalCaloriesBurnedRecord::class,
                )

                PermissionAccessTypeDto.WRITE -> HealthPermission.getWritePermission(
                    TotalCaloriesBurnedRecord::class,
                )
            }
        }

        HealthDataTypeDto.BASAL_METABOLIC_RATE -> {
            when (accessType) {
                PermissionAccessTypeDto.READ -> HealthPermission.getReadPermission(
                    BasalMetabolicRateRecord::class,
                )

                PermissionAccessTypeDto.WRITE -> HealthPermission.getWritePermission(
                    BasalMetabolicRateRecord::class,
                )
            }
        }

        HealthDataTypeDto.STEPS -> {
            when (accessType) {
                PermissionAccessTypeDto.READ -> HealthPermission.getReadPermission(
                    StepsRecord::class,
                )

                PermissionAccessTypeDto.WRITE -> HealthPermission.getWritePermission(
                    StepsRecord::class,
                )
            }
        }

        HealthDataTypeDto.WEIGHT -> {
            when (accessType) {
                PermissionAccessTypeDto.READ -> HealthPermission.getReadPermission(
                    WeightRecord::class,
                )

                PermissionAccessTypeDto.WRITE -> HealthPermission.getWritePermission(
                    WeightRecord::class,
                )
            }
        }

        HealthDataTypeDto.DISTANCE -> {
            when (accessType) {
                PermissionAccessTypeDto.READ -> HealthPermission.getReadPermission(
                    DistanceRecord::class,
                )

                PermissionAccessTypeDto.WRITE -> HealthPermission.getWritePermission(
                    DistanceRecord::class,
                )
            }
        }

        HealthDataTypeDto.ELEVATION_GAINED -> {
            when (accessType) {
                PermissionAccessTypeDto.READ -> HealthPermission.getReadPermission(
                    ElevationGainedRecord::class,
                )

                PermissionAccessTypeDto.WRITE -> HealthPermission.getWritePermission(
                    ElevationGainedRecord::class,
                )
            }
        }

        HealthDataTypeDto.FLOORS_CLIMBED -> {
            when (accessType) {
                PermissionAccessTypeDto.READ -> HealthPermission.getReadPermission(
                    FloorsClimbedRecord::class,
                )

                PermissionAccessTypeDto.WRITE -> HealthPermission.getWritePermission(
                    FloorsClimbedRecord::class,
                )
            }
        }

        HealthDataTypeDto.HEIGHT -> {
            when (accessType) {
                PermissionAccessTypeDto.READ -> HealthPermission.getReadPermission(
                    HeightRecord::class,
                )

                PermissionAccessTypeDto.WRITE -> HealthPermission.getWritePermission(
                    HeightRecord::class,
                )
            }
        }

        HealthDataTypeDto.HYDRATION -> {
            when (accessType) {
                PermissionAccessTypeDto.READ -> HealthPermission.getReadPermission(
                    HydrationRecord::class,
                )

                PermissionAccessTypeDto.WRITE -> HealthPermission.getWritePermission(
                    HydrationRecord::class,
                )
            }
        }

        HealthDataTypeDto.LEAN_BODY_MASS -> {
            when (accessType) {
                PermissionAccessTypeDto.READ -> HealthPermission.getReadPermission(
                    LeanBodyMassRecord::class,
                )

                PermissionAccessTypeDto.WRITE -> HealthPermission.getWritePermission(
                    LeanBodyMassRecord::class,
                )
            }
        }

        HealthDataTypeDto.BODY_FAT_PERCENTAGE -> {
            when (accessType) {
                PermissionAccessTypeDto.READ -> HealthPermission.getReadPermission(
                    BodyFatRecord::class,
                )

                PermissionAccessTypeDto.WRITE -> HealthPermission.getWritePermission(
                    BodyFatRecord::class,
                )
            }
        }

        HealthDataTypeDto.BODY_TEMPERATURE -> {
            when (accessType) {
                PermissionAccessTypeDto.READ -> HealthPermission.getReadPermission(
                    BodyTemperatureRecord::class,
                )

                PermissionAccessTypeDto.WRITE -> HealthPermission.getWritePermission(
                    BodyTemperatureRecord::class,
                )
            }
        }

        HealthDataTypeDto.BASAL_BODY_TEMPERATURE -> {
            when (accessType) {
                PermissionAccessTypeDto.READ -> HealthPermission.getReadPermission(
                    BasalBodyTemperatureRecord::class,
                )

                PermissionAccessTypeDto.WRITE -> HealthPermission.getWritePermission(
                    BasalBodyTemperatureRecord::class,
                )
            }
        }

        HealthDataTypeDto.CERVICAL_MUCUS -> {
            when (accessType) {
                PermissionAccessTypeDto.READ -> HealthPermission.getReadPermission(
                    CervicalMucusRecord::class,
                )

                PermissionAccessTypeDto.WRITE -> HealthPermission.getWritePermission(
                    CervicalMucusRecord::class,
                )
            }
        }

        HealthDataTypeDto.WHEELCHAIR_PUSHES -> {
            when (accessType) {
                PermissionAccessTypeDto.READ -> HealthPermission.getReadPermission(
                    WheelchairPushesRecord::class,
                )

                PermissionAccessTypeDto.WRITE -> HealthPermission.getWritePermission(
                    WheelchairPushesRecord::class,
                )
            }
        }

        HealthDataTypeDto.HEART_RATE_SERIES -> {
            when (accessType) {
                PermissionAccessTypeDto.READ -> HealthPermission.getReadPermission(
                    HeartRateRecord::class,
                )

                PermissionAccessTypeDto.WRITE -> HealthPermission.getWritePermission(
                    HeartRateRecord::class,
                )
            }
        }

        HealthDataTypeDto.SEXUAL_ACTIVITY -> {
            when (accessType) {
                PermissionAccessTypeDto.READ -> HealthPermission.getReadPermission(
                    SexualActivityRecord::class,
                )

                PermissionAccessTypeDto.WRITE -> HealthPermission.getWritePermission(
                    SexualActivityRecord::class,
                )
            }
        }

        HealthDataTypeDto.OVULATION_TEST -> {
            when (accessType) {
                PermissionAccessTypeDto.READ -> HealthPermission.getReadPermission(
                    OvulationTestRecord::class,
                )

                PermissionAccessTypeDto.WRITE -> HealthPermission.getWritePermission(
                    OvulationTestRecord::class,
                )
            }
        }

        HealthDataTypeDto.INTERMENSTRUAL_BLEEDING -> {
            when (accessType) {
                PermissionAccessTypeDto.READ -> HealthPermission.getReadPermission(
                    IntermenstrualBleedingRecord::class,
                )

                PermissionAccessTypeDto.WRITE -> HealthPermission.getWritePermission(
                    IntermenstrualBleedingRecord::class,
                )
            }
        }

        HealthDataTypeDto.MENSTRUAL_FLOW_INSTANT -> {
            when (accessType) {
                PermissionAccessTypeDto.READ -> HealthPermission.getReadPermission(
                    MenstruationFlowRecord::class,
                )

                PermissionAccessTypeDto.WRITE -> HealthPermission.getWritePermission(
                    MenstruationFlowRecord::class,
                )
            }
        }

        HealthDataTypeDto.MENSTRUATION_PERIOD -> {
            when (accessType) {
                PermissionAccessTypeDto.READ -> HealthPermission.getReadPermission(
                    MenstruationPeriodRecord::class,
                )

                PermissionAccessTypeDto.WRITE -> HealthPermission.getWritePermission(
                    MenstruationPeriodRecord::class,
                )
            }
        }

        HealthDataTypeDto.SLEEP_SESSION -> {
            when (accessType) {
                PermissionAccessTypeDto.READ -> HealthPermission.getReadPermission(
                    SleepSessionRecord::class,
                )

                PermissionAccessTypeDto.WRITE -> HealthPermission.getWritePermission(
                    SleepSessionRecord::class,
                )
            }
        }

        HealthDataTypeDto.RESTING_HEART_RATE -> {
            when (accessType) {
                PermissionAccessTypeDto.READ -> HealthPermission.getReadPermission(
                    RestingHeartRateRecord::class,
                )

                PermissionAccessTypeDto.WRITE -> HealthPermission.getWritePermission(
                    RestingHeartRateRecord::class,
                )
            }
        }

        HealthDataTypeDto.BLOOD_PRESSURE -> {
            when (accessType) {
                PermissionAccessTypeDto.READ -> HealthPermission.getReadPermission(
                    BloodPressureRecord::class,
                )

                PermissionAccessTypeDto.WRITE -> HealthPermission.getWritePermission(
                    BloodPressureRecord::class,
                )
            }
        }

        HealthDataTypeDto.BLOOD_GLUCOSE -> {
            when (accessType) {
                PermissionAccessTypeDto.READ -> HealthPermission.getReadPermission(
                    BloodGlucoseRecord::class,
                )

                PermissionAccessTypeDto.WRITE -> HealthPermission.getWritePermission(
                    BloodGlucoseRecord::class,
                )
            }
        }

        HealthDataTypeDto.OXYGEN_SATURATION -> {
            when (accessType) {
                PermissionAccessTypeDto.READ -> HealthPermission.getReadPermission(
                    OxygenSaturationRecord::class,
                )

                PermissionAccessTypeDto.WRITE -> HealthPermission.getWritePermission(
                    OxygenSaturationRecord::class,
                )
            }
        }

        HealthDataTypeDto.RESPIRATORY_RATE -> {
            when (accessType) {
                PermissionAccessTypeDto.READ -> HealthPermission.getReadPermission(
                    RespiratoryRateRecord::class,
                )

                PermissionAccessTypeDto.WRITE -> HealthPermission.getWritePermission(
                    RespiratoryRateRecord::class,
                )
            }
        }

        HealthDataTypeDto.VO2MAX -> {
            when (accessType) {
                PermissionAccessTypeDto.READ -> HealthPermission.getReadPermission(
                    Vo2MaxRecord::class,
                )

                PermissionAccessTypeDto.WRITE -> HealthPermission.getWritePermission(
                    Vo2MaxRecord::class,
                )
            }
        }

        HealthDataTypeDto.NUTRITION -> {
            when (accessType) {
                PermissionAccessTypeDto.READ -> HealthPermission.getReadPermission(
                    NutritionRecord::class,
                )

                PermissionAccessTypeDto.WRITE -> HealthPermission.getWritePermission(
                    NutritionRecord::class,
                )
            }
        }

        HealthDataTypeDto.SPEED_SERIES -> {
            when (accessType) {
                PermissionAccessTypeDto.READ -> HealthPermission.getReadPermission(
                    SpeedRecord::class,
                )

                PermissionAccessTypeDto.WRITE -> HealthPermission.getWritePermission(
                    SpeedRecord::class,
                )
            }
        }

        HealthDataTypeDto.POWER_SERIES -> {
            when (accessType) {
                PermissionAccessTypeDto.READ -> HealthPermission.getReadPermission(
                    PowerRecord::class,
                )

                PermissionAccessTypeDto.WRITE -> HealthPermission.getWritePermission(
                    PowerRecord::class,
                )
            }
        }

        HealthDataTypeDto.CYCLING_PEDALING_CADENCE_SERIES -> {
            when (accessType) {
                PermissionAccessTypeDto.READ -> HealthPermission.getReadPermission(
                    CyclingPedalingCadenceRecord::class,
                )

                PermissionAccessTypeDto.WRITE -> HealthPermission.getWritePermission(
                    CyclingPedalingCadenceRecord::class,
                )
            }
        }

        HealthDataTypeDto.STEPS_CADENCE_SERIES_RECORD -> {
            when (accessType) {
                PermissionAccessTypeDto.READ -> HealthPermission.getReadPermission(
                    StepsCadenceRecord::class,
                )

                PermissionAccessTypeDto.WRITE -> HealthPermission.getWritePermission(
                    StepsCadenceRecord::class,
                )
            }
        }

        HealthDataTypeDto.EXERCISE_SESSION -> {
            when (accessType) {
                PermissionAccessTypeDto.READ -> HealthPermission.getReadPermission(
                    ExerciseSessionRecord::class,
                )

                PermissionAccessTypeDto.WRITE -> HealthPermission.getWritePermission(
                    ExerciseSessionRecord::class,
                )
            }
        }

        HealthDataTypeDto.MINDFULNESS_SESSION -> {
            when (accessType) {
                PermissionAccessTypeDto.READ -> HealthPermission.getReadPermission(
                    MindfulnessSessionRecord::class,
                )

                PermissionAccessTypeDto.WRITE -> HealthPermission.getWritePermission(
                    MindfulnessSessionRecord::class,
                )
            }
        }

        HealthDataTypeDto.BONE_MASS -> {
            when (accessType) {
                PermissionAccessTypeDto.READ -> HealthPermission.getReadPermission(
                    BoneMassRecord::class,
                )

                PermissionAccessTypeDto.WRITE -> HealthPermission.getWritePermission(
                    BoneMassRecord::class,
                )
            }
        }

        HealthDataTypeDto.BODY_WATER_MASS -> {
            when (accessType) {
                PermissionAccessTypeDto.READ -> HealthPermission.getReadPermission(
                    BodyWaterMassRecord::class,
                )

                PermissionAccessTypeDto.WRITE -> HealthPermission.getWritePermission(
                    BodyWaterMassRecord::class,
                )
            }
        }

        HealthDataTypeDto.HEART_RATE_VARIABILITY_RMSSD -> {
            when (accessType) {
                PermissionAccessTypeDto.READ -> HealthPermission.getReadPermission(
                    HeartRateVariabilityRmssdRecord::class,
                )

                PermissionAccessTypeDto.WRITE -> HealthPermission.getWritePermission(
                    HeartRateVariabilityRmssdRecord::class,
                )
            }
        }

        HealthDataTypeDto.ACTIVITY_INTENSITY -> {
            when (accessType) {
                PermissionAccessTypeDto.READ -> HealthPermission.getReadPermission(
                    ActivityIntensityRecord::class,
                )

                PermissionAccessTypeDto.WRITE -> HealthPermission.getWritePermission(
                    ActivityIntensityRecord::class,
                )
            }
        }

        HealthDataTypeDto.SKIN_TEMPERATURE_DELTA_SERIES -> {
            when (accessType) {
                PermissionAccessTypeDto.READ -> HealthPermission.getReadPermission(
                    SkinTemperatureRecord::class,
                )

                PermissionAccessTypeDto.WRITE -> HealthPermission.getWritePermission(
                    SkinTemperatureRecord::class,
                )
            }
        }
    }

/**
 * Converts a Health Connect permission string back to a [HealthDataPermissionRequestDto].
 *
 * This function parses Android Health Connect permission strings (e.g.,
 * "android.permission.health.READ_STEPS") and converts them to the corresponding DTO.
 *
 * @receiver The Health Connect permission string to parse
 * @return The corresponding [HealthDataPermissionRequestDto]
 * @throws IllegalArgumentException if:
 *         - the permission string format is invalid or doesn't start with the expected prefix
 *         - the data type or access type is not supported by this application
 */
@Throws(IllegalArgumentException::class)
private fun String.toHealthDataPermissionDto(): HealthDataPermissionRequestDto {
    // Health Connect permission strings follow the pattern:
    // android.permission.health.READ_STEPS, android.permission.health.WRITE_WEIGHT, etc.
    val prefix = "android.permission.health."
    if (!this.startsWith(prefix)) {
        throw IllegalArgumentException(
            "Invalid Health Connect permission string: '$this'. " +
                "Expected format: 'android.permission.health.READ_<TYPE>' " +
                "or 'android.permission.health.WRITE_<TYPE>'",
        )
    }

    val suffix = this.removePrefix(prefix)
    val parts = suffix.split("_", limit = 2)
    if (parts.size != 2) {
        throw IllegalArgumentException(
            "Invalid Health Connect permission string: '$this'. " +
                "Permission suffix '$suffix' could not be split into access type and data type. " +
                "Expected format: 'READ_<TYPE>' or 'WRITE_<TYPE>'",
        )
    }

    val accessTypeStr = parts[0] // READ or WRITE
    val dataTypeStr = parts[1] // STEPS, WEIGHT, etc.

    val accessType = when (accessTypeStr) {
        "READ" -> PermissionAccessTypeDto.READ
        "WRITE" -> PermissionAccessTypeDto.WRITE
        else -> throw IllegalArgumentException(
            "Invalid Health Connect permission string: '$this'. " +
                "Unknown access type: '$accessTypeStr'. Expected 'READ' or 'WRITE'",
        )
    }

    val dataType = when (dataTypeStr) {
        "ACTIVE_CALORIES_BURNED" -> HealthDataTypeDto.ACTIVE_CALORIES_BURNED
        "TOTAL_CALORIES_BURNED" -> HealthDataTypeDto.TOTAL_CALORIES_BURNED
        "STEPS" -> HealthDataTypeDto.STEPS
        "WEIGHT" -> HealthDataTypeDto.WEIGHT
        "DISTANCE" -> HealthDataTypeDto.DISTANCE
        "ELEVATION_GAINED" -> HealthDataTypeDto.ELEVATION_GAINED
        "FLOORS_CLIMBED" -> HealthDataTypeDto.FLOORS_CLIMBED
        "HEIGHT" -> HealthDataTypeDto.HEIGHT
        "HYDRATION" -> HealthDataTypeDto.HYDRATION
        "LEAN_BODY_MASS" -> HealthDataTypeDto.LEAN_BODY_MASS
        "BODY_FAT" -> HealthDataTypeDto.BODY_FAT_PERCENTAGE
        "BODY_TEMPERATURE" -> HealthDataTypeDto.BODY_TEMPERATURE
        "BASAL_BODY_TEMPERATURE" -> HealthDataTypeDto.BASAL_BODY_TEMPERATURE
        "CERVICAL_MUCUS" -> HealthDataTypeDto.CERVICAL_MUCUS
        "SEXUAL_ACTIVITY" -> HealthDataTypeDto.SEXUAL_ACTIVITY
        "WHEELCHAIR_PUSHES" -> HealthDataTypeDto.WHEELCHAIR_PUSHES
        "HEART_RATE" -> HealthDataTypeDto.HEART_RATE_SERIES
        "RESTING_HEART_RATE" -> HealthDataTypeDto.RESTING_HEART_RATE
        "SLEEP" -> HealthDataTypeDto.SLEEP_SESSION
        "BLOOD_PRESSURE" -> HealthDataTypeDto.BLOOD_PRESSURE
        "BLOOD_GLUCOSE" -> HealthDataTypeDto.BLOOD_GLUCOSE
        "OVULATION_TEST" -> HealthDataTypeDto.OVULATION_TEST
        "INTERMENSTRUAL_BLEEDING" -> HealthDataTypeDto.INTERMENSTRUAL_BLEEDING
        "MENSTRUATION" -> HealthDataTypeDto.MENSTRUAL_FLOW_INSTANT
        "OXYGEN_SATURATION" -> HealthDataTypeDto.OXYGEN_SATURATION
        "RESPIRATORY_RATE" -> HealthDataTypeDto.RESPIRATORY_RATE
        "VO2_MAX" -> HealthDataTypeDto.VO2MAX
        "NUTRITION" -> HealthDataTypeDto.NUTRITION
        "SPEED" -> HealthDataTypeDto.SPEED_SERIES
        "POWER" -> HealthDataTypeDto.POWER_SERIES
        "STEPS_CADENCE" -> HealthDataTypeDto.STEPS_CADENCE_SERIES_RECORD
        "CYCLING_PEDALING_CADENCE" -> HealthDataTypeDto.CYCLING_PEDALING_CADENCE_SERIES
        "EXERCISE" -> HealthDataTypeDto.EXERCISE_SESSION
        "MINDFULNESS" -> HealthDataTypeDto.MINDFULNESS_SESSION
        "BONE_MASS" -> HealthDataTypeDto.BONE_MASS
        "BODY_WATER_MASS" -> HealthDataTypeDto.BODY_WATER_MASS
        "HEART_RATE_VARIABILITY" -> HealthDataTypeDto.HEART_RATE_VARIABILITY_RMSSD
        "ACTIVITY_INTENSITY" -> HealthDataTypeDto.ACTIVITY_INTENSITY
        "SKIN_TEMPERATURE" -> HealthDataTypeDto.SKIN_TEMPERATURE_DELTA_SERIES
        else -> throw IllegalArgumentException(
            "Invalid/unsupported/unimplemented Health Connect data type: $dataTypeStr.",
        )
    }

    return HealthDataPermissionRequestDto(healthDataType = dataType, accessType = accessType)
}
