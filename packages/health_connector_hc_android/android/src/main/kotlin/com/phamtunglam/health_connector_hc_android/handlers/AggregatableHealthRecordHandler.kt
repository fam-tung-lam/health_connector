package com.phamtunglam.health_connector_hc_android.handlers

import android.os.RemoteException
import androidx.health.connect.client.HealthConnectClient
import androidx.health.connect.client.aggregate.AggregateMetric
import androidx.health.connect.client.request.AggregateRequest
import androidx.health.connect.client.time.TimeRangeFilter
import com.phamtunglam.health_connector_hc_android.mappers.aggregationMetric
import com.phamtunglam.health_connector_hc_android.mappers.endTime
import com.phamtunglam.health_connector_hc_android.mappers.startTime
import com.phamtunglam.health_connector_hc_android.pigeon.AggregateRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.AggregateResponseDto
import com.phamtunglam.health_connector_hc_android.pigeon.AggregationMetricDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthConnectorErrorDto
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
     * Maps aggregation metrics to their Health Connect SDK equivalents.
     */
    val aggregateMetricMappings: Map<AggregationMetricDto, AggregateMetric<*>>

    @Throws(IllegalArgumentException::class)
    fun convertAggregatedValue(aggregatedValue: Any): MeasurementUnitDto

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

        val metric = aggregateMetricMappings[request.aggregationMetric]
            ?: throw IllegalArgumentException(
                "Unsupported metric: ${request.aggregationMetric}. " +
                    "Supported: ${aggregateMetricMappings.keys}",
            )
        val aggregateRequest = AggregateRequest(
            metrics = setOf(metric),
            timeRangeFilter = TimeRangeFilter.between(
                Instant.ofEpochMilli(request.startTime),
                Instant.ofEpochMilli(request.endTime),
            ),
        )

        val result = client.aggregate(aggregateRequest)
        val aggregatedValue = result[metric] ?: error("Aggregation result for $metric is null")

        AggregateResponseDto(value = convertAggregatedValue(aggregatedValue))
    }
}

/**
 * Capability for handlers that support custom manual aggregation logic.
 *
 * Use this when Health Connect native aggregation is not available.
 * This interface provides a default paginated aggregation implementation.
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
     * @param recordDto The health record DTO to extract a value from
     * @return The numeric value if the DTO is of the expected type, throws error otherwise
     * @throws IllegalArgumentException if the [recordDto] is invalid type
     */
    @Throws(IllegalArgumentException::class)
    fun extractValueForAggregation(recordDto: HealthRecordDto): Double

    /**
     * Wrap the aggregated numeric result into the appropriate response format.
     *
     * @param value The aggregated numeric value (AVG, MIN, or MAX)
     * @return The measurement unit DTO appropriate for this data type
     */
    fun wrapAggregationResult(value: Double): MeasurementUnitDto

    /**
     * Performs custom paginated aggregation over health records within a time range.
     *
     * This default implementation:
     * 1. Validates the request (time range, supported metrics)
     * 2. Paginates through all records in the time range
     * 3. Accumulates statistics (count, sum, min, max)
     * 4. Calculates the requested metric (AVG, MIN, MAX, or SUM)
     * 5. Wraps the result in the appropriate format
     *
     * Implementations can override this method if custom aggregation logic is needed,
     * but in most cases, only [extractValueForAggregation] and [wrapAggregationResult]
     * need to be implemented.
     *
     * @param request The aggregation request containing data type, metric, and time range
     * @return The aggregation response with the computed value
     * @throws HealthConnectorErrorDto with appropriate error code
     */
    @Throws(
        HealthConnectorErrorDto::class,
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

        val resultValue = when (request.aggregationMetric) {
            AggregationMetricDto.AVG -> aggregationResult.avg
            AggregationMetricDto.MIN -> aggregationResult.min
            AggregationMetricDto.MAX -> aggregationResult.max
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
        var min: Double? = null
        var max: Double? = null

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
                min = if (min == null) value else minOf(min, value)
                max = if (max == null) value else maxOf(max, value)
            }

            pageToken = nextToken
        } while (!pageToken.isNullOrEmpty())

        return PaginatedAggregationResult(
            avg = if (count > 0) sum / count else 0.0,
            sum = sum,
            min = if (count > 0) min ?: 0.0 else 0.0,
            max = if (count > 0) max ?: 0.0 else 0.0,
        )
    }

    /**
     * Internal data class to hold intermediate aggregation results.
     */
    private data class PaginatedAggregationResult(
        val avg: Double,
        val sum: Double,
        val min: Double,
        val max: Double,
    )
}
