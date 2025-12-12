package com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers

import com.phamtunglam.health_connector_hc_android.pigeon.ActiveCaloriesBurnedRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.BloodPressureRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.BodyFatPercentageRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.BodyTemperatureRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.DistanceRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.FloorsClimbedRecordDto
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
import com.phamtunglam.health_connector_hc_android.pigeon.StepRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.Vo2MaxRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.WeightRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.WheelchairPushesRecordDto

/**
 * Extension property to get the ID from a [HealthRecordDto].
 *
 * This extension is needed due to a Pigeon limitation where sealed classes cannot have
 * any fields. Since [HealthRecordDto] is a sealed class, we cannot define a common `id`
 * field at the sealed class level. Instead, each subclass has its own `id` field, and
 * this extension provides a unified way to access the ID across all record types.
 *
 * @return The platform-assigned unique identifier for the record, or `null` if the
 * record doesn't have an ID (e.g., for new records being written).
 */
internal val HealthRecordDto.id: String?
    get() = when (this) {
        is ActiveCaloriesBurnedRecordDto -> id
        is DistanceRecordDto -> id
        is FloorsClimbedRecordDto -> id
        is StepRecordDto -> id
        is HeightRecordDto -> id
        is HydrationRecordDto -> id
        is BodyFatPercentageRecordDto -> id
        is BodyTemperatureRecordDto -> id
        is WeightRecordDto -> id
        is LeanBodyMassRecordDto -> id
        is WheelchairPushesRecordDto -> id
        is HeartRateSeriesRecordDto -> id
        is RestingHeartRateRecordDto -> id
        is OxygenSaturationRecordDto -> id
        is SleepSessionRecordDto -> id
        is RespiratoryRateRecordDto -> id
        is Vo2MaxRecordDto -> id

        // Blood pressure records
        is BloodPressureRecordDto -> id

        // Unified nutrition record
        is NutritionRecordDto -> id
    }
