package com.phamtunglam.health_connector_hc_android.handlers

import androidx.health.connect.client.HealthConnectClient
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataTypeDto

/**
 * Central registry for Health Connect type handlers.
 */
internal class HealthRecordHandlerRegistry(private val client: HealthConnectClient) {
    private val handlers: Map<HealthDataTypeDto, HealthRecordHandler> by lazy {
        buildMap {
            register(HeartRateHandler(client))
            register(HeightHandler(client))
            register(BodyTemperatureHandler(client))
            register(LeanBodyMassHandler(client))
            register(BodyFatPercentageHandler(client))
            register(StepsHandler(client))
            register(ActiveCaloriesBurnedHandler(client))
            register(DistanceHandler(client))
            register(WeightHandler(client))
            register(RestingHeartRateHandler(client))
            register(OxygenSaturationHandler(client))
            register(RespiratoryRateHandler(client))
            register(Vo2MaxHandler(client))
            register(BloodGlucoseHandler(client))
            register(BloodPressureHandler(client))
            register(FloorsClimbedHandler(client))
            register(HydrationHandler(client))
            register(NutritionHandler(client))
            register(SleepSessionHandler(client))
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
