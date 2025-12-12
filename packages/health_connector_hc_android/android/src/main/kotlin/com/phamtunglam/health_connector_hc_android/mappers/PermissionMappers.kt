package com.phamtunglam.health_connector_hc_android.mappers

import androidx.health.connect.client.permission.HealthPermission
import androidx.health.connect.client.records.ActiveCaloriesBurnedRecord
import androidx.health.connect.client.records.BloodPressureRecord
import androidx.health.connect.client.records.BodyFatRecord
import androidx.health.connect.client.records.BodyTemperatureRecord
import androidx.health.connect.client.records.DistanceRecord
import androidx.health.connect.client.records.FloorsClimbedRecord
import androidx.health.connect.client.records.HeartRateRecord
import androidx.health.connect.client.records.HeightRecord
import androidx.health.connect.client.records.HydrationRecord
import androidx.health.connect.client.records.LeanBodyMassRecord
import androidx.health.connect.client.records.NutritionRecord
import androidx.health.connect.client.records.OxygenSaturationRecord
import androidx.health.connect.client.records.RespiratoryRateRecord
import androidx.health.connect.client.records.RestingHeartRateRecord
import androidx.health.connect.client.records.SleepSessionRecord
import androidx.health.connect.client.records.StepsRecord
import androidx.health.connect.client.records.Vo2MaxRecord
import androidx.health.connect.client.records.WeightRecord
import androidx.health.connect.client.records.WheelchairPushesRecord
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataPermissionDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthPlatformFeatureDto
import com.phamtunglam.health_connector_hc_android.pigeon.PermissionAccessTypeDto

/**
 * Health Connect platform feature permission constants.
 * These special permissions grant additional capabilities beyond basic read/write access.
 */
private const val PERMISSION_READ_HEALTH_DATA_IN_BACKGROUND =
    "android.permission.health.READ_HEALTH_DATA_IN_BACKGROUND"
private const val PERMISSION_READ_HEALTH_DATA_HISTORY =
    "android.permission.health.READ_HEALTH_DATA_HISTORY"

/**
 * Converts a [HealthDataPermissionDto] to a Health Connect permission string.
 *
 * @receiver The [HealthDataPermissionDto] to convert
 * @return The Health Connect permission string corresponding to the DTO
 */
internal fun HealthDataPermissionDto.toHealthConnectPermission(): String =
    when (this.healthDataType) {
        HealthDataTypeDto.ACTIVE_CALORIES_BURNED -> {
            when (this.accessType) {
                PermissionAccessTypeDto.READ -> HealthPermission.getReadPermission(
                    ActiveCaloriesBurnedRecord::class,
                )
                PermissionAccessTypeDto.WRITE -> HealthPermission.getWritePermission(
                    ActiveCaloriesBurnedRecord::class,
                )
            }
        }

        HealthDataTypeDto.STEPS -> {
            when (this.accessType) {
                PermissionAccessTypeDto.READ -> HealthPermission.getReadPermission(
                    StepsRecord::class,
                )
                PermissionAccessTypeDto.WRITE -> HealthPermission.getWritePermission(
                    StepsRecord::class,
                )
            }
        }

        HealthDataTypeDto.WEIGHT -> {
            when (this.accessType) {
                PermissionAccessTypeDto.READ -> HealthPermission.getReadPermission(
                    WeightRecord::class,
                )
                PermissionAccessTypeDto.WRITE -> HealthPermission.getWritePermission(
                    WeightRecord::class,
                )
            }
        }

        HealthDataTypeDto.DISTANCE -> {
            when (this.accessType) {
                PermissionAccessTypeDto.READ -> HealthPermission.getReadPermission(
                    DistanceRecord::class,
                )
                PermissionAccessTypeDto.WRITE -> HealthPermission.getWritePermission(
                    DistanceRecord::class,
                )
            }
        }

        HealthDataTypeDto.FLOORS_CLIMBED -> {
            when (this.accessType) {
                PermissionAccessTypeDto.READ -> HealthPermission.getReadPermission(
                    FloorsClimbedRecord::class,
                )
                PermissionAccessTypeDto.WRITE -> HealthPermission.getWritePermission(
                    FloorsClimbedRecord::class,
                )
            }
        }

        HealthDataTypeDto.HEIGHT -> {
            when (this.accessType) {
                PermissionAccessTypeDto.READ -> HealthPermission.getReadPermission(
                    HeightRecord::class,
                )
                PermissionAccessTypeDto.WRITE -> HealthPermission.getWritePermission(
                    HeightRecord::class,
                )
            }
        }

        HealthDataTypeDto.HYDRATION -> {
            when (this.accessType) {
                PermissionAccessTypeDto.READ -> HealthPermission.getReadPermission(
                    HydrationRecord::class,
                )
                PermissionAccessTypeDto.WRITE -> HealthPermission.getWritePermission(
                    HydrationRecord::class,
                )
            }
        }

        HealthDataTypeDto.LEAN_BODY_MASS -> {
            when (this.accessType) {
                PermissionAccessTypeDto.READ -> HealthPermission.getReadPermission(
                    LeanBodyMassRecord::class,
                )
                PermissionAccessTypeDto.WRITE -> HealthPermission.getWritePermission(
                    LeanBodyMassRecord::class,
                )
            }
        }

        HealthDataTypeDto.BODY_FAT_PERCENTAGE -> {
            when (this.accessType) {
                PermissionAccessTypeDto.READ -> HealthPermission.getReadPermission(
                    BodyFatRecord::class,
                )
                PermissionAccessTypeDto.WRITE -> HealthPermission.getWritePermission(
                    BodyFatRecord::class,
                )
            }
        }

        HealthDataTypeDto.BODY_TEMPERATURE -> {
            when (this.accessType) {
                PermissionAccessTypeDto.READ -> HealthPermission.getReadPermission(
                    BodyTemperatureRecord::class,
                )
                PermissionAccessTypeDto.WRITE -> HealthPermission.getWritePermission(
                    BodyTemperatureRecord::class,
                )
            }
        }

        HealthDataTypeDto.WHEELCHAIR_PUSHES -> {
            when (this.accessType) {
                PermissionAccessTypeDto.READ -> HealthPermission.getReadPermission(
                    WheelchairPushesRecord::class,
                )
                PermissionAccessTypeDto.WRITE -> HealthPermission.getWritePermission(
                    WheelchairPushesRecord::class,
                )
            }
        }

        HealthDataTypeDto.HEART_RATE_SERIES_RECORD -> {
            when (this.accessType) {
                PermissionAccessTypeDto.READ -> HealthPermission.getReadPermission(
                    HeartRateRecord::class,
                )
                PermissionAccessTypeDto.WRITE -> HealthPermission.getWritePermission(
                    HeartRateRecord::class,
                )
            }
        }

        HealthDataTypeDto.SLEEP_SESSION -> {
            when (this.accessType) {
                PermissionAccessTypeDto.READ -> HealthPermission.getReadPermission(
                    SleepSessionRecord::class,
                )
                PermissionAccessTypeDto.WRITE -> HealthPermission.getWritePermission(
                    SleepSessionRecord::class,
                )
            }
        }

        HealthDataTypeDto.RESTING_HEART_RATE -> {
            when (this.accessType) {
                PermissionAccessTypeDto.READ -> HealthPermission.getReadPermission(
                    RestingHeartRateRecord::class,
                )
                PermissionAccessTypeDto.WRITE -> HealthPermission.getWritePermission(
                    RestingHeartRateRecord::class,
                )
            }
        }

        HealthDataTypeDto.BLOOD_PRESSURE -> {
            when (this.accessType) {
                PermissionAccessTypeDto.READ -> HealthPermission.getReadPermission(
                    BloodPressureRecord::class,
                )
                PermissionAccessTypeDto.WRITE -> HealthPermission.getWritePermission(
                    BloodPressureRecord::class,
                )
            }
        }

        HealthDataTypeDto.OXYGEN_SATURATION -> {
            when (this.accessType) {
                PermissionAccessTypeDto.READ -> HealthPermission.getReadPermission(
                    OxygenSaturationRecord::class,
                )
                PermissionAccessTypeDto.WRITE -> HealthPermission.getWritePermission(
                    OxygenSaturationRecord::class,
                )
            }
        }

        HealthDataTypeDto.RESPIRATORY_RATE -> {
            when (this.accessType) {
                PermissionAccessTypeDto.READ -> HealthPermission.getReadPermission(
                    RespiratoryRateRecord::class,
                )
                PermissionAccessTypeDto.WRITE -> HealthPermission.getWritePermission(
                    RespiratoryRateRecord::class,
                )
            }
        }

        HealthDataTypeDto.VO2MAX -> {
            when (this.accessType) {
                PermissionAccessTypeDto.READ -> HealthPermission.getReadPermission(
                    Vo2MaxRecord::class,
                )
                PermissionAccessTypeDto.WRITE -> HealthPermission.getWritePermission(
                    Vo2MaxRecord::class,
                )
            }
        }

        HealthDataTypeDto.ENERGY_NUTRIENT,
        HealthDataTypeDto.CAFFEINE,
        HealthDataTypeDto.PROTEIN,
        HealthDataTypeDto.TOTAL_CARBOHYDRATE,
        HealthDataTypeDto.TOTAL_FAT,
        HealthDataTypeDto.SATURATED_FAT,
        HealthDataTypeDto.MONOUNSATURATED_FAT,
        HealthDataTypeDto.POLYUNSATURATED_FAT,
        HealthDataTypeDto.CHOLESTEROL,
        HealthDataTypeDto.DIETARY_FIBER,
        HealthDataTypeDto.SUGAR,
        HealthDataTypeDto.VITAMIN_A,
        HealthDataTypeDto.VITAMIN_B6,
        HealthDataTypeDto.VITAMIN_B12,
        HealthDataTypeDto.VITAMIN_C,
        HealthDataTypeDto.VITAMIN_D,
        HealthDataTypeDto.VITAMIN_E,
        HealthDataTypeDto.VITAMIN_K,
        HealthDataTypeDto.THIAMIN,
        HealthDataTypeDto.RIBOFLAVIN,
        HealthDataTypeDto.NIACIN,
        HealthDataTypeDto.FOLATE,
        HealthDataTypeDto.BIOTIN,
        HealthDataTypeDto.PANTOTHENIC_ACID,
        HealthDataTypeDto.CALCIUM,
        HealthDataTypeDto.IRON,
        HealthDataTypeDto.MAGNESIUM,
        HealthDataTypeDto.MANGANESE,
        HealthDataTypeDto.PHOSPHORUS,
        HealthDataTypeDto.POTASSIUM,
        HealthDataTypeDto.SELENIUM,
        HealthDataTypeDto.SODIUM,
        HealthDataTypeDto.ZINC,
        HealthDataTypeDto.NUTRITION,
        -> {
            when (this.accessType) {
                PermissionAccessTypeDto.READ -> HealthPermission.getReadPermission(
                    NutritionRecord::class,
                )
                PermissionAccessTypeDto.WRITE -> HealthPermission.getWritePermission(
                    NutritionRecord::class,
                )
            }
        }
    }

/**
 * Converts a Health Connect permission string back to a [HealthDataPermissionDto].
 *
 * This function parses Android Health Connect permission strings (e.g.,
 * "android.permission.health.READ_STEPS") and converts them to the corresponding DTO.
 *
 * @receiver The Health Connect permission string to parse
 * @return The corresponding [HealthDataPermissionDto]
 * @throws IllegalArgumentException if the permission string format is invalid or doesn't
 *         start with the expected prefix
 * @throws UnsupportedOperationException if the data type or access type is not supported
 *         by this application
 */
@Throws(IllegalArgumentException::class, UnsupportedOperationException::class)
internal fun String.toDto(): HealthDataPermissionDto {
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
        "STEPS" -> HealthDataTypeDto.STEPS
        "WEIGHT" -> HealthDataTypeDto.WEIGHT
        "DISTANCE" -> HealthDataTypeDto.DISTANCE
        "FLOORS_CLIMBED" -> HealthDataTypeDto.FLOORS_CLIMBED
        "HEIGHT" -> HealthDataTypeDto.HEIGHT
        "HYDRATION" -> HealthDataTypeDto.HYDRATION
        "LEAN_BODY_MASS" -> HealthDataTypeDto.LEAN_BODY_MASS
        "BODY_FAT_PERCENTAGE" -> HealthDataTypeDto.BODY_FAT_PERCENTAGE
        "BODY_TEMPERATURE" -> HealthDataTypeDto.BODY_TEMPERATURE
        "WHEELCHAIR_PUSHES" -> HealthDataTypeDto.WHEELCHAIR_PUSHES
        "HEART_RATE" -> HealthDataTypeDto.HEART_RATE_SERIES_RECORD
        "RESTING_HEART_RATE" -> HealthDataTypeDto.RESTING_HEART_RATE
        "SLEEP_SESSION" -> HealthDataTypeDto.SLEEP_SESSION
        "BLOOD_PRESSURE" -> HealthDataTypeDto.BLOOD_PRESSURE
        "OXYGEN_SATURATION" -> HealthDataTypeDto.OXYGEN_SATURATION
        "RESPIRATORY_RATE" -> HealthDataTypeDto.RESPIRATORY_RATE
        "VO2_MAX" -> HealthDataTypeDto.VO2MAX
        "NUTRITION" -> HealthDataTypeDto.NUTRITION
        else -> throw UnsupportedOperationException(
            "Unsupported Health Connect data type: '$dataTypeStr' in permission '$this'.",
        )
    }

    return HealthDataPermissionDto(healthDataType = dataType, accessType = accessType)
}

/**
 * Converts a Health Platform Feature DTO to a Health Connect permission string.
 *
 * @receiver The [HealthPlatformFeatureDto] to convert
 * @return The Health Connect permission string corresponding to the feature
 */
internal fun HealthPlatformFeatureDto.toHealthConnectPermission(): String = when (this) {
    HealthPlatformFeatureDto.READ_HEALTH_DATA_IN_BACKGROUND ->
        PERMISSION_READ_HEALTH_DATA_IN_BACKGROUND
    HealthPlatformFeatureDto.READ_HEALTH_DATA_HISTORY ->
        PERMISSION_READ_HEALTH_DATA_HISTORY
}

/**
 * Converts a Health Connect permission string back to a [HealthPlatformFeatureDto].
 *
 * @receiver The Health Connect permission string to parse
 * @return The corresponding [HealthPlatformFeatureDto]
 * @throws UnsupportedOperationException if the permission string doesn't match a known
 *         platform feature or represents a feature not supported by this application
 */
@Throws(UnsupportedOperationException::class)
internal fun String.toHealthPlatformFeatureDto(): HealthPlatformFeatureDto = when (this) {
    PERMISSION_READ_HEALTH_DATA_IN_BACKGROUND ->
        HealthPlatformFeatureDto.READ_HEALTH_DATA_IN_BACKGROUND
    PERMISSION_READ_HEALTH_DATA_HISTORY ->
        HealthPlatformFeatureDto.READ_HEALTH_DATA_HISTORY
    else -> throw UnsupportedOperationException(
        "Unsupported Health Connect platform feature: '$this'. " +
            "Supported features: READ_HEALTH_DATA_IN_BACKGROUND, READ_HEALTH_DATA_HISTORY.",
    )
}

/**
 * Checks if this permission string represents a Health Connect platform feature permission.
 *
 * Platform feature permissions grant special capabilities like background reading or
 * historical data access, as opposed to regular data type permissions.
 *
 * @receiver The permission string to check
 * @return `true` if this is a platform feature permission, `false` otherwise
 */
internal val String.isFeaturePermission: Boolean
    get() = this == PERMISSION_READ_HEALTH_DATA_IN_BACKGROUND ||
        this == PERMISSION_READ_HEALTH_DATA_HISTORY
