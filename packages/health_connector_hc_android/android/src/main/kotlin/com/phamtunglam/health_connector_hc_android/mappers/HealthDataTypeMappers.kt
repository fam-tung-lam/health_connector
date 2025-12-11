package com.phamtunglam.health_connector_hc_android.mappers

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
import androidx.health.connect.client.records.Record
import androidx.health.connect.client.records.SleepSessionRecord
import androidx.health.connect.client.records.StepsRecord
import androidx.health.connect.client.records.WeightRecord
import androidx.health.connect.client.records.WheelchairPushesRecord
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataTypeDto
import kotlin.reflect.KClass

/**
 * Converts a [HealthDataTypeDto] to a Health Connect record class.
 *
 * @receiver The [HealthDataTypeDto] to convert
 * @return The Health Connect record class [KClass] corresponding to the DTO
 */
internal fun HealthDataTypeDto.toHealthConnectRecordClass(): KClass<out Record> = when (this) {
    HealthDataTypeDto.ACTIVE_CALORIES_BURNED -> ActiveCaloriesBurnedRecord::class
    HealthDataTypeDto.DISTANCE -> DistanceRecord::class
    HealthDataTypeDto.FLOORS_CLIMBED -> FloorsClimbedRecord::class
    HealthDataTypeDto.HEIGHT -> HeightRecord::class
    HealthDataTypeDto.HYDRATION -> HydrationRecord::class
    HealthDataTypeDto.LEAN_BODY_MASS -> LeanBodyMassRecord::class
    HealthDataTypeDto.BODY_FAT_PERCENTAGE -> BodyFatRecord::class
    HealthDataTypeDto.BODY_TEMPERATURE -> BodyTemperatureRecord::class
    HealthDataTypeDto.STEPS -> StepsRecord::class
    HealthDataTypeDto.WEIGHT -> WeightRecord::class
    HealthDataTypeDto.WHEELCHAIR_PUSHES -> WheelchairPushesRecord::class
    HealthDataTypeDto.HEART_RATE_SERIES_RECORD -> HeartRateRecord::class
    HealthDataTypeDto.SLEEP_SESSION -> SleepSessionRecord::class
    HealthDataTypeDto.BLOOD_PRESSURE -> BloodPressureRecord::class
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
    -> NutritionRecord::class
}
