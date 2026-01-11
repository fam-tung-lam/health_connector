package com.phamtunglam.health_connector_hc_android.handlers

import androidx.annotation.VisibleForTesting
import androidx.health.connect.client.HealthConnectClient
import com.phamtunglam.health_connector_hc_android.DispatcherProvider
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
import com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers.StepsHandler
import com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers.TotalEnergyBurnedHandler
import com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers.Vo2MaxHandler
import com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers.WeightHandler
import com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers.WheelchairPushesHandler
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataTypeDto

/**
 * Central registry for Health Connect type handlers.
 */
internal class HealthRecordHandlerRegistry(
    private val dispatchers: DispatcherProvider,
    private val client: HealthConnectClient,
) {
    @get:VisibleForTesting
    internal val registeredHandlersCount: Int
        get() = handlers.size

    private val handlers: Map<HealthDataTypeDto, HealthRecordHandler> by lazy {
        buildMap {
            register(
                HeartRateHandler(
                    dispatcher = dispatchers.io,
                    client = client,
                ),
            )
            register(
                CyclingPedalingCadenceHandler(
                    dispatcher = dispatchers.io,
                    client = client,
                ),
            )
            register(
                HeightHandler(
                    dispatcher = dispatchers.io,
                    client = client,
                ),
            )
            register(
                BodyTemperatureHandler(
                    dispatcher = dispatchers.io,
                    client = client,
                ),
            )
            register(
                BasalBodyTemperatureHandler(
                    dispatcher = dispatchers.io,
                    client = client,
                ),
            )
            register(
                CervicalMucusHandler(
                    dispatcher = dispatchers.io,
                    client = client,
                ),
            )
            register(
                LeanBodyMassHandler(
                    dispatcher = dispatchers.io,
                    client = client,
                ),
            )
            register(
                BodyFatPercentageHandler(
                    dispatcher = dispatchers.io,
                    client = client,
                ),
            )
            register(
                StepsHandler(
                    dispatcher = dispatchers.io,
                    client = client,
                ),
            )
            register(
                ActiveEnergyBurnedHandler(
                    dispatcher = dispatchers.io,
                    client = client,
                ),
            )
            register(
                TotalEnergyBurnedHandler(
                    dispatcher = dispatchers.io,
                    client = client,
                ),
            )
            register(
                DistanceHandler(
                    dispatcher = dispatchers.io,
                    client = client,
                ),
            )
            register(
                WeightHandler(
                    dispatcher = dispatchers.io,
                    client = client,
                ),
            )
            register(
                RestingHeartRateHandler(
                    dispatcher = dispatchers.io,
                    client = client,
                ),
            )
            register(
                OxygenSaturationHandler(
                    dispatcher = dispatchers.io,
                    client = client,
                ),
            )
            register(
                RespiratoryRateHandler(
                    dispatcher = dispatchers.io,
                    client = client,
                ),
            )
            register(
                Vo2MaxHandler(
                    dispatcher = dispatchers.io,
                    client = client,
                ),
            )
            register(
                BloodGlucoseHandler(
                    dispatcher = dispatchers.io,
                    client = client,
                ),
            )
            register(
                BloodPressureHandler(
                    dispatcher = dispatchers.io,
                    client = client,
                ),
            )
            register(
                FloorsClimbedHandler(
                    dispatcher = dispatchers.io,
                    client = client,
                ),
            )
            register(
                ExerciseSessionHandler(
                    dispatcher = dispatchers.io,
                    client = client,
                ),
            )
            register(
                HydrationHandler(
                    dispatcher = dispatchers.io,
                    client = client,
                ),
            )
            register(
                NutritionHandler(
                    dispatcher = dispatchers.io,
                    client = client,
                ),
            )
            register(
                OvulationTestHandler(
                    dispatcher = dispatchers.io,
                    client = client,
                ),
            )
            register(
                IntermenstrualBleedingHandler(
                    dispatcher = dispatchers.io,
                    client = client,
                ),
            )
            register(
                MenstrualFlowInstantHandler(
                    dispatcher = dispatchers.io,
                    client = client,
                ),
            )
            register(
                PowerSeriesHandler(
                    dispatcher = dispatchers.io,
                    client = client,
                ),
            )
            register(
                SexualActivityHandler(
                    dispatcher = dispatchers.io,
                    client = client,
                ),
            )
            register(
                SleepSessionHandler(
                    dispatcher = dispatchers.io,
                    client = client,
                ),
            )
            register(
                MindfulnessSessionHandler(
                    dispatcher = dispatchers.io,
                    client = client,
                ),
            )
            register(
                SpeedSeriesHandler(
                    dispatcher = dispatchers.io,
                    client = client,
                ),
            )
            register(
                WheelchairPushesHandler(
                    dispatcher = dispatchers.io,
                    client = client,
                ),
            )
            register(
                BoneMassHandler(
                    dispatcher = dispatchers.io,
                    client = client,
                ),
            )
            register(
                BodyWaterMassHandler(
                    dispatcher = dispatchers.io,
                    client = client,
                ),
            )
            register(
                HeartRateVariabilityRMSSDHandler(
                    dispatcher = dispatchers.io,
                    client = client,
                ),
            )
        }
    }

    /**
     * Retrieves a record handler for the specified health data type.
     *
     * @param type The health data type
     * @return The record handler for the type, or null if not found
     */
    fun getRecordHandler(type: HealthDataTypeDto): HealthRecordHandler? = handlers[type]

    /**
     * Registers a handler in the map builder.
     *
     * This is a private extension function used during map initialization.
     *
     * @param handler The handler to register
     */
    private fun MutableMap<HealthDataTypeDto, HealthRecordHandler>.register(
        handler: HealthRecordHandler,
    ) {
        this[handler.dataType] = handler
    }
}
