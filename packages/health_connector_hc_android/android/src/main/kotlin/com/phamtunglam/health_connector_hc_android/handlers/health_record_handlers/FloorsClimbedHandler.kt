package com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers

import androidx.health.connect.client.HealthConnectClient
import androidx.health.connect.client.records.FloorsClimbedRecord
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
 * Handler for Floors Climbed records.
 */
internal class FloorsClimbedHandler(
    override val dispatcher: CoroutineDispatcher = Dispatchers.IO,
    override val client: HealthConnectClient,
) : ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    UpdatableHealthRecordHandler,
    DeletableHealthRecordHandler,
    HealthConnectAggregatableHealthRecordHandler {

    override val dataType = HealthDataTypeDto.FLOORS_CLIMBED

    override val tag = "FloorsClimbedHandler"

    override val aggregateMetricMappings = mapOf(
        AggregationMetricDto.SUM to FloorsClimbedRecord.FLOORS_CLIMBED_TOTAL,
    )

    override fun convertAggregatedValue(aggregatedValue: Any): Double {
        val floors = aggregatedValue as? Double
            ?: throw IllegalArgumentException(
                "Aggregated value is not Number type: ${aggregatedValue::class.simpleName}",
            )
        return floors
    }
}
