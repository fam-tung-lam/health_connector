package com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers

import androidx.health.connect.client.HealthConnectClient
import androidx.health.connect.client.aggregate.AggregateMetric
import androidx.health.connect.client.aggregate.AggregationResult
import androidx.health.connect.client.records.FloorsClimbedRecord
import com.phamtunglam.health_connector_hc_android.handlers.DeletableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.handlers.HealthConnectAggregatableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.handlers.ReadableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.handlers.UpdatableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.handlers.WritableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.mappers.aggregationMetric
import com.phamtunglam.health_connector_hc_android.mappers.toNumericDto
import com.phamtunglam.health_connector_hc_android.pigeon.AggregateRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.AggregationMetricDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.MeasurementUnitDto

/**
 * Handler for Floors Climbed records.
 */
internal class FloorsClimbedHandler(override val client: HealthConnectClient) :
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    UpdatableHealthRecordHandler,
    DeletableHealthRecordHandler,
    HealthConnectAggregatableHealthRecordHandler {

    override val dataType = HealthDataTypeDto.FLOORS_CLIMBED

    override fun toAggregateMetric(request: AggregateRequestDto): AggregateMetric<*> =
        when (request.aggregationMetric) {
            AggregationMetricDto.SUM -> FloorsClimbedRecord.FLOORS_CLIMBED_TOTAL
            else -> throw IllegalArgumentException(
                "Unsupported metric: ${request.aggregationMetric}",
            )
        }

    override fun extractAggregateValue(
        result: AggregationResult,
        metric: AggregateMetric<*>,
    ): MeasurementUnitDto = when (metric) {
        FloorsClimbedRecord.FLOORS_CLIMBED_TOTAL -> {
            val floors = result[metric]
                ?: error("Aggregation result for $metric is null")
            floors.toNumericDto()
        }

        else -> throw IllegalArgumentException("Unsupported metric: $metric")
    }
}
