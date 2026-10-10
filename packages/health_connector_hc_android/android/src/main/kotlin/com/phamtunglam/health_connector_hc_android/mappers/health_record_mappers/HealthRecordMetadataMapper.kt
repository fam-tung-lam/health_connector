package com.phamtunglam.health_connector_hc_android.mappers.health_record_mappers

import com.phamtunglam.health_connector_hc_android.pigeon.ActiveEnergyBurnedRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.ActivityIntensityRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.BasalBodyTemperatureRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.BasalMetabolicRateRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.BloodGlucoseRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.BloodPressureRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.BodyFatPercentageRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.BodyTemperatureRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.BodyWaterMassRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.BoneMassRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.CervicalMucusRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.CyclingPedalingCadenceSeriesRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.DistanceRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.ElevationGainedRecordDto
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
import com.phamtunglam.health_connector_hc_android.pigeon.MenstruationPeriodRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.MetadataDto
import com.phamtunglam.health_connector_hc_android.pigeon.MindfulnessSessionRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.NutritionRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.OvulationTestRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.OxygenSaturationRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.PowerSeriesRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.RespiratoryRateRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.RestingHeartRateRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.SexualActivityRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.SkinTemperatureDeltaSeriesRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.SleepSessionRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.SpeedSeriesRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.StepsCadenceSeriesRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.StepsRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.TotalEnergyBurnedRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.Vo2MaxRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.WeightRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.WheelchairPushesRecordDto

/**
 * Copies a record with transformed metadata while preserving its health data.
 */
// Keep all sealed DTO variants together so adding a record requires metadata handling.
@Suppress("LongMethod", "CyclomaticComplexMethod")
internal fun HealthRecordDto.mapMetadata(
    transform: (MetadataDto) -> MetadataDto,
): HealthRecordDto = when (this) {
    is BloodGlucoseRecordDto -> copy(metadata = transform(metadata))
    is RestingHeartRateRecordDto -> copy(metadata = transform(metadata))
    is OxygenSaturationRecordDto -> copy(metadata = transform(metadata))
    is OvulationTestRecordDto -> copy(metadata = transform(metadata))
    is IntermenstrualBleedingRecordDto -> copy(metadata = transform(metadata))
    is MenstrualFlowInstantRecordDto -> copy(metadata = transform(metadata))
    is MenstruationPeriodRecordDto -> copy(metadata = transform(metadata))
    is RespiratoryRateRecordDto -> copy(metadata = transform(metadata))
    is Vo2MaxRecordDto -> copy(metadata = transform(metadata))
    is ActiveEnergyBurnedRecordDto -> copy(metadata = transform(metadata))
    is DistanceRecordDto -> copy(metadata = transform(metadata))
    is FloorsClimbedRecordDto -> copy(metadata = transform(metadata))
    is WheelchairPushesRecordDto -> copy(metadata = transform(metadata))
    is StepsRecordDto -> copy(metadata = transform(metadata))
    is WeightRecordDto -> copy(metadata = transform(metadata))
    is BloodPressureRecordDto -> copy(metadata = transform(metadata))
    is LeanBodyMassRecordDto -> copy(metadata = transform(metadata))
    is HeightRecordDto -> copy(metadata = transform(metadata))
    is BodyFatPercentageRecordDto -> copy(metadata = transform(metadata))
    is BodyTemperatureRecordDto -> copy(metadata = transform(metadata))
    is BasalBodyTemperatureRecordDto -> copy(metadata = transform(metadata))
    is CervicalMucusRecordDto -> copy(metadata = transform(metadata))
    is HydrationRecordDto -> copy(metadata = transform(metadata))
    is HeartRateSeriesRecordDto -> copy(metadata = transform(metadata))
    is CyclingPedalingCadenceSeriesRecordDto -> copy(metadata = transform(metadata))
    is StepsCadenceSeriesRecordDto -> copy(metadata = transform(metadata))
    is ElevationGainedRecordDto -> copy(metadata = transform(metadata))
    is SpeedSeriesRecordDto -> copy(metadata = transform(metadata))
    is PowerSeriesRecordDto -> copy(metadata = transform(metadata))
    is SkinTemperatureDeltaSeriesRecordDto -> copy(metadata = transform(metadata))
    is SleepSessionRecordDto -> copy(metadata = transform(metadata))
    is SexualActivityRecordDto -> copy(metadata = transform(metadata))
    is ExerciseSessionRecordDto -> copy(metadata = transform(metadata))
    is ActivityIntensityRecordDto -> copy(metadata = transform(metadata))
    is MindfulnessSessionRecordDto -> copy(metadata = transform(metadata))
    is NutritionRecordDto -> copy(metadata = transform(metadata))
    is TotalEnergyBurnedRecordDto -> copy(metadata = transform(metadata))
    is BasalMetabolicRateRecordDto -> copy(metadata = transform(metadata))
    is BoneMassRecordDto -> copy(metadata = transform(metadata))
    is HeartRateVariabilityRMSSDRecordDto -> copy(metadata = transform(metadata))
    is BodyWaterMassRecordDto -> copy(metadata = transform(metadata))
}
