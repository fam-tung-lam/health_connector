package com.phamtunglam.health_connector_hc_android.handlers

import androidx.health.connect.client.HealthConnectClient
import androidx.health.connect.client.aggregate.AggregateMetric
import androidx.health.connect.client.request.AggregateRequest
import androidx.health.connect.client.time.TimeRangeFilter
import com.phamtunglam.health_connector_hc_android.logger.HealthConnectorLogger
import com.phamtunglam.health_connector_hc_android.pigeon.AggregateRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.AggregationMetricDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthConnectorErrorDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthRecordDto
import com.phamtunglam.health_connector_hc_android.utils.aggregationMetric
import com.phamtunglam.health_connector_hc_android.utils.dataType
import com.phamtunglam.health_connector_hc_android.utils.endTime
import com.phamtunglam.health_connector_hc_android.utils.startTime
import java.time.Duration
import java.time.Instant
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext

/**
 * Capability for handlers that support aggregation operations.
 */
internal interface AggregatableHealthRecordHandler : HealthRecordHandler {
    suspend fun aggregate(request: AggregateRequestDto): Double
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
    fun convertAggregatedValue(aggregatedValue: Any): Double

    /**
     * Performs aggregation using native Health Connect SDK.
     *
     * @param request The aggregation request containing data type, metric, and time range
     * @return The aggregation response with the computed value
     * @throws HealthConnectorErrorDto if [startTime] > [endTime] or exception by [HealthConnectClient.aggregate]
     */
    @Throws(HealthConnectorErrorDto::class)
    override suspend fun aggregate(request: AggregateRequestDto): Double = process(
        operation = "aggregate",
        context = mapOf("request" to request),
    ) {
        require(request.startTime < request.endTime) {
            "Invalid time range: startTime must be before endTime"
        }

        require(request.dataType == dataType) {
            "Handler does not support data type: ${request.dataType}. Supported data type: $dataType"
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

        convertAggregatedValue(aggregatedValue)
    }
}

/**
 * Capability for handlers that support custom manual aggregation logic.
 *
 * Use this when Health Connect native aggregation is not available.
 * This interface provides a default paginated aggregation implementation.
 *
 * @see extractValueForAggregation
 */
internal interface CustomAggregatableHealthRecordHandler :
    AggregatableHealthRecordHandler,
    ReadableHealthRecordHandler {

    companion object {
        private const val OPERATION = "custom_aggregate"
    }

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
     * Performs custom paginated aggregation over health records within a time range.
     *
     * @param request The aggregation request containing data type, metric, and time range
     * @return The aggregation response with the computed value
     * @throws HealthConnectorErrorDto with appropriate error code
     */
    @Throws(
        HealthConnectorErrorDto::class,
    )
    override suspend fun aggregate(request: AggregateRequestDto): Double {
        val startTime = Instant.ofEpochMilli(request.startTime)
        val endTime = Instant.ofEpochMilli(request.endTime)
        val querySpanDays = Duration.between(startTime, endTime).toDays()
        val aggregationMetric = request.aggregationMetric
        val context = mapOf(
            "data_type" to request.dataType,
            "metric" to aggregationMetric,
            "query_span_days" to querySpanDays,
        )

        HealthConnectorLogger.debug(
            tag = tag,
            operation = OPERATION,
            message = "Preparing custom aggregation",
            context = context,
        )

        return process(
            OPERATION,
            context = context,
        ) {
            require(startTime < endTime) {
                "Invalid time range: startTime ($startTime) must be less than endTime ($endTime)"
            }

            require(
                supportedAggregationMetrics.contains(aggregationMetric),
            ) {
                "Aggregation metric $aggregationMetric not supported for $dataType. " +
                    "Supported metrics: $supportedAggregationMetrics"
            }

            val aggregationResult = paginateAndAggregate(
                startTime = startTime,
                endTime = endTime,
                context = context,
            )

            val resultValue = when (aggregationMetric) {
                AggregationMetricDto.AVG -> aggregationResult.avg
                AggregationMetricDto.MIN -> aggregationResult.min
                AggregationMetricDto.MAX -> aggregationResult.max
                AggregationMetricDto.SUM -> aggregationResult.sum
            }

            HealthConnectorLogger.info(
                tag = tag,
                operation = OPERATION,
                message = "Custom aggregation completed",
                context = context + mapOf(
                    "result_value" to resultValue,
                ),
            )

            return@process resultValue
        }
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
        context: Map<String, Any?>,
    ): PaginatedAggregationResult = withContext(Dispatchers.IO) {
        HealthConnectorLogger.debug(
            tag = tag,
            operation = OPERATION,
            message = "Starting pagination for custom aggregation",
            context = context,
        )

        var pageToken: String? = null
        var count = 0
        var sum = 0.0
        var min: Double? = null
        var max: Double? = null
        var pageNumber = 0

        do {
            pageNumber++
            val (records, nextToken) = readRecords(
                startTime = startTime,
                endTime = endTime,
                pageToken = pageToken,
            )

            HealthConnectorLogger.debug(
                tag = tag,
                operation = OPERATION,
                message = "Processing page $pageNumber",
                context = context + mapOf(
                    "page_number" to pageNumber,
                    "records_in_page" to records.size,
                    "total_records_so_far" to (count + records.size),
                ),
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

        val result = PaginatedAggregationResult(
            avg = if (count > 0) sum / count else 0.0,
            sum = sum,
            min = if (count > 0) min ?: 0.0 else 0.0,
            max = if (count > 0) max ?: 0.0 else 0.0,
        )

        HealthConnectorLogger.info(
            tag = tag,
            operation = OPERATION,
            message = "Custom aggregation pagination completed",
            context = context + mapOf(
                "total_pages" to pageNumber,
                "total_records" to count,
            ),
        )

        return@withContext result
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
