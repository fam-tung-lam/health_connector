package com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers

import androidx.health.connect.client.HealthConnectClient
import androidx.health.connect.client.aggregate.AggregateMetric
import androidx.health.connect.client.records.ActivityIntensityRecord
import com.phamtunglam.health_connector_hc_android.handlers.DeletableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.handlers.HealthConnectAggregatableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.handlers.ReadableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.handlers.UpdatableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.handlers.WritableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.pigeon.ActivityIntensityAggregateRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.ActivityIntensityTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.AggregateRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataTypeDto
import java.time.Duration
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
    HealthConnectAggregatableHealthRecordHandler {

    override val dataType = HealthDataTypeDto.ACTIVITY_INTENSITY

    override val tag = "ActivityIntensityHandler"

    override fun getAggregateMetric(request: AggregateRequestDto): AggregateMetric<*> {
        require(request is ActivityIntensityAggregateRequestDto) {
            "Expected ActivityIntensityAggregateRequestDto for ActivityIntensityHandler"
        }
        return getAggregateMetric(request.intensityType)
    }

    override fun convertAggregatedValue(aggregatedValue: Any): Double {
        val duration = aggregatedValue as? Duration ?: throw IllegalArgumentException(
            "Expected Duration",
        )
        // Return duration in seconds
        return duration.seconds.toDouble()
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
