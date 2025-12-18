package com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers

import androidx.health.connect.client.records.ActiveCaloriesBurnedRecord
import androidx.health.connect.client.records.BloodGlucoseRecord
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
import androidx.health.connect.client.records.Record
import androidx.health.connect.client.records.RespiratoryRateRecord
import androidx.health.connect.client.records.RestingHeartRateRecord
import androidx.health.connect.client.records.SleepSessionRecord
import androidx.health.connect.client.records.StepsRecord
import androidx.health.connect.client.records.Vo2MaxRecord
import androidx.health.connect.client.records.WeightRecord
import androidx.health.connect.client.records.WheelchairPushesRecord
import com.phamtunglam.health_connector_hc_android.pigeon.ActiveCaloriesBurnedRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.BloodGlucoseRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.BloodPressureRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.BodyFatPercentageRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.BodyTemperatureRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.DistanceRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.FloorsClimbedRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.HeartRateSeriesRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.HeightRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.HydrationRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.LeanBodyMassRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.NutritionRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.OxygenSaturationRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.RespiratoryRateRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.RestingHeartRateRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.SleepSessionRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.StepsRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.Vo2MaxRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.WeightRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.WheelchairPushesRecordDto

/**
 * Returns the [HealthDataTypeDto] for this health record.
 *
 * This extension uses pattern matching on the sealed class to determine
 * the corresponding health data type for each record type.
 */
internal val HealthRecordDto.dataType: HealthDataTypeDto
    get() = when (this) {
        is ActiveCaloriesBurnedRecordDto -> HealthDataTypeDto.ACTIVE_CALORIES_BURNED
        is DistanceRecordDto -> HealthDataTypeDto.DISTANCE
        is FloorsClimbedRecordDto -> HealthDataTypeDto.FLOORS_CLIMBED
        is StepsRecordDto -> HealthDataTypeDto.STEPS
        is HeightRecordDto -> HealthDataTypeDto.HEIGHT
        is HydrationRecordDto -> HealthDataTypeDto.HYDRATION
        is BodyFatPercentageRecordDto -> HealthDataTypeDto.BODY_FAT_PERCENTAGE
        is BodyTemperatureRecordDto -> HealthDataTypeDto.BODY_TEMPERATURE
        is WeightRecordDto -> HealthDataTypeDto.WEIGHT
        is LeanBodyMassRecordDto -> HealthDataTypeDto.LEAN_BODY_MASS
        is WheelchairPushesRecordDto -> HealthDataTypeDto.WHEELCHAIR_PUSHES
        is HeartRateSeriesRecordDto -> HealthDataTypeDto.HEART_RATE_SERIES_RECORD
        is RestingHeartRateRecordDto -> HealthDataTypeDto.RESTING_HEART_RATE
        is SleepSessionRecordDto -> HealthDataTypeDto.SLEEP_SESSION
        is NutritionRecordDto -> HealthDataTypeDto.NUTRITION
        is OxygenSaturationRecordDto -> HealthDataTypeDto.OXYGEN_SATURATION
        is RespiratoryRateRecordDto -> HealthDataTypeDto.RESPIRATORY_RATE
        is Vo2MaxRecordDto -> HealthDataTypeDto.VO2MAX
        is BloodPressureRecordDto -> HealthDataTypeDto.BLOOD_PRESSURE
        is BloodGlucoseRecordDto -> HealthDataTypeDto.BLOOD_GLUCOSE
    }

/**
 * Converts a [HealthRecordDto] to a Health Connect [Record] object.
 *
 * This extension uses pattern matching on the sealed class to convert
 * each record type to its corresponding Health Connect record.
 */
internal fun HealthRecordDto.toHealthConnect(): Record = when (this) {
    is ActiveCaloriesBurnedRecordDto -> toHealthConnect()
    is DistanceRecordDto -> toHealthConnect()
    is FloorsClimbedRecordDto -> toHealthConnect()
    is StepsRecordDto -> toHealthConnect()
    is HeightRecordDto -> toHealthConnect()
    is HydrationRecordDto -> toHealthConnect()
    is BodyFatPercentageRecordDto -> toHealthConnect()
    is BodyTemperatureRecordDto -> toHealthConnect()
    is WeightRecordDto -> toHealthConnect()
    is LeanBodyMassRecordDto -> toHealthConnect()
    is WheelchairPushesRecordDto -> toHealthConnect()
    is HeartRateSeriesRecordDto -> toHealthConnect()
    is RestingHeartRateRecordDto -> toHealthConnect()
    is SleepSessionRecordDto -> toHealthConnect()
    is NutritionRecordDto -> toHealthConnect()
    is OxygenSaturationRecordDto -> toHealthConnect()
    is RespiratoryRateRecordDto -> toHealthConnect()
    is Vo2MaxRecordDto -> toHealthConnect()
    is BloodPressureRecordDto -> toHealthConnect()
    is BloodGlucoseRecordDto -> toHealthConnect()
}

/**
 * Converts a Health Connect [Record] to a [HealthRecordDto].
 *
 * This is the reverse mapping of [toHealthConnect].
 *
 * This extension uses pattern matching on the record type to convert
 * each Health Connect record to its corresponding DTO.
 *
 * @receiver The Health Connect [Record] to convert
 * @return The [HealthRecordDto] corresponding to the record type
 * @throws IllegalArgumentException if the record type is not supported
 */
internal fun Record.toDto(): HealthRecordDto = when (this) {
    is ActiveCaloriesBurnedRecord -> toDto()
    is DistanceRecord -> toDto()
    is FloorsClimbedRecord -> toDto()
    is StepsRecord -> toDto()
    is HeightRecord -> toDto()
    is HydrationRecord -> toDto()
    is BodyFatRecord -> toDto()
    is BodyTemperatureRecord -> toDto()
    is WeightRecord -> toDto()
    is LeanBodyMassRecord -> toDto()
    is WheelchairPushesRecord -> toDto()
    is HeartRateRecord -> toDto()
    is RestingHeartRateRecord -> toDto()
    is SleepSessionRecord -> toDto()
    is NutritionRecord -> toDto()
    is OxygenSaturationRecord -> toDto()
    is RespiratoryRateRecord -> toDto()
    is Vo2MaxRecord -> toDto()
    is BloodPressureRecord -> toDto()
    is BloodGlucoseRecord -> toDto()
    else -> throw IllegalArgumentException("Unsupported record type: ${this::class.simpleName}")
}
