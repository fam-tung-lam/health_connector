package com.phamtunglam.health_connector_hc_android.handlers

import android.os.RemoteException
import androidx.health.connect.client.HealthConnectClient
import androidx.health.connect.client.aggregate.AggregateMetric
import androidx.health.connect.client.aggregate.AggregationResult
import androidx.health.connect.client.request.AggregateRequest
import androidx.health.connect.client.time.TimeRangeFilter
import com.phamtunglam.health_connector_hc_android.mappers.aggregationMetric
import com.phamtunglam.health_connector_hc_android.mappers.endTime
import com.phamtunglam.health_connector_hc_android.mappers.startTime
import com.phamtunglam.health_connector_hc_android.pigeon.AggregateRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.AggregateResponseDto
import com.phamtunglam.health_connector_hc_android.pigeon.AggregationMetricDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.MeasurementUnitDto
import java.io.IOException
import java.time.Instant

/**
 * Capability for handlers that support aggregation operations.
 */
internal interface AggregatableHealthRecordHandler : HealthRecordHandler {
    suspend fun aggregate(request: AggregateRequestDto): AggregateResponseDto
}

/**
 * Capability for handlers that support native Health Connect aggregation using [AggregateRequest].
 */
internal interface HealthConnectAggregatableHealthRecordHandler : AggregatableHealthRecordHandler {

    /**
     * Converts a platform aggregation request to a Health Connect metric.
     *
     * Validates that the requested [request] metric is compatible with the health data type.
     * For example, steps only supports [AggregationMetricDto.SUM], while weight supports AVG, MIN, and MAX.
     *
     * @param request The aggregation request containing the metric type to map.
     * @return The native Health Connect [AggregateMetric].
     * @throws IllegalArgumentException If the [request] contains a metric type that is
     *         incompatible with this specific health data type.
     */
    @Throws(IllegalArgumentException::class)
    fun toAggregateMetric(request: AggregateRequestDto): AggregateMetric<*>

    /**
     * Extracts aggregation result from Health Connect and converts to platform DTO.
     *
     * This method retrieves the aggregated value for a specific metric from the Health Connect
     * AggregationResult and wraps it in the appropriate measurement unit DTO.
     *
     * @param result The aggregation result from Health Connect SDK
     * @param metric The specific metric to extract from the result
     * @return The measurement unit DTO containing the aggregated value
     * @throws IllegalArgumentException if the metric is not recognized/supported
     * @throws IllegalStateException if the aggregation result is unexpectedly null
     */
    @Throws(IllegalArgumentException::class, IllegalStateException::class)
    fun extractAggregateValue(
        result: AggregationResult,
        metric: AggregateMetric<*>,
    ): MeasurementUnitDto

    /**
     * Performs aggregation using native Health Connect SDK.
     *
     * @param request The aggregation request containing data type, metric, and time range
     * @return The aggregation response with the computed value
     * @throws IllegalArgumentException if [startTime] > [endTime]
     * @throws Exception that can be thrown by [HealthConnectClient.deleteRecords]
     */
    @Throws(
        IllegalArgumentException::class,
        RemoteException::class,
        SecurityException::class,
        IOException::class,
    )
    override suspend fun aggregate(request: AggregateRequestDto): AggregateResponseDto = process(
        operation = "aggregate",
        context = mapOf("request" to request),
    ) {
        require(request.startTime < request.endTime) {
            "Invalid time range: startTime must be before endTime"
        }

        val metric = toAggregateMetric(request)
        val aggregateRequest = AggregateRequest(
            metrics = setOf(metric),
            timeRangeFilter = TimeRangeFilter.between(
                Instant.ofEpochMilli(request.startTime),
                Instant.ofEpochMilli(request.endTime),
            ),
        )

        val result = client.aggregate(aggregateRequest)

        val valueDto = extractAggregateValue(result, metric)

        AggregateResponseDto(value = valueDto)
    }
}

/**
 * Capability for handlers that support custom manual aggregation logic.
 *
 * Use this when Health Connect native aggregation is not available.
 * This interface provides a default paginated aggregation implementation that eliminates
 * code duplication across handlers.
 *
 * The paginated aggregation handles large datasets efficiently by:
 * - Paginating through records in chunks ([ReadableHealthRecordHandler.DEFAULT_PAGE_SIZE] records per page)
 * - Accumulating statistics (count, sum, min, max) without loading all data into memory
 *
 * @see extractValueForAggregation
 * @see wrapAggregationResult
 */
internal interface CustomAggregatableHealthRecordHandler :
    AggregatableHealthRecordHandler,
    ReadableHealthRecordHandler {

    /**
     * Set of aggregation metrics supported by this handler.
     */
    val supportedAggregationMetrics: Set<AggregationMetricDto>

    /**
     * Extract the numeric value from a specific DTO type for aggregation.
     *
     * This method should perform type checking and value extraction specific
     * to the handler's data type.
     *
     * @param recordDto The health record DTO to extract a value from
     * @return The numeric value if the DTO is of the expected type, null otherwise
     * @throws IllegalArgumentException if the [recordDto] is invalid type
     */
    @Throws(IllegalArgumentException::class)
    fun extractValueForAggregation(recordDto: HealthRecordDto): Double

    /**
     * Wrap the aggregated numeric result into the appropriate response format.
     *
     * Different data types may require different wrapping:
     * - Simple numeric types use toNumericDto()
     * - Complex types with units use specific DTO constructors
     *
     * @param value The aggregated numeric value (AVG, MIN, or MAX)
     * @return The measurement unit DTO appropriate for this data type
     *
     * Example implementations:
     * ```
     * // For simple numeric types (Oxygen Saturation, Respiratory Rate, VO2 Max):
     * override fun wrapAggregationResult(value: Double): MeasurementUnitDto {
     *     return value.toNumericDto()
     * }
     *
     * // For types with units (Blood Glucose):
     * override fun wrapAggregationResult(value: Double): MeasurementUnitDto {
     *     return BloodGlucoseDto(
     *         BloodGlucoseUnitDto.MILLIGRAMS_PER_DECILITER,
     *         value,
     *     )
     * }
     * ```
     */
    fun wrapAggregationResult(value: Double): MeasurementUnitDto

    /**
     * Performs custom paginated aggregation over health records within a time range.
     *
     * This default implementation:
     * 1. Validates the request (time range, supported metrics)
     * 2. Paginates through all records in the time range
     * 3. Accumulates statistics (count, sum, min, max)
     * 4. Calculates the requested metric (AVG, MIN, MAX, COUNT, or SUM)
     * 5. Wraps the result in the appropriate format
     *
     * Supported metrics:
     * - AVG: Average of all values
     * - MIN: Minimum value
     * - MAX: Maximum value
     * - COUNT: Number of records with valid extractable values
     * - SUM: Sum of all values
     *
     * Implementations can override this method if custom aggregation logic is needed,
     * but in most cases, only [extractValueForAggregation] and [wrapAggregationResult]
     * need to be implemented.
     *
     * @param request The aggregation request containing data type, metric, and time range
     * @return The aggregation response with the computed value
     * @throws IllegalArgumentException if [startTime] > [endTime]
     * @throws Exception that can be thrown by [HealthConnectClient.readRecords]
     */
    @Throws(
        IllegalArgumentException::class,
        RemoteException::class,
        SecurityException::class,
        IOException::class,
    )
    override suspend fun aggregate(request: AggregateRequestDto): AggregateResponseDto = process(
        "custom_aggregate",
        context = mapOf("request" to request),
    ) {
        require(request.startTime < request.endTime) {
            "Invalid time range: startTime (${request.startTime}) must be less than endTime (${request.endTime})"
        }

        require(
            supportedAggregationMetrics.contains(request.aggregationMetric),
        ) {
            "Aggregation metric ${request.aggregationMetric} not supported for $dataType. " +
                "Supported metrics: $supportedAggregationMetrics"
        }

        val aggregationResult = paginateAndAggregate(
            startTime = Instant.ofEpochMilli(request.startTime),
            endTime = Instant.ofEpochMilli(request.endTime),
        )

        if (aggregationResult.count == 0) {
            return@process AggregateResponseDto(value = wrapAggregationResult(0.0))
        }

        val resultValue = when (request.aggregationMetric) {
            AggregationMetricDto.AVG -> aggregationResult.avg
            AggregationMetricDto.MIN -> aggregationResult.min
            AggregationMetricDto.MAX -> aggregationResult.max
            AggregationMetricDto.COUNT -> aggregationResult.count.toDouble()
            AggregationMetricDto.SUM -> aggregationResult.sum
        }

        AggregateResponseDto(value = wrapAggregationResult(resultValue))
    }

    /**
     * Internal method that performs the actual pagination and aggregation.
     *
     * This method pages through all records in the time range and accumulates
     * statistics without loading all records into memory at once.
     */
    private suspend fun paginateAndAggregate(
        startTime: Instant,
        endTime: Instant,
    ): PaginatedAggregationResult {
        var pageToken: String? = null
        var count = 0
        var sum = 0.0
        var min = Double.MAX_VALUE
        var max = Double.MIN_VALUE

        do {
            val (records, nextToken) = readRecords(
                startTime = startTime,
                endTime = endTime,
                pageToken = pageToken,
            )

            for (recordDto in records) {
                val value = extractValueForAggregation(recordDto)
                sum += value
                count++
                if (value < min) min = value
                if (value > max) max = value
            }

            pageToken = nextToken
        } while (!pageToken.isNullOrEmpty())

        return PaginatedAggregationResult(
            avg = sum / count,
            count = count,
            sum = sum,
            min = if (count > 0) min else 0.0,
            max = if (count > 0) max else 0.0,
        )
    }

    /**
     * Internal data class to hold intermediate aggregation results.
     */
    private data class PaginatedAggregationResult(
        val avg: Double,
        val count: Int,
        val sum: Double,
        val min: Double,
        val max: Double,
    )
}
