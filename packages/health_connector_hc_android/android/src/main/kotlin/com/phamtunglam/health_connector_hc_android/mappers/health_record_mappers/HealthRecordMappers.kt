package com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers

import androidx.health.connect.client.records.Record
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
import com.phamtunglam.health_connector_hc_android.pigeon.WeightRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.WheelchairPushesRecordDto

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
    is StepRecordDto -> toHealthConnect()
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
    is BloodPressureRecordDto -> toHealthConnect()
}
