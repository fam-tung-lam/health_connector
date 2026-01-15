package com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers

import androidx.health.connect.client.HealthConnectClient
import androidx.health.connect.client.records.ElevationGainedRecord
import androidx.health.connect.client.units.Length
import com.phamtunglam.health_connector_hc_android.handlers.DeletableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.handlers.HealthConnectAggregatableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.handlers.ReadableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.handlers.UpdatableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.handlers.WritableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.pigeon.AggregationMetricDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataTypeDto
import kotlinx.coroutines.CoroutineDispatcher
import kotlinx.coroutines.Dispatchers

/**
 * Handler for Elevation Gained records.
 */
internal class ElevationGainedHandler(
    override val dispatcher: CoroutineDispatcher = Dispatchers.IO,
    override val client: HealthConnectClient,
) : ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    UpdatableHealthRecordHandler,
    DeletableHealthRecordHandler,
    HealthConnectAggregatableHealthRecordHandler {

    override val dataType = HealthDataTypeDto.ELEVATION_GAINED

    override val tag = "ElevationGainedHandler"

    override val aggregateMetricMappings = mapOf(
        AggregationMetricDto.SUM to ElevationGainedRecord.ELEVATION_GAINED_TOTAL,
    )

    override fun convertAggregatedValue(aggregatedValue: Any): Double {
        val length = aggregatedValue as? Length
            ?: throw IllegalArgumentException(
                "Aggregated value is not Length type: ${aggregatedValue::class.simpleName}",
            )
        return length.inMeters
    }
}
