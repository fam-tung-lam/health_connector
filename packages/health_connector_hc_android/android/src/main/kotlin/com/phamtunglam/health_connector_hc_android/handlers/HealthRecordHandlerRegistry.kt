package com.phamtunglam.health_connector_hc_android.handlers

import androidx.health.connect.client.HealthConnectClient
import com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers.ActiveCaloriesBurnedHandler
import com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers.BasalBodyTemperatureHandler
import com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers.BloodGlucoseHandler
import com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers.BloodPressureHandler
import com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers.BodyFatPercentageHandler
import com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers.BodyTemperatureHandler
import com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers.CervicalMucusHandler
import com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers.CyclingPedalingCadenceHandler
import com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers.DistanceHandler
import com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers.ExerciseSessionHandler
import com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers.FloorsClimbedHandler
import com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers.HeartRateHandler
import com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers.HeightHandler
import com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers.HydrationHandler
import com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers.LeanBodyMassHandler
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
import com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers.TotalCaloriesBurnedHandler
import com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers.Vo2MaxHandler
import com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers.WeightHandler
import com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers.WheelchairPushesHandler
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataTypeDto

/**
 * Central registry for Health Connect type handlers.
 */
internal class HealthRecordHandlerRegistry(private val client: HealthConnectClient) {
    private val handlers: Map<HealthDataTypeDto, HealthRecordHandler> by lazy {
        buildMap {
            register(HeartRateHandler(client))
            register(CyclingPedalingCadenceHandler(client))
            register(HeightHandler(client))
            register(BodyTemperatureHandler(client))
            register(BasalBodyTemperatureHandler(client))
            register(CervicalMucusHandler(client))
            register(LeanBodyMassHandler(client))
            register(BodyFatPercentageHandler(client))
            register(StepsHandler(client))
            register(ActiveCaloriesBurnedHandler(client))
            register(TotalCaloriesBurnedHandler(client))
            register(DistanceHandler(client))
            register(WeightHandler(client))
            register(RestingHeartRateHandler(client))
            register(OxygenSaturationHandler(client))
            register(RespiratoryRateHandler(client))
            register(Vo2MaxHandler(client))
            register(BloodGlucoseHandler(client))
            register(BloodPressureHandler(client))
            register(FloorsClimbedHandler(client))
            register(ExerciseSessionHandler(client))
            register(HydrationHandler(client))
            register(NutritionHandler(client))
            register(OvulationTestHandler(client))
            register(PowerSeriesHandler(client))
            register(SexualActivityHandler(client))
            register(SleepSessionHandler(client))
            register(MindfulnessSessionHandler(client))
            register(SpeedSeriesHandler(client))
            register(WheelchairPushesHandler(client))
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
