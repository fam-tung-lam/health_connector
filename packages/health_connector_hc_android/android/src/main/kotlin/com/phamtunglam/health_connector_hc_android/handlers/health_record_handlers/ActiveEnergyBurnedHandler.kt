package com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers

import androidx.health.connect.client.HealthConnectClient
import androidx.health.connect.client.records.ActiveCaloriesBurnedRecord
import androidx.health.connect.client.units.Energy
import com.phamtunglam.health_connector_hc_android.handlers.DeletableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.handlers.HealthConnectAggregatableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.handlers.ReadableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.handlers.UpdatableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.handlers.WritableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.mappers.health_measurement_unit_mappers.toDto
import com.phamtunglam.health_connector_hc_android.pigeon.AggregationMetricDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.MeasurementUnitDto
import kotlinx.coroutines.CoroutineDispatcher
import kotlinx.coroutines.Dispatchers

/**
 * Handler for Active Calories Burned records.
 */
internal class ActiveEnergyBurnedHandler(
    override val dispatcher: CoroutineDispatcher = Dispatchers.IO,
    override val client: HealthConnectClient,
) : ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    UpdatableHealthRecordHandler,
    DeletableHealthRecordHandler,
    HealthConnectAggregatableHealthRecordHandler {

    override val dataType = HealthDataTypeDto.ACTIVE_CALORIES_BURNED

    override val tag = "ActiveEnergyBurnedHandler"

    override val aggregateMetricMappings = mapOf(
        AggregationMetricDto.SUM to ActiveCaloriesBurnedRecord.ACTIVE_CALORIES_TOTAL,
    )

    override fun convertAggregatedValue(aggregatedValue: Any): MeasurementUnitDto {
        val energy = aggregatedValue as? Energy
            ?: throw IllegalArgumentException(
                "Aggregated value is not Energy type: ${aggregatedValue::class.simpleName}",
            )
        return energy.toDto()
    }
}
