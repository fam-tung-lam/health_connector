package com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers

import com.phamtunglam.health_connector_hc_android.pigeon.ActiveEnergyBurnedRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.BasalBodyTemperatureRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.BloodGlucoseRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.BloodPressureRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.BodyFatPercentageRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.BodyTemperatureRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.BodyWaterMassRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.BoneMassRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.CervicalMucusRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.CyclingPedalingCadenceSeriesRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.DistanceRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.ExerciseSessionRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.FloorsClimbedRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.HeartRateSeriesRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.HeartRateVariabilityRMSSDRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.HeightRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.HydrationRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.IntermenstrualBleedingRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.LeanBodyMassRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.MenstrualFlowInstantRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.MindfulnessSessionRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.NutritionRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.OvulationTestRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.OxygenSaturationRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.PowerSeriesRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.RespiratoryRateRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.RestingHeartRateRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.SexualActivityRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.SleepSessionRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.SpeedSeriesRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.StepsCadenceSeriesRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.StepsRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.TotalEnergyBurnedRecordDto
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
        is ActiveEnergyBurnedRecordDto -> id
        is TotalEnergyBurnedRecordDto -> id
        is DistanceRecordDto -> id
        is FloorsClimbedRecordDto -> id
        is StepsRecordDto -> id
        is StepsCadenceSeriesRecordDto -> id
        is HeightRecordDto -> id
        is HydrationRecordDto -> id
        is BodyFatPercentageRecordDto -> id
        is BodyTemperatureRecordDto -> id
        is BasalBodyTemperatureRecordDto -> id
        is CervicalMucusRecordDto -> id
        is WeightRecordDto -> id
        is LeanBodyMassRecordDto -> id
        is WheelchairPushesRecordDto -> id
        is HeartRateSeriesRecordDto -> id
        is RestingHeartRateRecordDto -> id
        is SexualActivityRecordDto -> id
        is OvulationTestRecordDto -> id
        is OxygenSaturationRecordDto -> id
        is SleepSessionRecordDto -> id
        is SpeedSeriesRecordDto -> id
        is PowerSeriesRecordDto -> id
        is CyclingPedalingCadenceSeriesRecordDto -> id
        is RespiratoryRateRecordDto -> id
        is Vo2MaxRecordDto -> id
        is BloodPressureRecordDto -> id
        is BloodGlucoseRecordDto -> id
        is NutritionRecordDto -> id
        is ExerciseSessionRecordDto -> id
        is MindfulnessSessionRecordDto -> id
        is IntermenstrualBleedingRecordDto -> id
        is MenstrualFlowInstantRecordDto -> id
        is BoneMassRecordDto -> id
        is BodyWaterMassRecordDto -> id
        is HeartRateVariabilityRMSSDRecordDto -> id
    }
