package com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers

import androidx.health.connect.client.HealthConnectClient
import androidx.health.connect.client.records.RestingHeartRateRecord
import com.phamtunglam.health_connector_hc_android.handlers.DeletableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.handlers.HealthConnectAggregatableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.handlers.ReadableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.handlers.UpdatableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.handlers.WritableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.mappers.health_measurement_unit_mappers.toNumberDto
import com.phamtunglam.health_connector_hc_android.pigeon.AggregationMetricDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.MeasurementUnitDto

/**
 * Handler for Resting Heart Rate records.
 */
internal class RestingHeartRateHandler(override val client: HealthConnectClient) :
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    UpdatableHealthRecordHandler,
    DeletableHealthRecordHandler,
    HealthConnectAggregatableHealthRecordHandler {

    override val dataType = HealthDataTypeDto.RESTING_HEART_RATE

    override val aggregateMetricMappings = mapOf(
        AggregationMetricDto.AVG to RestingHeartRateRecord.BPM_AVG,
        AggregationMetricDto.MIN to RestingHeartRateRecord.BPM_MIN,
        AggregationMetricDto.MAX to RestingHeartRateRecord.BPM_MAX,
    )

    override fun convertAggregatedValue(aggregatedValue: Any): MeasurementUnitDto {
        if (aggregatedValue !is Number) {
            throw IllegalArgumentException(
                "Aggregated value is not numeric value: ${aggregatedValue::class.simpleName}",
            )
        }
        return aggregatedValue.toNumberDto()
    }
}
