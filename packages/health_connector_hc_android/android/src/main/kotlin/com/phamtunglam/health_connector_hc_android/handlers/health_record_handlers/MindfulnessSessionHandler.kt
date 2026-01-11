package com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers

import androidx.health.connect.client.HealthConnectClient
import androidx.health.connect.client.feature.ExperimentalMindfulnessSessionApi
import androidx.health.connect.client.records.MindfulnessSessionRecord
import com.phamtunglam.health_connector_hc_android.handlers.DeletableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.handlers.HealthConnectAggregatableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.handlers.ReadableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.handlers.UpdatableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.handlers.WritableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.mappers.health_measurement_unit_mappers.toDto
import com.phamtunglam.health_connector_hc_android.pigeon.AggregationMetricDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataTypeDto
import com.phamtunglam.health_connector_hc_android.pigeon.MeasurementUnitDto
import kotlin.time.toKotlinDuration
import kotlinx.coroutines.CoroutineDispatcher
import kotlinx.coroutines.Dispatchers

/**
 * Handler for Mindfulness Session records.
 */
@OptIn(ExperimentalMindfulnessSessionApi::class)
internal class MindfulnessSessionHandler(
    override val dispatcher: CoroutineDispatcher = Dispatchers.IO,
    override val client: HealthConnectClient,
) : ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    UpdatableHealthRecordHandler,
    DeletableHealthRecordHandler,
    HealthConnectAggregatableHealthRecordHandler {

    override val dataType = HealthDataTypeDto.MINDFULNESS_SESSION

    override val aggregateMetricMappings = mapOf(
        AggregationMetricDto.SUM to MindfulnessSessionRecord.MINDFULNESS_DURATION_TOTAL,
    )

    override fun convertAggregatedValue(aggregatedValue: Any): MeasurementUnitDto {
        // Health Connect returns java.time.Duration, so we need to cast to that type
        // and convert it to kotlin.time.Duration before calling toDto()
        val javaDuration = aggregatedValue as? java.time.Duration
            ?: throw IllegalArgumentException(
                "Aggregated value is not java.time.Duration type: ${aggregatedValue::class.qualifiedName}",
            )
        val kotlinDuration = javaDuration.toKotlinDuration()
        return kotlinDuration.toDto()
    }
}
