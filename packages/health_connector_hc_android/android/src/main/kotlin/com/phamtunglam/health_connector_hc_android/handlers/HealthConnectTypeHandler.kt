package com.phamtunglam.health_connector_hc_android.handlers

import androidx.health.connect.client.aggregate.AggregateMetric
import androidx.health.connect.client.aggregate.AggregationResult
import androidx.health.connect.client.records.Record
import com.phamtunglam.health_connector_hc_android.HealthConnectDataCategory
import com.phamtunglam.health_connector_hc_android.pigeon.AggregateRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.MeasurementUnitDto
import kotlin.reflect.KClass

/**
 * Base interface for all Health Connect type handlers.
 *
 * Each handler is responsible for managing a specific health data type, including
 * type identification, categorization, and type-specific operations.
 */
sealed interface HealthConnectTypeHandler {
    /**
     * The health data type this handler supports.
     */
    val supportedType: HealthDataTypeDto

    /**
     * The data category this handler belongs to (interval, instant, series, session).
     */
    val category: HealthConnectDataCategory
}

/**
 * Interface for handlers that manage Health Connect Record CRUD operations.
 *
 * This interface provides bidirectional conversion between Health Connect Record types
 * and platform-agnostic DTOs, as well as type information for SDK operations.
 */
sealed interface HealthConnectRecordHandler : HealthConnectTypeHandler {
    /**
     * Converts a Health Connect Record to a platform DTO.
     *
     * @param record The Health Connect record to convert
     * @return The converted DTO, or null if the record type doesn't match
     * @throws IllegalArgumentException if the record type doesn't match the expected type
     */
    @Throws(IllegalArgumentException::class)
    fun toDto(record: Record): HealthRecordDto?

    /**
     * Converts a platform DTO to a Health Connect Record.
     *
     * @param dto The DTO to convert
     * @return The Health Connect record
     * @throws IllegalArgumentException if the DTO type doesn't match the expected type
     */
    @Throws(IllegalArgumentException::class)
    fun toHealthConnect(dto: HealthRecordDto): Record

    /**
     * Returns the Kotlin class of the Health Connect Record this handler manages.
     *
     * This is used for type-safe SDK operations like deleteRecords().
     *
     * @return The KClass of the Record type
     */
    fun getRecordClass(): KClass<out Record>
}

/**
 * Handler for interval-based health records.
 *
 * Interval records have both startTime and endTime, representing data over a time period.
 * Examples: Steps, Distance, ActiveCaloriesBurned
 */
sealed interface IntervalRecordHandler : HealthConnectRecordHandler {
    override val category: HealthConnectDataCategory
        get() = HealthConnectDataCategory.INTERVAL_RECORD
}

/**
 * Handler for instant health records.
 *
 * Instant records have a single timestamp, representing a point-in-time measurement.
 * Examples: Weight, Height, BodyTemperature
 */
sealed interface InstantRecordHandler : HealthConnectRecordHandler {
    override val category: HealthConnectDataCategory
        get() = HealthConnectDataCategory.INSTANT_RECORD
}

/**
 * Handler for series health records.
 *
 * Series records contain multiple samples with individual timestamps over a time range.
 * Examples: HeartRate samples
 */
sealed interface SeriesRecordHandler : HealthConnectRecordHandler {
    override val category: HealthConnectDataCategory
        get() = HealthConnectDataCategory.SERIES_RECORD
}

/**
 * Handler for session health records.
 *
 * Session records are extended intervals that may contain stages or additional metadata.
 * Examples: Sleep sessions
 */
sealed interface SessionRecordHandler : HealthConnectRecordHandler {
    override val category: HealthConnectDataCategory
        get() = HealthConnectDataCategory.SESSION_RECORD
}

/**
 * Capability interface for handlers that support aggregation operations.
 *
 * Handlers implementing this interface can perform statistical aggregations
 * (sum, average, min, max) on their health data type.
 */
interface AggregationSupportingHandler<R : AggregateRequestDto> : HealthConnectRecordHandler {
    /**
     * Converts a platform aggregation metric to a Health Connect AggregateMetric.
     *
     * @param request The aggregate request DTO
     * @return The corresponding Health Connect AggregateMetric
     * @throws UnsupportedOperationException if the metric is not supported
     */
    @Throws(UnsupportedOperationException::class)
    fun toAggregateMetric(request: R): AggregateMetric<*>

    /**
     * Extracts and converts the aggregated value from a Health Connect aggregation result.
     *
     * This method handles type-specific value extraction and conversion to platform DTOs.
     *
     * @param aggregationResult The Health Connect aggregation result
     * @param aggregateMetric The aggregate metric to extract from the result
     * @return The converted measurement unit DTO
     * @throws IllegalStateException if [aggregationResult] for [aggregateMetric] is null or handler contains invalid data type
     */
    @Throws(IllegalStateException::class)
    fun extractAggregateValue(
        aggregationResult: AggregationResult,
        aggregateMetric: AggregateMetric<*>,
    ): MeasurementUnitDto
}
