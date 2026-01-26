package com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers

import androidx.health.connect.client.HealthConnectClient
import androidx.health.connect.client.records.HeartRateRecord
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
 * Handler for Heart Rate records.
 */
internal class HeartRateHandler(
    override val dispatcher: CoroutineDispatcher = Dispatchers.IO,
    override val client: HealthConnectClient,
) : ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    UpdatableHealthRecordHandler,
    DeletableHealthRecordHandler,
    HealthConnectAggregatableHealthRecordHandler {

    override val dataType = HealthDataTypeDto.HEART_RATE_SERIES

    override val tag = "HeartRateHandler"

    override val aggregateMetricMappings = mapOf(
        AggregationMetricDto.AVG to HeartRateRecord.BPM_AVG,
        AggregationMetricDto.MIN to HeartRateRecord.BPM_MIN,
        AggregationMetricDto.MAX to HeartRateRecord.BPM_MAX,
    )

    override fun convertAggregatedValue(aggregatedValue: Any): Double {
        require(aggregatedValue is Long) {
            "Aggregated value is not Long type: ${aggregatedValue::class.simpleName}"
        }
        return aggregatedValue.toDouble()
    }
}
