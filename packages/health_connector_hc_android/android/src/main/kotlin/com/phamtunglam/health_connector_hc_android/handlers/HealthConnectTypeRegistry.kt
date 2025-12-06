package com.phamtunglam.health_connector_hc_android.handlers

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
object HealthConnectTypeRegistry {
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

            register(NutrientHandler(HealthDataTypeDto.ENERGY_NUTRIENT))
            register(NutrientHandler(HealthDataTypeDto.CAFFEINE))
            register(NutrientHandler(HealthDataTypeDto.PROTEIN))
            register(NutrientHandler(HealthDataTypeDto.TOTAL_CARBOHYDRATE))
            register(NutrientHandler(HealthDataTypeDto.TOTAL_FAT))
            register(NutrientHandler(HealthDataTypeDto.SATURATED_FAT))
            register(NutrientHandler(HealthDataTypeDto.MONOUNSATURATED_FAT))
            register(NutrientHandler(HealthDataTypeDto.POLYUNSATURATED_FAT))
            register(NutrientHandler(HealthDataTypeDto.CHOLESTEROL))
            register(NutrientHandler(HealthDataTypeDto.DIETARY_FIBER))
            register(NutrientHandler(HealthDataTypeDto.SUGAR))
            register(NutrientHandler(HealthDataTypeDto.VITAMIN_A))
            register(NutrientHandler(HealthDataTypeDto.VITAMIN_B6))
            register(NutrientHandler(HealthDataTypeDto.VITAMIN_B12))
            register(NutrientHandler(HealthDataTypeDto.VITAMIN_C))
            register(NutrientHandler(HealthDataTypeDto.VITAMIN_D))
            register(NutrientHandler(HealthDataTypeDto.VITAMIN_E))
            register(NutrientHandler(HealthDataTypeDto.VITAMIN_K))
            register(NutrientHandler(HealthDataTypeDto.THIAMIN))
            register(NutrientHandler(HealthDataTypeDto.RIBOFLAVIN))
            register(NutrientHandler(HealthDataTypeDto.NIACIN))
            register(NutrientHandler(HealthDataTypeDto.FOLATE))
            register(NutrientHandler(HealthDataTypeDto.BIOTIN))
            register(NutrientHandler(HealthDataTypeDto.PANTOTHENIC_ACID))
            register(NutrientHandler(HealthDataTypeDto.CALCIUM))
            register(NutrientHandler(HealthDataTypeDto.IRON))
            register(NutrientHandler(HealthDataTypeDto.MAGNESIUM))
            register(NutrientHandler(HealthDataTypeDto.MANGANESE))
            register(NutrientHandler(HealthDataTypeDto.PHOSPHORUS))
            register(NutrientHandler(HealthDataTypeDto.POTASSIUM))
            register(NutrientHandler(HealthDataTypeDto.SELENIUM))
            register(NutrientHandler(HealthDataTypeDto.SODIUM))
            register(NutrientHandler(HealthDataTypeDto.ZINC))

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
        handler: HealthConnectRecordHandler
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
    fun getRecordHandler(type: HealthDataTypeDto): HealthConnectRecordHandler? =
        handlers[type]

    /**
     * Retrieves an aggregation-supporting handler for the specified health data type.
     *
     * @param type The health data type
     * @return The aggregation handler if the type supports aggregation, or null otherwise
     */
    fun getAggregationHandler(type: HealthDataTypeDto): AggregationSupportingHandler? =
        handlers[type] as? AggregationSupportingHandler
}
