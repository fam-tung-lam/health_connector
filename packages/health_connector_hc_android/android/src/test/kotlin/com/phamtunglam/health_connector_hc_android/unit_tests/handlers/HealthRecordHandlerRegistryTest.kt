package com.phamtunglam.health_connector_hc_android.unit_tests.handlers

import androidx.health.connect.client.HealthConnectClient
import com.phamtunglam.health_connector_hc_android.handlers.HealthRecordHandlerRegistry
import com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers.ActiveEnergyBurnedHandler
import com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers.BasalBodyTemperatureHandler
import com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers.BloodGlucoseHandler
import com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers.BloodPressureHandler
import com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers.BodyFatPercentageHandler
import com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers.BodyTemperatureHandler
import com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers.BodyWaterMassHandler
import com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers.BoneMassHandler
import com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers.CervicalMucusHandler
import com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers.CyclingPedalingCadenceHandler
import com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers.DistanceHandler
import com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers.ExerciseSessionHandler
import com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers.FloorsClimbedHandler
import com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers.HeartRateHandler
import com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers.HeartRateVariabilityRMSSDHandler
import com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers.HeightHandler
import com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers.HydrationHandler
import com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers.IntermenstrualBleedingHandler
import com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers.LeanBodyMassHandler
import com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers.MenstrualFlowInstantHandler
import com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers.MindfulnessSessionHandler
import com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers.NutritionHandler
import com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers.OvulationTestHandler
import com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers.OxygenSaturationHandler
import com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers.PowerSeriesHandler
import com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers.RespiratoryRateHandler
import com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers.RestingHeartRateHandler
import com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers.SexualActivityHandler
import com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers.SleepSessionHandler
import com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers.SpeedSeriesHandler
import com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers.StepsCadenceSeriesHandler
import com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers.StepsHandler
import com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers.TotalEnergyBurnedHandler
import com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers.Vo2MaxHandler
import com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers.WeightHandler
import com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers.WheelchairPushesHandler
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataTypeDto
import com.phamtunglam.health_connector_hc_android.utils.TestDispatcherProvider
import io.kotest.matchers.nulls.shouldNotBeNull
import io.kotest.matchers.shouldBe
import io.mockk.MockKAnnotations
import io.mockk.impl.annotations.RelaxedMockK
import io.mockk.unmockkAll
import java.util.stream.Stream
import kotlin.reflect.KClass
import kotlinx.coroutines.test.StandardTestDispatcher
import org.junit.jupiter.api.AfterEach
import org.junit.jupiter.api.BeforeEach
import org.junit.jupiter.api.DisplayName
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.TestInstance
import org.junit.jupiter.params.ParameterizedTest
import org.junit.jupiter.params.provider.Arguments
import org.junit.jupiter.params.provider.MethodSource

@DisplayName("HealthRecordHandlerRegistry")
@TestInstance(TestInstance.Lifecycle.PER_CLASS)
class HealthRecordHandlerRegistryTest {

    // region Test Fixtures

    @RelaxedMockK
    private lateinit var healthConnectClient: HealthConnectClient

    private lateinit var systemUnderTest: HealthRecordHandlerRegistry

    // endregion

    // region Setup

    @BeforeEach
    fun setUp() {
        MockKAnnotations.init(this)
        systemUnderTest = HealthRecordHandlerRegistry(
            dispatchers = TestDispatcherProvider(
                testDispatcher = StandardTestDispatcher(),
            ),
            client = healthConnectClient,
        )
    }

    @AfterEach
    fun tearDown() {
        unmockkAll()
    }

    @ParameterizedTest(name = "{0} should map to {1}")
    @MethodSource("provideHandlerMappings")
    @DisplayName("GIVEN registry WHEN getRecordHandler called THEN returns correct handler type")
    fun testGetRecordHandler(dataType: HealthDataTypeDto, expectedClass: KClass<*>) {
        val handler = systemUnderTest.getRecordHandler(dataType)
        handler.shouldNotBeNull()
        handler::class shouldBe expectedClass
    }

    @Test
    @DisplayName(
        "GIVEN registry WHEN initialized THEN has handlers for all HealthDataTypeDto values",
    )
    fun testRegisteredHandlersCount() {
        systemUnderTest.registeredHandlersCount shouldBe HealthDataTypeDto.entries.size
    }

    fun provideHandlerMappings(): Stream<Arguments> = Stream.of(
        Arguments.of(
            HealthDataTypeDto.ACTIVE_CALORIES_BURNED,
            ActiveEnergyBurnedHandler::class,
        ),
        Arguments.of(HealthDataTypeDto.DISTANCE, DistanceHandler::class),
        Arguments.of(HealthDataTypeDto.FLOORS_CLIMBED, FloorsClimbedHandler::class),
        Arguments.of(HealthDataTypeDto.EXERCISE_SESSION, ExerciseSessionHandler::class),
        Arguments.of(HealthDataTypeDto.STEPS, StepsHandler::class),
        Arguments.of(HealthDataTypeDto.WEIGHT, WeightHandler::class),
        Arguments.of(HealthDataTypeDto.HEIGHT, HeightHandler::class),
        Arguments.of(HealthDataTypeDto.BODY_FAT_PERCENTAGE, BodyFatPercentageHandler::class),
        Arguments.of(HealthDataTypeDto.BODY_TEMPERATURE, BodyTemperatureHandler::class),
        Arguments.of(
            HealthDataTypeDto.BASAL_BODY_TEMPERATURE,
            BasalBodyTemperatureHandler::class,
        ),
        Arguments.of(HealthDataTypeDto.CERVICAL_MUCUS, CervicalMucusHandler::class),
        Arguments.of(HealthDataTypeDto.LEAN_BODY_MASS, LeanBodyMassHandler::class),
        Arguments.of(HealthDataTypeDto.WHEELCHAIR_PUSHES, WheelchairPushesHandler::class),
        Arguments.of(HealthDataTypeDto.HYDRATION, HydrationHandler::class),
        Arguments.of(HealthDataTypeDto.HEART_RATE_SERIES, HeartRateHandler::class),
        Arguments.of(
            HealthDataTypeDto.CYCLING_PEDALING_CADENCE_SERIES,
            CyclingPedalingCadenceHandler::class,
        ),
        Arguments.of(
            HealthDataTypeDto.STEPS_CADENCE_SERIES_RECORD,
            StepsCadenceSeriesHandler::class,
        ),
        Arguments.of(HealthDataTypeDto.SEXUAL_ACTIVITY, SexualActivityHandler::class),
        Arguments.of(HealthDataTypeDto.SLEEP_SESSION, SleepSessionHandler::class),
        Arguments.of(HealthDataTypeDto.NUTRITION, NutritionHandler::class),
        Arguments.of(HealthDataTypeDto.RESTING_HEART_RATE, RestingHeartRateHandler::class),
        Arguments.of(HealthDataTypeDto.BLOOD_PRESSURE, BloodPressureHandler::class),
        Arguments.of(HealthDataTypeDto.OVULATION_TEST, OvulationTestHandler::class),
        Arguments.of(
            HealthDataTypeDto.INTERMENSTRUAL_BLEEDING,
            IntermenstrualBleedingHandler::class,
        ),
        Arguments.of(
            HealthDataTypeDto.MENSTRUAL_FLOW_INSTANT,
            MenstrualFlowInstantHandler::class,
        ),
        Arguments.of(HealthDataTypeDto.OXYGEN_SATURATION, OxygenSaturationHandler::class),
        Arguments.of(HealthDataTypeDto.POWER_SERIES, PowerSeriesHandler::class),
        Arguments.of(HealthDataTypeDto.RESPIRATORY_RATE, RespiratoryRateHandler::class),
        Arguments.of(HealthDataTypeDto.VO2MAX, Vo2MaxHandler::class),
        Arguments.of(HealthDataTypeDto.BLOOD_GLUCOSE, BloodGlucoseHandler::class),
        Arguments.of(HealthDataTypeDto.SPEED_SERIES, SpeedSeriesHandler::class),
        Arguments.of(HealthDataTypeDto.MINDFULNESS_SESSION, MindfulnessSessionHandler::class),
        Arguments.of(
            HealthDataTypeDto.TOTAL_CALORIES_BURNED,
            TotalEnergyBurnedHandler::class,
        ),
        Arguments.of(HealthDataTypeDto.BONE_MASS, BoneMassHandler::class),
        Arguments.of(
            HealthDataTypeDto.HEART_RATE_VARIABILITY_RMSSD,
            HeartRateVariabilityRMSSDHandler::class,
        ),
        Arguments.of(HealthDataTypeDto.BODY_WATER_MASS, BodyWaterMassHandler::class),
    )
}
