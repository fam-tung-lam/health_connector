package com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers

import androidx.health.connect.client.HealthConnectClient
import com.phamtunglam.health_connector_hc_android.handlers.CustomAggregatableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.handlers.DeletableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.handlers.UpdatableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.handlers.WritableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.pigeon.AggregationMetricDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthRecordDto
import com.phamtunglam.health_connector_hc_android.pigeon.RespiratoryRateRecordDto
import kotlinx.coroutines.CoroutineDispatcher
import kotlinx.coroutines.Dispatchers

/**
 * Handler for Respiratory Rate records.
 *
 * This handler leverages the default paginated aggregation implementation from
 * [CustomAggregatableHealthRecordHandler], requiring only value extraction and result wrapping logic.
 */
internal class RespiratoryRateHandler(
    override val dispatcher: CoroutineDispatcher = Dispatchers.IO,
    override val client: HealthConnectClient,
) : CustomAggregatableHealthRecordHandler,
    WritableHealthRecordHandler,
    UpdatableHealthRecordHandler,
    DeletableHealthRecordHandler {

    override val dataType = HealthDataTypeDto.RESPIRATORY_RATE

    override val tag = "RespiratoryRateHandler"

    override val supportedAggregationMetrics: Set<AggregationMetricDto>
        get() = setOf(
            AggregationMetricDto.AVG,
            AggregationMetricDto.MIN,
            AggregationMetricDto.MAX,
        )

    override fun extractValueForAggregation(recordDto: HealthRecordDto): Double {
        if (recordDto !is RespiratoryRateRecordDto) {
            throw IllegalArgumentException(
                "Expected ${RespiratoryRateRecordDto::class.simpleName} but received: " +
                    "${recordDto::class.simpleName}",
            )
        }

        return recordDto.breathsPerMinute
    }
}
