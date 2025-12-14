package com.phamtunglam.health_connector_hc_android.handlers

import androidx.health.connect.client.HealthConnectClient
import androidx.health.connect.client.aggregate.AggregateMetric
import androidx.health.connect.client.aggregate.AggregationResult
import androidx.health.connect.client.records.WheelchairPushesRecord
import com.phamtunglam.health_connector_hc_android.mappers.aggregationMetric
import com.phamtunglam.health_connector_hc_android.mappers.toNumericDto
import com.phamtunglam.health_connector_hc_android.pigeon.AggregateRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.AggregationMetricDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.MeasurementUnitDto

/**
 * Handler for Wheelchair Pushes records.
 */
internal class WheelchairPushesHandler(override val client: HealthConnectClient) :
    HealthRecordHandler,
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    UpdatableHealthRecordHandler,
    DeletableHealthRecordHandler,
    HealthConnectAggregatableHealthRecordHandler {

    override val dataType = HealthDataTypeDto.WHEELCHAIR_PUSHES

    override fun toAggregateMetric(request: AggregateRequestDto): AggregateMetric<*> =
        when (request.aggregationMetric) {
            AggregationMetricDto.SUM -> WheelchairPushesRecord.COUNT_TOTAL
            else -> throw UnsupportedOperationException(
                "Unsupported metric: ${request.aggregationMetric}",
            )
        }

    override fun extractAggregateValue(
        result: AggregationResult,
        metric: AggregateMetric<*>,
    ): MeasurementUnitDto = when (metric) {
        WheelchairPushesRecord.COUNT_TOTAL -> {
            val count = result[metric]
                ?: error("Aggregation result for $metric is null")
            count.toNumericDto()
        }

        else -> throw UnsupportedOperationException("Unsupported metric: $metric")
    }
}
