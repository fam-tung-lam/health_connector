package com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers

import androidx.health.connect.client.HealthConnectClient
import androidx.health.connect.client.aggregate.AggregateMetric
import androidx.health.connect.client.records.ActivityIntensityRecord
import androidx.health.connect.client.request.AggregateRequest
import androidx.health.connect.client.time.TimeRangeFilter
import com.phamtunglam.health_connector_hc_android.handlers.AggregatableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.handlers.DeletableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.handlers.ReadableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.handlers.UpdatableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.handlers.WritableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.pigeon.ActivityIntensityAggregateRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.ActivityIntensityTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.AggregateRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataTypeDto
import java.time.Duration
import java.time.Instant
import kotlinx.coroutines.CoroutineDispatcher
import kotlinx.coroutines.Dispatchers

/**
 * Handler for Activity Intensity records.
 *
 * Supports custom aggregation for:
 * - DURATION_TOTAL: Total minutes spent in activity (any intensity)
 * - MODERATE_DURATION_TOTAL: Total minutes spent in moderate-intensity activity
 * - VIGOROUS_DURATION_TOTAL: Total minutes spent in vigorous-intensity activity
 */
internal class ActivityIntensityHandler(
    override val dispatcher: CoroutineDispatcher = Dispatchers.IO,
    override val client: HealthConnectClient,
) : ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    UpdatableHealthRecordHandler,
    DeletableHealthRecordHandler,
    AggregatableHealthRecordHandler {

    override val dataType = HealthDataTypeDto.ACTIVITY_INTENSITY

    override val tag = "ActivityIntensityHandler"

    override suspend fun aggregate(request: AggregateRequestDto): Double = process(
        operation = "aggregate",
        context = mapOf("request" to request),
    ) {
        if (request !is ActivityIntensityAggregateRequestDto) {
            throw IllegalArgumentException(
                "Expected ActivityIntensityAggregateRequestDto for ActivityIntensityHandler",
            )
        }

        require(request.startTime < request.endTime) {
            "Invalid time range: startTime must be before endTime"
        }

        val metric = getAggregateMetric(request.intensityType)
        val aggregateRequest = AggregateRequest(
            metrics = setOf(metric),
            timeRangeFilter = TimeRangeFilter.between(
                Instant.ofEpochMilli(request.startTime),
                Instant.ofEpochMilli(request.endTime),
            ),
        )

        val result = client.aggregate(aggregateRequest)

        val value = result[metric] ?: error("Aggregation result for $metric is null")

        // Return duration in seconds
        value.toSeconds().toDouble()
    }

    /**
     * Maps the intensity type to the appropriate Health Connect aggregation metric.
     *
     * @param intensityType The type of activity intensity to aggregate, or null for total
     * @return The corresponding Health Connect aggregation metric
     */
    private fun getAggregateMetric(
        intensityType: ActivityIntensityTypeDto?,
    ): AggregateMetric<Duration> = when (intensityType) {
        null -> ActivityIntensityRecord.DURATION_TOTAL
        ActivityIntensityTypeDto.MODERATE -> ActivityIntensityRecord.MODERATE_DURATION_TOTAL
        ActivityIntensityTypeDto.VIGOROUS -> ActivityIntensityRecord.VIGOROUS_DURATION_TOTAL
    }
}
