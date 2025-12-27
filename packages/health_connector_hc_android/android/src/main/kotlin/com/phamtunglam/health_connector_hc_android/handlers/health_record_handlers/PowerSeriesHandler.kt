package com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers

import androidx.health.connect.client.HealthConnectClient
import androidx.health.connect.client.records.PowerRecord
import androidx.health.connect.client.units.Power
import com.phamtunglam.health_connector_hc_android.handlers.DeletableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.handlers.HealthConnectAggregatableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.handlers.ReadableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.handlers.UpdatableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.handlers.WritableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.mappers.health_measurement_unit_mappers.toDto
import com.phamtunglam.health_connector_hc_android.pigeon.AggregationMetricDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.MeasurementUnitDto

/**
 * Handler for Power series records.
 */
internal class PowerSeriesHandler(override val client: HealthConnectClient) :
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    UpdatableHealthRecordHandler,
    DeletableHealthRecordHandler,
    HealthConnectAggregatableHealthRecordHandler {

    override val dataType = HealthDataTypeDto.POWER_SERIES
    override val aggregateMetricMappings = mapOf(
        AggregationMetricDto.AVG to PowerRecord.POWER_AVG,
        AggregationMetricDto.MIN to PowerRecord.POWER_MIN,
        AggregationMetricDto.MAX to PowerRecord.POWER_MAX,
    )

    override fun convertAggregatedValue(aggregatedValue: Any): MeasurementUnitDto {
        val power = aggregatedValue as? Power
            ?: throw IllegalArgumentException(
                "Aggregated value is not Power type: ${aggregatedValue::class.simpleName}",
            )
        return power.toDto()
    }
}
