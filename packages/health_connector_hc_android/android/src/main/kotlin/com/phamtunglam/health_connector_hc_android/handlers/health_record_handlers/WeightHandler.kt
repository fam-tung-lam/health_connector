package com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers

import androidx.health.connect.client.HealthConnectClient
import androidx.health.connect.client.aggregate.AggregateMetric
import androidx.health.connect.client.aggregate.AggregationResult
import androidx.health.connect.client.records.WeightRecord
import com.phamtunglam.health_connector_hc_android.handlers.DeletableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.handlers.HealthConnectAggregatableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.handlers.ReadableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.handlers.UpdatableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.handlers.WritableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.mappers.aggregationMetric
import com.phamtunglam.health_connector_hc_android.mappers.toDto
import com.phamtunglam.health_connector_hc_android.pigeon.AggregateRequestDto
import com.phamtunglam.health_connector_hc_android.pigeon.AggregationMetricDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.MeasurementUnitDto

/**
 * Handler for Weight records.
 */
internal class WeightHandler(override val client: HealthConnectClient) :
    ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    UpdatableHealthRecordHandler,
    DeletableHealthRecordHandler,
    HealthConnectAggregatableHealthRecordHandler {

    override val dataType = HealthDataTypeDto.WEIGHT

    override fun toAggregateMetric(request: AggregateRequestDto): AggregateMetric<*> =
        when (request.aggregationMetric) {
            AggregationMetricDto.AVG -> WeightRecord.WEIGHT_AVG
            AggregationMetricDto.MIN -> WeightRecord.WEIGHT_MIN
            AggregationMetricDto.MAX -> WeightRecord.WEIGHT_MAX
            else -> throw IllegalArgumentException(
                "Unsupported metric: ${request.aggregationMetric}",
            )
        }

    override fun extractAggregateValue(
        result: AggregationResult,
        metric: AggregateMetric<*>,
    ): MeasurementUnitDto = when (metric) {
        WeightRecord.WEIGHT_AVG,
        WeightRecord.WEIGHT_MIN,
        WeightRecord.WEIGHT_MAX,
        -> {
            val mass = result[metric]
                ?: error("Aggregation result for $metric is null")
            mass.toDto()
        }

        else -> throw IllegalArgumentException("Unsupported metric: $metric")
    }
}
