package com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers

import androidx.health.connect.client.HealthConnectClient
import androidx.health.connect.client.aggregate.AggregateMetric
import androidx.health.connect.client.records.StepsCadenceRecord
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
 * Handler for Steps Cadence Series records.
 */
internal class StepsCadenceSeriesHandler(
    override val dispatcher: CoroutineDispatcher = Dispatchers.IO,
    override val client: HealthConnectClient,
) : ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    UpdatableHealthRecordHandler,
    DeletableHealthRecordHandler,
    HealthConnectAggregatableHealthRecordHandler {

    override val dataType = HealthDataTypeDto.STEPS_CADENCE_SERIES_RECORD

    override val tag = "StepsCadenceSeriesHandler"

    override val aggregateMetricMappings: Map<AggregationMetricDto, AggregateMetric<*>> =
        mapOf(
            AggregationMetricDto.AVG to StepsCadenceRecord.RATE_AVG,
            AggregationMetricDto.MIN to StepsCadenceRecord.RATE_MIN,
            AggregationMetricDto.MAX to StepsCadenceRecord.RATE_MAX,
        )

    override fun convertAggregatedValue(aggregatedValue: Any): Double {
        require(aggregatedValue is Double) {
            "Expected Double for aggregated steps cadence value, got ${aggregatedValue::class.simpleName}"
        }
        return aggregatedValue
    }
}
