package com.phamtunglam.health_connector_hc_android.unit_tests.mappers

import androidx.health.connect.client.records.ActiveCaloriesBurnedRecord
import androidx.health.connect.client.records.ActivityIntensityRecord
import androidx.health.connect.client.records.BasalBodyTemperatureRecord
import androidx.health.connect.client.records.BloodGlucoseRecord
import androidx.health.connect.client.records.BloodPressureRecord
import androidx.health.connect.client.records.BodyFatRecord
import androidx.health.connect.client.records.BodyTemperatureRecord
import androidx.health.connect.client.records.BodyWaterMassRecord
import androidx.health.connect.client.records.BoneMassRecord
import androidx.health.connect.client.records.CervicalMucusRecord
import androidx.health.connect.client.records.CyclingPedalingCadenceRecord
import androidx.health.connect.client.records.DistanceRecord
import androidx.health.connect.client.records.ExerciseSessionRecord
import androidx.health.connect.client.records.FloorsClimbedRecord
import androidx.health.connect.client.records.HeartRateRecord
import androidx.health.connect.client.records.HeartRateVariabilityRmssdRecord
import androidx.health.connect.client.records.HeightRecord
import androidx.health.connect.client.records.HydrationRecord
import androidx.health.connect.client.records.IntermenstrualBleedingRecord
import androidx.health.connect.client.records.LeanBodyMassRecord
import androidx.health.connect.client.records.MenstruationFlowRecord
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
import androidx.health.connect.client.records.TotalCaloriesBurnedRecord
import androidx.health.connect.client.records.Vo2MaxRecord
import androidx.health.connect.client.records.WeightRecord
import androidx.health.connect.client.records.WheelchairPushesRecord
import com.phamtunglam.health_connector_hc_android.mappers.toHealthConnectRecordClass
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataTypeDto
import io.kotest.matchers.shouldBe
import kotlin.reflect.KClass
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Nested
import org.junit.jupiter.api.TestInstance
import org.junit.jupiter.params.ParameterizedTest
import org.junit.jupiter.params.provider.Arguments
import org.junit.jupiter.params.provider.MethodSource

/**
 * Unit tests for Health Data Type Mappers.
 *
 * Tests verify proper mapping between [HealthDataTypeDto] values and Health Connect
 * record classes. Uses parameterized tests to verify all 35 data types are correctly mapped.
 */
@DisplayName("HealthDataTypeMappers")
class HealthDataTypeMapperTest {

    @Nested
    @TestInstance(TestInstance.Lifecycle.PER_CLASS)
    @DisplayName("toHealthConnectRecordClass")
    inner class ToHealthConnectRecordClass {

        @ParameterizedTest(name = "dataType={0} maps to recordClass={1}")
        @MethodSource("provideAllDataTypeMappings")
        @DisplayName(
            "GIVEN any HealthDataTypeDto → " +
                "WHEN toHealthConnectRecordClass called → " +
                "THEN maps to correct Health Connect record class",
        )
        fun whenAnyDataType_thenMapsToCorrectRecordClass(
            dataType: HealthDataTypeDto,
            expectedRecordClass: KClass<out Record>,
        ) {
            // When
            val result = dataType.toHealthConnectRecordClass()

            // Then
            result shouldBe expectedRecordClass
        }

        fun provideAllDataTypeMappings(): List<Arguments> = listOf(
            // Activity & Fitness
            Arguments.of(
                HealthDataTypeDto.ACTIVE_CALORIES_BURNED,
                ActiveCaloriesBurnedRecord::class,
            ),
            Arguments.of(
                HealthDataTypeDto.TOTAL_CALORIES_BURNED,
                TotalCaloriesBurnedRecord::class,
            ),
            Arguments.of(HealthDataTypeDto.STEPS, StepsRecord::class),
            Arguments.of(HealthDataTypeDto.DISTANCE, DistanceRecord::class),
            Arguments.of(HealthDataTypeDto.FLOORS_CLIMBED, FloorsClimbedRecord::class),
            Arguments.of(HealthDataTypeDto.EXERCISE_SESSION, ExerciseSessionRecord::class),
            Arguments.of(HealthDataTypeDto.WHEELCHAIR_PUSHES, WheelchairPushesRecord::class),
            Arguments.of(
                HealthDataTypeDto.ACTIVITY_INTENSITY,
                ActivityIntensityRecord::class,
            ),

            // Body Measurements
            Arguments.of(HealthDataTypeDto.WEIGHT, WeightRecord::class),
            Arguments.of(HealthDataTypeDto.HEIGHT, HeightRecord::class),
            Arguments.of(HealthDataTypeDto.BODY_FAT_PERCENTAGE, BodyFatRecord::class),
            Arguments.of(HealthDataTypeDto.LEAN_BODY_MASS, LeanBodyMassRecord::class),
            Arguments.of(HealthDataTypeDto.BONE_MASS, BoneMassRecord::class),
            Arguments.of(HealthDataTypeDto.BODY_WATER_MASS, BodyWaterMassRecord::class),

            // Vital Signs
            Arguments.of(HealthDataTypeDto.BODY_TEMPERATURE, BodyTemperatureRecord::class),
            Arguments.of(
                HealthDataTypeDto.BASAL_BODY_TEMPERATURE,
                BasalBodyTemperatureRecord::class,
            ),
            Arguments.of(HealthDataTypeDto.BLOOD_PRESSURE, BloodPressureRecord::class),
            Arguments.of(HealthDataTypeDto.BLOOD_GLUCOSE, BloodGlucoseRecord::class),
            Arguments.of(HealthDataTypeDto.OXYGEN_SATURATION, OxygenSaturationRecord::class),
            Arguments.of(HealthDataTypeDto.RESPIRATORY_RATE, RespiratoryRateRecord::class),
            Arguments.of(
                HealthDataTypeDto.HEART_RATE_SERIES,
                HeartRateRecord::class,
            ),
            Arguments.of(HealthDataTypeDto.RESTING_HEART_RATE, RestingHeartRateRecord::class),
            Arguments.of(
                HealthDataTypeDto.HEART_RATE_VARIABILITY_RMSSD,
                HeartRateVariabilityRmssdRecord::class,
            ),

            // Nutrition & Hydration
            Arguments.of(HealthDataTypeDto.HYDRATION, HydrationRecord::class),
            Arguments.of(HealthDataTypeDto.NUTRITION, NutritionRecord::class),

            // Reproductive Health
            Arguments.of(HealthDataTypeDto.CERVICAL_MUCUS, CervicalMucusRecord::class),
            Arguments.of(HealthDataTypeDto.SEXUAL_ACTIVITY, SexualActivityRecord::class),
            Arguments.of(HealthDataTypeDto.OVULATION_TEST, OvulationTestRecord::class),
            Arguments.of(
                HealthDataTypeDto.INTERMENSTRUAL_BLEEDING,
                IntermenstrualBleedingRecord::class,
            ),
            Arguments.of(HealthDataTypeDto.MENSTRUAL_FLOW_INSTANT, MenstruationFlowRecord::class),

            // Sleep & Mindfulness
            Arguments.of(HealthDataTypeDto.SLEEP_SESSION, SleepSessionRecord::class),
            Arguments.of(HealthDataTypeDto.MINDFULNESS_SESSION, MindfulnessSessionRecord::class),

            // Performance & Series Data
            Arguments.of(HealthDataTypeDto.VO2MAX, Vo2MaxRecord::class),
            Arguments.of(HealthDataTypeDto.SPEED_SERIES, SpeedRecord::class),
            Arguments.of(HealthDataTypeDto.POWER_SERIES, PowerRecord::class),
            Arguments.of(
                HealthDataTypeDto.CYCLING_PEDALING_CADENCE_SERIES,
                CyclingPedalingCadenceRecord::class,
            ),
        )
    }
}
