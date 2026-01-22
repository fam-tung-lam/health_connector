package com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers

import androidx.health.connect.client.HealthConnectClient
import androidx.health.connect.client.aggregate.AggregateMetric
import androidx.health.connect.client.records.CyclingPedalingCadenceRecord
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
 * Handler for Cycling Pedaling Cadence records.
 */
internal class CyclingPedalingCadenceHandler(
    override val dispatcher: CoroutineDispatcher = Dispatchers.IO,
    override val client: HealthConnectClient,
) : ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    UpdatableHealthRecordHandler,
    DeletableHealthRecordHandler,
    HealthConnectAggregatableHealthRecordHandler {

    override val dataType = HealthDataTypeDto.CYCLING_PEDALING_CADENCE_SERIES

    override val tag = "CyclingPedalingCadenceHandler"

    override val aggregateMetricMappings: Map<AggregationMetricDto, AggregateMetric<*>> =
        mapOf(
            AggregationMetricDto.AVG to CyclingPedalingCadenceRecord.RPM_AVG,
            AggregationMetricDto.MIN to CyclingPedalingCadenceRecord.RPM_MIN,
            AggregationMetricDto.MAX to CyclingPedalingCadenceRecord.RPM_MAX,
        )

    override fun convertAggregatedValue(aggregatedValue: Any): Double {
        require(aggregatedValue is Double) {
            "Expected Double for aggregated RPM value, got ${aggregatedValue::class.simpleName}"
        }
        return aggregatedValue
    }
}
