package com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers

import androidx.health.connect.client.HealthConnectClient
import androidx.health.connect.client.records.SkinTemperatureRecord
import androidx.health.connect.client.units.TemperatureDelta
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
 * Handler for Skin Temperature Delta Series records.
 */
internal class SkinTemperatureDeltaSeriesHandler(
    override val dispatcher: CoroutineDispatcher = Dispatchers.IO,
    override val client: HealthConnectClient,
) : ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    UpdatableHealthRecordHandler,
    DeletableHealthRecordHandler,
    HealthConnectAggregatableHealthRecordHandler {

    override val dataType = HealthDataTypeDto.SKIN_TEMPERATURE_DELTA_SERIES

    override val tag = "SkinTemperatureDeltaSeriesHandler"

    override val aggregateMetricMappings = mapOf(
        AggregationMetricDto.AVG to SkinTemperatureRecord.TEMPERATURE_DELTA_AVG,
        AggregationMetricDto.MIN to SkinTemperatureRecord.TEMPERATURE_DELTA_MIN,
        AggregationMetricDto.MAX to SkinTemperatureRecord.TEMPERATURE_DELTA_MAX,
    )

    override fun convertAggregatedValue(aggregatedValue: Any): Double {
        val temperatureDelta = aggregatedValue as? TemperatureDelta
            ?: throw IllegalArgumentException(
                "Aggregated value is not TemperatureDelta type: " +
                    "${aggregatedValue::class.simpleName}",
            )
        return temperatureDelta.inCelsius
    }
}
