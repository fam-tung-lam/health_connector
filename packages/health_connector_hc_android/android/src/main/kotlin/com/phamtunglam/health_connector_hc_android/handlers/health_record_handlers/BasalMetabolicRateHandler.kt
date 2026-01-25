package com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers

import androidx.health.connect.client.HealthConnectClient
import androidx.health.connect.client.records.BasalMetabolicRateRecord
import androidx.health.connect.client.units.Energy
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
 * Handler for Basal Metabolic Rate records.
 */
internal class BasalMetabolicRateHandler(
    override val dispatcher: CoroutineDispatcher = Dispatchers.IO,
    override val client: HealthConnectClient,
) : ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    UpdatableHealthRecordHandler,
    DeletableHealthRecordHandler,
    HealthConnectAggregatableHealthRecordHandler {

    override val dataType = HealthDataTypeDto.BASAL_METABOLIC_RATE

    override val tag = "BasalMetabolicRateHandler"

    override val aggregateMetricMappings = mapOf(
        AggregationMetricDto.SUM to BasalMetabolicRateRecord.BASAL_CALORIES_TOTAL,
    )

    override fun convertAggregatedValue(aggregatedValue: Any): Double {
        val energy = aggregatedValue as? Energy
            ?: throw IllegalArgumentException(
                "Aggregated value is not Energy type: ${aggregatedValue::class.simpleName}",
            )
        return energy.inKilocalories
    }
}
