package com.phamtunglam.health_connector_hc_android.handlers

import com.phamtunglam.health_connector_hc_android.pigeon.AggregateRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataTypeDto

/**
 * Central registry for Health Connect type handlers.
 *
 * This object provides O(1) lookup for handlers by health data type, enabling
 * efficient type dispatch without large when-expression blocks.
 *
 * The registry is thread-safe through Kotlin's lazy initialization guarantees
 * and uses an immutable map for concurrent read access.
 */
internal object HealthConnectTypeHandlerRegistry {
    /**
     * Immutable map of health data types to their handlers.
     *
     * Initialized lazily on first access, ensuring thread-safe singleton behavior.
     * Once built, the map is never modified, making it safe for concurrent reads.
     */
    private val handlers: Map<HealthDataTypeDto, HealthConnectRecordHandler> by lazy {
        buildMap {
            // Interval records
            register(StepsHandler)
            register(ActiveCaloriesBurnedHandler)
            register(DistanceHandler)
            register(FloorsClimbedHandler)
            register(WheelchairPushesHandler)
            register(HydrationHandler)
            register(NutritionHandler)

            // Instant records
            register(WeightHandler)
            register(HeightHandler)
            register(BodyTemperatureHandler)
            register(LeanBodyMassHandler)
            register(BodyFatPercentageHandler)

            register(BloodPressureHandler)

            register(RestingHeartRateHandler)
            register(OxygenSaturationHandler)
            register(RespiratoryRateHandler)
            register(Vo2MaxHandler)
            register(BloodGlucoseHandler)

            // Series records
            register(HeartRateHandler)

            // Session records
            register(SleepSessionHandler)
        }
    }

    /**
     * Registers a handler in the map builder.
     *
     * This is a private extension function used during map initialization.
     *
     * @param handler The handler to register
     */
    private fun MutableMap<HealthDataTypeDto, HealthConnectRecordHandler>.register(
        handler: HealthConnectRecordHandler,
    ) {
        put(handler.supportedType, handler)
    }

    /**
     * Retrieves a record handler for the specified health data type.
     *
     * This is an alias for getHandler() that makes the intent clearer when
     * specifically looking for CRUD operations.
     *
     * @param type The health data type
     * @return The record handler for the type, or null if not found
     */
    fun getRecordHandler(type: HealthDataTypeDto): HealthConnectRecordHandler? = handlers[type]

    /**
     * Retrieves an aggregation-supporting handler for the specified health data type.
     *
     * @param type The health data type
     * @return The aggregation handler if the type supports aggregation, or null otherwise
     */
    // Unchecked cast: we know the request type matches the handler's expected type at runtime
    @Suppress("UNCHECKED_CAST")
    fun getAggregationHandler(
        type: HealthDataTypeDto,
    ): AggregationSupportingHandler<AggregateRequestDto>? =
        handlers[type] as AggregationSupportingHandler<AggregateRequestDto>?
}
