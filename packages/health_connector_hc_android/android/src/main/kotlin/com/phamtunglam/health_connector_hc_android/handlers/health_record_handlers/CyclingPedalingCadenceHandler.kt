package com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers

import androidx.health.connect.client.HealthConnectClient
import androidx.health.connect.client.aggregate.AggregateMetric
import androidx.health.connect.client.records.CyclingPedalingCadenceRecord
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
 * Handler for Cycling Pedaling Cadence records.
 *
 * Supports aggregation using Health Connect's native RPM metrics:
 * - RPM_AVG: Average cycling pedaling cadence
 * - RPM_MIN: Minimum cycling pedaling cadence
 * - RPM_MAX: Maximum cycling pedaling cadence
 */
internal class CyclingPedalingCadenceHandler(override val client: HealthConnectClient) :
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    UpdatableHealthRecordHandler,
    DeletableHealthRecordHandler,
    HealthConnectAggregatableHealthRecordHandler {

    override val dataType = HealthDataTypeDto.CYCLING_PEDALING_CADENCE_SERIES_RECORD

    override val aggregateMetricMappings: Map<AggregationMetricDto, AggregateMetric<*>> =
        mapOf(
            AggregationMetricDto.AVG to CyclingPedalingCadenceRecord.RPM_AVG,
            AggregationMetricDto.MIN to CyclingPedalingCadenceRecord.RPM_MIN,
            AggregationMetricDto.MAX to CyclingPedalingCadenceRecord.RPM_MAX,
        )

    override fun convertAggregatedValue(aggregatedValue: Any): MeasurementUnitDto {
        require(aggregatedValue is Double) {
            "Expected Double for aggregated RPM value, got ${aggregatedValue::class.simpleName}"
        }
        return aggregatedValue.toNumberDto()
    }
}
