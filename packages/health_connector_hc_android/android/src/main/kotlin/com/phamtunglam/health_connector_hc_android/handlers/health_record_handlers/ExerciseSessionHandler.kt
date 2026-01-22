package com.phamtunglam.health_connector_hc_android.handlers.health_record_handlers

import androidx.health.connect.client.HealthConnectClient
import androidx.health.connect.client.records.ExerciseSessionRecord
import com.phamtunglam.health_connector_hc_android.handlers.DeletableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.handlers.HealthConnectAggregatableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.handlers.ReadableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.handlers.UpdatableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.handlers.WritableHealthRecordHandler
import com.phamtunglam.health_connector_hc_android.pigeon.AggregationMetricDto
import com.phamtunglam.health_connector_hc_android.pigeon.HealthDataTypeDto
import kotlinx.coroutines.CoroutineDispatcher
import kotlinx.coroutines.Dispatchers

/**
 * Handler for Exercise Session records.
 */
internal class ExerciseSessionHandler(
    override val dispatcher: CoroutineDispatcher = Dispatchers.IO,
    override val client: HealthConnectClient,
) : ReadableHealthRecordHandler,
    WritableHealthRecordHandler,
    UpdatableHealthRecordHandler,
    DeletableHealthRecordHandler,
    HealthConnectAggregatableHealthRecordHandler {

    override val dataType = HealthDataTypeDto.EXERCISE_SESSION

    override val tag = "ExerciseSessionHandler"

    override val aggregateMetricMappings = mapOf(
        AggregationMetricDto.SUM to ExerciseSessionRecord.EXERCISE_DURATION_TOTAL,
    )

    override fun convertAggregatedValue(aggregatedValue: Any): Double {
        val javaDuration = aggregatedValue as? java.time.Duration
            ?: throw IllegalArgumentException(
                "Aggregated value is not java.time.Duration type: ${aggregatedValue::class.qualifiedName}",
            )
        return javaDuration.toSeconds().toDouble()
    }
}
