package com.phamtunglam.health_connector_hc_android.handlers

import android.os.RemoteException
import androidx.health.connect.client.HealthConnectClient
import androidx.health.connect.client.aggregate.AggregateMetric
import androidx.health.connect.client.aggregate.AggregationResult
import androidx.health.connect.client.request.AggregateRequest
import androidx.health.connect.client.time.TimeRangeFilter
import com.phamtunglam.health_connector_hc_android.mappers.endTime
import com.phamtunglam.health_connector_hc_android.mappers.startTime
import com.phamtunglam.health_connector_hc_android.pigeon.AggregateRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.AggregateResponseDto
import com.phamtunglam.health_connector_hc_android.pigeon.AggregationMetricDto
import com.phamtunglam.health_connector_hc_android.pigeon.MeasurementUnitDto
import java.io.IOException
import java.time.Instant

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
    suspend fun aggregate(request: AggregateRequestDto): AggregateResponseDto = process(
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
