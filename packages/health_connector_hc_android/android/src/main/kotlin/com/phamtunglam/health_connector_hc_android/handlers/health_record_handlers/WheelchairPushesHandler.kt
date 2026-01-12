package com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers

import androidx.health.connect.client.HealthConnectClient
import androidx.health.connect.client.records.WheelchairPushesRecord
import com.phamtunglam.health_connector_hc_android.handlers.DeletableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.handlers.HealthConnectAggregatableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.handlers.ReadableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.handlers.UpdatableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.handlers.WritableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.mappers.health_measurement_unit_mappers.toNumberDto
import com.phamtunglam.health_connector_hc_android.pigeon.AggregationMetricDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.MeasurementUnitDto
import kotlinx.coroutines.CoroutineDispatcher
import kotlinx.coroutines.Dispatchers

/**
 * Handler for Wheelchair Pushes records.
 */
internal class WheelchairPushesHandler(
    override val dispatcher: CoroutineDispatcher = Dispatchers.IO,
    override val client: HealthConnectClient,
) : ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    UpdatableHealthRecordHandler,
    DeletableHealthRecordHandler,
    HealthConnectAggregatableHealthRecordHandler {

    override val dataType = HealthDataTypeDto.WHEELCHAIR_PUSHES

    override val tag = "WheelchairPushesHandler"

    override val aggregateMetricMappings = mapOf(
        AggregationMetricDto.SUM to WheelchairPushesRecord.COUNT_TOTAL,
    )

    override fun convertAggregatedValue(aggregatedValue: Any): MeasurementUnitDto {
        if (aggregatedValue !is Long) {
            throw IllegalArgumentException(
                "Aggregated value is not numeric value: ${aggregatedValue::class.simpleName}",
            )
        }
        return aggregatedValue.toNumberDto()
    }
}
