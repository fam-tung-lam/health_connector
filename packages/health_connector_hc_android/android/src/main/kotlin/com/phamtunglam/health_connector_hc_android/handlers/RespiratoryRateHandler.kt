package com.phamtunglam.health_connector_hc_android.handlers

import androidx.health.connect.client.HealthConnectClient
import com.phamtunglam.health_connector_hc_android.mappers.toNumericDto
import com.phamtunglam.health_connector_hc_android.pigeon.AggregationMetricDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.MeasurementUnitDto
import com.phamtunglam.health_connector_hc_android.pigeon.RespiratoryRateRecordDto

/**
 * Handler for Respiratory Rate records.
 *
 * This handler leverages the default paginated aggregation implementation from
 * [CustomAggregatableHealthRecordHandler], requiring only value extraction and result wrapping logic.
 */
internal class RespiratoryRateHandler(override val client: HealthConnectClient) :
    HealthRecordHandler,
    CustomAggregatableHealthRecordHandler,
    WritableHealthRecordHandler,
    UpdatableHealthRecordHandler,
    DeletableHealthRecordHandler {

    override val dataType = HealthDataTypeDto.RESPIRATORY_RATE

    override val supportedAggregationMetrics: Set<AggregationMetricDto>
        get() = setOf(
            AggregationMetricDto.AVG,
            AggregationMetricDto.COUNT,
            AggregationMetricDto.MIN,
            AggregationMetricDto.MAX,
        )

    override fun extractValueForAggregation(recordDto: HealthRecordDto): Double? =
        (recordDto as? RespiratoryRateRecordDto)?.rate?.value

    override fun wrapAggregationResult(value: Double): MeasurementUnitDto = value.toNumericDto()
}
