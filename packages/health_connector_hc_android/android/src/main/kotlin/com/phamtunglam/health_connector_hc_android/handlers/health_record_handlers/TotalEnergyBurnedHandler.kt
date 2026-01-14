package com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers

import androidx.health.connect.client.HealthConnectClient
import androidx.health.connect.client.records.TotalCaloriesBurnedRecord
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
 * Handler for Total Calories Burned records.
 */
internal class TotalEnergyBurnedHandler(
    override val dispatcher: CoroutineDispatcher = Dispatchers.IO,
    override val client: HealthConnectClient,
) : ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    UpdatableHealthRecordHandler,
    DeletableHealthRecordHandler,
    HealthConnectAggregatableHealthRecordHandler {

    override val dataType = HealthDataTypeDto.TOTAL_CALORIES_BURNED

    override val tag = "TotalEnergyBurnedHandler"

    override val aggregateMetricMappings = mapOf(
        AggregationMetricDto.SUM to TotalCaloriesBurnedRecord.ENERGY_TOTAL,
    )

    override fun convertAggregatedValue(aggregatedValue: Any): Double {
        val energy = aggregatedValue as? Energy
            ?: throw IllegalArgumentException(
                "Aggregated value is not Energy type: ${aggregatedValue::class.simpleName}",
            )
        return energy.inKilocalories
    }
}
