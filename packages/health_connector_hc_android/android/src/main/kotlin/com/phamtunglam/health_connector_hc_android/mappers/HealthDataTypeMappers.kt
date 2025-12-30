package com.phamtunglam.health_connector_hc_android.mappers

import androidx.health.connect.client.feature.ExperimentalMindfulnessSessionApi
import androidx.health.connect.client.records.ActiveCaloriesBurnedRecord
import androidx.health.connect.client.records.BloodGlucoseRecord
import androidx.health.connect.client.records.BloodPressureRecord
import androidx.health.connect.client.records.BodyFatRecord
import androidx.health.connect.client.records.BodyTemperatureRecord
import androidx.health.connect.client.records.CervicalMucusRecord
import androidx.health.connect.client.records.CyclingPedalingCadenceRecord
import androidx.health.connect.client.records.DistanceRecord
import androidx.health.connect.client.records.ExerciseSessionRecord
import androidx.health.connect.client.records.FloorsClimbedRecord
import androidx.health.connect.client.records.HeartRateRecord
import androidx.health.connect.client.records.HeightRecord
import androidx.health.connect.client.records.HydrationRecord
import androidx.health.connect.client.records.LeanBodyMassRecord
import androidx.health.connect.client.records.MindfulnessSessionRecord
import androidx.health.connect.client.records.NutritionRecord
import androidx.health.connect.client.records.OvulationTestRecord
import androidx.health.connect.client.records.OxygenSaturationRecord
import androidx.health.connect.client.records.PowerRecord
import androidx.health.connect.client.records.Record
import androidx.health.connect.client.records.RespiratoryRateRecord
import androidx.health.connect.client.records.RestingHeartRateRecord
import androidx.health.connect.client.records.SexualActivityRecord
import androidx.health.connect.client.records.SleepSessionRecord
import androidx.health.connect.client.records.SpeedRecord
import androidx.health.connect.client.records.StepsRecord
import androidx.health.connect.client.records.Vo2MaxRecord
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
@OptIn(ExperimentalMindfulnessSessionApi::class)
internal fun HealthDataTypeDto.toHealthConnectRecordClass(): KClass<out Record> = when (this) {
    HealthDataTypeDto.ACTIVE_CALORIES_BURNED -> ActiveCaloriesBurnedRecord::class
    HealthDataTypeDto.DISTANCE -> DistanceRecord::class
    HealthDataTypeDto.FLOORS_CLIMBED -> FloorsClimbedRecord::class
    HealthDataTypeDto.EXERCISE_SESSION -> ExerciseSessionRecord::class
    HealthDataTypeDto.HEIGHT -> HeightRecord::class
    HealthDataTypeDto.HYDRATION -> HydrationRecord::class
    HealthDataTypeDto.LEAN_BODY_MASS -> LeanBodyMassRecord::class
    HealthDataTypeDto.BODY_FAT_PERCENTAGE -> BodyFatRecord::class
    HealthDataTypeDto.BODY_TEMPERATURE -> BodyTemperatureRecord::class
    HealthDataTypeDto.CERVICAL_MUCUS -> CervicalMucusRecord::class
    HealthDataTypeDto.STEPS -> StepsRecord::class
    HealthDataTypeDto.WEIGHT -> WeightRecord::class
    HealthDataTypeDto.WHEELCHAIR_PUSHES -> WheelchairPushesRecord::class
    HealthDataTypeDto.HEART_RATE_SERIES_RECORD -> HeartRateRecord::class
    HealthDataTypeDto.SEXUAL_ACTIVITY -> SexualActivityRecord::class
    HealthDataTypeDto.SLEEP_SESSION -> SleepSessionRecord::class
    HealthDataTypeDto.RESTING_HEART_RATE -> RestingHeartRateRecord::class
    HealthDataTypeDto.BLOOD_PRESSURE -> BloodPressureRecord::class
    HealthDataTypeDto.BLOOD_GLUCOSE -> BloodGlucoseRecord::class
    HealthDataTypeDto.OXYGEN_SATURATION -> OxygenSaturationRecord::class
    HealthDataTypeDto.RESPIRATORY_RATE -> RespiratoryRateRecord::class
    HealthDataTypeDto.VO2MAX -> Vo2MaxRecord::class
    HealthDataTypeDto.NUTRITION -> NutritionRecord::class
    HealthDataTypeDto.OVULATION_TEST -> OvulationTestRecord::class
    HealthDataTypeDto.SPEED_SERIES -> SpeedRecord::class
    HealthDataTypeDto.POWER_SERIES -> PowerRecord::class
    HealthDataTypeDto.CYCLING_PEDALING_CADENCE_SERIES_RECORD -> CyclingPedalingCadenceRecord::class
    HealthDataTypeDto.MINDFULNESS_SESSION -> MindfulnessSessionRecord::class
}
